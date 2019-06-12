Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8A7423C0
	for <lists+linux-serial@lfdr.de>; Wed, 12 Jun 2019 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438325AbfFLLO7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 12 Jun 2019 07:14:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56003 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438314AbfFLLO6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Jun 2019 07:14:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so6118087wmj.5
        for <linux-serial@vger.kernel.org>; Wed, 12 Jun 2019 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JC6Q8CjmGdxzS1r/l1ugJJUHGuJAio4YE7r12Sbrm1Q=;
        b=dfHnZnm/KeAKx0Y53W8U+Gve09GK0RsLcHKGzBp8skf8dieoVp+3rfiL2YnQayFHcb
         Lkfz1A+SwK7w+BUs52YV74L3fZLP3J9loLnVg+o9gWVgFH0oSAU6JzR3FOXHo2SkklyO
         s1WZEV1YfCDAmEPtAm3S/PpyLCfDN8f+/eiUzFsjKKNirIBLFta9bZocKUHJW3iuYWXk
         Kvz+A4Ujf8PryyBkA08Z4eCmgbflrI4pyjgutp3y8C0zfcrFW2FNAaPnpCkrMY3Tw/ly
         enYA/42NpbShVA/yMX21VKyJWtjCP4rreyRiWs0ec1wfiByCbkYA970s8PpE6ujeb/pq
         wq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=JC6Q8CjmGdxzS1r/l1ugJJUHGuJAio4YE7r12Sbrm1Q=;
        b=mNQYz4lGV1Tm4YnIx0an1pglVWpXBsbfQ5AqoqsTUoenFFaV71DJ1TlDIQm8jrlZ6D
         4iznCAHalVXszqwo+htxdbqGvTlKLnWsIVR7xQEJcGnHRrJFfzprRZoCwREaNu7U07JC
         12BGavymG0vAvrOtpVzYlPjesew0OPBw7kBqyu+EOqqtWH0Mmmw+49U1n0PplU9ziANa
         S8WLnO7aqC5QvuJrypfBav/mEpe74qiOnLtFy4PLJTkC1BnOHZVw9m3401lD0MS89M+E
         rHCYy2g8PZYJy78Rbo62EPeLWiNt6VhNlRFRgrNilG45t9wESd7ve/juvF8fZ/FoVgnj
         9ljA==
X-Gm-Message-State: APjAAAXP3Zso/aU4tv8kmXtuuUvJ7+9pXfaMKDzijl3SdGY36Uo0oLLA
        6qun8MS/zWY07J3WH6VDEtvm+g==
X-Google-Smtp-Source: APXvYqxhsrtt2KXOawEWbugdsCleP2uygG0LIu+9qXaDXVByC4OzGpQkIVhgSA12n1EyQRy68HBOsw==
X-Received: by 2002:a1c:3d41:: with SMTP id k62mr19765359wma.61.1560338096902;
        Wed, 12 Jun 2019 04:14:56 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j16sm38159921wre.94.2019.06.12.04.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:14:56 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/6] serial: uartps: Do not add a trailing semicolon to macro
Date:   Wed, 12 Jun 2019 13:14:42 +0200
Message-Id: <5d938d34c3c4710577df898dbf4b70c74d2e6730.1560338079.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch fixes this checkpatch warning:
WARNING: macros should not use a trailing semicolon
+#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
+		clk_rate_change_nb);

Fixes: d9bb3fb12685 ("tty: xuartps: Rebrand driver as Cadence UART")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Add Fixes tag

Origin patch which introduce this semicolon was
c4b0510cc1571ff44e1 ("tty: xuartps: Dynamically adjust to input frequency
changes")
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c3949a323815..d4c1ae2ffca6 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -199,7 +199,7 @@ struct cdns_platform_data {
 	u32 quirks;
 };
 #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
-		clk_rate_change_nb);
+		clk_rate_change_nb)
 
 /**
  * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.
-- 
2.17.1

