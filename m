Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0045C48
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 14:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfFNML4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 08:11:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35118 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfFNML4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 08:11:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so2186304ljh.2
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2019 05:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MnAE4r5Gl1VIMZviL9ksOeXJGJoVijEdryliB0x51XQ=;
        b=WU87SO0rFdKL0jGGN3E6Yp4DQcPvigBLGDldakRZfF9oHXptATGbb3eOe65YT23hUd
         dkf7UPpuSeYpi6DzYDXNoxAv/mWc8BepQwQVRO5NR6Xc+CaKDd6L/Sq6oCweq6YLldxE
         A29Df0QutRTjnn1BG6/cz2jJovdwQGI3+JxTV0sLtr2CS8gr6sfFthAaaUuJnBQT07an
         P+tJX6Lj5Lr4NDPk9RgIWe8h1nMMR2kqTT+xMnrfTeoRBEGZkF/kFczWQFQ2/lRPXbJL
         rLCHCfKS9qmAouwI9qDFy5XqlHg8tj7DD0g6RGnJ3U2Z3oOJZ2vPNkZ0M9hBm3S8Jwih
         MPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MnAE4r5Gl1VIMZviL9ksOeXJGJoVijEdryliB0x51XQ=;
        b=AOovTuA7ivAUFMp0Hng3OyJ0MhT2IvC5w1YnWX9qjNYVPrNG/7QGjxLKIo93U6tRdp
         FWbAeNGAJn/IQsKQWntl0DzzdmcTA0LvipnHWVWEqGL8lcbN/Fe/hkssqvEN3uHsMBbb
         wprTjr+yOOIC8Ue64G7+RZEK0r+aNKCVbI70iL8jVRJzLQNNWlftntvi6LpBdevfYjOf
         V6FvA2vYKFSUc8ifLXul3vgZ7rLlJuPudkX8etAi/PT0aU+eQt9sSW5zbInq6QNemflh
         2xO3tekVyJEQ/O5B0jX3+WOrb2OPbTvc30n6brVayF49JXWqXV+IU94YW88CevpTi0ka
         FPkQ==
X-Gm-Message-State: APjAAAWUxM55pzBSRs9ysUzJaWsHEEZ0QRSODP2b7zau112ZUGjMl6oK
        YczxRFMJykU3zHJBzBpxjfSVFmKN
X-Google-Smtp-Source: APXvYqxW2PF12BhUCKAQN98WEsRpNhDJrFTYunpAY6YNMydMQgm5z9W1FQbZS6qhN/xSK/JDxqUcHw==
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr35479854lja.207.1560514314037;
        Fri, 14 Jun 2019 05:11:54 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p27sm459683lfh.8.2019.06.14.05.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 05:11:53 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC 3/7] serial: imx: set_termios(): clarify RTS/CTS bits calculation
Date:   Fri, 14 Jun 2019 15:11:30 +0300
Message-Id: <1560514294-29111-4-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1560514294-29111-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1560514294-29111-1-git-send-email-sorganov@gmail.com>
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

