Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D137624AAC
	for <lists+linux-serial@lfdr.de>; Tue, 21 May 2019 10:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfEUIrO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 May 2019 04:47:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46443 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUIrO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 May 2019 04:47:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id r18so8087942pls.13
        for <linux-serial@vger.kernel.org>; Tue, 21 May 2019 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89bb4fjtj/kIr7qzcMVgqe2OmX6wOnyg4q53NtNpkN0=;
        b=a4k83vGTdv2AkIXZY24HVw5HqlHA1ohlGoeeyIjO1/wGvXZFVuFLUO8jxjsjgdp1Yj
         xWn0Q42VQQ9sUAT0FysRT6GMG0DOKg0PY/5POc0mNmtGlnlILYAGaOvd5sM/1IgKZbAm
         hCvxY3xT4X3OPHGyGhrPqYLKBAlYb7fJn98NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89bb4fjtj/kIr7qzcMVgqe2OmX6wOnyg4q53NtNpkN0=;
        b=EiJ1AsBEfwV0OT/iGNjpya2jfEX55k+Rd/cDYhazwaLMpJ0OSg1PmSaqfRxNEJfK/3
         ETjVnovX5f6gbjUop3WGna2J848QPVA4CsYKzywnxXMJfHC5MraTQcrT/+P65xXXEG+c
         mVfkfIVyyCPaf+RwJNMdfE0go0WN4TtRL3x1dSH+molp1sCFTA2D57j+nadQixyseYpu
         5D1hgoDZjBUAcdj4FCwK1XRjFTBq6hU45HEwoLQe5kb2U2lpk1flxJnxgLanpn3eQZ20
         Pl6D6Ql0N3Jm0jbX0nbkME7+6jmLoXvS15I3FXIV0WrKb0PsM8IpgXVT0PVL8olfXEoR
         Q4xg==
X-Gm-Message-State: APjAAAXoSBDBONc6ol/JU6Zv924hd7CE2rCK56Jl6LtgV0Nu5uI60dOy
        Bpf83hDr4RUbzIf3xsJAh02OPA==
X-Google-Smtp-Source: APXvYqxoywMpydKI5oVMMvlMk2yqmN7dQYxCwk3n17OXLBgw9/d1xfdo5XxX+YrM2NRWRq09UUSyEA==
X-Received: by 2002:a17:902:581:: with SMTP id f1mr28609767plf.343.1558428433730;
        Tue, 21 May 2019 01:47:13 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id f5sm13690386pgc.7.2019.05.21.01.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:47:13 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH 2/2] uart: mediatek: support Rx in-band wakeup
Date:   Tue, 21 May 2019 16:47:01 +0800
Message-Id: <20190521084701.100179-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190521084701.100179-1-tientzu@chromium.org>
References: <20190521084701.100179-1-tientzu@chromium.org>
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
 drivers/tty/serial/8250/8250_mtk.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 417c7c810df9..61892abf707d 100644
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
 
@@ -572,15 +576,44 @@ static int mtk8250_remove(struct platform_device *pdev)
 static int __maybe_unused mtk8250_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(data->line);
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
+	int err;
+
+	if (irq >= 0) {
+		err = disable_irq_wake(irq);
+		if (err) {
+			dev_err(dev,
+				"failed to disable irq wake on IRQ %d: %d\n",
+				irq, err);
+			return err;
+		}
+	}
+	pinctrl_pm_select_default_state(dev);
 
 	serial8250_resume_port(data->line);
 
-- 
2.21.0.1020.gf2820cf01a-goog

