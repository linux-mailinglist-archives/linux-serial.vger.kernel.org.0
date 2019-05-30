Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5508A2FF82
	for <lists+linux-serial@lfdr.de>; Thu, 30 May 2019 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfE3PgG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 May 2019 11:36:06 -0400
Received: from mail.javad.com ([54.86.164.124]:59874 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbfE3PgF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 May 2019 11:36:05 -0400
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 598B054543;
        Thu, 30 May 2019 15:30:09 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@gnss.ru smtp.helo=localhost6.localdomain6
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id x4UFU7tB026068;
        Thu, 30 May 2019 18:30:07 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id x4UFU76Q026065;
        Thu, 30 May 2019 18:30:07 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 8/8] serial: imx: use Tx ready rather than Tx empty irq
Date:   Thu, 30 May 2019 18:29:50 +0300
Message-Id: <20190530152950.25377-9-sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
In-Reply-To: <20190530152950.25377-1-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This should help to avoid unnecessary gaps in transmission while
adding little overhead due to low default Tx threshold level (2
bytes).

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index db3fb4c..f1d5c75 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -442,7 +442,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 		return;
 
 	ucr1 = imx_uart_readl(sport, UCR1);
-	imx_uart_writel(sport, ucr1 & ~UCR1_TXMPTYEN, UCR1);
+	imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);
 
 	/* in rs485 mode disable transmitter if shifter is empty */
 	if (port->rs485.flags & SER_RS485_ENABLED &&
@@ -520,7 +520,7 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 		 * and the TX IRQ is disabled.
 		 **/
 		ucr1 = imx_uart_readl(sport, UCR1);
-		ucr1 &= ~UCR1_TXMPTYEN;
+		ucr1 &= ~UCR1_TRDYEN;
 		if (sport->dma_is_txing) {
 			ucr1 |= UCR1_TXDMAEN;
 			imx_uart_writel(sport, ucr1, UCR1);
@@ -682,7 +682,7 @@ static void imx_uart_start_tx(struct uart_port *port)
 
 	if (!sport->dma_is_enabled) {
 		ucr1 = imx_uart_readl(sport, UCR1);
-		imx_uart_writel(sport, ucr1 | UCR1_TXMPTYEN, UCR1);
+		imx_uart_writel(sport, ucr1 | UCR1_TRDYEN, UCR1);
 	}
 
 	if (sport->dma_is_enabled) {
@@ -691,7 +691,7 @@ static void imx_uart_start_tx(struct uart_port *port)
 			 * disable TX DMA to let TX interrupt to send X-char */
 			ucr1 = imx_uart_readl(sport, UCR1);
 			ucr1 &= ~UCR1_TXDMAEN;
-			ucr1 |= UCR1_TXMPTYEN;
+			ucr1 |= UCR1_TRDYEN;
 			imx_uart_writel(sport, ucr1, UCR1);
 			return;
 		}
@@ -877,7 +877,7 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 		usr1 &= ~USR1_RRDY;
 	if ((ucr2 & UCR2_ATEN) == 0)
 		usr1 &= ~USR1_AGTIM;
-	if ((ucr1 & UCR1_TXMPTYEN) == 0)
+	if ((ucr1 & UCR1_TRDYEN) == 0)
 		usr1 &= ~USR1_TRDY;
 	if ((ucr4 & UCR4_TCEN) == 0)
 		usr2 &= ~USR2_TXDC;
@@ -1466,7 +1466,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	ucr1 = imx_uart_readl(sport, UCR1);
-	ucr1 &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN | UCR1_RXDMAEN | UCR1_ATDMAEN);
+	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN | UCR1_RXDMAEN | UCR1_ATDMAEN);
 
 	imx_uart_writel(sport, ucr1, UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -1771,7 +1771,7 @@ static int imx_uart_poll_init(struct uart_port *port)
 		ucr1 |= IMX1_UCR1_UARTCLKEN;
 
 	ucr1 |= UCR1_UARTEN;
-	ucr1 &= ~(UCR1_TXMPTYEN | UCR1_RTSDEN | UCR1_RRDYEN);
+	ucr1 &= ~(UCR1_TRDYEN | UCR1_RTSDEN | UCR1_RRDYEN);
 
 	ucr2 |= UCR2_RXEN;
 	ucr2 &= ~UCR2_ATEN;
@@ -1931,7 +1931,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	if (imx_uart_is_imx1(sport))
 		ucr1 |= IMX1_UCR1_UARTCLKEN;
 	ucr1 |= UCR1_UARTEN;
-	ucr1 &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN);
+	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN);
 
 	imx_uart_writel(sport, ucr1, UCR1);
 
@@ -2287,7 +2287,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	/* Disable interrupts before requesting them */
 	ucr1 = imx_uart_readl(sport, UCR1);
 	ucr1 &= ~(UCR1_ADEN | UCR1_TRDYEN | UCR1_IDEN | UCR1_RRDYEN |
-		 UCR1_TXMPTYEN | UCR1_RTSDEN);
+		 UCR1_TRDYEN | UCR1_RTSDEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
 	if (!imx_uart_is_imx1(sport) && sport->dte_mode) {
-- 
2.10.0.1.g57b01a3

