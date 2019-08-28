Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C895BA09C0
	for <lists+linux-serial@lfdr.de>; Wed, 28 Aug 2019 20:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfH1SiM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 28 Aug 2019 14:38:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39839 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfH1SiM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Aug 2019 14:38:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id l11so386618lfk.6
        for <linux-serial@vger.kernel.org>; Wed, 28 Aug 2019 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=94QLFZILjt+R9uSIMn5NXhRdv4CTLDwWL1ZhIXmN8/k=;
        b=Sjx0JPFQ/5mQv31+zaAUpoNMO8NFVJxuk3E3z5By6c7YxoY2DLLWAsyuK8VBvNjW4k
         to/np/EkNWr8OlyM+Gj48cM08KgfJGu+TNYK3vu4/CpUfaowY1K/F0AnjH5zOsm5xxkq
         P1lw53K1cjGIap8kNep75ayFBzuZSmMEtq3IIhPLPUYPfBD8m85ToiTLREDNFZtCiydR
         e4/dRUBW7Bklflimdx1lY1EGwjNtMd30I5nMbzYxVrjuA7X1LlP8ixJ5oaHHuXkFDJ81
         Qufo+R/MZ+2lm/JqaAURsKeo4AZ/6Xd1X5pWwRvEjZq/7OC/Aj40yIkTYAmeTA6htl1i
         rATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=94QLFZILjt+R9uSIMn5NXhRdv4CTLDwWL1ZhIXmN8/k=;
        b=F4qH0CGyBJ3un1KDwQFICSHpZacrw4pFZxwT0JdvleDo5XiSGeC09Y+UO7uZDzatnl
         WTE3e/qjO/zWKcsEFcVhwNlEoItFVI1KVImSzZfMmeJvxJ/6r/8EXMiXi5JAt0vfzTWl
         lBR2Ce3CrXFNn+BHm7TF2YswE1+CjPoeVFyo0Uqba/PVVpoEHkmErYRJPjMVkhdONFRg
         gvySNbWjdbY8K7nWsQlMAIXdv4VmxMpS4VMuuUL+2GZuGDQO70nXAcEC5Pi8+sfbLzLT
         Jab4/GsdzplbRivrKgywwovsiFNDiqDKBOJMBLlA5Ik46LkZWLUh44F0Fh/bae3RhK+p
         vPLQ==
X-Gm-Message-State: APjAAAVMXFe+V3VH5Czaph4UwHfUEsZtD+ErjdsdXDWeU+3rVjY6Z8VF
        DpCOvd01yjPBr+x3RCK7D4jQ9iFc
X-Google-Smtp-Source: APXvYqyA2PnTA5e5wDo86A8QDyQ/uPkRhx8VsUeKRQC0LY4ZwQ5XaUQrYcQbrYeVaWZkr9A/n1G7vQ==
X-Received: by 2002:ac2:4289:: with SMTP id m9mr3747085lfh.49.1567017489554;
        Wed, 28 Aug 2019 11:38:09 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f6sm9226lja.16.2019.08.28.11.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 11:38:09 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 5/5] serial: imx: use Tx ready rather than Tx empty irq
Date:   Wed, 28 Aug 2019 21:37:55 +0300
Message-Id: <1567017475-11919-6-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1567017475-11919-1-git-send-email-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <1567017475-11919-1-git-send-email-sorganov@gmail.com>
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
index e89045a..87c58f9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -439,7 +439,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 		return;
 
 	ucr1 = imx_uart_readl(sport, UCR1);
-	imx_uart_writel(sport, ucr1 & ~UCR1_TXMPTYEN, UCR1);
+	imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);
 
 	/* in rs485 mode disable transmitter if shifter is empty */
 	if (port->rs485.flags & SER_RS485_ENABLED &&
@@ -517,7 +517,7 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 		 * and the TX IRQ is disabled.
 		 **/
 		ucr1 = imx_uart_readl(sport, UCR1);
-		ucr1 &= ~UCR1_TXMPTYEN;
+		ucr1 &= ~UCR1_TRDYEN;
 		if (sport->dma_is_txing) {
 			ucr1 |= UCR1_TXDMAEN;
 			imx_uart_writel(sport, ucr1, UCR1);
@@ -679,7 +679,7 @@ static void imx_uart_start_tx(struct uart_port *port)
 
 	if (!sport->dma_is_enabled) {
 		ucr1 = imx_uart_readl(sport, UCR1);
-		imx_uart_writel(sport, ucr1 | UCR1_TXMPTYEN, UCR1);
+		imx_uart_writel(sport, ucr1 | UCR1_TRDYEN, UCR1);
 	}
 
 	if (sport->dma_is_enabled) {
@@ -688,7 +688,7 @@ static void imx_uart_start_tx(struct uart_port *port)
 			 * disable TX DMA to let TX interrupt to send X-char */
 			ucr1 = imx_uart_readl(sport, UCR1);
 			ucr1 &= ~UCR1_TXDMAEN;
-			ucr1 |= UCR1_TXMPTYEN;
+			ucr1 |= UCR1_TRDYEN;
 			imx_uart_writel(sport, ucr1, UCR1);
 			return;
 		}
@@ -874,7 +874,7 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 		usr1 &= ~USR1_RRDY;
 	if ((ucr2 & UCR2_ATEN) == 0)
 		usr1 &= ~USR1_AGTIM;
-	if ((ucr1 & UCR1_TXMPTYEN) == 0)
+	if ((ucr1 & UCR1_TRDYEN) == 0)
 		usr1 &= ~USR1_TRDY;
 	if ((ucr4 & UCR4_TCEN) == 0)
 		usr2 &= ~USR2_TXDC;
@@ -1474,7 +1474,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	ucr1 = imx_uart_readl(sport, UCR1);
-	ucr1 &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN | UCR1_RXDMAEN | UCR1_ATDMAEN);
+	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN | UCR1_RXDMAEN | UCR1_ATDMAEN);
 
 	imx_uart_writel(sport, ucr1, UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -1778,7 +1778,7 @@ static int imx_uart_poll_init(struct uart_port *port)
 		ucr1 |= IMX1_UCR1_UARTCLKEN;
 
 	ucr1 |= UCR1_UARTEN;
-	ucr1 &= ~(UCR1_TXMPTYEN | UCR1_RTSDEN | UCR1_RRDYEN);
+	ucr1 &= ~(UCR1_TRDYEN | UCR1_RTSDEN | UCR1_RRDYEN);
 
 	ucr2 |= UCR2_RXEN;
 	ucr2 &= ~UCR2_ATEN;
@@ -1938,7 +1938,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	if (imx_uart_is_imx1(sport))
 		ucr1 |= IMX1_UCR1_UARTCLKEN;
 	ucr1 |= UCR1_UARTEN;
-	ucr1 &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN);
+	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN);
 
 	imx_uart_writel(sport, ucr1, UCR1);
 
@@ -2294,7 +2294,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	/* Disable interrupts before requesting them */
 	ucr1 = imx_uart_readl(sport, UCR1);
 	ucr1 &= ~(UCR1_ADEN | UCR1_TRDYEN | UCR1_IDEN | UCR1_RRDYEN |
-		 UCR1_TXMPTYEN | UCR1_RTSDEN);
+		 UCR1_TRDYEN | UCR1_RTSDEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
 	if (!imx_uart_is_imx1(sport) && sport->dte_mode) {
-- 
2.10.0.1.g57b01a3

