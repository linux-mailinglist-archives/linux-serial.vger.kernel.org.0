Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2EC2AEFE
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 08:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfE0G4M (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 02:56:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36892 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfE0G4M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 02:56:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23so9031663pff.4
        for <linux-serial@vger.kernel.org>; Sun, 26 May 2019 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GXP8X1L27wbZgV5j2BKjX7dRHd3c48Hr+NTlDkvhu/M=;
        b=S+mQ9UJ4I5ubtMiMdqvmfqWdiSqc74l0Mc9AnXEIOQ20XfNFKiSfalNkNyBOySHAFW
         856VDRK0cw5Lu32ixbA+HHlIIoiMkAd3DoJUalDxpijJR7+NKZfSfod5Z231tSjpknEe
         /WjxtTaLzqRpoLTqI6ZiRct3NHqCVkbTasIiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXP8X1L27wbZgV5j2BKjX7dRHd3c48Hr+NTlDkvhu/M=;
        b=rkMoeq1LmCahMNQdXmk0j0iCepe1JV4Hyqhpw8XbhPl1f20rzuFBHbDTTmzaYycLJP
         QEjZiw3/YhaIFtY3cD/ZviFLQNbL3utZELYYXQvOZYA69E0pCI9Er9I1G9/J70VWrO5E
         1D7Qss9eEbT19Cs+djwF6kukk5tId7pzPHB+YnbppQ/Ch0NWPuJpMlpsl8DMYBv7D/Xv
         AmFrx+Qps5RUAD3prUk2L+mPwBmPuCacVUiCvMiUQ4RKpOxd/DUNK1Vi3PSkEUtG649q
         aspUw1ru7V27DNDsUUPvIIV+OVAaBHFrcmAc+jO9aPm+cy1jQSh/qx9rpVDyv3VzTCSX
         IqBQ==
X-Gm-Message-State: APjAAAU8KaRoT25X6X9nlmxJBFASH2jpJtawjAoRRx49DMtE4t99Ulpo
        /vSLjS/1gMyy1DMDeLXbxZKdSQ==
X-Google-Smtp-Source: APXvYqw5dGklTTVfU8TQscGL43Q9tu0l4wUXGb1BPxZewZP8p90W5k1RrK1NZ+Np8xVQinhQ+le8kA==
X-Received: by 2002:a17:90a:21a8:: with SMTP id q37mr29420363pjc.5.1558940171453;
        Sun, 26 May 2019 23:56:11 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id o6sm10326995pfo.164.2019.05.26.23.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 23:56:10 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v2 2/2] uart: mediatek: support Rx in-band wakeup
Date:   Mon, 27 May 2019 14:55:59 +0800
Message-Id: <20190527065559.66056-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190527065559.66056-1-tientzu@chromium.org>
References: <20190527065559.66056-1-tientzu@chromium.org>
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
 drivers/tty/serial/8250/8250_mtk.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 417c7c810df9..b0713d1e07bb 100644
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
 
@@ -572,15 +576,36 @@ static int mtk8250_remove(struct platform_device *pdev)
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
+
+	if (irq >= 0)
+		disable_irq_wake(irq);
+	pinctrl_pm_select_default_state(dev);
 
 	serial8250_resume_port(data->line);
 
-- 
2.22.0.rc1.257.g3120a18244-goog

