Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD412B042
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 10:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfE0IcB (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 04:32:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43571 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0IcB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 04:32:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so9161684pfa.10
        for <linux-serial@vger.kernel.org>; Mon, 27 May 2019 01:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LqoCn9Xhl56Gl3+VvLRbq2L1F7zbqoVOBwyCwaTUpoM=;
        b=O+YQVkHQNN/p5LUAtWx+Tnj9GQq88I6z6fhkAa9LVS5XiwVAGzLe3C9XXGeCmG7koh
         mvXhcoSURd6jFjMGLpL1uRe/boOy8vAhM+2cW2hnh7uPeewWk8ORIVEG/8xUMD90b+70
         ryS2Fi+Fqxs1otmya2No2gkmuFcSN64bikuuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LqoCn9Xhl56Gl3+VvLRbq2L1F7zbqoVOBwyCwaTUpoM=;
        b=iewgB7irdqgo6nMssyh0jH0sx9rKSN9CSuNTUFGCtONg83VAMzxS2Fj5jf6aMWAmzf
         nut1uOYzki82x61GldRmUzhx0W5KjTnpgs5lYPiVywENUM7vSKev+0Ag10JrJxzXvOe+
         q/vZS7G7zal2/0lZvcACH1i8ERU0seNFiMX6rW284S3B+eWJVgMSLRlw97YkdwM10M9x
         0yMcGeayqk8QG0gsR613dAAAo3TfpTolHvRq+APdEGQrhERH4YT/gJ/lt7wd17drtAHN
         9Ip4prJcby9mIGrh3uamicC7dRZEeDzKrChdz/h8i7vhWQiVZm18YZgun/S184jPDs8i
         DWog==
X-Gm-Message-State: APjAAAXM19IiWcVfYc3MHYAa3dfGrgEnRLEYe4bIW85XHx64XrW8eZ6R
        czFBgiRqIy2YU/V5Wh5kQihcXA==
X-Google-Smtp-Source: APXvYqwjlREo18YcQPzD0JN8hZ/tFQ9UzO6kb3YZgMEKdPeOdh+Hinr68gQDfNLo8vVcF+ciOR1Dbw==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr28893570pji.120.1558945920357;
        Mon, 27 May 2019 01:32:00 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id n35sm9517453pgl.44.2019.05.27.01.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 01:31:59 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v3 2/2] uart: mediatek: support Rx in-band wakeup
Date:   Mon, 27 May 2019 16:31:50 +0800
Message-Id: <20190527083150.220194-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190527083150.220194-1-tientzu@chromium.org>
References: <20190527083150.220194-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In order to support Rx in-band wakeup, we need to enable irq wake on an
edge sensitive interrupt of Rx pin before suspend and disable it when
resuming.

This interrupt is used only as wake source to resume the system when
suspended. Note that the sent character will be lost as the controller is
actually suspended.

We use this to support wakeup on bluetooth. Bluetooth will repeatedly send
0xFD to wakeup host. Once host detects Rx falling, an interrupt is
triggered, and the system leaves sleep state. Then, the bluetooth driver
will send 0xFC to bluetooth and bluetooth can start to send normal HCI
packets.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/tty/serial/8250/8250_mtk.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 417c7c810df9..5b94b853387d 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/serial_8250.h>
@@ -70,6 +71,7 @@ struct mtk8250_data {
 #ifdef CONFIG_SERIAL_8250_DMA
 	enum dma_rx_status	rx_status;
 #endif
+	int			rx_wakeup_irq;
 };
 
 /* flow control mode */
@@ -551,6 +553,8 @@ static int mtk8250_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	data->rx_wakeup_irq = platform_get_irq(pdev, 1);
+
 	return 0;
 }
 
@@ -572,15 +576,35 @@ static int mtk8250_remove(struct platform_device *pdev)
 static int __maybe_unused mtk8250_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
+	int irq = data->rx_wakeup_irq;
+	int err;
 
 	serial8250_suspend_port(data->line);
 
+	pinctrl_pm_select_sleep_state(dev);
+	if (irq >= 0) {
+		err = enable_irq_wake(irq);
+		if (err) {
+			dev_err(dev,
+				"failed to enable irq wake on IRQ %d: %d\n",
+				irq, err);
+			pinctrl_pm_select_default_state(dev);
+			serial8250_resume_port(data->line);
+			return err;
+		}
+	}
+
 	return 0;
 }
 
 static int __maybe_unused mtk8250_resume(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
+	int irq = data->rx_wakeup_irq;
+
+	if (irq >= 0)
+		disable_irq_wake(irq);
+	pinctrl_pm_select_default_state(dev);
 
 	serial8250_resume_port(data->line);
 
-- 
2.22.0.rc1.257.g3120a18244-goog

