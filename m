Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2BD45C46
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 14:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfFNMLy (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 08:11:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40299 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfFNMLy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 08:11:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id a21so2155340ljh.7
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2019 05:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SMvfNXrBGoXH5Rlv9ONYJ/L8T8ix7gsLxKZmilMNxjo=;
        b=OXEqXdFYrhgQa3V2TQRJ6AexhYZVCKIhb6Wb2iFCOCEBjuFOJsvlSGlw2eceWJHHuI
         J3HnTHQ/O69pnE7PhM11LQoC9pBVLOi8Le5efld4HJZ5cME2mtIHVpzxpwNWLYBJcNkn
         18L/HO059DbOznsGU6aJUH91YebrU8EEugRNjmIql3Yzus7dzWMKtVEnzugWhHGK9TzI
         6Z8vN3veiqG0OlqYRurW7nx/skf1qIoF6FnK7WLKdwM2+cjGuHE8hnyNEJMnQ0WzVSuw
         jx1tjf/WMkNVcvdlMfww+7kzk6IzSJXjWhD+vPQSYH2tpmrJbWd7z5wytPvrk6D7CGCG
         T35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SMvfNXrBGoXH5Rlv9ONYJ/L8T8ix7gsLxKZmilMNxjo=;
        b=aXFhYCPX0WJzpHdOMW+NQ99bZHLrNS9eS0KNI1roOdy53jviRvcAIQk2ysbwdSb+nf
         6FNZ31eVyMMxKNn0WvZ3LCZnKAva3mZ8B8Nj30K9ZVLm5s/Y6Y/xISqDA8lAjZZwYufw
         fDy30ikrv4znW90I+cBUn/GbL7Q5SiFB9b7maaPDvLUbHFFQcYuu18zm//jtHeDH0pcG
         YjSyNpkU8GhQiZfNHWVDOxoEI3qGXJNKQJiLouuLptUd9Zg1BM1Z9ytIxdtdGSXZZJiT
         q4gejBv89wgmPf24S9bPt6CX8wpwkUis+hlIut6YugVE2+oH0e0K9g9+xv9kl6Dej/zY
         pVrQ==
X-Gm-Message-State: APjAAAX89/lHalFRtBC3eKyzGhaj6USTMXFfRIVE7HqRpsW27ykV1god
        x6NWoL4xeX/NCkUZiwpSIXESi/UQ
X-Google-Smtp-Source: APXvYqyfSBKlleftIibV4Y83OfC6jOJA6VbY7mUXU01V8OkZkjsW9ihhGp/DrZuxDvinUc5ATsuWFw==
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr25518090ljk.3.1560514312085;
        Fri, 14 Jun 2019 05:11:52 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p27sm459683lfh.8.2019.06.14.05.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 05:11:51 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC 1/7] serial: imx: fix locking in set_termios()
Date:   Fri, 14 Jun 2019 15:11:28 +0300
Message-Id: <1560514294-29111-2-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1560514294-29111-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1560514294-29111-1-git-send-email-sorganov@gmail.com>
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

