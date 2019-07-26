Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A547702C
	for <lists+linux-serial@lfdr.de>; Fri, 26 Jul 2019 19:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfGZR2V (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 26 Jul 2019 13:28:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:18259 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbfGZR2U (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jul 2019 13:28:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 10:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="161367836"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2019 10:28:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 24C00130; Fri, 26 Jul 2019 20:28:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250_pnp: Move to struct dev_pm_ops
Date:   Fri, 26 Jul 2019 20:28:17 +0300
Message-Id: <20190726172817.73253-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The established way to provide PM callbacks is through struct dev_pm_ops
which is more generic.

Convert driver to use it instead of legacy approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index dfca33141fcc..de90d681b64c 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -498,10 +498,9 @@ static void serial_pnp_remove(struct pnp_dev *dev)
 		serial8250_unregister_port(line - 1);
 }
 
-#ifdef CONFIG_PM
-static int serial_pnp_suspend(struct pnp_dev *dev, pm_message_t state)
+static int __maybe_unused serial_pnp_suspend(struct device *dev)
 {
-	long line = (long)pnp_get_drvdata(dev);
+	long line = (long)dev_get_drvdata(dev);
 
 	if (!line)
 		return -ENODEV;
@@ -509,26 +508,25 @@ static int serial_pnp_suspend(struct pnp_dev *dev, pm_message_t state)
 	return 0;
 }
 
-static int serial_pnp_resume(struct pnp_dev *dev)
+static int __maybe_unused serial_pnp_resume(struct device *dev)
 {
-	long line = (long)pnp_get_drvdata(dev);
+	long line = (long)dev_get_drvdata(dev);
 
 	if (!line)
 		return -ENODEV;
 	serial8250_resume_port(line - 1);
 	return 0;
 }
-#else
-#define serial_pnp_suspend NULL
-#define serial_pnp_resume NULL
-#endif /* CONFIG_PM */
+
+static SIMPLE_DEV_PM_OPS(serial_pnp_pm_ops, serial_pnp_suspend, serial_pnp_resume);
 
 static struct pnp_driver serial_pnp_driver = {
 	.name		= "serial",
 	.probe		= serial_pnp_probe,
 	.remove		= serial_pnp_remove,
-	.suspend	= serial_pnp_suspend,
-	.resume		= serial_pnp_resume,
+	.driver         = {
+		.pm     = &serial_pnp_pm_ops,
+	},
 	.id_table	= pnp_dev_table,
 };
 
-- 
2.20.1

