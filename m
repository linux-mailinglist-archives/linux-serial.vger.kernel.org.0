Return-Path: <linux-serial+bounces-638-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B87C808D5D
	for <lists+linux-serial@lfdr.de>; Thu,  7 Dec 2023 17:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7211C208E8
	for <lists+linux-serial@lfdr.de>; Thu,  7 Dec 2023 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DEB46BA8;
	Thu,  7 Dec 2023 16:26:45 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E10512D;
	Thu,  7 Dec 2023 08:26:42 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f5da5df68eso730575fac.2;
        Thu, 07 Dec 2023 08:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966401; x=1702571201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrIilKopCy+JlhjKJ757AT5TowHvKtEtJSE0B1E87zw=;
        b=Wyh8DiYYuwiHoQduTHsez1N3CuY3h5RCHvQSV5/7bgH4l/UlK8zRO90nxxS9pVfV4X
         gW0iViKI0vhjFNLM8QU6UOZnPuqXwJ2Fi1gTbNXTsJCwIHGPNWHy40FnTUMFhYQs5/d9
         YKZWpdIcMHuPtYYKRIPjDuyw+y6LhD5DeItYqIYJNGiobhfrQ8hIEDdYLmch1hGPBl1h
         o1zpLCcBYyx+Ar5Rocfqmcw4nMm/+4YzHl0o2jTDR2xR4wPz4UCU/AcNTxOTTk3WdCLC
         +JQavcMqozm2jcCWuUV1unX+0QvM39mbk1sAVN1Q3cpL55zHpUkPIfKzSmbdjBfVvyua
         B0Uw==
X-Gm-Message-State: AOJu0YzJXTFavB375NNHGxT1upLXQwuZevuXMHlt6OB8ENe/1uAJkIzZ
	2kJ43OKRoUw66tZrUtUB5412bMP60A==
X-Google-Smtp-Source: AGHT+IE6+NezKaYvdw+o/oi4OrqQ8qwfYR0izhNlIVeKAUJXNXWpC45tUStqHm/WBLKctyT+TB7Kzg==
X-Received: by 2002:a05:6871:2b29:b0:1fa:d948:5992 with SMTP id dr41-20020a0568712b2900b001fad9485992mr2835849oac.54.1701966401694;
        Thu, 07 Dec 2023 08:26:41 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id my14-20020a056870698e00b001fb044ebdfdsm26453oab.13.2023.12.07.08.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:26:39 -0800 (PST)
Received: (nullmailer pid 2651545 invoked by uid 1000);
	Thu, 07 Dec 2023 16:26:37 -0000
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 2/2] serial: esp32_uart: Use device_get_match_data()
Date: Thu,  7 Dec 2023 10:26:31 -0600
Message-ID: <20231207162632.2650356-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207162632.2650356-1-robh@kernel.org>
References: <20231207162632.2650356-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Error checking for matching was not necessary as matching is always
successful if we're already in probe and the match tables always have data
pointers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/esp32_uart.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 6e12955d1315..6fc61f323355 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -9,7 +9,8 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/tty_flip.h>
@@ -678,16 +679,11 @@ static struct uart_driver esp32_uart_reg = {
 static int esp32_uart_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	static const struct of_device_id *match;
 	struct uart_port *port;
 	struct esp32_port *sport;
 	struct resource *res;
 	int ret;
 
-	match = of_match_device(esp32_uart_dt_ids, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
 	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
 	if (!sport)
 		return -ENOMEM;
@@ -728,7 +724,7 @@ static int esp32_uart_probe(struct platform_device *pdev)
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->has_sysrq = 1;
 	port->fifosize = ESP32_UART_TX_FIFO_SIZE;
-	port->private_data = (void *)match->data;
+	port->private_data = (void *)device_get_match_data(&pdev->dev);
 
 	esp32_uart_ports[port->line] = sport;
 
-- 
2.42.0


