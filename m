Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181712FF83
	for <lists+linux-serial@lfdr.de>; Thu, 30 May 2019 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE3PgH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 May 2019 11:36:07 -0400
Received: from mail.javad.com ([54.86.164.124]:59876 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfE3PgF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 May 2019 11:36:05 -0400
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id E308954541;
        Thu, 30 May 2019 15:30:08 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@gnss.ru smtp.helo=localhost6.localdomain6
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id x4UFU7l0026025;
        Thu, 30 May 2019 18:30:07 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id x4UFU75h026021;
        Thu, 30 May 2019 18:30:07 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 6/8] serial: imx: do not disable individual irqs during termios change
Date:   Thu, 30 May 2019 18:29:48 +0300
Message-Id: <20190530152950.25377-7-sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
In-Reply-To: <20190530152950.25377-1-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_set_termios(): disabling individual interrupt requests in UART for
duration of the routine is pointless. Get rid of it.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 469a0c3..4b9c560 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1533,7 +1533,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long flags;
-	u32 ucr2, old_ucr1, old_ucr2, ufcr;
+	u32 ucr2, old_ucr2, ufcr;
 	unsigned int baud, quot;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 	unsigned long div;
@@ -1633,16 +1633,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	/*
-	 * disable interrupts
-	 */
-	old_ucr1 = imx_uart_readl(sport, UCR1);
-	imx_uart_writel(sport,
-			old_ucr1 & ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN),
-			UCR1);
-	old_ucr2 = imx_uart_readl(sport, UCR2);
-	imx_uart_writel(sport, old_ucr2 & ~UCR2_ATEN, UCR2);
-
 	/* custom-baudrate handling */
 	div = sport->port.uartclk / (baud * 16);
 	if (baud == 38400 && quot != div)
@@ -1677,9 +1667,8 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		imx_uart_writel(sport, sport->port.uartclk / div / 1000,
 				IMX21_ONEMS);
 
-	imx_uart_writel(sport, old_ucr1, UCR1);
-
 	/* Set parity, stop bits, data size, etc. Keep bits we don't compute. */
+	old_ucr2 = imx_uart_readl(sport, UCR2);
 	old_ucr2 &= (UCR2_CTS | UCR2_TXEN | UCR2_RXEN | UCR2_ATEN);
 	imx_uart_writel(sport, ucr2 | old_ucr2, UCR2);
 
-- 
2.10.0.1.g57b01a3

