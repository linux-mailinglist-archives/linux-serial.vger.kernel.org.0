Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD3985F2B
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389788AbfHHKC1 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 06:02:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:7794 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389751AbfHHKC1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 06:02:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 03:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="374096093"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2019 03:02:15 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 1/3] serial: lantiq: Use proper DT compatible string
Date:   Thu,  8 Aug 2019 18:02:06 +0800
Message-Id: <57e2b69e9fbd93328a477b4c7dd2dcc78784ecb1.1565257887.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use explicit string instead of a macro for devicetree compatible string.

This series of patches is to add support for multiple SoCs which reuse the same
serial controller IP. The following patches will add another compatible string
to support new Lightning Mountain(LGM) SoC. So it makes sense to have the
compatible strings explicitly mentioned instead of a fixed macro.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/tty/serial/lantiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 42e27b48e9cc..660d21db57dc 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -693,7 +693,7 @@ lqasc_serial_early_console_setup(struct earlycon_device *device,
 	device->con->write = lqasc_serial_early_console_write;
 	return 0;
 }
-OF_EARLYCON_DECLARE(lantiq, DRVNAME, lqasc_serial_early_console_setup);
+OF_EARLYCON_DECLARE(lantiq, "lantiq,asc", lqasc_serial_early_console_setup);
 
 static struct uart_driver lqasc_reg = {
 	.owner =	THIS_MODULE,
@@ -792,7 +792,7 @@ lqasc_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id ltq_asc_match[] = {
-	{ .compatible = DRVNAME },
+	{ .compatible = "lantiq,asc" },
 	{},
 };
 
-- 
2.11.0

