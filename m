Return-Path: <linux-serial+bounces-6389-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87C29938A5
	for <lists+linux-serial@lfdr.de>; Mon,  7 Oct 2024 22:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C954E1C23D41
	for <lists+linux-serial@lfdr.de>; Mon,  7 Oct 2024 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3021DD86A;
	Mon,  7 Oct 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uBS/QCuZ"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551681727
	for <linux-serial@vger.kernel.org>; Mon,  7 Oct 2024 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334727; cv=none; b=JM2LREbPw7lPO3eTkHQPIDCq1kxIEn6XLBBerLGiKKzlG1ZVV/lNqAoWxsspib6IU6wJWrFt2RMa3AGgqHAo6u3ZDOWKYGO7hMGzItBdmmcR+iPThacWWVjcwUd4TlfHiCJwlcWlJmcJorWZf0AxjIeioXj72d3AxRYN46v7HDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334727; c=relaxed/simple;
	bh=4XefouF3I7PlToBWXo9tVuRM84DvN1mhtuatIyFdOtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AZaLt/1YELkdPsbmePdpJIQLDe/JfNzMjPHUk+qE3mfazwFLcYKNmPi2gLn2ysHlALuRxRPfc6HdNDK+v+Nf+KHrLlSYVrMqklLX4RnZ6NX2vwCPGb9TS4dm7/gWoBwzYMOsvI5bBmOY1c27XkUKy2j99jTVNYrx0YH2+gnkttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uBS/QCuZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9952ea05c5so211078166b.2
        for <linux-serial@vger.kernel.org>; Mon, 07 Oct 2024 13:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728334721; x=1728939521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IyN0uuDETAWA3p7xoFGqn49SkFSe/uu1Btr4uRYXkfM=;
        b=uBS/QCuZ3vwlV8/iK4RLi0k8csmzDw0P8I6WLgVP/r6p4oKM1e1pe3OW5sng2G55d4
         x2dPuyBEX2rt+3pQOplf4jYwc1Y4LJ3d0l+8SenESYLNDQU9xqnbfryR+OnRE/2sC5tT
         c1Q6OjS9i2rnc6MqpPxzrfPMhTJ4QQH14RbM9Wn+vdwLUt5eHYJQSszIj7oD6e20dwkw
         A+lREfza82t3E3Is3/2uQypGVVjSAe9nPribLmN0lAEpiCC6CXphGhVtFfRGHanqFEt7
         My0XUAof0KSSz5jCEhOSEJpJUt4wrSrmDfb0ilauhAPTk7TKYv/J3WvcLd6QqPdsJZ0V
         BNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728334721; x=1728939521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyN0uuDETAWA3p7xoFGqn49SkFSe/uu1Btr4uRYXkfM=;
        b=XPP/0CsIrP75mc//JH2aL3g6FLjCSgaoNqrlPFdpLHrO2CQlD443wsNmpUsFASLdUQ
         U2kFbTB5KA8VHVtarEPfPNX+Ase6AILzXsQJfNdUeWBUPHo++CH+i7k95lVSD7ccUAE+
         HgGJPbT4mz/fTbTby4vzL+PLv5CD9BjyuMhDJrzR9a94Y2+I5RPQ7OA13mWv9SJplufI
         t1xbrY9mzbPGMWU2dJGuD4R5EWZwB4mgu9WQ3cLce+NH6yGUiMyuaQVLaaxC3+DvcrBu
         emLSNcFI2oM8q0fOLZHpOmwT1zEFsACYAPBApg/6jaJsggGebZV3tCbzj1cIhiw9995X
         dBxw==
X-Gm-Message-State: AOJu0YydiVnl4FXJbgWEZRpC34hNKyQ+N8wcLAyWbHHVE14qCFk4Q4gC
	pqk2I9f4HixB9kk6arAH+JrUaENaF1N8bDaKsP+748P9ADtiHqIuv3fKaKNK+9c=
X-Google-Smtp-Source: AGHT+IEDC9o/gSTkFiM0aYTXjV2+YB0JN2IA0ftKNRa0JRa5E2WhMSBNMLv32ZF17YjtKcAO9zrrSg==
X-Received: by 2002:a17:907:3f8a:b0:a99:5240:381e with SMTP id a640c23a62f3a-a9952403a3dmr491151266b.18.1728334721472;
        Mon, 07 Oct 2024 13:58:41 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:492d:9548:aca1:239d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9940f613c2sm334539766b.4.2024.10.07.13.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:58:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Subject: [PATCH] serial: Switch back to struct platform_driver::remove()
