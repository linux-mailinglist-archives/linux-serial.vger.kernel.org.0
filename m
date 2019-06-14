Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE12D45C4A
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 14:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfFNML6 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 08:11:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40446 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfFNML6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 08:11:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so1574455lff.7
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2019 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p8PmpzAbRDVJoeBuit/g26TECB2oYt6y7ni9hx4zI8w=;
        b=fQuo2zrpMCuabBlUMf1rVUEvwsHvE6+8jPSDVc+L1fgqjP02c0JsjUR3b/Q93OxSh9
         BCPlEaTD5YEdujGBF2r382+8pudMWyoEfzuvRld7V5akGTlp1xWmjDBqK5inh0H4kxlQ
         y9pGQ7X3pY1NbpsFFPEJE1URn7oWiV+7Qmab96JSQ3exGafQdJedX/DLXL8rzdY3gjgW
         Kn8h6Cj543f30W3md6b8q2aVfuIN/4N+/KgyS4FUQAtQAZ4K33J/izosMSvViZCc9nkk
         fsusU8pRNNOoUowMKCbkCTMOpGMRHhauy7MTB4Cd0XBz/52PQgoe9RPs/wOcPznTpfCS
         alQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p8PmpzAbRDVJoeBuit/g26TECB2oYt6y7ni9hx4zI8w=;
        b=lYQJ23weBXTSsmZY96IsSiGc75YJbF8nQYKTWgmBb4yo+pJGCqGjtFrGRxUrqwkaJn
         NJZuTd8teTckUtFD8gmG+PTl81zWvhn7YRWPbwmlttfHMw3/VY4IvDXyRUcAHp77IOFI
         8vbmaEO0xt9Jn4zXlab9zqSCC9v8E6lisybhZzis8mbG74GYFzN7G/c5p4EDa0yYkBan
         HlHFFptW9qhou4ji2vCQB8r9xdWXgfcILwXv+eFBgaxHq8DGydKwuasiTGYQvKZjGtcx
         7lKiqxr5Op2n+aQTdUlGOtuCK4jU5AYkY9r0k6qBYrNyUs25x6fUoPlrYRflaG+DZf9o
         DpmQ==
X-Gm-Message-State: APjAAAVPIux4LNfBJF9tqDkJQNUENIYw26GofKNpcQTBb9Jf2UZNwjwy
        XbFW3UYpZ2/9BZ8rJPc8shw=
X-Google-Smtp-Source: APXvYqytig4LM1LLSO65nkrj13abfiZO90k3Hd+raLW/m2R9YpRb/VKxxV8lIaz5AhcKUa1gQnrY8Q==
X-Received: by 2002:a19:f00e:: with SMTP id p14mr4876955lfc.94.1560514316299;
        Fri, 14 Jun 2019 05:11:56 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p27sm459683lfh.8.2019.06.14.05.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 05:11:55 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH RFC 5/7] serial: imx: set_termios(): preserve RTS state
Date:   Fri, 14 Jun 2019 15:11:32 +0300
Message-Id: <1560514294-29111-6-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1560514294-29111-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1560514294-29111-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_set_termios() cleared RTS on every call, now fixed.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8ee910f..de23068 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1564,6 +1564,13 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
+	/*
+	 * Read current UCR2 and save it for future use, then clear all the bits
+	 * except those we will or may need to preserve.
+	 */
+	old_ucr2 = imx_uart_readl(sport, UCR2);
+	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTSC);
+
 	ucr2 = UCR2_SRST | UCR2_IRTS;
 	if ((termios->c_cflag & CSIZE) == CS8)
 		ucr2 |= UCR2_WS;
@@ -1633,7 +1640,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	imx_uart_writel(sport,
 			old_ucr1 & ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN),
 			UCR1);
-	old_ucr2 = imx_uart_readl(sport, UCR2);
 	imx_uart_writel(sport, old_ucr2 & ~UCR2_ATEN, UCR2);
 
 	while (!(imx_uart_readl(sport, USR2) & USR2_TXDC))
@@ -1641,7 +1647,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/* then, disable everything */
 	imx_uart_writel(sport, old_ucr2 & ~(UCR2_TXEN | UCR2_RXEN | UCR2_ATEN), UCR2);
-	old_ucr2 &= (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN);
 
 	/* custom-baudrate handling */
 	div = sport->port.uartclk / (baud * 16);
@@ -1679,8 +1684,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	imx_uart_writel(sport, old_ucr1, UCR1);
 
-	/* set the parity, stop bits and data size */
-	imx_uart_writel(sport, ucr2 | old_ucr2, UCR2);
+	imx_uart_writel(sport, ucr2, UCR2);
 
 	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
 		imx_uart_enable_ms(&sport->port);
-- 
2.10.0.1.g57b01a3

