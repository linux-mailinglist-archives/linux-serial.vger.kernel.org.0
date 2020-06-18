Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572F31FF184
	for <lists+linux-serial@lfdr.de>; Thu, 18 Jun 2020 14:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgFRMWq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 18 Jun 2020 08:22:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:35590 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgFRMWp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 08:22:45 -0400
IronPort-SDR: iRGGLystx/IR3BeTDbdrfjo2uQHEu9ySPqWeD1c1OEPbZQ/BM9/b1rjmmh1GWUe6GJW/WCfZgS
 axQ4sZIAAVQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="141624946"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="141624946"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 05:22:44 -0700
IronPort-SDR: Q/DP0y+xr6dBptWw2S7lfwhyHJGST3gVBCUJSgplzSiRJNXp8HtTA4/h7HaV9AUmoTjeBBlm9/
 pFWptRZiRLAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="299674549"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jun 2020 05:22:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E9650217; Thu, 18 Jun 2020 15:22:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250_mtk: Switch to use platform_get_irq()
Date:   Thu, 18 Jun 2020 15:22:42 +0300
Message-Id: <20200618122242.87346-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

platform_get_irq() provides an established error code and error message.
Also, it's better to use dedicated API to retrieve Linux IRQ resource.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 22591c025fd0..7c920b089f0f 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -480,13 +480,17 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 static int mtk8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {};
-	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	struct mtk8250_data *data;
-	int err;
+	struct resource *regs;
+	int irq, err;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
-	if (!regs || !irq) {
-		dev_err(&pdev->dev, "no registers/irq defined\n");
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(&pdev->dev, "no registers defined\n");
 		return -EINVAL;
 	}
 
@@ -510,7 +514,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 
 	spin_lock_init(&uart.port.lock);
 	uart.port.mapbase = regs->start;
-	uart.port.irq = irq->start;
+	uart.port.irq = irq;
 	uart.port.type = PORT_16550;
 	uart.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
 	uart.port.dev = &pdev->dev;
-- 
2.27.0.rc2

