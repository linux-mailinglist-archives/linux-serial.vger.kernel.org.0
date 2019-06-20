Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62EF24D0B0
	for <lists+linux-serial@lfdr.de>; Thu, 20 Jun 2019 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfFTOsK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Jun 2019 10:48:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41157 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfFTOsJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jun 2019 10:48:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id s21so2964003lji.8
        for <linux-serial@vger.kernel.org>; Thu, 20 Jun 2019 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SMvfNXrBGoXH5Rlv9ONYJ/L8T8ix7gsLxKZmilMNxjo=;
        b=aqRlB+88y7te1IyXTJCENFWgDaJpY4yVvKtbZbxKe26ehEh2Xo9cv16sRswEyd1jD3
         DtKwsymBxxPKb1vvY8jYXdo6bo6sgsQFjIlwHGGgcsLOMEWMQW1b2kP/+VP8FQI24AKL
         mbm54fHZ9EqlQC76uDpkj430XOanlM7xc1lxJQi81T+4l1SmY1bTj3yuW65KdPkJXD5I
         5yvmA8XLP7qkEHuvHbm7XhJtPUQACMxxWUeIZ4KCTM/ktS61iRM+Jsnvggo0XHG1gczY
         IiOYjKMOtcOrILvlt8XDH34ictcBvOi+O4R5oB6oFREYtUgiFxhLD7lO3RJsen1Gs25k
         y3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SMvfNXrBGoXH5Rlv9ONYJ/L8T8ix7gsLxKZmilMNxjo=;
        b=XtgvhIKuRHUqRIDqZDFOcPijOnkvuP23gQxqg5GFuHxAeYOuoJURJRfM/dst5SwWQs
         siZ0mRuLNj1hTygUcWVSnHKChYJvynV4m+4bYRMG9tMk2AgtCce6AIyqo8MOBU/8glN8
         fhNKCmu1Fa1W8PxaFlojzb01H3x82jCqdK8Q+o4hu9hxQovPKe791bK0802N4Ni5tE4f
         JYJnXNg6n5WHcNBpLmdiN3TvCKIrks+uoibkGEG1GRvaL2g2K6nKbp8oc/18Em2ItJes
         yVCLGRYxr3XuijCmNcuf3C+c5iYjGN3zBe/1AEa3mxejpSUztOukRWkh/l9uHo396LNs
         Zq2Q==
X-Gm-Message-State: APjAAAWpFX32EchHIbpSaXtmdu9dkFc9A0w+QKKcWbefDgEgCYFCMUuO
        +G6MUDTKlqZ1cx69k5iG2SU=
X-Google-Smtp-Source: APXvYqzDfRIywJKMMIfRolNAT3UYVW4ndj63y5PejziUGG/Me/WSmmsouEJI9FwyllAa+MIvX/MpGA==
X-Received: by 2002:a2e:8559:: with SMTP id u25mr22892247ljj.224.1561042087903;
        Thu, 20 Jun 2019 07:48:07 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f10sm3577768ljk.95.2019.06.20.07.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 07:48:07 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC v1 1/7] serial: imx: fix locking in set_termios()
Date:   Thu, 20 Jun 2019 17:47:47 +0300
Message-Id: <1561042073-617-2-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561042073-617-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561042073-617-1-git-send-email-sorganov@gmail.com>
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

