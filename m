Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE32D3E67
	for <lists+linux-serial@lfdr.de>; Wed,  9 Dec 2020 10:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgLIJS3 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 9 Dec 2020 04:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgLIJS3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 04:18:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53944C0617B0
        for <linux-serial@vger.kernel.org>; Wed,  9 Dec 2020 01:17:46 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <str@pengutronix.de>)
        id 1kmvbT-0005wj-Gg; Wed, 09 Dec 2020 10:17:43 +0100
Received: from str by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <str@pengutronix.de>)
        id 1kmvbT-0000cs-6Q; Wed, 09 Dec 2020 10:17:43 +0100
From:   Steffen Trumtrar <s.trumtrar@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 2/2] tty: serial: 8250: wait till transmitter is empty
Date:   Wed,  9 Dec 2020 10:17:28 +0100
Message-Id: <20201209091728.2357-2-s.trumtrar@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201209091728.2357-1-s.trumtrar@pengutronix.de>
References: <20201209091728.2357-1-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: str@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When only one single character is sent and RS485 signaling is used,
the driver runs into timing issues.

When serial8250_tx_chars is called the single character is transmitted.
The check on uart_circ_empty will be positive and __stop_tx is called.
The check on UART_LSR_TEMT in BOTH_EMPTY will then be negativ and the
function will return. On the next call to serial8250_tx_chars
uart_circ_empty will still be true but the check on BOTH_EMPTY in
__stop_tx might still fail. This leads to a deadlock.

Use readx_poll_timeout_atomic to allow the shift register to be emptied
before checking on BOTH_EMPTY.

The timeout value is copied from 8250_dw.c.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3310c2b70138..87daf3758ff0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -18,6 +18,7 @@
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/sysrq.h>
+#include <linux/iopoll.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/tty.h>
@@ -1519,18 +1520,27 @@ static inline void __do_stop_tx(struct uart_8250_port *p)
 		serial8250_rpm_put_tx(p);
 }
 
+static unsigned char serial8250_read_lsr(struct uart_8250_port *p)
+{
+	return serial_in(p, UART_LSR);
+}
+
 static inline void __stop_tx(struct uart_8250_port *p)
 {
 	struct uart_8250_em485 *em485 = p->em485;
 
 	if (em485) {
-		unsigned char lsr = serial_in(p, UART_LSR);
+		unsigned char lsr;
+
 		/*
 		 * To provide required timeing and allow FIFO transfer,
 		 * __stop_tx_rs485() must be called only when both FIFO and
 		 * shift register are empty. It is for device driver to enable
 		 * interrupt on TEMT.
 		 */
+		readx_poll_timeout_atomic(serial8250_read_lsr, p, lsr,
+					  lsr & UART_LSR_TEMT, 1, 20000);
+
 		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
 			return;
 
-- 
2.20.1

