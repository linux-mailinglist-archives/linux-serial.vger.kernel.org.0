Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4550C5F8BD
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfGDNBI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 09:01:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45699 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfGDNBH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 09:01:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so6061583lje.12
        for <linux-serial@vger.kernel.org>; Thu, 04 Jul 2019 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=942xX7/V43Ir1tZd4dDu7UDtPNxQiTaRZHtBvgqzC20=;
        b=imkrJQTXeoCo8VKvKTQH1Zi9kdVDhH/6Fx3fbqCpkyMPM0wgU0Pl92amh1sgyMbmMy
         hYHMzXqjcincO+2Q5AVz6uvhjs3/y+qY2NxNAffVMbGBFPUiGZy7P9dN/upb2tFYsj1T
         fa8/81F5TuP0VILsBxjglJv9M+BbbXeW1LgKBTMODnZM+C5U4Kfivf8O8tu+VZcf3b3E
         i1HgLGdovYDFlYijCUh/pEHKJwTlKsJjyz24T25r4lnPiuJBxAc3SXPm0IwY2MgFFevG
         BeiBMvPVXZtIXN3YRRGX//T5nGdetdZ25iKgkWilaI9nokBzN3XIQaZBzrpy2pyLcLWs
         /uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=942xX7/V43Ir1tZd4dDu7UDtPNxQiTaRZHtBvgqzC20=;
        b=apoFoNXFN6gPB5FZakwdlCY/BC9+0iKPstNTFUWZAfhbBjpz9/w6snTEvijjzeJZ96
         TegDaJziLxsDG7AZqPZNQPsfGMj0SDUYoLk+xISj9ZMGtylm7wiuUWDL784u4M+R4ytj
         sQogUANcCtIydW+G5TqH0xAuY45jTsItLQZJqIymgoBxxKFA0yvZoUO1VNRA2o86fgds
         xr5rEwo4+jWW8Gpfl28qQ+TnxNrcZ/DQ/Q/cx5EL0LoomvO1oBsupPiDdqwmcq83wib2
         9T9Ub6BoHT9kM22w3t9cNi1tTyqDtgjTXYylo7eaMiUJCzRVWIsIGgYaVhs0H8l61LI4
         QaKg==
X-Gm-Message-State: APjAAAX1Jg9PUqciXhkH3fMfhFFSFQOrulwcttCVCSym0I0D6vwQS3Tw
        DD1xOJBhqjQUE3oyKcB6VbjtzdTu
X-Google-Smtp-Source: APXvYqwWzSpI+jWTSs7/U42qZ07CYj0qsddqPziA/5CTyO80U0gZgQNLmTFWC7Wd20kSqsdhSFw4gw==
X-Received: by 2002:a2e:981:: with SMTP id 123mr25025470ljj.66.1562245265485;
        Thu, 04 Jul 2019 06:01:05 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h1sm485914lfj.21.2019.07.04.06.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 06:01:04 -0700 (PDT)
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
Subject: [PATCH v3 4/7] serial: imx: set_termios(): preserve RTS state
Date:   Thu,  4 Jul 2019 16:00:26 +0300
Message-Id: <1562245229-709-5-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1562245229-709-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1562245229-709-1-git-send-email-sorganov@gmail.com>
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

