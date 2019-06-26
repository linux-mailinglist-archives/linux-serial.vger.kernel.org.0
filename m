Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE356B95
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 16:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFZOOU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 10:14:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36874 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFZOOU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 10:14:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so2385789ljf.4
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 07:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=942xX7/V43Ir1tZd4dDu7UDtPNxQiTaRZHtBvgqzC20=;
        b=vEcfd1F9kU6c3snTar1pRwW46ihzxse6+Y4VUj3JAJxwmk9OCvFHmCrgXUkECXemrV
         Zymaf5FxHIUjJpINJX1aZv67oSwDU6yvr4+D8p9ksaTnzQqQhR2Gzvj+EsilGzI4Q/MZ
         eRhsSYvTl3Mmhm+fJtjBz3xzGGjmvRsS2meP6ANBFPaIwfSFG/mcAgrQQ/4mIo1hlksG
         4l/x+5uF8kIXWJFbnXFgeEceXfL4zD80Rl9LO3YE9b1/bIJc6Zl6OTA4mFRMJmz0nfMn
         fA71nOeZTEmAjIiAFoLsnseNERzeivd+Et75vWsJo6qg0S7csKHSaFEihFyOsalu1MXP
         IVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=942xX7/V43Ir1tZd4dDu7UDtPNxQiTaRZHtBvgqzC20=;
        b=rG8FVgCycr3A03qMHuc2BMs3bmP8SVpAS8YZ7vBt2Jfsoi/7wRQsj8GUr1HSiU7xub
         +aZJ345VaSyGOzVFtzApprKmd36LyxVBJdchg4kwrm/1iqrpUuda0dr91hyrhDH6wiEp
         5OruWA4AZSwEyL18PD39uwHKRbjTMmNEQtHW1WeuEC1Oycs/O0Wolf6fwoAqb7oO/VIn
         O6UNhqkveDSUR+HNhjPdENBiQcvSeez1qba5vOCmyQ+Jg8ED4toFqa5a3AJ2DmE+O/8W
         8GMoEjl7SlISFz8zChSmfY5HaCG9MuSJhy97vTLltiNMjL+yuSgW+nr20E19XzVTDNng
         WW/w==
X-Gm-Message-State: APjAAAUkmt1sFYSaXUzJ1d/9ar+V1lwdoszJdQOV3+c2+RFKTIUKUv+Y
        ek3hSDTcQDdxtiPhriOvXGw=
X-Google-Smtp-Source: APXvYqzBCD/3G0Iiqs94s9c+nv/izaxNQc3GweYG/4vph5agy17vywn3RK+kSgUPvaJgNmPczA31fw==
X-Received: by 2002:a2e:9198:: with SMTP id f24mr3177704ljg.221.1561558458731;
        Wed, 26 Jun 2019 07:14:18 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 25sm2863825ljn.62.2019.06.26.07.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 07:14:18 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 4/7] serial: imx: set_termios(): preserve RTS state
Date:   Wed, 26 Jun 2019 17:11:30 +0300
Message-Id: <1561558293-7683-5-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561558293-7683-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_set_termios() cleared RTS on every call, now fixed.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 17e2322..e0f5365 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1563,7 +1563,14 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-	ucr2 = UCR2_SRST | UCR2_IRTS;
+	/*
+	 * Read current UCR2 and save it for future use, then clear all the bits
+	 * except those we will or may need to preserve.
+	 */
+	old_ucr2 = imx_uart_readl(sport, UCR2);
+	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTS);
+
+	ucr2 |= UCR2_SRST | UCR2_IRTS;
 	if ((termios->c_cflag & CSIZE) == CS8)
 		ucr2 |= UCR2_WS;
 
@@ -1632,7 +1639,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	imx_uart_writel(sport,
 			old_ucr1 & ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN),
 			UCR1);
-	old_ucr2 = imx_uart_readl(sport, UCR2);
 	imx_uart_writel(sport, old_ucr2 & ~UCR2_ATEN, UCR2);
 
 	while (!(imx_uart_readl(sport, USR2) & USR2_TXDC))
@@ -1640,7 +1646,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/* then, disable everything */
 	imx_uart_writel(sport, old_ucr2 & ~(UCR2_TXEN | UCR2_RXEN | UCR2_ATEN), UCR2);
-	old_ucr2 &= (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN);
 
 	/* custom-baudrate handling */
 	div = sport->port.uartclk / (baud * 16);
@@ -1678,8 +1683,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	imx_uart_writel(sport, old_ucr1, UCR1);
 
-	/* set the parity, stop bits and data size */
-	imx_uart_writel(sport, ucr2 | old_ucr2, UCR2);
+	imx_uart_writel(sport, ucr2, UCR2);
 
 	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
 		imx_uart_enable_ms(&sport->port);
-- 
2.10.0.1.g57b01a3

