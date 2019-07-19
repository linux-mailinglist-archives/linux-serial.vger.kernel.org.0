Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A755E6E2D4
	for <lists+linux-serial@lfdr.de>; Fri, 19 Jul 2019 10:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfGSIsQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 19 Jul 2019 04:48:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45353 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGSIsP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jul 2019 04:48:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so29974685lje.12
        for <linux-serial@vger.kernel.org>; Fri, 19 Jul 2019 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CKEfXVruFdZBhIgkyanOgCxjpHC1q3hmrulsl0t52XY=;
        b=WCTAmUGDqvk//uRjsx4yNZwDWCEZaUh9EqQ5WAyIJ61y63JhMrT4/rmPTjZx605sRM
         gEsSMkEGNCNlBoDbQ3VHnyKQPwI4x0j4unKXn//7+8rGand8vNpSVY9eSBiH/1QIWhU6
         yrG0+bqFN/YCtCGyjxPfkWs4v8X9Ni6K7Urs7swOksTuqqPDbx9Yun/1CnoUNTx3g/K2
         J/Lp74oUkzFaaGM6odKQKyBjQgmuF+KbXustr9/eNRpp+/fn9u+W5b+KDWJtlc8Zgfhs
         5L+6ddrVo3gI+3QbD88Axaif551DaRuwWChS0hidEFYZIjM4zEmqi4ExOMVeV5Vf0OTT
         N5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CKEfXVruFdZBhIgkyanOgCxjpHC1q3hmrulsl0t52XY=;
        b=tS3O7Zebubdisuup1XdHsl7UKjGFyYGB20Uh3vZO0RpzfndDJ9+kKlGKMCJKl1qZ0p
         Ra/V38PXNUicz1zzMHmQPlBl+pnaQijg5ITfftd3TKCwxWNpmrfgO4nJONcLGTxfxd6G
         6QFSM9qwMpw6ohtynmjjmsWD7rGIYYpjt5YrmdbpUbZ4gu4/11KPDIenv14ryfl0l22C
         eJVT9KtyKLldxFRjp81Dvo3OhI85oEMbzsWi7uDtxqUlJQBN9/VO4It1Heju+jdCdFaO
         JnlvBJfCHVpJNaVafBvpSddMz5PVErHdvXm2o2TzgcztfA8Ue+6lOqE/a6+HzBPePBFB
         w8aA==
X-Gm-Message-State: APjAAAXjLcDJZ6hUIDhMe372PNRhy2iNwQHYcl1Kg9gEBL4Qop4HspPy
        15MvDutSPPvQUfWAmXdDMuDzitXU
X-Google-Smtp-Source: APXvYqwDLMEJw/biWbIx3p9NfsGu/4MNp8AGQDzrNPIyoiDgfhVgD2DB93aCbDYl/FyEaHqnyg6UuA==
X-Received: by 2002:a2e:3807:: with SMTP id f7mr13452098lja.87.1563526093353;
        Fri, 19 Jul 2019 01:48:13 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s21sm5588742ljm.28.2019.07.19.01.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 01:48:12 -0700 (PDT)
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
Subject: [PATCH v4 2/3] serial: imx: set_mctrl(): correctly restore autoRTS state
Date:   Fri, 19 Jul 2019 11:47:53 +0300
Message-Id: <1563526074-20399-3-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1563526074-20399-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563526074-20399-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
turning handshake on only when CRTSCTS bit for the port is set.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 95d7984..34d61c4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -970,10 +970,22 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
 		u32 ucr2;
 
+		/*
+		 * Turn off autoRTS if RTS is lowered and restore autoRTS
+		 * setting if RTS is raised.
+		 */
 		ucr2 = imx_uart_readl(sport, UCR2);
 		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
-		if (mctrl & TIOCM_RTS)
-			ucr2 |= UCR2_CTS | UCR2_CTSC;
+		if (mctrl & TIOCM_RTS) {
+			ucr2 |= UCR2_CTS;
+			/*
+			 * UCR2_IRTS is unset if and only if the port is
+			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
+			 * to get the state to restore to.
+			 */
+			if (!(ucr2 & UCR2_IRTS))
+				ucr2 |= UCR2_CTSC;
+		}
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
-- 
2.10.0.1.g57b01a3

