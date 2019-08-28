Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75932A09BD
	for <lists+linux-serial@lfdr.de>; Wed, 28 Aug 2019 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfH1SiI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 28 Aug 2019 14:38:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44615 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfH1SiI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Aug 2019 14:38:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id v16so358304lfg.11
        for <linux-serial@vger.kernel.org>; Wed, 28 Aug 2019 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6lzh98sOLMsqCvm7qUrUZzyJz2eukzPb0EvBk7FuqQE=;
        b=X0C9DQD/F/4toZ9Ly2/MM/ayvInotEuMQXKtTOfRx+OCPoUp8QZQfWcgVGgk5jDrZP
         Fw+2pQH2a8mDCu4c+p5NgT7EFJ5l3e3C9saGeEJP7T6FthKMcH9AjMUWJlG2A+/eimI+
         13hORnBzMB6waEpE4pgNEpXlO67sebfnGGDZiNV6BUsxUMeEwKF9kfh2A8j8jBAxJA0f
         RzU+87tPgFnGBylNOJWXysz4cRlAP1ECj+feaxBSAFV+jYqLlHzI93xdALKC5eScsoCc
         frnMCJ7l/uxOpISObceHip0rOspVKVVPbjmZQTtpfncaYnXbhMmAwy/CPRLKvfJRlZS+
         eaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6lzh98sOLMsqCvm7qUrUZzyJz2eukzPb0EvBk7FuqQE=;
        b=lyQLP6Z/mRfKOvniKF/LFfZofxfE0ihdNHWOYqykS0c7q+kWCNzlneO2tHhM2qNXBy
         niqTV0H+d8iA1Xr/7z7fKsuzjP4JcWbziqqqBVPSWRJ37wD/tBVX7rb6EMjx7lLi+pyY
         HRtPthgE1FMcHF7GUUqDWBS8mbyReMzdm/QSaxs03rxen8lgbsreOg4CBKsnrEf/w2IU
         zrHltKCYq2DBkdxZmY+Uo1gMPXxhZyFqP/wbKAf1ggCepE9h7UwfRx43i/l3Thv8UUU3
         HyDJndGdkB2+ZmrKLYxJ8cY/ECBVbO12oeDnRApyxNib9hAK2GfJNMXCCCvfX0UQvAPV
         JC0Q==
X-Gm-Message-State: APjAAAU6xqH/nPNZK46rXz32I1pdgla3SEeMdQEug6t+DNEVKeVVmgTm
        DWFn4w+YKRPKmTo+5klDULeT7F+a
X-Google-Smtp-Source: APXvYqw2zr4JIw+BlcLX/SZK6QBLtrz+EkMw0hfRzkY43lErmZkJZCN2xiOLA+EbTE3XsRyPE4VkIA==
X-Received: by 2002:a19:5d53:: with SMTP id p19mr3376568lfj.109.1567017486320;
        Wed, 28 Aug 2019 11:38:06 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f6sm9226lja.16.2019.08.28.11.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 11:38:05 -0700 (PDT)
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
Subject: [PATCH v2 2/5] serial: imx: do not stop Rx/Tx on termios change
Date:   Wed, 28 Aug 2019 21:37:52 +0300
Message-Id: <1567017475-11919-3-git-send-email-sorganov@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1567017475-11919-1-git-send-email-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <1567017475-11919-1-git-send-email-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_set_termios(): stopping receiver and transmitter does harm when
something that doesn't touch transmission format/rate changes, such as
RTS/CTS handshake.

OTOH, it does no good on baud rate or format change, as
synchronization on upper-level protocols is still required to do it
right.

Therefore, just stop doing it.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 47b6156..fa723a9a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1652,9 +1652,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 			UCR1);
 	imx_uart_writel(sport, old_ucr2 & ~UCR2_ATEN, UCR2);
 
-	/* then, disable everything */
-	imx_uart_writel(sport, old_ucr2 & ~(UCR2_TXEN | UCR2_RXEN | UCR2_ATEN), UCR2);
-
 	/* custom-baudrate handling */
 	div = sport->port.uartclk / (baud * 16);
 	if (baud == 38400 && quot != div)
-- 
2.10.0.1.g57b01a3

