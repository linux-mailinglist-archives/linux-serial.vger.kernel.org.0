Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9272837F17A
	for <lists+linux-serial@lfdr.de>; Thu, 13 May 2021 05:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhEMDDI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 12 May 2021 23:03:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2574 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhEMDDI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 23:03:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FgbwP4kv8zsRQK;
        Thu, 13 May 2021 10:59:17 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 11:01:52 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>, <tangzihao1@hisilicon.com>
Subject: [PATCH 10/12] tty: serial: sunzilog: include <linux/io.h> instead of <asm/io.h>
Date:   Thu, 13 May 2021 11:01:42 +0800
Message-ID: <1620874904-39285-11-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620874904-39285-1-git-send-email-f.fangjian@huawei.com>
References: <1620874904-39285-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Zihao Tang <tangzihao1@hisilicon.com>

Include the more general linux/io.h instead of asm/io.h
as checkpatch suggests.

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/tty/serial/sunzilog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 001e19d..1a54e3e 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -35,7 +35,7 @@
 #include <linux/init.h>
 #include <linux/of_device.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/setup.h>
-- 
2.7.4