Date: Mon,  7 Oct 2024 22:58:04 +0200
Message-ID: <20241007205803.444994-7-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=38129; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=4XefouF3I7PlToBWXo9tVuRM84DvN1mhtuatIyFdOtI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnBEte9LHAY+vEw+os4NmfyfmadRjLE518UXYRB rq1q2hWFKKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZwRLXgAKCRCPgPtYfRL+ TvYjB/0drCspvN0RaT8PpWbXKIHH8pkDpMrVB8alulAdV26YMBjhRhE4hbm2zFvR5qi2IuMXaDn DrQENbHZhrXIR4T/e1/BNb28+8lInBMW9avEimpQsew2xIQyTua6oTm5q3Ju3oWYLNawwjDn+6I 1jX9PEmuHZJfvrrcX2lAg8pv9sKPX42XxdGExQ4KwGM7kP6rc496w52LZYaW/NXrffqKBMM+X19 16ddfizK+m9Rl9rZdLZLf0gqB+I2OIW8LuTO8kZchLeia7YuOASR3cr922E9mICBbGS3UedLJTa CxtTcPyUZngQzUF/ppHu6scGp0UA/zQ1QO3B48XYSX9eulso
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/tty/serial to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

given the simplicity of the individual changes I do this all in a single
patch. I you don't agree, please tell and I will happily split it.

It's based on Friday's next, feel free to drop changes that result in a
conflict when you come around to apply this. I'll care for the fallout
at a later time then. (Having said that, if you use b4 am -3 and git am
-3, there should be hardly any conflict.)

Note I didn't Cc: all the individual driver maintainers to not trigger
sending limits and spam filters.

Best regards
Uwe

 drivers/tty/serial/8250/8250_aspeed_vuart.c | 2 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c   | 2 +-
 drivers/tty/serial/8250/8250_bcm7271.c      | 2 +-
 drivers/tty/serial/8250/8250_dw.c           | 2 +-
 drivers/tty/serial/8250/8250_em.c           | 2 +-
 drivers/tty/serial/8250/8250_fsl.c          | 2 +-
 drivers/tty/serial/8250/8250_ingenic.c      | 2 +-
 drivers/tty/serial/8250/8250_ioc3.c         | 2 +-
 drivers/tty/serial/8250/8250_lpc18xx.c      | 2 +-
 drivers/tty/serial/8250/8250_mtk.c          | 2 +-
 drivers/tty/serial/8250/8250_of.c           | 2 +-
 drivers/tty/serial/8250/8250_omap.c         | 2 +-
 drivers/tty/serial/8250/8250_platform.c     | 2 +-
 drivers/tty/serial/8250/8250_pxa.c          | 2 +-
 drivers/tty/serial/8250/8250_tegra.c        | 2 +-
 drivers/tty/serial/8250/8250_uniphier.c     | 2 +-
 drivers/tty/serial/altera_jtaguart.c        | 2 +-
 drivers/tty/serial/altera_uart.c            | 2 +-
 drivers/tty/serial/amba-pl011.c             | 2 +-
 drivers/tty/serial/ar933x_uart.c            | 2 +-
 drivers/tty/serial/atmel_serial.c           | 2 +-
 drivers/tty/serial/bcm63xx_uart.c           | 2 +-
 drivers/tty/serial/clps711x.c               | 2 +-
 drivers/tty/serial/cpm_uart.c               | 2 +-
 drivers/tty/serial/digicolor-usart.c        | 2 +-
 drivers/tty/serial/esp32_acm.c              | 2 +-
 drivers/tty/serial/esp32_uart.c             | 2 +-
 drivers/tty/serial/fsl_linflexuart.c        | 2 +-
 drivers/tty/serial/fsl_lpuart.c             | 2 +-
 drivers/tty/serial/imx.c                    | 2 +-
 drivers/tty/serial/lantiq.c                 | 2 +-
 drivers/tty/serial/liteuart.c               | 2 +-
 drivers/tty/serial/lpc32xx_hs.c             | 2 +-
 drivers/tty/serial/ma35d1_serial.c          | 2 +-
 drivers/tty/serial/mcf.c                    | 2 +-
 drivers/tty/serial/meson_uart.c             | 2 +-
 drivers/tty/serial/milbeaut_usio.c          | 2 +-
 drivers/tty/serial/mpc52xx_uart.c           | 2 +-
 drivers/tty/serial/msm_serial.c             | 2 +-
 drivers/tty/serial/mxs-auart.c              | 2 +-
 drivers/tty/serial/omap-serial.c            | 2 +-
 drivers/tty/serial/owl-uart.c               | 2 +-
 drivers/tty/serial/pic32_uart.c             | 2 +-
 drivers/tty/serial/pmac_zilog.c             | 2 +-
 drivers/tty/serial/qcom_geni_serial.c       | 2 +-
 drivers/tty/serial/rda-uart.c               | 2 +-
 drivers/tty/serial/sa1100.c                 | 2 +-
 drivers/tty/serial/samsung_tty.c            | 2 +-
 drivers/tty/serial/sccnxp.c                 | 2 +-
 drivers/tty/serial/serial-tegra.c           | 2 +-
 drivers/tty/serial/serial_txx9.c            | 2 +-
 drivers/tty/serial/sh-sci.c                 | 2 +-
 drivers/tty/serial/sifive.c                 | 2 +-
 drivers/tty/serial/sprd_serial.c            | 2 +-
 drivers/tty/serial/st-asc.c                 | 2 +-
 drivers/tty/serial/stm32-usart.c            | 2 +-
 drivers/tty/serial/sunhv.c                  | 2 +-
 drivers/tty/serial/sunplus-uart.c           | 2 +-
 drivers/tty/serial/sunsab.c                 | 2 +-
 drivers/tty/serial/sunsu.c                  | 2 +-
 drivers/tty/serial/sunzilog.c               | 2 +-
 drivers/tty/serial/tegra-tcu.c              | 2 +-
 drivers/tty/serial/timbuart.c               | 2 +-
 drivers/tty/serial/uartlite.c               | 2 +-
 drivers/tty/serial/ucc_uart.c               | 2 +-
 drivers/tty/serial/xilinx_uartps.c          | 2 +-
 66 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 25c201cfb91e..e5da9ce26006 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -569,7 +569,7 @@ static struct platform_driver aspeed_vuart_driver = {
 		.of_match_table = aspeed_vuart_table,
 	},
 	.probe = aspeed_vuart_probe,
