Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6199482EEF
	for <lists+linux-serial@lfdr.de>; Tue,  6 Aug 2019 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfHFJnh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 05:43:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:42923 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFJng (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 05:43:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="349375879"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 06 Aug 2019 02:43:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3D452FF; Tue,  6 Aug 2019 12:43:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v1 1/9] serial: 8250_dw: Use a unified new dev variable in remove
Date:   Tue,  6 Aug 2019 12:43:14 +0300
Message-Id: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The commit 2cb78eab2376 ("serial: 8250_dw: Use a unified new dev variable in
probe") introduced a local dev variable in ->probe(). Do the same in ->remove()
in order to prepare for sequential patches.

Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 284e8d052fc3..7b559f969f61 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -667,8 +667,9 @@ static int dw8250_probe(struct platform_device *pdev)
 static int dw8250_remove(struct platform_device *pdev)
 {
 	struct dw8250_data *data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
 
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_get_sync(dev);
 
 	serial8250_unregister_port(data->line);
 
@@ -680,8 +681,8 @@ static int dw8250_remove(struct platform_device *pdev)
 	if (!IS_ERR(data->clk))
 		clk_disable_unprepare(data->clk);
 
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
 
 	return 0;
 }
-- 
2.20.1

