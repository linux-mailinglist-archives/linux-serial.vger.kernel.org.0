Return-Path: <linux-serial+bounces-1403-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9950829741
	for <lists+linux-serial@lfdr.de>; Wed, 10 Jan 2024 11:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6271F2845D
	for <lists+linux-serial@lfdr.de>; Wed, 10 Jan 2024 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90863F8FB;
	Wed, 10 Jan 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHa+QY2i"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2F3FE27
	for <linux-serial@vger.kernel.org>; Wed, 10 Jan 2024 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e5770d34fso3220335e9.3
        for <linux-serial@vger.kernel.org>; Wed, 10 Jan 2024 02:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882068; x=1705486868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/c7oDT8RKSeNrIFhGqJZw8sJoinUsXp+DaHWK6w1PA=;
        b=EHa+QY2iDGVWuOoQ/ys4OLVXFb/zbFRuQLlei825OF66EBStNyLjLXASYbhFPByzKw
         /5+o+cWIr5j9NULiMVgvlmdoIZxOOkBc1M+PXAQ4tOxOsRV/eTeBzLBa1bFI3bxUlp0s
         cR4aoavbQ6F/ol6DVoRc8ZtLW+gFGA1ArXl4tm90CmDU9q1WZuzOWbH9JD+Q4KXgk6pU
         pCgns/lCMXAji7MoRo45BAYTD4K8DDQdhnvb0fdeIpkwyx9xUz9HCT3g0BnoE+26hLMt
         Nw337rppyUK02tUyE5imJgAt/uFUj4+MV3XDQQxZqqpirBXogBbQQCRuyN8iOGYktrZY
         lj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882068; x=1705486868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/c7oDT8RKSeNrIFhGqJZw8sJoinUsXp+DaHWK6w1PA=;
        b=TivxMTgB0o+kO03T9pL/Ux7h3loPOpMYd26IFZXYfMOp9NRr/VBS0sR2NLaqowQ8WC
         o+2DsAb+PVyMkecN2n5pvHR9GDzWubdy2KRofveYwzgAAf21tgAQPeW8lb3fUpP31LFu
         /pqjGvZIVJ8ylupH4/z+kmUowxU5r4v6xvEY5iQ8h5ZUkLyWJpRuQCQ2W2kMHtsFbcON
         /jCAYOwuG9Y3if9k3efBEDqlMR3/jaPdYvfW0VIL7o0touSkyColectcKwxU3MFl4lbs
         Yyf5glmGDMrBZZJjiltaLZ9ljNi9HkT2SZ/TxA4ycMza1vEwThou9ViKVulwWU8dNIYw
         Z3hw==
X-Gm-Message-State: AOJu0YzEAJSdEu9nMoqaR7Q3zpzVpRSARiZ0596da/fEGy9DAMkNPyz8
	9oCqPF5XRIceTym8exnPWx5ipmmhmi+7lQ==
X-Google-Smtp-Source: AGHT+IEQmAz/yRZ4JQb4KH0cdGwc6wBVKJX8n66A4HzKVJGrDTgM6umRzceJA14m6Bo9F2DGOz85Jw==
X-Received: by 2002:a05:600c:b88:b0:40e:4cc6:9ff5 with SMTP id fl8-20020a05600c0b8800b0040e4cc69ff5mr406137wmb.100.1704882068122;
        Wed, 10 Jan 2024 02:21:08 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:07 -0800 (PST)
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
Subject: [PATCH 01/18] tty: serial: samsung: prepare for different IO types
Date: Wed, 10 Jan 2024 10:20:45 +0000
Message-ID: <20240110102102.61587-2-tudor.ambarus@linaro.org>
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
register accesses. If using 8-bit register accesses, a SError
Interrupt is raised causing the system unusable.

Instead of specifying the reg-io-width = 4 everywhere, for each node,
the requirement should be deduced from the compatible.

Prepare the samsung tty driver to allow IO types different than
UPIO_MEM. ``struct uart_port::iotype`` is an unsigned char where all
its 8 bits are exposed to uapi. We can't make NULL checks on it to
verify if it's set, thus always set it from the driver's data.
Use u8 for the ``iotype`` member of ``struct s3c24xx_uart_info`` to
emphasize that the iotype is an 8 bit mask.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 71d17d804fda..b8fe9df20202 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -84,6 +84,7 @@ struct s3c24xx_uart_info {
 	unsigned long		clksel_mask;
 	unsigned long		clksel_shift;
 	unsigned long		ucon_mask;
+	u8			iotype;
 
 	/* uart port features */
 
@@ -1742,7 +1743,6 @@ static void s3c24xx_serial_init_port_default(int index) {
 
 	spin_lock_init(&port->lock);
 
-	port->iotype = UPIO_MEM;
 	port->uartclk = 0;
 	port->fifosize = 16;
 	port->flags = UPF_BOOT_AUTOCONF;
@@ -1989,6 +1989,8 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 		break;
 	}
 
+	ourport->port.iotype = ourport->info->iotype;
+
 	if (np) {
 		of_property_read_u32(np,
 			"samsung,uart-fifosize", &ourport->port.fifosize);
@@ -2399,6 +2401,7 @@ static const struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 		.name		= "Samsung S3C6400 UART",
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
+		.iotype		= UPIO_MEM,
 		.fifosize	= 64,
 		.has_divslot	= 1,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
@@ -2428,6 +2431,7 @@ static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.name		= "Samsung S5PV210 UART",
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
+		.iotype		= UPIO_MEM,
 		.has_divslot	= 1,
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
@@ -2457,6 +2461,7 @@ static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.name		= "Samsung Exynos UART",	\
 		.type		= TYPE_S3C6400,			\
 		.port_type	= PORT_S3C6400,			\
+		.iotype		= UPIO_MEM,			\
 		.has_divslot	= 1,				\
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
@@ -2517,6 +2522,7 @@ static const struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 		.name		= "Apple S5L UART",
 		.type		= TYPE_APPLE_S5L,
 		.port_type	= PORT_8250,
+		.iotype		= UPIO_MEM,
 		.fifosize	= 16,
 		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
@@ -2546,6 +2552,7 @@ static const struct s3c24xx_serial_drv_data artpec8_serial_drv_data = {
 		.name		= "Axis ARTPEC-8 UART",
 		.type		= TYPE_S3C6400,
 		.port_type	= PORT_S3C6400,
+		.iotype		= UPIO_MEM,
 		.fifosize	= 64,
 		.has_divslot	= 1,
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
-- 
2.43.0.472.g3155946c3a-goog


