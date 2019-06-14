Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F345C4C
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfFNMMA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 08:12:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34027 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfFNMMA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 08:12:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so1602857lfa.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2019 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pvz4HiqActHfdiRpn2UDi2+QMjvhRluYztx0f3X9Mpg=;
        b=ALprnGLKTGKIqLJ3QZLWDYLTuJaddVtQQM8XIhhQWPKi+WmSl1BLYvmCMjWMObXSWk
         E2F7WblfXqBqllh9IRtujow7PcUcprDpME3bsE8aA70KNvyOsuK7uJGLoFyHd59F8OdA
         Jp+KkN6U2p0+HElhlmfTJmDrC4Y/7CCnsbffBt+8PaIEzmtdzvYtJYHSnK63rCe3rTBl
         /XicR+oanY9KVZs32ZP0FqWRnqGHxl2dQjLH8Cm8/K0vYJ6jZvGeIChZurZShL5Cjlyb
         ngUiITPldNa92Dkh2gLfXmUnhkZtOV7pz9wOw40Z7NYbjemsvGVnit2vzn/qASLpfaHF
         rOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pvz4HiqActHfdiRpn2UDi2+QMjvhRluYztx0f3X9Mpg=;
        b=Bi9OVjCqvPI6BG6q/CB5nBBzB5B0IBSlekL6GzoEjVkB4Kbwnz+BJ6HMkQUx9cR69Q
         OSgh00klQJOt1Kx9nGzo+Xliv4h1d1FNMwviV/VNNcwVlbs7Lo3FrAd998mh2kjsAZxw
         X1/mvGgOwRpAvZgDKUYyzolvQUqU85kINam8Qe8Cx2rmlEjlzrEK2IEVujR2KAHjzoCR
         SlaulLv4LvIZU9p++yKm2Xz6T8YqcPs/6sNM5L578Xk3l1DMVJwKZS+5KMjAriNK7tp6
         FLJQWdrk225VfVg4yTbLbJit7Fjyg99hYq9ElkLwKw030GtyliaYCtcouzKm9ZTCyHzp
         licg==
X-Gm-Message-State: APjAAAXrqf6MVkYGzPqNWuSsqo+N4hcv12jWhTIz/IeaNGDbzAuO1Ygs
        Pg3nySMg5bla3T5gfHOwk/k=
X-Google-Smtp-Source: APXvYqy4Z/aRBglvdZ5tjtESTDHX1S/1sS3lr4b01PScZdlYvgVS908OnmwCYDrE/8k36xjHntXm9g==
X-Received: by 2002:ac2:5981:: with SMTP id w1mr27213594lfn.48.1560514318592;
        Fri, 14 Jun 2019 05:11:58 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p27sm459683lfh.8.2019.06.14.05.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 05:11:57 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC 7/7] serial: imx: get rid of imx_uart_rts_auto()
Date:   Fri, 14 Jun 2019 15:11:34 +0300
Message-Id: <1560514294-29111-8-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1560514294-29111-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1560514294-29111-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Called in only one place, for RS232, it only obscures things, as it
doesn't go well with 2 similar named functions,
imx_uart_rts_inactive() and imx_uart_rts_active(), that both are
RS485-specific.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index bdb8b6a..cb28cff 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -402,13 +402,6 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
 	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
 }
 
-/* called with port.lock taken and irqs caller dependent */
-static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
-{
-	if (*ucr2 & UCR2_CTS)
-		*ucr2 |= UCR2_CTSC;
-}
-
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_rx(struct uart_port *port)
 {
@@ -1598,8 +1591,10 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		else
 			imx_uart_rts_inactive(sport, &ucr2);
 
-	} else if (termios->c_cflag & CRTSCTS)
-		imx_uart_rts_auto(sport, &ucr2);
+	} else if (termios->c_cflag & CRTSCTS) {
+		if (ucr2 & UCR2_CTS)
+			ucr2 |= UCR2_CTSC;
+	}
 
 	if (termios->c_cflag & CRTSCTS)
 		ucr2 &= ~UCR2_IRTS;
-- 
2.10.0.1.g57b01a3

