Return-Path: <linux-serial+bounces-10422-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DF0B20D66
	for <lists+linux-serial@lfdr.de>; Mon, 11 Aug 2025 17:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89067A827A
	for <lists+linux-serial@lfdr.de>; Mon, 11 Aug 2025 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FE12E093F;
	Mon, 11 Aug 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TOq0xFfe"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C352E0B44
	for <linux-serial@vger.kernel.org>; Mon, 11 Aug 2025 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925494; cv=none; b=AESPo4UIIQ6RsI2plxYPTSlCTkwE/8R7vPM3C8X6xQ9k7XiUyHsjbgeTSk0aYsAIPFyFMEi0za+18RHwOWBdXPIAfsruH0Z8/QUkV2AXflTkyXghzQnDYEEtuNg1XEmXm5BFZHgEeViuNn+4JVTHgCqEKMiiuQaBxk+UfKeMDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925494; c=relaxed/simple;
	bh=1keMc57+QR2CICrcPlWaiGj5bDJ4SG5s8RArDpJq+tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYYuhV2Wol6TACMxP455Hz9gcA3YtomNlutyEmVJYtpLa2xoASyKrVI3fdFPl/du17y4bETsd0KxaHMOoRdaoqRqANpnafypphTqGCaBrshi5udWNgLAo0LX2kXTIxebN0m5c8hXlcR4P/vePGPADJ5ZifrYFZLZ9ETkNHzovWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TOq0xFfe; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so5238729a12.2
        for <linux-serial@vger.kernel.org>; Mon, 11 Aug 2025 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754925490; x=1755530290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukdxjc5DrhlQ7eBdrlN9f+Y4/ViYX/zBdRo4k+wcLt4=;
        b=TOq0xFfeTfXMRiBhrQ5Ff14ya6b6UsgD+FMCq5YosDGLCmMUYGyxo5C6De3Jg6H99y
         X8WbzZEne//Ow/aqJ80JN/yNtrS7Tdx2ghHefFmpbHpdmK+FxMrYGE2TIwiBiRnL2PgD
         nfbCKtql5pcIi6BbI/q/WfGH0Kz8UEeWcRofMWOirbZtgrzQTapZZ5vbzoMaZGM9cACF
         UJXm7LObpEH2PsT1ELkSxYoJCbzWWz14bo1ECXfdd6ZZDLbShDd52uc/JCVdMfoGcoJa
         A2oXi+qrX4FyR+OzBkJUWiH5GM2SGN8QxW/OAPIfUy+VS+lHRImCQvQrud2OjwsKceZH
         fUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925490; x=1755530290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukdxjc5DrhlQ7eBdrlN9f+Y4/ViYX/zBdRo4k+wcLt4=;
        b=eXfe+kcPoUPHwqnrjNAa5ndexTbAQZ6zdjYu4P24zaDMkMiB1ST0IkuO2FfImdhe/m
         JlOhv/wUPND26/3+0rWxHXftgqK6X27amwGT/1gifPnN1G0KmEs6P+7aQHuqgVED/5qF
         BCvmMOIq+bhaQuxqzbiDQI+syOt6e6ADO8b8p/A/5l1OSic8h9wWTogQTbT84gDZ3SoT
         +0eovDjkTwK6mMmdET2ySD9TUD6jKIljc+ySUftI3pnXryXCrgcHApSnsrZsgFLbrXwl
         6LR5YYKuWKOAOyJf8nA3OiQE4552GNaDcSUyow0SNsfAVxWFhFCdcdJgRvv/8cg5LYkP
         ydZg==
X-Forwarded-Encrypted: i=1; AJvYcCUC+gPNPMChJhYIMYHmNiwlNeNrBbAKydl4IeQzgN5zFzMcHAx5fj+rsHCucmTFM7wPXl2qk8UfJGMQDb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2LZHbtp7fDpCfFSERNi9YhgC31XIEvguMN/BlCXJz90wuU0D
	51VSxaU47xbkros6mne911kDsDNxhmm2DW7dXIienVBuyeIXqSZweKrm85h1qEDYh+8=
