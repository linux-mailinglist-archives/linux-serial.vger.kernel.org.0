Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9060E48AE81
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jan 2022 14:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbiAKNfH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jan 2022 08:35:07 -0500
Received: from air.basealt.ru ([194.107.17.39]:49266 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239562AbiAKNfH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jan 2022 08:35:07 -0500
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jan 2022 08:35:06 EST
Received: by air.basealt.ru (Postfix, from userid 490)
        id A28485895D8; Tue, 11 Jan 2022 13:29:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on
        sa.local.altlinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
Received: from asheplyakov-rocket.lan (unknown [88.147.173.226])
        by air.basealt.ru (Postfix) with ESMTPSA id 592C758942B;
        Tue, 11 Jan 2022 13:29:14 +0000 (UTC)
From:   asheplyakov@basealt.ru
To:     linux-serial@vger.kernel.org
Cc:     Alexey Sheplyakov <asheplyakov@basealt.ru>,
        "Vadim V . Vlasov" <vadim.vlasov@elpitech.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH] serial: 8250_dw: verify clock rate in dw8250_set_termios
Date:   Tue, 11 Jan 2022 17:28:47 +0400
Message-Id: <20220111132847.218193-1-asheplyakov@basealt.ru>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Alexey Sheplyakov <asheplyakov@basealt.ru>

Refuse to change the clock rate if clk_round_rate() returns
a rate which is way too off (i.e. by more than 1/16 from the one
necessary for a given baud rate). In particular this happens if
the requested rate is below the minimum supported by the clock.

Fixes the UART console on BE-M1000 SoC. Without this patch the
console gets garbled immediately after loading the driver.
dw8250_set_termios tries to configure the baud rate (115200),
and calls clk_round_rate to figure out the supported rate closest
to 1843200 Hz (which is 115200 * 16). However the (SoC-specific)
clock driver returns 4705882 Hz. This frequency is way too off,
hence after setting it the console gets garbled.

Signed-off-by: Alexey Sheplyakov <asheplyakov@basealt.ru>
Signed-off-by: Vadim V. Vlasov <vadim.vlasov@elpitech.ru>

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/tty/serial/8250/8250_dw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1769808031c5..ec7e8169c983 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -329,14 +329,15 @@ dw8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 			       struct ktermios *old)
 {
-	unsigned long newrate = tty_termios_baud_rate(termios) * 16;
+	unsigned long baud = tty_termios_baud_rate(termios);
+	unsigned long newrate = baud * 16;
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
 	long rate;
 	int ret;
 
 	clk_disable_unprepare(d->clk);
 	rate = clk_round_rate(d->clk, newrate);
-	if (rate > 0) {
+	if (rate > 0 && rate >= baud * 15 && rate <= baud * 17) {
 		/*
 		 * Note that any clock-notifer worker will block in
 		 * serial8250_update_uartclk() until we are done.
-- 
2.32.0

