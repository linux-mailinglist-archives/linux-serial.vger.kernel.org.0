Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00879BE26D
	for <lists+linux-serial@lfdr.de>; Wed, 25 Sep 2019 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbfIYQ0V (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 25 Sep 2019 12:26:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:5710 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732803AbfIYQ0V (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Sep 2019 12:26:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 09:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="193826029"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2019 09:26:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2A7EA1A1; Wed, 25 Sep 2019 19:26:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] serial: 8250_dw: Use devm_clk_get_optional() to get the input clock
Date:   Wed, 25 Sep 2019 19:26:17 +0300
Message-Id: <20190925162617.30368-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Simplify the code which fetches the input clock by using
devm_clk_get_optional(). This comes with a small functional change: previously
all errors were ignored except deferred probe. Now all errors are
treated as errors. If no input clock is present devm_clk_get_optional() will
return NULL instead of an error which matches the behavior of the old code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: conditionally try to get a NULL clock
 drivers/tty/serial/8250/8250_dw.c | 75 +++++++++++++------------------
 1 file changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1c72fdc2dd37..acbf23b3e300 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -280,9 +280,6 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	long rate;
 	int ret;
 
-	if (IS_ERR(d->clk))
-		goto out;
-
 	clk_disable_unprepare(d->clk);
 	rate = clk_round_rate(d->clk, baud * 16);
 	if (rate < 0)
@@ -293,8 +290,10 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 		ret = clk_set_rate(d->clk, rate);
 	clk_prepare_enable(d->clk);
 
-	if (!ret)
-		p->uartclk = rate;
+	if (ret)
+		goto out;
+
+	p->uartclk = rate;
 
 out:
 	p->status &= ~UPSTAT_AUTOCTS;
@@ -472,19 +471,18 @@ static int dw8250_probe(struct platform_device *pdev)
 	device_property_read_u32(dev, "clock-frequency", &p->uartclk);
 
 	/* If there is separate baudclk, get the rate from it. */
-	data->clk = devm_clk_get(dev, "baudclk");
-	if (IS_ERR(data->clk) && PTR_ERR(data->clk) != -EPROBE_DEFER)
-		data->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(data->clk) && PTR_ERR(data->clk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-	if (!IS_ERR_OR_NULL(data->clk)) {
-		err = clk_prepare_enable(data->clk);
-		if (err)
-			dev_warn(dev, "could not enable optional baudclk: %d\n",
-				 err);
-		else
-			p->uartclk = clk_get_rate(data->clk);
-	}
+	data->clk = devm_clk_get_optional(dev, "baudclk");
+	if (data->clk == NULL)
+		data->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(data->clk))
+		return PTR_ERR(data->clk);
+
+	err = clk_prepare_enable(data->clk);
+	if (err)
+		dev_warn(dev, "could not enable optional baudclk: %d\n", err);
+
+	if (data->clk)
+		p->uartclk = clk_get_rate(data->clk);
 
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
@@ -493,17 +491,16 @@ static int dw8250_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	data->pclk = devm_clk_get(dev, "apb_pclk");
-	if (IS_ERR(data->pclk) && PTR_ERR(data->pclk) == -EPROBE_DEFER) {
-		err = -EPROBE_DEFER;
+	data->pclk = devm_clk_get_optional(dev, "apb_pclk");
+	if (IS_ERR(data->pclk)) {
+		err = PTR_ERR(data->pclk);
 		goto err_clk;
 	}
-	if (!IS_ERR(data->pclk)) {
-		err = clk_prepare_enable(data->pclk);
-		if (err) {
-			dev_err(dev, "could not enable apb_pclk\n");
-			goto err_clk;
-		}
+
+	err = clk_prepare_enable(data->pclk);
+	if (err) {
+		dev_err(dev, "could not enable apb_pclk\n");
+		goto err_clk;
 	}
 
 	data->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
@@ -546,12 +543,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	reset_control_assert(data->rst);
 
 err_pclk:
-	if (!IS_ERR(data->pclk))
-		clk_disable_unprepare(data->pclk);
+	clk_disable_unprepare(data->pclk);
 
 err_clk:
-	if (!IS_ERR(data->clk))
-		clk_disable_unprepare(data->clk);
+	clk_disable_unprepare(data->clk);
 
 	return err;
 }
@@ -567,11 +562,9 @@ static int dw8250_remove(struct platform_device *pdev)
 
 	reset_control_assert(data->rst);
 
-	if (!IS_ERR(data->pclk))
-		clk_disable_unprepare(data->pclk);
+	clk_disable_unprepare(data->pclk);
 
-	if (!IS_ERR(data->clk))
-		clk_disable_unprepare(data->clk);
+	clk_disable_unprepare(data->clk);
 
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
@@ -604,11 +597,9 @@ static int dw8250_runtime_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	if (!IS_ERR(data->clk))
-		clk_disable_unprepare(data->clk);
+	clk_disable_unprepare(data->clk);
 
-	if (!IS_ERR(data->pclk))
-		clk_disable_unprepare(data->pclk);
+	clk_disable_unprepare(data->pclk);
 
 	return 0;
 }
@@ -617,11 +608,9 @@ static int dw8250_runtime_resume(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	if (!IS_ERR(data->pclk))
-		clk_prepare_enable(data->pclk);
+	clk_prepare_enable(data->pclk);
 
-	if (!IS_ERR(data->clk))
-		clk_prepare_enable(data->clk);
+	clk_prepare_enable(data->clk);
 
 	return 0;
 }
-- 
2.23.0

