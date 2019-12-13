Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81AB411DADE
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbfLMAJE (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:09:04 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40735 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbfLMAJE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:04 -0500
Received: by mail-pj1-f67.google.com with SMTP id s35so340235pjb.7
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0AvuSAjkIKauhY++c7YWp6c3q12AUyVxjR83OEuWwPU=;
        b=N44hjPgUKP1rna4pDgr1TI6pgfXmWzNYqT2os27E2x9CgNvOq4XfY2uvZg3QbDL4q8
         lC2uzw05PZALhHdfZOv00DF4DpIBbBiXA5k9+3/l8Go8fBWKLx0KNKMDxH7lsbo1ZYEF
         QNGRGBDlsm1A5d+/s31tS1Eirnkr5aZfaRGP3QM+eD3CVaZ1++8VCJxOmoc/n4bNNa8k
         wvVJzYhEIKOStfkx7/jI7JW+1eS53I77LUvwumVzjIJf9Vu1T+gi29abhbiOlFuq+5oZ
         MMODig9sZun8DmyfjTS/+mELafP9hPHcMY44LTbnyeWo9KguTxA4KnALSwzn1jcrCX/L
         rpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AvuSAjkIKauhY++c7YWp6c3q12AUyVxjR83OEuWwPU=;
        b=L5Lr6n1xCe8Zwb3AeaAddCrK/VQ1X+LuWWZhMOhu40jEEEStu3dvMMgOu0pKbJMS1M
         Bhs0RyKiUkF9Tq7LBnxCEGDbxRSXs50my9RZxGXZB+yLqE2NIUXZqN0hcgSM4qrXnGDo
         ToAb2FGQeijvn2FasKWcCPxov72fN+0qq2WR6e8hCvhTU/D/LNdpHB2vk0aNW/y3tjbd
         SOJcVX4nYO32bpkDn9FMCbGFXpflElwE8+G513f88LUGq4OelyfKmKhZZeVd7+ZBR8WJ
         caKCW0ulOPf1WHjtu1ob59IaTajaE5xCogI3NS+vN4l8OiioRvtmOLxs729XCnQiPJNN
         G3gA==
X-Gm-Message-State: APjAAAUu3ORrmA8JmYHah3jgo16RhLT6bRpYJ9xZlqEwX3c6e1Yj1UU/
        1uQJT8iaX1SNGjQJjGc9W6NyFA==
X-Google-Smtp-Source: APXvYqwYRTF3MnCYATLiJ+ZqcgT9/DArauisQ+e4UKASVqEwmtFvSwNn2galsFLV/dQmuwgAPCREJA==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr13586682pjp.116.1576195743090;
        Thu, 12 Dec 2019 16:09:03 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:02 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 37/58] tty/serial: Migrate samsung_tty to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:36 +0000
Message-Id: <20191213000657.931618-38-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/samsung_tty.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 83fd51607741..9770fe29ae86 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -21,10 +21,6 @@
  * BJD, 04-Nov-2004
 */
 
-#if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
@@ -1909,6 +1905,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 		ourport->port.fifosize = ourport->drv_data->fifosize[index];
 	else if (ourport->info->fifosize)
 		ourport->port.fifosize = ourport->info->fifosize;
+	ourport->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SAMSUNG_CONSOLE);
 
 	/*
 	 * DMA transfers must be aligned at least to cache line size,
-- 
2.24.0

