Return-Path: <linux-serial+bounces-1404-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F82F829744
	for <lists+linux-serial@lfdr.de>; Wed, 10 Jan 2024 11:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43AAB26DD4
	for <lists+linux-serial@lfdr.de>; Wed, 10 Jan 2024 10:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E418F3FE36;
	Wed, 10 Jan 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xK8vMPH0"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004DD3FB38
	for <linux-serial@vger.kernel.org>; Wed, 10 Jan 2024 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e67e37661so4962695e87.0
        for <linux-serial@vger.kernel.org>; Wed, 10 Jan 2024 02:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882069; x=1705486869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA1wqdkIBgQshp7OOT7q6kHMVXJcjDA2G18H91tm8Z8=;
        b=xK8vMPH0tTdvjzREA+kXmSbeaSuoL9xKI3Vxcpz/UhDqZ0No8PCJPktXZo6YPmg7Qb
         EvboM8yFnzZ7QZziP1tMkoshVE6zxj4eAtO7nsMiOeVaGt6jkj2WrQeMdY8eD6/ukLtA
         Y6KC2T/X8HWOICt9fAMLVyf4l5j0x13/XKK4adfs+CP21gfEFAUj0ZGgSFWMOOw053N1
         JfMBEZ3OLaLQYtjHZPOoSJp8d24nwuS+fj2xab+znJKC3k5ZekmH3xaCz1sbhzxg0tbz
         EgDMMjWvpbxFEKApKU9+W1tm3j6nXngCb4hixslpdGiuiTuCVmfXOItdIlHprHbetLVp
         PHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882069; x=1705486869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA1wqdkIBgQshp7OOT7q6kHMVXJcjDA2G18H91tm8Z8=;
        b=oVUHWb+cOjKPX/Z8qwZ1yRntbu0n0n8D5hAIYT+O3WFWUKX/YaOQODykwnabflQpXB
         4VzTmYG3ERyjVYkTrhKMiIXqwsX4UCUwXrtzi6iNX1l/gTE0DkSQNA2fisrSkoCGpQmv
         /8Gs1DJ138HMbxBvsR6RFvotAH/EA10jnToqc3L7MuvBpfbX4cFEelsSU/DUw3BhJhZJ
         Xj38w372aYwPNPLlg5K5gqzh1sWci6wRqn5eM8ztm7C/5ZeED2nwmfTebbywIEDSAoOl
         LyRPkGdl0wh1sfEZrGb+g4nyxrmtPcRFL4cxnaH5tP/grpf8ZGqFwiNyQHFDtKptEXB2
         awlw==
X-Gm-Message-State: AOJu0YzKMVRs59tiyyP9jcRFERBQGyQOuFhILbxVxgTLs5WVXieb7poq
	yR94S17Vg76eVtxpl9Td1cdKbEYKXMUFsA==
X-Google-Smtp-Source: AGHT+IELjvrXw11hASDuqeoOjnXHBb/wHFRSBI3T8k5uASK1m5nJmKIYBXNYKwon+CNtfclv5aKAuA==
X-Received: by 2002:a05:6512:131f:b0:50e:d347:b83 with SMTP id x31-20020a056512131f00b0050ed3470b83mr344642lfu.115.1704882068958;
        Wed, 10 Jan 2024 02:21:08 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:08 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 02/18] tty: serial: samsung: set UPIO_MEM32 iotype for gs101
Date: Wed, 10 Jan 2024 10:20:46 +0000
Message-ID: <20240110102102.61587-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240110102102.61587-1-tudor.ambarus@linaro.org>
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GS101's Connectivity Peripheral blocks (peric0/1 blocks) which
include the I3C and USI (I2C, SPI, UART) only allow 32-bit
register accesses.

Instead of specifying the reg-io-width = 4 everywhere, for each node,
the requirement should be deduced from the compatible.

Infer UPIO_MEM32 iotype from the "google,gs101-uart" compatible.
Update the uart info name to be GS101 specific in order to
differentiate from the other exynos platforms. All the other settings
are not changed.

exynos_fifoszdt_serial_drv_data was replaced by gs101_serial_drv_data
because the iotype restriction is gs101 specific and there was no other
user of exynos_fifoszdt_serial_drv_data.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 38 +++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index b8fe9df20202..20ec6ef1a52f 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2495,25 +2495,43 @@ static const struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
 	.fifosize = { 256, 64, 64, 64 },
 };
 
-/*
- * Common drv_data struct for platforms that specify samsung,uart-fifosize in
- * device tree.
- */
-static const struct s3c24xx_serial_drv_data exynos_fifoszdt_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA(),
+static const struct s3c24xx_serial_drv_data gs101_serial_drv_data = {
+	.info = {
+		.name		= "Google GS101 UART",
+		.type		= TYPE_S3C6400,
+		.port_type	= PORT_S3C6400,
+		.iotype		= UPIO_MEM32,
+		.has_divslot	= 1,
+		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
+		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
+		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,
+		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,
+		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
+		.num_clks	= 1,
+		.clksel_mask	= 0,
+		.clksel_shift	= 0,
+	},
+	.def_cfg = {
+		.ucon		= S5PV210_UCON_DEFAULT,
+		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.has_fracval	= 1,
+	},
+	/* samsung,uart-fifosize must be specified in the device tree. */
 	.fifosize = { 0 },
 };
 
 #define EXYNOS4210_SERIAL_DRV_DATA (&exynos4210_serial_drv_data)
 #define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
 #define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
-#define EXYNOS_FIFOSZDT_DRV_DATA (&exynos_fifoszdt_serial_drv_data)
+#define GS101_SERIAL_DRV_DATA (&gs101_serial_drv_data)
 
 #else
 #define EXYNOS4210_SERIAL_DRV_DATA NULL
 #define EXYNOS5433_SERIAL_DRV_DATA NULL
 #define EXYNOS850_SERIAL_DRV_DATA NULL
-#define EXYNOS_FIFOSZDT_DRV_DATA NULL
+#define GS101_SERIAL_DRV_DATA NULL
 #endif
 
 #ifdef CONFIG_ARCH_APPLE
@@ -2601,7 +2619,7 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 		.driver_data	= (kernel_ulong_t)ARTPEC8_SERIAL_DRV_DATA,
 	}, {
 		.name		= "gs101-uart",
-		.driver_data	= (kernel_ulong_t)EXYNOS_FIFOSZDT_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)GS101_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -2624,7 +2642,7 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 	{ .compatible = "axis,artpec8-uart",
 		.data = ARTPEC8_SERIAL_DRV_DATA },
 	{ .compatible = "google,gs101-uart",
-		.data = EXYNOS_FIFOSZDT_DRV_DATA },
+		.data = GS101_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
-- 
2.43.0.472.g3155946c3a-goog


