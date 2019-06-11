Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA13CAB1
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbfFKMGT (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 08:06:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41277 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbfFKMGS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 08:06:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id s21so11363826lji.8
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2019 05:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7A8q3L9M+Q620jro/rcp0uqzd0O66Enq7x2/73E1cNU=;
        b=H/c7NadWC2gvucHKBh3SHsh2NBJsoLUPFyHnbC/goL+NAscUNTUVtaHv5fR+RPMNLe
         Yu2HDXX9FAvV8Q+yrU2Lr4buZvs04m/pNgmNsBfRW0vrE6BqfuUAhrdtCGSLs5zmEKh0
         ucE7Q/K+M9WHEVfM04WVHj+GvHyCmNyiwP65817wHckWYR2k5dWJsb3EjWfJvw8s1dV3
         fS7zEynYpIGurEzyUwlnzTa51LwXCv8EV8eE2NqJwjasFTttw6XYKhliqLHrNMmrzpb8
         zZQ4qdkrFb0gLj8ppTdIEOaxOT3eMj/+JLPyD1Ek5g9TCrCJdsFZcZ/n/oyua4/Dtg/X
         /HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7A8q3L9M+Q620jro/rcp0uqzd0O66Enq7x2/73E1cNU=;
        b=MMAKui+SFDj24Nj2r42Aq4ojvt/g/VYoq2tdZulfygsG7ymiqmFrg/Lu++mOuBP5CN
         OYVQ9YRpIFOPnVqHYCctxwP08LTtSpcp4x/N7IgSwJCtBFXVSg99+goTnG/97BvXyX3B
         WidRs6tB2rECYljKpPnSm7rZehlCL4l5DP+Tb5ctW2TzTxSo9fsPOcaPtZL2QFTr/Q9y
         sLec0jO5VUfTK7fuVh4NCX0o8p+4ulSIWsp8h28EQTp9enlD9E8jEY6NXmCc6tHS8Aal
         vmQUGPJWpNSlKaDyhbBYt5YLw6KJ73IvQ6A09sr6elm8Ux9DTAkRmkAZu621tYGKtJZa
         RxTA==
X-Gm-Message-State: APjAAAV7ouu8uSOh1/C513IpBlP96u8LceZIepDBMkFDbJa06b02ERuV
        GITG/XMSt8n39UJYB1R1I7LIjnek
X-Google-Smtp-Source: APXvYqyR3s6wUopyfHTJMJFbw9CfA7bRTxK7hA0nJwMRbWFCfd/HOh4klWcZQ9xGZpLXySJ4sGD6wg==
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr27536052ljb.30.1560254775461;
        Tue, 11 Jun 2019 05:06:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o74sm2498806lff.46.2019.06.11.05.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 05:06:14 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v1] serial: imx: fix locking in set_termios()
Date:   Tue, 11 Jun 2019 15:05:24 +0300
Message-Id: <1560254724-5130-1-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1559807977-4598-1-git-send-email-sorganov@gmail.com>
References: <1559807977-4598-1-git-send-email-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_uart_set_termios() called imx_uart_rts_active(), or
imx_uart_rts_inactive() before taking port->port.lock.

As a consequence, sport->port.mctrl that these functions modify
could have been changed without holding port->port.lock.

Moved locking of port->port.lock above the calls to fix the issue.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---

 v1: Improve comments as suggested by
     Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

 drivers/tty/serial/imx.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dff75dc..1055124 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -383,6 +383,7 @@ static void imx_uart_ucrs_restore(struct imx_port *sport,
 }
 #endif
 
+/* called with port.lock taken and irqs caller dependent */
 static void imx_uart_rts_active(struct imx_port *sport, u32 *ucr2)
 {
 	*ucr2 &= ~(UCR2_CTSC | UCR2_CTS);
@@ -391,6 +392,7 @@ static void imx_uart_rts_active(struct imx_port *sport, u32 *ucr2)
 	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
 }
 
+/* called with port.lock taken and irqs caller dependent */
 static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
 {
 	*ucr2 &= ~UCR2_CTSC;
@@ -400,6 +402,7 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
 	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
 }
 
+/* called with port.lock taken and irqs caller dependent */
 static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
 {
 	*ucr2 |= UCR2_CTSC;
@@ -1550,6 +1553,16 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		old_csize = CS8;
 	}
 
+	del_timer_sync(&sport->timer);
+
+	/*
+	 * Ask the core to calculate the divisor for us.
+	 */
+	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
+	quot = uart_get_divisor(port, baud);
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+
 	if ((termios->c_cflag & CSIZE) == CS8)
 		ucr2 = UCR2_WS | UCR2_SRST | UCR2_IRTS;
 	else
@@ -1593,16 +1606,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 			ucr2 |= UCR2_PROE;
 	}
 
-	del_timer_sync(&sport->timer);
-
-	/*
-	 * Ask the core to calculate the divisor for us.
-	 */
-	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
-	quot = uart_get_divisor(port, baud);
-
-	spin_lock_irqsave(&sport->port.lock, flags);
-
 	sport->port.read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
 		sport->port.read_status_mask |= (URXD_FRMERR | URXD_PRERR);
-- 
2.10.0.1.g57b01a3