X-Gm-Gg: ASbGnctcGVbbp7du5C2NBKJSAIfQvS/mpX+iLhEXB8YdIfC6itRlrLt8MLgTJ8db+/8
	hFC/mrHqdqXomu7tSGoxe+ml33cdEGOvAuAG3mV4EhSpbseQw/Un0PVxRi2Fxc/L96o4QpTUFKf
	hamJVEGfG7s3R/i1s3cneE8DLG5jKvTvfsBXbNQr+owlF0eidfcroZxaPMw3x2AUaOCywOhilk2
	9xzn1nAfppn3peNwAMdy7PQEvU9NzI90dCvbvdC+J0VqehuMHvR761CkZkebLtTcjoI1ww/hjVU
	x4yS81SWtI4XUwPhG0XtnGu7yxNMWLJqfK1NMY977Yna6A5xvzp/HolHxbCZ2b6C26KnY7MnLP8
	JdWowCAHSueTX5DZpZ16btRNB4dE7IVHFl2AxKKAHUK4dz3lVN8pIY0kpE3tTFa2mDM9/GU0xzF
	Ti
X-Google-Smtp-Source: AGHT+IGLYy3TQkH/3UhAMhNCt2Tp94AsM9dBQJ1xNBWsLvENOx4hXDkAR8wy7Smqj1yqAlol91Adqw==
X-Received: by 2002:a17:907:9705:b0:ad8:9c97:c2e5 with SMTP id a640c23a62f3a-af9c606d956mr1287835366b.0.1754925490087;
        Mon, 11 Aug 2025 08:18:10 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c039sm2046620266b.110.2025.08.11.08.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:18:09 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 5/6] arm64: dts: broadcom: bcm2712: Add second SDHCI controller node
Date: Mon, 11 Aug 2025 17:19:49 +0200
Message-ID: <79b48fbeb009460fd2c03b910a0412b8facab9a8.1754924348.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1754924348.git.andrea.porta@suse.com>
References: <cover.1754924348.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Ivan T. Ivanov" <iivanov@suse.de>

Add SDIO2 node. On RPi5 it is connected to WiFi chip.
Add related pin, gpio and regulator definitions and
add WiFi node. With this and firmware already provided by
distributions, at least on openSUSE Tumbleweed, this is
sufficient to make WiFi operational on RPi5 \o/.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 52 +++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 15 ++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
index f0883c903527..411b58c1dddf 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
@@ -66,6 +66,18 @@ sd_vcc_reg: sd-vcc-reg {
 		enable-active-high;
 		gpios = <&gio_aon 4 GPIO_ACTIVE_HIGH>;
 	};
+
+	wl_on_reg: wl-on-reg {
+		compatible = "regulator-fixed";
+		regulator-name = "wl-on-regulator";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-0 = <&wl_on_default>;
+		pinctrl-names = "default";
+		gpio = <&gio 28 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <150000>;
+		enable-active-high;
+	};
 };
 
 &pinctrl {
@@ -79,6 +91,29 @@ pwr_button_default: pwr-button-default-state {
 		pins = "gpio20";
 		bias-pull-up;
 	};
+
+	sdio2_30_default: sdio2-30-default-state {
+		clk-pins {
+			function = "sd2";
+			pins = "gpio30";
+			bias-disable;
+		};
+		cmd-pins {
+			function = "sd2";
+			pins = "gpio31";
+			bias-pull-up;
+		};
+		dat-pins {
+			function = "sd2";
+			pins = "gpio32", "gpio33", "gpio34", "gpio35";
+			bias-pull-up;
+		};
+	};
+
+	wl_on_default: wl-on-default-state {
+		function = "gpio";
+		pins = "gpio28";
+	};
 };
 
 &pinctrl_aon {
@@ -109,6 +144,23 @@ &sdio1 {
 	cd-gpios = <&gio_aon 5 GPIO_ACTIVE_LOW>;
 };
 
+&sdio2 {
+	pinctrl-0 = <&sdio2_30_default>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	vmmc-supply = <&wl_on_reg>;
+	sd-uhs-ddr50;
+	non-removable;
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	wifi: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
 &soc {
 	firmware: firmware {
 		compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index f70ec8d3dc4d..871537366e96 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -285,6 +285,21 @@ gio_aon: gpio@7d517c00 {
 			 */
 		};
 
+		sdio2: mmc@1100000 {
+			compatible = "brcm,bcm2712-sdhci",
+				     "brcm,sdhci-brcmstb";
+			reg = <0x01100000  0x260>,
+			      <0x01100400  0x200>;
+			reg-names = "host", "cfg";
+			interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_emmc2>;
+			clock-names = "sw_sdio";
+			sdhci-caps-mask = <0x0000C000 0x0>;
+			sdhci-caps = <0x0 0x0>;
+			mmc-ddr-3_3v;
+			status = "disabled";
+		};
+
 		gicv2: interrupt-controller@7fff9000 {
 			compatible = "arm,gic-400";
 			reg = <0x7fff9000 0x1000>,
-- 
2.35.3


