Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23056B94
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 16:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfFZOOU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 10:14:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43794 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFZOOT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 10:14:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id 16so2364254ljv.10
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mRhyyilptEVPd04WdgykTEukksr9XwSZnIYd4NBzYsQ=;
        b=WOsdVMo2sTqQcIO7BzQhJ9DHnEJ3DY7P8bNKT1VNcGqjAUlnFGAZY0dK4XZYnH5ua1
         v3Tfcu8MMImCEs2vjwsLFPMQOVWRktM9ufCg39KKPc0Y1M/7trTsHbsKVTCh4IqOENH3
         Ib5gg+aBvNiYqJvlRQStweOnKbfqlcSGwUwtH2gkGUm1metLMJFw2kerj8IQnanQc7l5
         nRBrydWsx5dlYPJrZMiZn3Sk9gJixMNNlgSPumNI90w31xO6weAHTkbKxd2hcj2l0C68
         26LkRmMyqE/okSD0EhAtIb0JR8w7amcb70WpMjaA3v1L7RRm66yMV11PFOEYxGrlRI8t
         +5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mRhyyilptEVPd04WdgykTEukksr9XwSZnIYd4NBzYsQ=;
        b=TrfbgEsj5Lc7HaXwhZS/RIgryrOzRRE0Z+J6+JjqzSH8SylTTDtJSacDnbGLFJ5+RJ
         cjMhZ297UJdaVqhWM50r5oyMt/5P5St+MCRW6Tft9pLFNDIalG7djCH5uRaOWHtYEiA4
         HeLYxHmjG+IBcAeSTop3sHhK94mlnZ5lq5UMrkKgFzDOapsPQxwlNoPquiHlaV9MWiQP
         +VNI6q3P7A/6mPrk04l+uQKgZE7q6euMshXQZWbuxE1a5O/ANvGiru1cqLDesjIelyLI
         oS2fJUvZHJ6O13JxPbsqNBcHGgIAJCPmjWtLZSPznJL+qyhHsD0Et5cI/z16z7w8uJH7
         IxNA==
X-Gm-Message-State: APjAAAWAP+Lftw6Ri9Fk1KV1VOnDQEOQv1yq6yXrSynzRuC2QtgW3s+3
        7lEQEybIvViwrjiM84T0N8U=
X-Google-Smtp-Source: APXvYqxk6g01vSfZluLIWn9pL9tzMRhVHf6a8E/WPw/jzMv8uirCzehRsPM4NYsa4A7CfTEhMI0y+A==
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr3064173ljj.146.1561558457810;
        Wed, 26 Jun 2019 07:14:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 25sm2863825ljn.62.2019.06.26.07.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 07:14:17 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 3/7] serial: imx: set_termios(): clarify RTS/CTS bits calculation
Date:   Wed, 26 Jun 2019 17:11:29 +0300
Message-Id: <1561558293-7683-4-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1561558293-7683-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Avoid repeating the same code for rs485 twice.

Make it obvious we clear CRTSCTS bit in termios->c_cflag whenever
sport->have_rtscts is false.

Make it obvious we clear UCR2_IRTS whenever CRTSCTS is set.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
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

