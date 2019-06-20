Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86784D0B3
	for <lists+linux-serial@lfdr.de>; Thu, 20 Jun 2019 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfFTOsM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Jun 2019 10:48:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36382 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTOsM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jun 2019 10:48:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so2982237ljj.3
        for <linux-serial@vger.kernel.org>; Thu, 20 Jun 2019 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zDXBWhuIJraZ+zpNVsz4D9shiJ9Jh7WL+xtta/xOGQA=;
        b=NrHeV0Jtfe5Cqfpq2CMkT9X2zY+Ip0ARkWJqZJHs7fd8VJ9rX1I0CSeu8VELzEOPdc
         9yyvbF7do/4gD92Ej05poMljxb7sWPAg/wStTCMDtDl7p4gMg+0CnmPqPoH+mInbRIY9
         KLpOPTMiiyOyBYP5j2yO4cPusr7zgEgUz/V3OseUjjPApgDC8hrMgLPZ2hYlaNcV4P/0
         R/EK3xdjiAV+tj9FJsfLEIOEtZuFCf/lD16yXBSA1gT7mt22TXJWRNX9FomFi+yONkVv
         Un9QOSe91rrRhcS0cUESSNdxbNv9PtIE6mXua/1ItbporbMpSBJUOeokc+gLasWxQDi0
         ZaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zDXBWhuIJraZ+zpNVsz4D9shiJ9Jh7WL+xtta/xOGQA=;
        b=W3k71xkfEvfgJxwegj1PqX6J81s1dpj4NOUQnOm/CvnLJm2iDWZDzs9xQi7axVpX0M
         8fTeG4+OjMa29XUDuKU6GJWaQQFhZCvIdF3rgiS6S4yvgk+tCIFwT2XssU3LPhxo/SGM
         Q4K+nh9AQwkBKUMhi/W0gTJhtgsZL65SoeDlyTet34NlCY6LsTZ38Sr8FHxPypDj1d0F
         glkBMnMuMeEMIf30QseOuzabfZzAAdT35GNfwFyIYLAT/uKbLkdn2xBf5XWnWH5dBRnS
         NhOzzBO2cniFNm5kz45JFzlynmSxEvYVxmjFkDb1Dnyp2oiZUNfkBK4db1CUG6joi6VR
         wu9g==
X-Gm-Message-State: APjAAAXF0X3YFQE7ho6MlCAcPgU5GQhGOsFZ7lY2+0x5gJ6TfOQbx2k5
        IM34F33ZKmCZqP+vdvGw2vY=
X-Google-Smtp-Source: APXvYqx27D35b009mAgFwoWJHWOY4wSxlGLazVqCJGBL/1yAes9mXjxYjYj7WEfHIbsHOkEGRojWIg==
X-Received: by 2002:a2e:3807:: with SMTP id f7mr29431101lja.87.1561042090600;
        Thu, 20 Jun 2019 07:48:10 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f10sm3577768ljk.95.2019.06.20.07.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 07:48:10 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC v1 4/7] serial: imx: set_termios(): preserve RTS state
Date:   Thu, 20 Jun 2019 17:47:50 +0300
Message-Id: <1561042073-617-5-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561042073-617-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561042073-617-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_set_termios() cleared RTS on every call, now fixed.

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

