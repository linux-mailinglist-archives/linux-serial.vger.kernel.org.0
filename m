Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCDF423C6
	for <lists+linux-serial@lfdr.de>; Wed, 12 Jun 2019 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438324AbfFLLPO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 12 Jun 2019 07:15:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38109 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438275AbfFLLOx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Jun 2019 07:14:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so16434897wrs.5
        for <linux-serial@vger.kernel.org>; Wed, 12 Jun 2019 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pL4z/swoTMwbTbMm+CZTE8PZN5IahPwWK1oKgA44Jw8=;
        b=P6xquQrececmcvLrvYX6swykHVbte7Nk4tMjJVlxC/IGkE5po85UR/FmEjTmBnjHBN
         7UXsptqBv4hijV+N6F7edAiOxTf+ZQZme0r0cEUHESbi9S7GOm+OyYpIq+HZMZ7IMpaq
         6ch1uIpSIvD6d0ZiSPH22yyqoPcWc7c9wkfkEyGcRJ60ehHz5PhiMhayyoZbvOGsBrxQ
         bZ2LzFT48JTUjjm41S5ZNe7RbvRK+iVQuVV4NibXS0K6W/FVhfanPVOkDruhGfEIqS47
         1jK4ZdVTE3QhZyH/G2nPRAGWdjbcedgLKigKS00FyWB3fRstKP6kgEUlfiNPaDWDxIQB
         SlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=pL4z/swoTMwbTbMm+CZTE8PZN5IahPwWK1oKgA44Jw8=;
        b=qqnJQnWXvM85STHAPYvZ3bATo1dBzjqkRKNEe7e8ji3/A07e6aJhIO/vNob9F0NWSI
         9yGr+/rk+nMZPjF4l7QXAXuwbYUHTCxy3I9KZraK3PadCV5tFrh4hSTrlwg2daVYbxrA
         SYn6pwROp/VVxoa6hsIBYpgzIE9/tFYDJcNTohTTjR7+1CSkyBbn0i8TaTWUZbHKJh/S
         dZod2uVJWArH3Nh0NVHOIoJwYBLOLjJyvWdI5YNST45C/kEzFLHk8Ng7n5xsC+FOqKqa
         M3efIE/Nw4/QaLm8QTZekrQ0r+vNY1e9s4uCx9IyyUygEJnlT6RlX4ns4W4g4ZJ3ngrB
         jQRw==
X-Gm-Message-State: APjAAAUEQc1ivpea97O6aIAdk4SVjl4pdhg0DaH6iOFMowRD1iV1AFwJ
        g9TfHeG7Wv6f5ryG+oBHL2kAYxmb5v85tQ==
X-Google-Smtp-Source: APXvYqwF+qopOc/h+NW4uHI2iFfpMRXvQ05mIybiixrrOldDG1ljO4J1jrhB5kuhJ/jptlEuRoQ9rg==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr1818664wrs.183.1560338091629;
        Wed, 12 Jun 2019 04:14:51 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id y2sm17676131wrl.4.2019.06.12.04.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:14:51 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/6] serial: uartps: Use octal permission for module_param()
Date:   Wed, 12 Jun 2019 13:14:39 +0200
Message-Id: <159139864be4ab81e75f20f7fdad604ce270f8cf.1560338079.git.michal.simek@xilinx.com>
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

Octal permission is preffered compare to symbolic one.

This patch fixes checkpatch warnings:
Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal
permissions '0444'.

Fixes: 85baf542d54e ("tty: xuartps: support 64 byte FIFO size")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Fixes second S_IRUGO usage
- Add Fixes tag

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9dcc4d855ddd..c84db82bdaab 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -35,12 +35,12 @@
 /* Rx Trigger level */
 static int rx_trigger_level = 56;
 static int uartps_major;
-module_param(rx_trigger_level, uint, S_IRUGO);
+module_param(rx_trigger_level, uint, 0444);
 MODULE_PARM_DESC(rx_trigger_level, "Rx trigger level, 1-63 bytes");
 
 /* Rx Timeout */
 static int rx_timeout = 10;
-module_param(rx_timeout, uint, S_IRUGO);
+module_param(rx_timeout, uint, 0444);
 MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 
 /* Register offsets for the UART. */
-- 
2.17.1

