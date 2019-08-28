Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D267BA09BE
	for <lists+linux-serial@lfdr.de>; Wed, 28 Aug 2019 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfH1SiK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 28 Aug 2019 14:38:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38571 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfH1SiJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Aug 2019 14:38:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id c12so389760lfh.5
        for <linux-serial@vger.kernel.org>; Wed, 28 Aug 2019 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZlfktRIZDpnYsYdM+ski1fwXXj3g4icgLqulIn6LmQg=;
        b=ozl9b2tshIIEjFQSKd5HpAMSMfC09bFrBg2q0TIodiWyA964QMW+SLvNkfPRowlKak
         OhGljELCQ/dBpeGSZcQbkJRlHkTTLF5K+71qq1iWvxQ3Tal2FgLUw7wDo0Sc/aCoO4DT
         VSOlJEjtXV2mF1Z89uxC6kmyQ1OYmyNlfnlZqS5gXG5RTkxsMnHJJy7amAz96KEq6gCV
         K4OIzICmSNepb9H71lSuFxuabPkphHWQbWAzFJXWJwwu0xq9e3c8bXucWHPi48yxgiTE
         NAmaxsj4+UVIyoyU8vktBwFVWEQ8gLWZuSn/gKQVQid07KTmPzh5pmy0xQnbg/yj6bWI
         GTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZlfktRIZDpnYsYdM+ski1fwXXj3g4icgLqulIn6LmQg=;
        b=PnQxsxUcrv5GjoO0WZJnqA9sgV4Y8CgiDRW4Iaxg4u31T53zjkeHAPCna4Fw8yHGZK
         nE7J+jF1xKmLasvXAiFeDr5/nwMo8nZta95lRFAp5UdjOnBT4AO0jTrFQD5LTnmpmw3a
         NmqyUYw2ScBlX9hwG0UZhH5/RAx8aMx3t1tFBUBL/mx2hNqBK/WZW7xSI50IFOsUINKB
         DbmFRoN6hAaktP7hBCsvbj8h0D1cw/wIY9QS/+MfIs0ROIM1QaWvwuXn6lO+XaWSY50o
         T6V2PwlpE6j8kTmpx0jKrSgljymWIH8JCQTPeyvoEQSxdq2XnEFy+06qWOS9Fy3JycVl
         P3uQ==
X-Gm-Message-State: APjAAAVB/WrLPB/qq8JtGmkXhuwFwXiCkWKhsvIV1iqRTr2u5qbH7Vuu
        IxxTVXWBX2cUE0HDrf5AIZI7ZS8e
X-Google-Smtp-Source: APXvYqzRlpHejliRwLqVBKetlj8ffbEuoEWGT621+mRDCl1GOVUaOp5L/xAyIW4hXhkGTo762OHy0Q==
X-Received: by 2002:a19:6d17:: with SMTP id i23mr3473594lfc.44.1567017487415;
        Wed, 28 Aug 2019 11:38:07 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f6sm9226lja.16.2019.08.28.11.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 11:38:06 -0700 (PDT)
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
Subject: [PATCH v2 3/5] serial: imx: do not disable individual irqs during termios change
Date:   Wed, 28 Aug 2019 21:37:53 +0300
Message-Id: <1567017475-11919-4-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1567017475-11919-1-git-send-email-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <1567017475-11919-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_set_termios(): disabling individual interrupt requests in UART for
duration of the routine is pointless. Get rid of it.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fa723a9a..cc3783c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1541,7 +1541,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long flags;
-	u32 ucr2, old_ucr1, old_ucr2, ufcr;
+	u32 ucr2, old_ucr2, ufcr;
 	unsigned int baud, quot;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 	unsigned long div;
@@ -1643,15 +1643,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	/*
-	 * disable interrupts
-	 */
-	old_ucr1 = imx_uart_readl(sport, UCR1);
-	imx_uart_writel(sport,
-			old_ucr1 & ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN),
-			UCR1);
-	imx_uart_writel(sport, old_ucr2 & ~UCR2_ATEN, UCR2);
-
 	/* custom-baudrate handling */
 	div = sport->port.uartclk / (baud * 16);
 	if (baud == 38400 && quot != div)
@@ -1686,8 +1677,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		imx_uart_writel(sport, sport->port.uartclk / div / 1000,
 				IMX21_ONEMS);
 
-	imx_uart_writel(sport, old_ucr1, UCR1);
-
 	imx_uart_writel(sport, ucr2, UCR2);
 
 	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
-- 
2.10.0.1.g57b01a3

