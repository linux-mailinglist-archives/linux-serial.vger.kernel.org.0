Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E4956B92
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 16:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfFZOOS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 10:14:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42333 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFZOOS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 10:14:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so2362802lje.9
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bZEuBr/u7QmcmUUX/8Ym5nImEHkVz1m2bXUhPQcNDuE=;
        b=PSS223db/d4jR+7QIlHArthBCcpQqnYC18l7YmJGLgfztQImucQ9dT1X9xs0qtTis2
         gYnkmfT5qfyFRpplR2r+qA0NX5D3VfPlGczY1z1dyzCrMrGQF/rClvOTdgW72zWSUs4L
         Kpn2C4UfaJxv91FtrCm7Tioe0NYV4xzlllwqtJTY1qgvPfwSxZ2DtY1o9G1KJfa0dFO/
         2R3o79DIoEe2KhqfXlq44zZCe6YiMLYeJCWp3hyGx8LCFsyhwDBj/YOrCKltKhcIR+n5
         AeBGt9Iy4xR8Wqgh70rpydWSZ+V4iP2y/LTSIR6uzbdT/ulcZ6Iw0GqrwyLi9NDWuLH+
         kPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bZEuBr/u7QmcmUUX/8Ym5nImEHkVz1m2bXUhPQcNDuE=;
        b=LXifazhqFdrs8tTrsCLLE2OQXFdhG4CFnAtvzQxy9pNXyoaClPjHCVR6d3I20FDchq
         blX01ZHSz9yY0G5/5hPhQ6eBYYX8gZ77QTHVzKCJJ3h/gZikX8vc4VajhZWTRI+yJjLx
         y8msZPWdJHAw4/mbxj6juNR9pyKSfmW7FLyCn6BPNq4JF5gYRW4rCPyhy0OdN2zuSfRV
         fzB6Oe8mYndhRXA8kuj+C4/7T91rlr7FsMbeYtEvDR07lSfZ10o/iPPs/crpAkJoK+do
         LSZfEljNu27i2JLwLkg6gVnpovlp/Y6GQFZZMibw979B3CbAZIcXYCbfIYj/wgaD29SS
         M70g==
X-Gm-Message-State: APjAAAUTea21B+rKaoAhJHsQgXzkmcE3mXXYqrktq5jSwQ0Vh27QVqFP
        iurYL9zY39Od+PiIB5mAHgE=
X-Google-Smtp-Source: APXvYqzoEA2Ur4kBMLRQMwb8qjOtucgHIrwKndnQ/vYw7CBLOdEYrcXt8Ekye1Bai8jgGYBgMf8BVg==
X-Received: by 2002:a2e:9250:: with SMTP id v16mr3048462ljg.89.1561558455912;
        Wed, 26 Jun 2019 07:14:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 25sm2863825ljn.62.2019.06.26.07.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 07:14:15 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 1/7] serial: imx: fix locking in set_termios()
Date:   Wed, 26 Jun 2019 17:11:27 +0300
Message-Id: <1561558293-7683-2-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561558293-7683-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
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

