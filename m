Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D770E352F36
	for <lists+linux-serial@lfdr.de>; Fri,  2 Apr 2021 20:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbhDBS1o (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 2 Apr 2021 14:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbhDBS1m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Apr 2021 14:27:42 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B01C0613E6;
        Fri,  2 Apr 2021 11:27:41 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id CBC91198;
        Fri,  2 Apr 2021 11:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617388061;
        bh=tyW6sXNRBj6Uk4Ih7WWBioGPwnfyDpbZ0v47TOM8+4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iiwvo5vWjO/m6hb2uDCA+hLYAFQ0ZFDNq7BzMSG4hZiRshXywnxXA8tPablkSvOnh
         c0bBmj0NrzqisC1GEOubPgG+bkh4lZk22ARp3wyUwsxC+Rb/gQBTIePm6p8slzS6g7
         2t6fC8c3J8tDetTV6PUfb5LVFZO+HBbVtjvyiOh8=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH v4 3/4] drivers/tty/serial/8250: add aspeed,lpc-io-reg and aspeed,lpc-interrupts DT properties
Date:   Fri,  2 Apr 2021 13:27:23 -0500
Message-Id: <20210402182724.20848-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402182724.20848-1-zev@bewilderbeest.net>
References: <20210402182724.20848-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These allow describing all the Aspeed VUART attributes currently
available via sysfs.  aspeed,sirq provides a replacement for the
deprecated aspeed,sirq-polarity-sense property.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 44 ++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 8433f8dbb186..75ef006fa24b 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -28,6 +28,10 @@
 #define ASPEED_VUART_ADDRL		0x28
 #define ASPEED_VUART_ADDRH		0x2c
 
+#define ASPEED_VUART_DEFAULT_LPC_ADDR	0x3f8
+#define ASPEED_VUART_DEFAULT_SIRQ	4
+#define ASPEED_VUART_DEFAULT_SIRQ_POLARITY	IRQ_TYPE_LEVEL_LOW
+
 struct aspeed_vuart {
 	struct device		*dev;
 	void __iomem		*regs;
@@ -393,7 +397,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	struct aspeed_vuart *vuart;
 	struct device_node *np;
 	struct resource *res;
-	u32 clk, prop;
+	u32 clk, prop, sirq[2];
+	bool sirq_polarity;
 	int rc;
 
 	np = pdev->dev.of_node;
@@ -501,6 +506,43 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 		of_node_put(sirq_polarity_sense_args.np);
 	}
 
+	rc = of_property_read_u32(np, "aspeed,lpc-io-reg", &prop);
+	if (rc < 0)
+		prop = ASPEED_VUART_DEFAULT_LPC_ADDR;
+
+	rc = aspeed_vuart_set_lpc_address(vuart, prop);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "invalid value in aspeed,lpc-io-reg property\n");
+		goto err_clk_disable;
+	}
+
+	rc = of_property_read_u32_array(np, "aspeed,lpc-interrupts", sirq, 2);
+	if (rc < 0) {
+		sirq[0] = ASPEED_VUART_DEFAULT_SIRQ;
+		sirq[1] = ASPEED_VUART_DEFAULT_SIRQ_POLARITY;
+	}
+
+	rc = aspeed_vuart_set_sirq(vuart, sirq[0]);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "invalid sirq number in aspeed,lpc-interrupts property\n");
+		goto err_clk_disable;
+	}
+
+	switch (sirq[1]) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sirq_polarity = false;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		sirq_polarity = true;
+		break;
+	default:
+		dev_err(&pdev->dev, "invalid sirq polarity in aspeed,lpc-interrupts property\n");
+		rc = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	aspeed_vuart_set_sirq_polarity(vuart, sirq_polarity);
+
 	aspeed_vuart_set_enabled(vuart, true);
 	aspeed_vuart_set_host_tx_discard(vuart, true);
 	platform_set_drvdata(pdev, vuart);
-- 
2.31.1

