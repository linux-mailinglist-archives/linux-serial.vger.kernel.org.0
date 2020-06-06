Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564891F070D
	for <lists+linux-serial@lfdr.de>; Sat,  6 Jun 2020 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgFFOkT (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 6 Jun 2020 10:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgFFOkS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Jun 2020 10:40:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE78C03E96A;
        Sat,  6 Jun 2020 07:40:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so21685pjd.0;
        Sat, 06 Jun 2020 07:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GViXQwsNEwMzcKcJUYZl3xJtNTykxgzCsHdmjAqnXzM=;
        b=U8EF7ZmU68bm6zgAlAT6va0itAw+yn7pqzGaR6lzefVRdBE90I+MY1MyKRGrMdF4J1
         tlz2GtQZQgQTgerWFadVanqNRVkv5QUXj2k8JefG2gE37LpMzpa9W7DbkLvE9Y+YTc8/
         cpdywjazBlA5QQOX8zkupnKCslJ3paREnivZGtOUzF9B0UGVvZ5txtuTdLW71gj3NnH4
         AursxlNtmjwYVBUtlB+jRfFtofhgGHL8ujRgf1Zk1vwrCcoMg+ODHyldb+kmm1xJMBdY
         3ABVTW0XgITYHSDpPH+T/Db6aitPYIwzSOnyeQacqrOUj8yodlIZPk1sZCWf789oetj2
         yREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GViXQwsNEwMzcKcJUYZl3xJtNTykxgzCsHdmjAqnXzM=;
        b=Jxl0civFxgaDNWlz7LBblCkToPNfNkGx+ZjeClTVGBoTgcvzi9HRiI+X1VlAjxv+IS
         +bFWcR4kKmuv86RpwE4G1SCPdWq8aeqtc+7IEfApNVK9tCAsrFMJCitjzhzwTDjZg5zr
         l/827rDQNwxl/0/nUz9e6yn5LN/uq7MAwMLdDayASs5MR1RebeTHIONVP+IOPedwk+W8
         izSrtraNiK1pS27SDDwCmfuuRZQmwRT2BxuPHbq/oI4B5gGZApGPnTN45yx8zrS0v7nN
         UwmPKN0deGssL8unokvqK4zn4PRFIcSQge/U3Dki6HtrFWny8Ivb9Z+pj8cOq0QbwXCg
         n4YQ==
X-Gm-Message-State: AOAM5321xg9EBo8DAGFrTg4LMfA9+ZSS+kKz0iv5pCvRgazvVwIH1rVX
        UKl+XyvU7JbuSIMahGvmUk4=
X-Google-Smtp-Source: ABdhPJwAZdRXZcOhokbba7h2K+v6sjLwBsq0222yXcaZc3mexqnhURCKrPM8PwjXVsswJo3Wzq92hw==
X-Received: by 2002:a17:902:bb86:: with SMTP id m6mr13971345pls.341.1591454418202;
        Sat, 06 Jun 2020 07:40:18 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id h6sm2511935pfq.214.2020.06.06.07.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:40:17 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] serial: mxs-auart: Use devm_ioremap() to fix the missing undo bug
Date:   Sat,  6 Jun 2020 22:40:08 +0800
Message-Id: <20200606144008.2869652-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This driver calls ioremap() in probe, but it misses calling iounmap() in 
probe's error handler and remove.
Replace ioremap() with the devm version to fix it.

Fixes: 47d37d6f94cc ("serial: Add auart driver for i.MX23/28")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index b4f835e7de23..b3e16fd72eaf 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1679,7 +1679,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	}
 
 	s->port.mapbase = r->start;
-	s->port.membase = ioremap(r->start, resource_size(r));
+	s->port.membase = devm_ioremap(&pdev->dev, r->start, resource_size(r));
 	if (!s->port.membase) {
 		ret = -ENOMEM;
 		goto out_disable_clks;
-- 
2.26.2

