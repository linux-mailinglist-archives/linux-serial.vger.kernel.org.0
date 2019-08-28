Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53621A09BF
	for <lists+linux-serial@lfdr.de>; Wed, 28 Aug 2019 20:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfH1SiL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 28 Aug 2019 14:38:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44620 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfH1SiL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Aug 2019 14:38:11 -0400
Received: by mail-lf1-f68.google.com with SMTP id v16so358398lfg.11
        for <linux-serial@vger.kernel.org>; Wed, 28 Aug 2019 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hq8Irfar0eMF52VRL6jb7YZsMYuqVZje40ByVMTx8hM=;
        b=o6bem+9DKTPq730Ec0kUZztFBO3dsRWGsyCHCE4SR9ms4N+8jDj1sogyLkdpYT2f/n
         Gjdexj8F8AsOVDyqby440XFGGxJlUFNKftogR33ix1Xk/uzcsOvIeh+oeVWsLSmOOoqa
         lVzTsklURj7AD9kIhCE9p0m5bh8yljLaVaN7TPAC/idftsP0yyMkzYEXbr0T5ZiSsfVB
         4BpR5Onq5bDDP/n37prrjjMRzK9nq4XvH+a/0GNUL3zWNsu3dAfvE9wFlWupNgBhTdhY
         IT/WXOmkjhp0k+XPWHPVrrFLKcw5SGhNi/qimdbGTtwpCOWNfd4YXljFKjChg5X9wj7V
         d5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hq8Irfar0eMF52VRL6jb7YZsMYuqVZje40ByVMTx8hM=;
        b=j2I+ZvGVYKnF7pMwG0Qx7ffzHMFYJ9jxZWF1ltm/bzEQd9OQYCXgB7642PeJhwz7Yc
         iK013NLaq1PtOir03Zl/zIeRMhUy0mAQ77AZSBaRfSG/UwkVTpXqDnhXCunGfdDT+Q+Z
         /XY6qTYTQph5796yj4TUN3Xk2PoXZuDdCywEVo7pbRCXObyikF996tECkY017OEiDo42
         7XdObFXgnWuwCJP2SrMB1vZGCzbP60D2Lol6H02vB1EmU9gt6PXbJzO7BXwNTgO3FLox
         iGOnbyqzS/Y7mv3a75xLLH22mHqzXcLJIB5n98+KbbyHbQR9f9c7llJC23+bTShrBVvW
         LFCA==
X-Gm-Message-State: APjAAAUwDmARPd4DKiSRtQ3M3nMm/oxQGcIUqtVLYkXHnoIy/KuNWeQe
        4y+aQwKmW7vrknkSRSgtpJQZ7UdS
X-Google-Smtp-Source: APXvYqwysdFTCEKB9GdYyg8ZVRVcrqhCYFgN8D9pq/JihCpiNfIceCXGHSpStlzWIMAdbETWLONv7Q==
X-Received: by 2002:ac2:447c:: with SMTP id y28mr3345252lfl.177.1567017488497;
        Wed, 28 Aug 2019 11:38:08 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f6sm9226lja.16.2019.08.28.11.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 11:38:07 -0700 (PDT)
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
Subject: [PATCH v2 4/5] serial: imx: fix data breakage on termios change
Date:   Wed, 28 Aug 2019 21:37:54 +0300
Message-Id: <1567017475-11919-5-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1567017475-11919-1-git-send-email-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <1567017475-11919-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_set_termios(): avoid writing baud rate divider registers when the
values to be written are the same as current. Any writing seems to
restart transmission/receiving logic in the hardware, that leads to
data breakage even when rate doesn't in fact change. E.g., user
switches RTS/CTS handshake and suddenly gets broken bytes.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index cc3783c..e89045a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1545,7 +1545,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int baud, quot;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 	unsigned long div;
-	unsigned long num, denom;
+	unsigned long num, denom, old_ubir, old_ubmr;
 	uint64_t tdiv64;
 
 	/*
@@ -1670,8 +1670,21 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	ufcr = (ufcr & (~UFCR_RFDIV)) | UFCR_RFDIV_REG(div);
 	imx_uart_writel(sport, ufcr, UFCR);
 
-	imx_uart_writel(sport, num, UBIR);
-	imx_uart_writel(sport, denom, UBMR);
+	/*
+	 *  Two registers below should always be written both and in this
+	 *  particular order. One consequence is that we need to check if any of
+	 *  them changes and then update both. We do need the check for change
+	 *  as even writing the same values seem to "restart"
+	 *  transmission/receiving logic in the hardware, that leads to data
+	 *  breakage even when rate doesn't in fact change. E.g., user switches
+	 *  RTS/CTS handshake and suddenly gets broken bytes.
+	 */
+	old_ubir = imx_uart_readl(sport, UBIR);
+	old_ubmr = imx_uart_readl(sport, UBMR);
+	if (old_ubir != num || old_ubmr != denom) {
+		imx_uart_writel(sport, num, UBIR);
+		imx_uart_writel(sport, denom, UBMR);
+	}
 
 	if (!imx_uart_is_imx1(sport))
 		imx_uart_writel(sport, sport->port.uartclk / div / 1000,
-- 
2.10.0.1.g57b01a3

