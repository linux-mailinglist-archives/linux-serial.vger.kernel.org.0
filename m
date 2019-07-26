Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB9C771A7
	for <lists+linux-serial@lfdr.de>; Fri, 26 Jul 2019 20:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbfGZSxW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 26 Jul 2019 14:53:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43807 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388000AbfGZSxW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jul 2019 14:53:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so37750978lfm.10
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2019 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jZWmDj4ynzd3H3aeFWqnlP+/VckrZm4pXfnfA3698MQ=;
        b=t5TcUS9UG2i5BR3IcZr5CmtPv66vh9zRIHMqIt473cvspguf8CZe3XhCSnDOBGMWA6
         eldCZ9MHwOB4FqX2NZ9kFZpblp41KqM86nHTzn+sDqjcpEMN9SVPfjbqah+X7cjKkxj4
         UBkGk05DQBCAk/uvjG5M9ZopALgp/vk9DFqrR2LoN4zW2D93/gi36smZWEzb9HlNSIAA
         K/7v6gZ9G4RpQifGemYt1Gj9BO/W8h/HMVFX7tOywWxr/hON/wIs2L3VERCK7ZbeOcec
         owqpIWi5oNY4OblefEjU6W2VBwpQY/XxfgIzg93eACVx2iqMnKdX1blwnXuXxLkig3R7
         b6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jZWmDj4ynzd3H3aeFWqnlP+/VckrZm4pXfnfA3698MQ=;
        b=DmSv0tM8kfIayoM38GsUGoLhSLOHWM50DQpA2WtkK+ukh/Y6+vLkbu9tIHD1xtLkYn
         G6MM+JOGH6sCA60FIMLMFcunPZ/EgMKDp3I1emiTFLa/2BVDUT1HBYYpix9rL17dUmyJ
         gyngcsjz9p7X2uYMYRlpbb6plMIMC6Pivcn4KE86qXRIQXG7m8Wu0oNPyqhzRF04Im/n
         jo/MJ1V3Ip+H3UfcfFIZ1VQTmaJ7sorv2fKw7TKPH0n3SERGzz3NAO1nj0kkZ44cOp7M
         fSPVeEeiTWpM0EOybpkYGFyuFBnrBFYBYkEwAbApirZyzPeOw85tAsxmxhzlRpmicmQF
         chcA==
X-Gm-Message-State: APjAAAXubVYpwOO1iXLgrcrn81/DibfI+ea66pE/ms0X1LjopqcKtL24
        Wgbq1F1uRy01kP0ScjyZv5YP634l
X-Google-Smtp-Source: APXvYqyGHeBm5PjleeluML4AzpxpOJHQoGmOKRykfTe+PMMgtgbeCze1llNiRpIuXxA9yu4ft7G/bA==
X-Received: by 2002:a19:5217:: with SMTP id m23mr44591619lfb.124.1564167199911;
        Fri, 26 Jul 2019 11:53:19 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u15sm10254810lji.61.2019.07.26.11.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 11:53:19 -0700 (PDT)
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
Subject: [PATCH v7 2/3] serial: imx: set_mctrl(): correctly restore autoRTS state
Date:   Fri, 26 Jul 2019 21:52:40 +0300
Message-Id: <1564167161-3972-3-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1564167161-3972-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1564167161-3972-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
turning handshake on only when CRTSCTS bit for the port is set.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 32f36d8..059ba35 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -974,10 +974,22 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
 		u32 ucr2;
 
+		/*
+		 * Turn off autoRTS if RTS is lowered and restore autoRTS
+		 * setting if RTS is raised.
+		 */
 		ucr2 = imx_uart_readl(sport, UCR2);
 		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
-		if (mctrl & TIOCM_RTS)
-			ucr2 |= UCR2_CTS | UCR2_CTSC;
+		if (mctrl & TIOCM_RTS) {
+			ucr2 |= UCR2_CTS;
+			/*
+			 * UCR2_IRTS is unset if and only if the port is
+			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
+			 * to get the state to restore to.
+			 */
+			if (!(ucr2 & UCR2_IRTS))
+				ucr2 |= UCR2_CTSC;
+		}
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
-- 
2.10.0.1.g57b01a3

