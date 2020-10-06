Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967A1285472
	for <lists+linux-serial@lfdr.de>; Wed,  7 Oct 2020 00:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJFWW3 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Oct 2020 18:22:29 -0400
Received: from fgw22-7.mail.saunalahti.fi ([62.142.5.83]:42556 "EHLO
        fgw22-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgJFWW1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Oct 2020 18:22:27 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 68b25e9a-0822-11eb-88cb-005056bdf889;
        Wed, 07 Oct 2020 01:22:24 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 2/2] serial: max310x: Use devm_clk_get_optional() to get the input clock
Date:   Wed,  7 Oct 2020 01:22:22 +0300
Message-Id: <20201006222222.583254-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006222222.583254-1-andy.shevchenko@gmail.com>
References: <20201006222222.583254-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Simplify the code which fetches the input clock by using
devm_clk_get_optional(). If no input clock is present
devm_clk_get_optional() will return NULL instead of an error
which matches the behavior of the old code.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/tty/serial/max310x.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index f25b9516109c..9795b2e8b0b2 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1273,7 +1273,6 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 			 struct regmap *regmap, int irq)
 {
 	int i, ret, fmin, fmax, freq, uartclk;
-	struct clk *clk_osc, *clk_xtal;
 	struct max310x_port *s;
 	bool xtal = false;
 
@@ -1287,23 +1286,24 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		return -ENOMEM;
 	}
 
-	clk_osc = devm_clk_get(dev, "osc");
-	clk_xtal = devm_clk_get(dev, "xtal");
-	if (!IS_ERR(clk_osc)) {
-		s->clk = clk_osc;
+	s->clk = devm_clk_get_optional(dev, "osc");
+	if (IS_ERR(s->clk))
+		return PTR_ERR(s->clk);
+	if (s->clk) {
 		fmin = 500000;
 		fmax = 35000000;
-	} else if (!IS_ERR(clk_xtal)) {
-		s->clk = clk_xtal;
-		fmin = 1000000;
-		fmax = 4000000;
-		xtal = true;
-	} else if (PTR_ERR(clk_osc) == -EPROBE_DEFER ||
-		   PTR_ERR(clk_xtal) == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
 	} else {
-		dev_err(dev, "Cannot get clock\n");
-		return -EINVAL;
+		s->clk = devm_clk_get_optional(dev, "xtal");
+		if (IS_ERR(s->clk))
+			return PTR_ERR(s->clk);
+		if (s->clk) {
+			fmin = 1000000;
+			fmax = 4000000;
+			xtal = true;
+		} else {
+			dev_err(dev, "Cannot get clock\n");
+			return -EINVAL;
+		}
 	}
 
 	ret = clk_prepare_enable(s->clk);
-- 
2.28.0

