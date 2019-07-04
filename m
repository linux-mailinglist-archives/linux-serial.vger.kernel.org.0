Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49CAD5F8BA
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 15:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGDNBD (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 09:01:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42969 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfGDNBD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 09:01:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so6068753lje.9
        for <linux-serial@vger.kernel.org>; Thu, 04 Jul 2019 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bILvk7zww/MHzS0Ry8ydW5zQpvSdBYxtDr+zE8tM+sU=;
        b=jMNp8dC0A+sar0j+Ndv2aZcg+m3SjKWN/qql2KbBPlRWm3MHYJ8akksCCNPYMD8J4l
         4OPaCADR1zli5dsaAtbhCQFInApBlhTWZVZWUyGWgByqiH5/WIkVE/E/r65y9UlAYyCp
         cEGYQ2Fz27/v/Y6QegXtdZFNfg6XEyTzebOIe0OO/2xKABH9tD1UQJbDPwXD3wQ71wqY
         2/nhBLK5ntmjo2Ubnf5i6xQi7ZglF7sIHR5IArXx4eeCG4OwmhYKnMn+k8hVtdhn0eWi
         M5DQ9Z0ET1yMFygcSBJ73IKC2JVjIatVm8U60D9Bvzx8GDItnOPCJtwcfmo4H+vlQI36
         NInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bILvk7zww/MHzS0Ry8ydW5zQpvSdBYxtDr+zE8tM+sU=;
        b=BD2HuRXw7SqmRb1Xbu1UnZM/YtIIqkDW/vPtL9voGv+WzjnPQIzsEFZqiLFTE5+qZF
         Q9ylewbWbbWVxCtDnoffDRk+8yKRxMUzVJeUv4Z8QVhLq6dIEpj2i/KcZijTwISIWoY7
         QdY/C6YQP5jBy3BYiWmqNo7JX1IKlw25N463AMLbhPR1FIFzSlYpmcmvv1NfQWMP75z3
         +mTflPmtUQzPVDS9odHP9VWgXKPmS0TqpLkV2d8udrN1+rrAIxQl9r3fNDzZrwg90YSP
         1geQQ2yuorc19ZGjsl759SnERZtmb0YOQfPjrNE7ebRS9QCijuovb8htPw3GcfMSVZZS
         F0Ug==
X-Gm-Message-State: APjAAAW9Dxz7QC4GgvY7uWuYUwpNHGM0bLIcsbtLOi02wNZYYVIjNUK6
        fxShq4+Zx+CYx+2NFrfnea14beEF
X-Google-Smtp-Source: APXvYqwqe6vwvjs4G2dhy4KMCh3DxCD4S1TAcq7FkC6YdKvcUHqEmzDueEOmUFZoOHStbQl7zawztg==
X-Received: by 2002:a2e:88d3:: with SMTP id a19mr11892513ljk.32.1562245260861;
        Thu, 04 Jul 2019 06:01:00 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h1sm485914lfj.21.2019.07.04.06.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 06:01:00 -0700 (PDT)
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
Subject: [PATCH v3 1/7] serial: imx: fix locking in set_termios()
Date:   Thu,  4 Jul 2019 16:00:23 +0300
Message-Id: <1562245229-709-2-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1562245229-709-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1562245229-709-1-git-send-email-sorganov@gmail.com>
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

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

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

