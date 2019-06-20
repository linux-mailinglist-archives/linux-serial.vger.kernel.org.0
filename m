Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2334D0B2
	for <lists+linux-serial@lfdr.de>; Thu, 20 Jun 2019 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfFTOsM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Jun 2019 10:48:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34227 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfFTOsL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jun 2019 10:48:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so3001651ljg.1
        for <linux-serial@vger.kernel.org>; Thu, 20 Jun 2019 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MnAE4r5Gl1VIMZviL9ksOeXJGJoVijEdryliB0x51XQ=;
        b=esADZiMgQW0phjcMP5wGBWdGf0sjWXZVlUmxjk3spgkE/2OYr3lKq6mqsOhzTXqQTz
         ukrVC0PnYxysphIT72J+suxXuM+zzaE6PC8qMPXxAuV/4nAYBnfhsD5MoZ4XQ91mFNNJ
         /zowM5mm9mSgyrnhhUn/AXHgM7i5bdxbxQLSzlHmIG+DOezY6j3Usr+zlDoTIg/Y1DYR
         bzJ8UvMloxzecGl0ZCInvukHiBubu3yzoJPTjLfQiroCfEZqMq93myXDzXQP1uzt3f0c
         m/cKWIacS1yy1Ggyfq5cShrzF7N4WF73SPj6z6/NcYru+XuJmRdJNTvWL02kcSitUXjF
         6J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MnAE4r5Gl1VIMZviL9ksOeXJGJoVijEdryliB0x51XQ=;
        b=HQ2Wpf8RiVlxBt9uwJuztn4ERvUM4BsyVuUriXMDYfgEeDSWjR1L5Rhz8WZJxSwp7j
         YO+GO4xBgm+QYS2uSkz2erW7Kr4NsoFbqLCBZkc05OQ/hQI2Lr/PpjvQ6A9mmD6N8Pij
         U/6xb2N7wWBQiV9vC7JTsEJtWjIK5V2ISXOIHN3GY9XAfA69xj9zBM+qZExn1ZZS3ZEC
         mPihVw619UH8abux5zsBtGNCaFTKIOWPX8KeuGZSeJUnM3jb+5Tr1Eabyspr8Mj7Gd+D
         PyKUidlVhdNLIUKl8XsaE9ieGGm/h1pCYhO2j+zAeDJcd/lu30rthTULVv+HargOEoKK
         yNeQ==
X-Gm-Message-State: APjAAAWBqF+75C4QKjayUBlB4B8GV3Q9gNVRwbrgWoTT0wRhSAGL7+0b
        LRyFGDwTbU3ks2uYx2KryuY=
X-Google-Smtp-Source: APXvYqyAnGzVJ/Osqss5wtdaH9tLn+JR7FRReDUCijI7YySbgQBmR2hFw/wCoPHZYc2MS5T3JLwUfw==
X-Received: by 2002:a2e:989a:: with SMTP id b26mr9690786ljj.31.1561042089823;
        Thu, 20 Jun 2019 07:48:09 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f10sm3577768ljk.95.2019.06.20.07.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 07:48:09 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC v1 3/7] serial: imx: set_termios(): clarify RTS/CTS bits calculation
Date:   Thu, 20 Jun 2019 17:47:49 +0300
Message-Id: <1561042073-617-4-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561042073-617-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561042073-617-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Avoid repeating the same code for rs485 twice.

Make it obvious we clear CRTSCTS bit in termios->c_cflag whenever
sport->have_rtscts is false.

Make it obvious we clear UCR2_IRTS whenever CRTSCTS is set.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 87802fd..17e2322 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1567,35 +1567,25 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CSIZE) == CS8)
 		ucr2 |= UCR2_WS;
 
-	if (termios->c_cflag & CRTSCTS) {
-		if (sport->have_rtscts) {
-			ucr2 &= ~UCR2_IRTS;
+	if (!sport->have_rtscts)
+		termios->c_cflag &= ~CRTSCTS;
 
-			if (port->rs485.flags & SER_RS485_ENABLED) {
-				/*
-				 * RTS is mandatory for rs485 operation, so keep
-				 * it under manual control and keep transmitter
-				 * disabled.
-				 */
-				if (port->rs485.flags &
-				    SER_RS485_RTS_AFTER_SEND)
-					imx_uart_rts_active(sport, &ucr2);
-				else
-					imx_uart_rts_inactive(sport, &ucr2);
-			} else {
-				imx_uart_rts_auto(sport, &ucr2);
-			}
-		} else {
-			termios->c_cflag &= ~CRTSCTS;
-		}
-	} else if (port->rs485.flags & SER_RS485_ENABLED) {
-		/* disable transmitter */
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		/*
+		 * RTS is mandatory for rs485 operation, so keep
+		 * it under manual control and keep transmitter
+		 * disabled.
+		 */
 		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
 			imx_uart_rts_active(sport, &ucr2);
 		else
 			imx_uart_rts_inactive(sport, &ucr2);
-	}
 
+	} else if (termios->c_cflag & CRTSCTS)
+		imx_uart_rts_auto(sport, &ucr2);
+
+	if (termios->c_cflag & CRTSCTS)
+		ucr2 &= ~UCR2_IRTS;
 
 	if (termios->c_cflag & CSTOPB)
 		ucr2 |= UCR2_STPB;
-- 
2.10.0.1.g57b01a3

