Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410D2195934
	for <lists+linux-serial@lfdr.de>; Fri, 27 Mar 2020 15:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0Ojm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 27 Mar 2020 10:39:42 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:55347 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgC0Ojm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Mar 2020 10:39:42 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id D1CCF100376D4;
        Fri, 27 Mar 2020 15:39:40 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 93AFA61CED4A;
        Fri, 27 Mar 2020 15:39:40 +0100 (CET)
X-Mailbox-Line: From 019839cb1f61b01210b6ff9ac9f9079ca77f8411 Mon Sep 17 00:00:00 2001
Message-Id: <019839cb1f61b01210b6ff9ac9f9079ca77f8411.1585319447.git.lukas@wunner.de>
In-Reply-To: <9dd67f33c90d23f7fafa3b81b1e812ddabf9ca24.1585319447.git.lukas@wunner.de>
References: <9dd67f33c90d23f7fafa3b81b1e812ddabf9ca24.1585319447.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 27 Mar 2020 15:38:16 +0100
Subject: [PATCH v2 tty-next 2/2] serial: 8250: Optimize irq enable after
 console write
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Heiko Schocher <hs@denx.de>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Stefan Wahren <wahrenst@gmx.net>,
        Martin Sperl <kernel@martin.sperl.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 7f9803072ff6 ("serial: 8250: Support console on software emulated
rs485 ports") amended serial8250_console_write() with rs485 support, but
positioned the invocation of ->rs485_stop_tx() after re-enablement of
interrupts.  The irq handler and ->console_write() are serialized with
the port spinlock, so no problem there, but due to the rs485 delay, the
irq handler may unnecessarily spin for a while.  Avoid that by moving
->rs485_stop_tx() before re-enablement of interrupts, which also mirrors
the order at the beginning of serial8250_console_write().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
v2:
 fix hash of referenced commit

 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a1d3aef3c406..f77bf820b7a3 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3268,7 +3268,6 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	serial_port_out(port, UART_IER, ier);
 
 	if (em485) {
 		mdelay(port->rs485.delay_rts_after_send);
@@ -3276,6 +3275,8 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 			up->rs485_stop_tx(up);
 	}
 
+	serial_port_out(port, UART_IER, ier);
+
 	/*
 	 *	The receive handling will happen properly because the
 	 *	receive ready bit will still be set; it is not cleared
-- 
2.25.0