-	.remove_new = aspeed_vuart_remove,
+	.remove = aspeed_vuart_remove,
 };
 
 module_platform_driver(aspeed_vuart_driver);
diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index d7a0f271263a..fdb53b54e99e 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -267,7 +267,7 @@ static struct platform_driver bcm2835aux_serial_driver = {
 		.pm = pm_ptr(&bcm2835aux_dev_pm_ops),
 	},
 	.probe  = bcm2835aux_serial_probe,
-	.remove_new = bcm2835aux_serial_remove,
+	.remove = bcm2835aux_serial_remove,
 };
 module_platform_driver(bcm2835aux_serial_driver);
 
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 2569ca69223f..a713ffce533c 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1204,7 +1204,7 @@ static struct platform_driver brcmuart_platform_driver = {
 		.of_match_table = brcmuart_dt_ids,
 	},
 	.probe		= brcmuart_probe,
-	.remove_new	= brcmuart_remove,
+	.remove		= brcmuart_remove,
 };
 
 static int __init brcmuart_init(void)
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ab9e7f204260..3b278bf8520d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -796,7 +796,7 @@ static struct platform_driver dw8250_platform_driver = {
 		.acpi_match_table = dw8250_acpi_match,
 	},
 	.probe			= dw8250_probe,
-	.remove_new		= dw8250_remove,
+	.remove			= dw8250_remove,
 };
 
 module_platform_driver(dw8250_platform_driver);
diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index a754755100ff..35094f884492 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -219,7 +219,7 @@ static struct platform_driver serial8250_em_platform_driver = {
 		.of_match_table = serial8250_em_dt_ids,
 	},
 	.probe			= serial8250_em_probe,
-	.remove_new		= serial8250_em_remove,
+	.remove			= serial8250_em_remove,
 };
 
 module_platform_driver(serial8250_em_platform_driver);
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index b4ed442082a8..1b7bd55619c6 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -179,7 +179,7 @@ static struct platform_driver fsl8250_platform_driver = {
 		.acpi_match_table	= ACPI_PTR(fsl_8250_acpi_id),
 	},
 	.probe			= fsl8250_acpi_probe,
-	.remove_new		= fsl8250_acpi_remove,
+	.remove			= fsl8250_acpi_remove,
 };
 
 module_platform_driver(fsl8250_platform_driver);
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index a2783e38a2e3..a73dd3773640 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -361,7 +361,7 @@ static struct platform_driver ingenic_uart_platform_driver = {
 		.of_match_table	= of_match,
 	},
 	.probe			= ingenic_uart_probe,
-	.remove_new		= ingenic_uart_remove,
+	.remove			= ingenic_uart_remove,
 };
 
 module_platform_driver(ingenic_uart_platform_driver);
diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
index 50c77c3dacf2..499e80aa4cf9 100644
--- a/drivers/tty/serial/8250/8250_ioc3.c
+++ b/drivers/tty/serial/8250/8250_ioc3.c
@@ -84,7 +84,7 @@ static void serial8250_ioc3_remove(struct platform_device *pdev)
 
 static struct platform_driver serial8250_ioc3_driver = {
 	.probe  = serial8250_ioc3_probe,
-	.remove_new = serial8250_ioc3_remove,
+	.remove = serial8250_ioc3_remove,
 	.driver = {
 		.name = "ioc3-serial8250",
 	}
diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 47e1a056a60c..d52445948da0 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -195,7 +195,7 @@ MODULE_DEVICE_TABLE(of, lpc18xx_serial_match);
 
 static struct platform_driver lpc18xx_serial_driver = {
 	.probe  = lpc18xx_serial_probe,
-	.remove_new = lpc18xx_serial_remove,
+	.remove = lpc18xx_serial_remove,
 	.driver = {
 		.name = "lpc18xx-uart",
 		.of_match_table = lpc18xx_serial_match,
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index b9cca210e171..ed2225bc0544 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -654,7 +654,7 @@ static struct platform_driver mtk8250_platform_driver = {
 		.of_match_table	= mtk8250_of_match,
 	},
 	.probe			= mtk8250_probe,
-	.remove_new		= mtk8250_remove,
+	.remove			= mtk8250_remove,
 };
 module_platform_driver(mtk8250_platform_driver);
 
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index e14f47ef1172..64aed7efc569 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -352,7 +352,7 @@ static struct platform_driver of_platform_serial_driver = {
 		.pm = &of_serial_pm_ops,
 	},
 	.probe = of_platform_serial_probe,
-	.remove_new = of_platform_serial_remove,
+	.remove = of_platform_serial_remove,
 };
 
 module_platform_driver(of_platform_serial_driver);
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 88b58f44e4e9..9b99a50ccc4f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1867,7 +1867,7 @@ static struct platform_driver omap8250_platform_driver = {
 		.of_match_table = omap8250_dt_ids,
 	},
 	.probe			= omap8250_probe,
-	.remove_new		= omap8250_remove,
+	.remove			= omap8250_remove,
 };
 module_platform_driver(omap8250_platform_driver);
 
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index be7ff07cbdd0..8bdc1879d952 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -285,7 +285,7 @@ MODULE_DEVICE_TABLE(acpi, acpi_platform_serial_table);
 
 static struct platform_driver serial8250_isa_driver = {
 	.probe		= serial8250_probe,
-	.remove_new	= serial8250_remove,
+	.remove		= serial8250_remove,
 	.suspend	= serial8250_suspend,
 	.resume		= serial8250_resume,
 	.driver		= {
diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 96dd6126296c..6dd0190b4843 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -154,7 +154,7 @@ static void serial_pxa_remove(struct platform_device *pdev)
 
 static struct platform_driver serial_pxa_driver = {
 	.probe          = serial_pxa_probe,
-	.remove_new     = serial_pxa_remove,
+	.remove         = serial_pxa_remove,
 
 	.driver		= {
 		.name	= "pxa2xx-uart",
diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index 60a80d00d251..2f3b0075763f 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -182,7 +182,7 @@ static struct platform_driver tegra_uart_driver = {
 		.acpi_match_table = ACPI_PTR(tegra_uart_acpi_match),
 	},
 	.probe = tegra_uart_probe,
-	.remove_new = tegra_uart_remove,
+	.remove = tegra_uart_remove,
 };
 
 module_platform_driver(tegra_uart_driver);
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 670d2ca0f757..4874a9632db3 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -282,7 +282,7 @@ MODULE_DEVICE_TABLE(of, uniphier_uart_match);
 
 static struct platform_driver uniphier_uart_platform_driver = {
 	.probe		= uniphier_uart_probe,
-	.remove_new	= uniphier_uart_remove,
+	.remove		= uniphier_uart_remove,
 	.driver = {
 		.name	= "uniphier-uart",
 		.of_match_table = uniphier_uart_match,
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index effcba71ea77..6162108c758e 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -449,7 +449,7 @@ MODULE_DEVICE_TABLE(of, altera_jtaguart_match);
 
 static struct platform_driver altera_jtaguart_platform_driver = {
 	.probe	= altera_jtaguart_probe,
-	.remove_new = altera_jtaguart_remove,
+	.remove = altera_jtaguart_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.of_match_table	= of_match_ptr(altera_jtaguart_match),
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 897f0995b2fe..8eed2542627e 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -617,7 +617,7 @@ MODULE_DEVICE_TABLE(of, altera_uart_match);
 
 static struct platform_driver altera_uart_platform_driver = {
 	.probe	= altera_uart_probe,
-	.remove_new = altera_uart_remove,
+	.remove = altera_uart_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.of_match_table	= of_match_ptr(altera_uart_match),
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7d0134ecd82f..56e587b94823 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2937,7 +2937,7 @@ MODULE_DEVICE_TABLE(acpi, sbsa_uart_acpi_match);
 
 static struct platform_driver arm_sbsa_uart_platform_driver = {
 	.probe		= sbsa_uart_probe,
-	.remove_new	= sbsa_uart_remove,
+	.remove		= sbsa_uart_remove,
 	.driver	= {
 		.name	= "sbsa-uart",
 		.pm	= &pl011_dev_pm_ops,
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 47889a557119..8bb33556b312 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -832,7 +832,7 @@ MODULE_DEVICE_TABLE(of, ar933x_uart_of_ids);
 
 static struct platform_driver ar933x_uart_platform_driver = {
 	.probe		= ar933x_uart_probe,
-	.remove_new	= ar933x_uart_remove,
+	.remove		= ar933x_uart_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.of_match_table = of_match_ptr(ar933x_uart_of_ids),
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 09b246c9e389..b9be993ebdf4 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -3017,7 +3017,7 @@ static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
 
 static struct platform_driver atmel_serial_driver = {
 	.probe		= atmel_serial_probe,
-	.remove_new	= atmel_serial_remove,
+	.remove		= atmel_serial_remove,
 	.driver		= {
 		.name			= "atmel_usart_serial",
 		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index b88cc28c94e3..51df9d2d8bfc 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -884,7 +884,7 @@ MODULE_DEVICE_TABLE(of, bcm63xx_of_match);
  */
 static struct platform_driver bcm_uart_platform_driver = {
 	.probe	= bcm_uart_probe,
-	.remove_new = bcm_uart_remove,
+	.remove = bcm_uart_remove,
 	.driver	= {
 		.name  = "bcm63xx_uart",
 		.of_match_table = bcm63xx_of_match,
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 30425a3d19fb..83186bf50002 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -529,7 +529,7 @@ static struct platform_driver clps711x_uart_platform = {
 		.of_match_table	= of_match_ptr(clps711x_uart_dt_ids),
 	},
 	.probe	= uart_clps711x_probe,
-	.remove_new = uart_clps711x_remove,
+	.remove = uart_clps711x_remove,
 };
 
 static int __init uart_clps711x_init(void)
diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.c
index a927478f581d..550712a13593 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -1573,7 +1573,7 @@ static struct platform_driver cpm_uart_driver = {
 		.of_match_table = cpm_uart_match,
 	},
 	.probe = cpm_uart_probe,
-	.remove_new = cpm_uart_remove,
+	.remove = cpm_uart_remove,
  };
 
 static int __init cpm_uart_init(void)
diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 2ccd13cc0a89..d2482df5cb9b 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -522,7 +522,7 @@ static struct platform_driver digicolor_uart_platform = {
 		.of_match_table	= of_match_ptr(digicolor_uart_dt_ids),
 	},
 	.probe	= digicolor_uart_probe,
-	.remove_new = digicolor_uart_remove,
+	.remove = digicolor_uart_remove,
 };
 
 static int __init digicolor_uart_init(void)
diff --git a/drivers/tty/serial/esp32_acm.c b/drivers/tty/serial/esp32_acm.c
index 85eb0392e379..bb7cc65427f0 100644
--- a/drivers/tty/serial/esp32_acm.c
+++ b/drivers/tty/serial/esp32_acm.c
@@ -423,7 +423,7 @@ static void esp32s3_acm_remove(struct platform_device *pdev)
 
 static struct platform_driver esp32s3_acm_driver = {
 	.probe		= esp32s3_acm_probe,
-	.remove_new	= esp32s3_acm_remove,
+	.remove		= esp32s3_acm_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table	= esp32s3_acm_dt_ids,
diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 8c86cf9cb763..667c2198a03a 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -743,7 +743,7 @@ static void esp32_uart_remove(struct platform_device *pdev)
 
 static struct platform_driver esp32_uart_driver = {
 	.probe		= esp32_uart_probe,
-	.remove_new	= esp32_uart_remove,
+	.remove		= esp32_uart_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table	= esp32_uart_dt_ids,
diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index e972df4b188d..e70a56de1fce 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -882,7 +882,7 @@ static SIMPLE_DEV_PM_OPS(linflex_pm_ops, linflex_suspend, linflex_resume);
 
 static struct platform_driver linflex_driver = {
 	.probe		= linflex_probe,
-	.remove_new	= linflex_remove,
+	.remove		= linflex_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table	= linflex_dt_ids,
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 77efa7ee6eda..c14a83c86029 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -3206,7 +3206,7 @@ static const struct dev_pm_ops lpuart_pm_ops = {
 
 static struct platform_driver lpuart_driver = {
 	.probe		= lpuart_probe,
-	.remove_new	= lpuart_remove,
+	.remove		= lpuart_remove,
 	.driver		= {
 		.name	= "fsl-lpuart",
 		.of_match_table = lpuart_dt_ids,
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 67d4a72eda77..f7367969a42a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2702,7 +2702,7 @@ static const struct dev_pm_ops imx_uart_pm_ops = {
 
 static struct platform_driver imx_uart_platform_driver = {
 	.probe = imx_uart_probe,
-	.remove_new = imx_uart_remove,
+	.remove = imx_uart_remove,
 
 	.driver = {
 		.name = "imx-uart",
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index a0731773ce75..58a3ab030d67 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -915,7 +915,7 @@ MODULE_DEVICE_TABLE(of, ltq_asc_match);
 
 static struct platform_driver lqasc_driver = {
 	.probe		= lqasc_probe,
-	.remove_new	= lqasc_remove,
+	.remove		= lqasc_remove,
 	.driver		= {
 		.name	= DRVNAME,
 		.of_match_table = ltq_asc_match,
diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 3ce369f76349..6c13cf1ab646 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -353,7 +353,7 @@ MODULE_DEVICE_TABLE(of, liteuart_of_match);
 
 static struct platform_driver liteuart_platform_driver = {
 	.probe = liteuart_probe,
-	.remove_new = liteuart_remove,
+	.remove = liteuart_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = liteuart_of_match,
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 3e4ac46de1bc..42c5f9bc18b7 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -695,7 +695,7 @@ MODULE_DEVICE_TABLE(of, serial_hs_lpc32xx_dt_ids);
 
 static struct platform_driver serial_hs_lpc32xx_driver = {
 	.probe		= serial_hs_lpc32xx_probe,
-	.remove_new	= serial_hs_lpc32xx_remove,
+	.remove		= serial_hs_lpc32xx_remove,
 	.suspend	= serial_hs_lpc32xx_suspend,
 	.resume		= serial_hs_lpc32xx_resume,
 	.driver		= {
diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 3b4206e815fe..8dcad52eedfd 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -794,7 +794,7 @@ static int ma35d1serial_resume(struct platform_device *dev)
 
 static struct platform_driver ma35d1serial_driver = {
 	.probe      = ma35d1serial_probe,
-	.remove_new = ma35d1serial_remove,
+	.remove     = ma35d1serial_remove,
 	.suspend    = ma35d1serial_suspend,
 	.resume     = ma35d1serial_resume,
 	.driver     = {
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 58858dd352c5..93e7dda4d39a 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -616,7 +616,7 @@ static void mcf_remove(struct platform_device *pdev)
 
 static struct platform_driver mcf_platform_driver = {
 	.probe		= mcf_probe,
-	.remove_new	= mcf_remove,
+	.remove		= mcf_remove,
 	.driver		= {
 		.name	= "mcfuart",
 	},
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8eb586ac3b0d..a6cb2a535f9d 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -842,7 +842,7 @@ MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
 
 static  struct platform_driver meson_uart_platform_driver = {
 	.probe		= meson_uart_probe,
-	.remove_new	= meson_uart_remove,
+	.remove		= meson_uart_remove,
 	.driver		= {
 		.name		= "meson_uart",
 		.of_match_table	= meson_uart_dt_match,
diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index fb082ee73d5b..059bea18dbab 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -570,7 +570,7 @@ MODULE_DEVICE_TABLE(of, mlb_usio_dt_ids);
 
 static struct platform_driver mlb_usio_driver = {
 	.probe          = mlb_usio_probe,
-	.remove_new     = mlb_usio_remove,
+	.remove         = mlb_usio_remove,
 	.driver         = {
 		.name   = USIO_NAME,
 		.of_match_table = mlb_usio_dt_ids,
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 95dae5e27b28..f55aa353aed9 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1843,7 +1843,7 @@ MODULE_DEVICE_TABLE(of, mpc52xx_uart_of_match);
 
 static struct platform_driver mpc52xx_uart_of_driver = {
 	.probe		= mpc52xx_uart_of_probe,
-	.remove_new	= mpc52xx_uart_of_remove,
+	.remove		= mpc52xx_uart_of_remove,
 #ifdef CONFIG_PM
 	.suspend	= mpc52xx_uart_of_suspend,
 	.resume		= mpc52xx_uart_of_resume,
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 0a9c5219df88..1b137e068444 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1894,7 +1894,7 @@ static const struct dev_pm_ops msm_serial_dev_pm_ops = {
 };
 
 static struct platform_driver msm_platform_driver = {
-	.remove_new = msm_serial_remove,
+	.remove = msm_serial_remove,
 	.probe = msm_serial_probe,
 	.driver = {
 		.name = "msm_serial",
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index a1c76565c399..cc65c9fb6446 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1704,7 +1704,7 @@ static void mxs_auart_remove(struct platform_device *pdev)
 
 static struct platform_driver mxs_auart_driver = {
 	.probe = mxs_auart_probe,
-	.remove_new = mxs_auart_remove,
+	.remove = mxs_auart_remove,
 	.driver = {
 		.name = "mxs-auart",
 		.of_match_table = mxs_auart_dt_ids,
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d7e172eeaab1..0b85f47ff19e 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1802,7 +1802,7 @@ MODULE_DEVICE_TABLE(of, omap_serial_of_match);
 
 static struct platform_driver serial_omap_driver = {
 	.probe          = serial_omap_probe,
-	.remove_new     = serial_omap_remove,
+	.remove         = serial_omap_remove,
 	.driver		= {
 		.name	= OMAP_SERIAL_DRIVER_NAME,
 		.pm	= &serial_omap_dev_pm_ops,
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index ecec483d4d59..0542882cfbbe 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -730,7 +730,7 @@ static void owl_uart_remove(struct platform_device *pdev)
 
 static struct platform_driver owl_uart_platform_driver = {
 	.probe = owl_uart_probe,
-	.remove_new = owl_uart_remove,
+	.remove = owl_uart_remove,
 	.driver = {
 		.name = "owl-uart",
 		.of_match_table = owl_uart_dt_matches,
diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 261c8115a700..14d50bd7f1bd 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -956,7 +956,7 @@ MODULE_DEVICE_TABLE(of, pic32_serial_dt_ids);
 
 static struct platform_driver pic32_uart_platform_driver = {
 	.probe		= pic32_uart_probe,
-	.remove_new	= pic32_uart_remove,
+	.remove		= pic32_uart_remove,
 	.driver		= {
 		.name	= PIC32_DEV_NAME,
 		.of_match_table	= of_match_ptr(pic32_serial_dt_ids),
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 8969b11cc0a9..e3a919328695 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1776,7 +1776,7 @@ static struct macio_driver pmz_driver = {
 
 static struct platform_driver pmz_driver = {
 	.probe		= pmz_attach,
-	.remove_new	= pmz_detach,
+	.remove		= pmz_detach,
 	.driver		= {
 		.name		= "scc",
 	},
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6f0db310cf69..a433a3c6e1ae 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1846,7 +1846,7 @@ static const struct of_device_id qcom_geni_serial_match_table[] = {
 MODULE_DEVICE_TABLE(of, qcom_geni_serial_match_table);
 
 static struct platform_driver qcom_geni_serial_platform_driver = {
-	.remove_new = qcom_geni_serial_remove,
+	.remove = qcom_geni_serial_remove,
 	.probe = qcom_geni_serial_probe,
 	.driver = {
 		.name = "qcom_geni_serial",
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 663e35e424bd..87fa30d68687 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -777,7 +777,7 @@ static void rda_uart_remove(struct platform_device *pdev)
 
 static struct platform_driver rda_uart_platform_driver = {
 	.probe = rda_uart_probe,
-	.remove_new = rda_uart_remove,
+	.remove = rda_uart_remove,
 	.driver = {
 		.name = "rda-uart",
 		.of_match_table = rda_uart_dt_matches,
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index 79c794fa6545..3c34027687d2 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -880,7 +880,7 @@ static void sa1100_serial_remove(struct platform_device *pdev)
 
 static struct platform_driver sa11x0_serial_driver = {
 	.probe		= sa1100_serial_probe,
-	.remove_new	= sa1100_serial_remove,
+	.remove		= sa1100_serial_remove,
 	.suspend	= sa1100_serial_suspend,
 	.resume		= sa1100_serial_resume,
 	.driver		= {
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 0d184ee2f9ce..405b1a27a4fd 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2653,7 +2653,7 @@ MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
 
 static struct platform_driver samsung_serial_driver = {
 	.probe		= s3c24xx_serial_probe,
-	.remove_new	= s3c24xx_serial_remove,
+	.remove		= s3c24xx_serial_remove,
 	.id_table	= s3c24xx_serial_driver_ids,
 	.driver		= {
 		.name	= "samsung-uart",
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 6d1d142fd216..4c851dae6624 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -1052,7 +1052,7 @@ static struct platform_driver sccnxp_uart_driver = {
 		.name	= SCCNXP_NAME,
 	},
 	.probe		= sccnxp_probe,
-	.remove_new	= sccnxp_remove,
+	.remove		= sccnxp_remove,
 	.id_table	= sccnxp_id_table,
 };
 module_platform_driver(sccnxp_uart_driver);
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 1183ca54ab92..8004fc00fb9c 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1648,7 +1648,7 @@ static const struct dev_pm_ops tegra_uart_pm_ops = {
 
 static struct platform_driver tegra_uart_platform_driver = {
 	.probe		= tegra_uart_probe,
-	.remove_new	= tegra_uart_remove,
+	.remove		= tegra_uart_remove,
 	.driver		= {
 		.name	= "serial-tegra",
 		.of_match_table = tegra_uart_of_match,
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index abba39722958..436a559234df 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1097,7 +1097,7 @@ static int serial_txx9_resume(struct platform_device *dev)
 
 static struct platform_driver serial_txx9_plat_driver = {
 	.probe		= serial_txx9_probe,
-	.remove_new	= serial_txx9_remove,
+	.remove		= serial_txx9_remove,
 #ifdef CONFIG_PM
 	.suspend	= serial_txx9_suspend,
 	.resume		= serial_txx9_resume,
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b80e9a528e17..df523c744423 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3505,7 +3505,7 @@ static SIMPLE_DEV_PM_OPS(sci_dev_pm_ops, sci_suspend, sci_resume);
 
 static struct platform_driver sci_driver = {
 	.probe		= sci_probe,
-	.remove_new	= sci_remove,
+	.remove		= sci_remove,
 	.driver		= {
 		.name	= "sh-sci",
 		.pm	= &sci_dev_pm_ops,
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index cbfce65c9d22..5904a2d4cefa 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -1040,7 +1040,7 @@ MODULE_DEVICE_TABLE(of, sifive_serial_of_match);
 
 static struct platform_driver sifive_serial_platform_driver = {
 	.probe		= sifive_serial_probe,
-	.remove_new	= sifive_serial_remove,
+	.remove		= sifive_serial_remove,
 	.driver		= {
 		.name	= SIFIVE_SERIAL_NAME,
 		.pm = pm_sleep_ptr(&sifive_uart_pm_ops),
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 3fc54cc02a1f..397a284e3fdc 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1255,7 +1255,7 @@ MODULE_DEVICE_TABLE(of, serial_ids);
 
 static struct platform_driver sprd_platform_driver = {
 	.probe		= sprd_probe,
-	.remove_new	= sprd_remove,
+	.remove		= sprd_remove,
 	.driver		= {
 		.name	= "sprd_serial",
 		.of_match_table = serial_ids,
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 8aea59f8ca13..6ed9a327702b 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -934,7 +934,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(asc_serial_pm_ops, asc_serial_suspend,
 
 static struct platform_driver asc_serial_driver = {
 	.probe		= asc_serial_probe,
-	.remove_new	= asc_serial_remove,
+	.remove		= asc_serial_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.pm	= pm_sleep_ptr(&asc_serial_pm_ops),
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index e1e7bc04c579..7dc254546075 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -2188,7 +2188,7 @@ static const struct dev_pm_ops stm32_serial_pm_ops = {
 
 static struct platform_driver stm32_serial_driver = {
 	.probe		= stm32_usart_serial_probe,
-	.remove_new	= stm32_usart_serial_remove,
+	.remove		= stm32_usart_serial_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.pm	= &stm32_serial_pm_ops,
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 7f60679fdde1..2b3ec65d595d 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -633,7 +633,7 @@ static struct platform_driver hv_driver = {
 		.of_match_table = hv_match,
 	},
 	.probe		= hv_probe,
-	.remove_new	= hv_remove,
+	.remove		= hv_remove,
 };
 
 static int __init sunhv_init(void)
diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
index abf7c449308d..38deee571b0d 100644
--- a/drivers/tty/serial/sunplus-uart.c
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -697,7 +697,7 @@ MODULE_DEVICE_TABLE(of, sp_uart_of_match);
 
 static struct platform_driver sunplus_uart_platform_driver = {
 	.probe		= sunplus_uart_probe,
-	.remove_new	= sunplus_uart_remove,
+	.remove		= sunplus_uart_remove,
 	.driver = {
 		.name	= "sunplus_uart",
 		.of_match_table = sp_uart_of_match,
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 1acbe2fba746..df906ccf2e8a 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -1100,7 +1100,7 @@ static struct platform_driver sab_driver = {
 		.of_match_table = sab_match,
 	},
 	.probe		= sab_probe,
-	.remove_new	= sab_remove,
+	.remove		= sab_remove,
 };
 
 static int __init sunsab_init(void)
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 0f463da5e7ce..7f0fef07e141 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1549,7 +1549,7 @@ static struct platform_driver su_driver = {
 		.of_match_table = su_match,
 	},
 	.probe		= su_probe,
-	.remove_new	= su_remove,
+	.remove		= su_remove,
 };
 
 static int __init sunsu_init(void)
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 71758ad4241c..0551c24c06f5 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1538,7 +1538,7 @@ static struct platform_driver zs_driver = {
 		.of_match_table = zs_match,
 	},
 	.probe		= zs_probe,
-	.remove_new	= zs_remove,
+	.remove		= zs_remove,
 };
 
 static int __init sunzilog_init(void)
diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
index 21ca5fcadf49..7033dbfe8ba1 100644
--- a/drivers/tty/serial/tegra-tcu.c
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -293,7 +293,7 @@ static struct platform_driver tegra_tcu_driver = {
 		.of_match_table = tegra_tcu_match,
 	},
 	.probe = tegra_tcu_probe,
-	.remove_new = tegra_tcu_remove,
+	.remove = tegra_tcu_remove,
 };
 module_platform_driver(tegra_tcu_driver);
 
diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 43fa0938b5e3..6fa93c3872a7 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -485,7 +485,7 @@ static struct platform_driver timbuart_platform_driver = {
 		.name	= "timb-uart",
 	},
 	.probe		= timbuart_probe,
-	.remove_new	= timbuart_remove,
+	.remove		= timbuart_remove,
 };
 
 module_platform_driver(timbuart_platform_driver);
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 68357ac8ffe3..a41e7fc373b7 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -915,7 +915,7 @@ MODULE_ALIAS("platform:uartlite");
 
 static struct platform_driver ulite_platform_driver = {
 	.probe = ulite_probe,
-	.remove_new = ulite_remove,
+	.remove = ulite_remove,
 	.driver = {
 		.name  = "uartlite",
 		.of_match_table = of_match_ptr(ulite_of_match),
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 53bb8c5ef499..6e27843437ab 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1484,7 +1484,7 @@ static struct platform_driver ucc_uart_of_driver = {
 		.of_match_table    = ucc_uart_match,
 	},
 	.probe  	= ucc_uart_probe,
-	.remove_new 	= ucc_uart_remove,
+	.remove 	= ucc_uart_remove,
 };
 
 static int __init ucc_uart_init(void)
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 777392914819..beb151be4d32 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1903,7 +1903,7 @@ static void cdns_uart_remove(struct platform_device *pdev)
 
 static struct platform_driver cdns_uart_platform_driver = {
 	.probe   = cdns_uart_probe,
-	.remove_new = cdns_uart_remove,
+	.remove  = cdns_uart_remove,
 	.driver  = {
 		.name = CDNS_UART_NAME,
 		.of_match_table = cdns_uart_of_match,

base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
-- 
2.45.2


