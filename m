Return-Path: <linux-serial+bounces-12641-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCwRFQMzhGkw0wMAu9opvQ
	(envelope-from <linux-serial+bounces-12641-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Thu, 05 Feb 2026 07:04:51 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C211BEEDF4
	for <lists+linux-serial@lfdr.de>; Thu, 05 Feb 2026 07:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 944003026895
	for <lists+linux-serial@lfdr.de>; Thu,  5 Feb 2026 06:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79648334C14;
	Thu,  5 Feb 2026 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGzP40zQ"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532403346AB;
	Thu,  5 Feb 2026 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770271446; cv=none; b=RsLc/IWRkVYhAitKmaM6p8eD4hu7lOzAKAh2l2TRONAU2FFxdztNe80Mq9Z8Ndg5kqo3y6oUE6KKcOGbkp813fFxm8IEXuLPlr+NuDaM16jCUR+1rQB9RKez67k1uB5QNJzv14XIJFnQKRVe3DnGImwjYO0TcFuXrNxFWWge3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770271446; c=relaxed/simple;
	bh=bALSOoddiL5w8oFGgff93Z4RVCpo79tvO8FM1Vpr8Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0Fdp+zij3KudSlfVWMckxPHndsJ5oukSw3yuVbT7XtV2f/OSHaXlEt/t+cwOIzDrD0EM48Kq7ltdRTYkOFuplZNBBGKL4nYaTE5Yksv04RyxUf8Obu0MeAiuW4FP2hqsgi8J18QAhUIEXLcjP7ICCNYS2gP1QN/dYjhnu/Y9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGzP40zQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18BD6C116D0;
	Thu,  5 Feb 2026 06:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770271446;
	bh=bALSOoddiL5w8oFGgff93Z4RVCpo79tvO8FM1Vpr8Io=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uGzP40zQe1nh/3wGqqOU1BLeUpMxIQcqbvTMtABt6+zxra/h4dg0vIjy4kDpVPglE
	 GfjkMDgrXNv0KjgJadaoJg0YHWzoNthlHnjFkeJj5HmM2EKGczSh06VUtQQilGZ5GV
	 WsMGRd8M17yJrdz6/4aiYCa9WZSBx8xs2FB/fyX8tE2qZEyJi5e2rZLA2KLSnvt2vD
	 NUNxJz9zuLV8SVpnvrLMnSuG33zi1F8bj+5a57OrlwxkXeoKfcqBRI/aadezomlVq1
	 CZFoNwLFP9e4Z6C70/wXREe3QyUaDcNYb3woTKLuhU9kIWRz1wIIV6zXrKe22DGHRx
	 AOQUaSLHmffVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF8DE91266;
	Thu,  5 Feb 2026 06:04:06 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 05 Feb 2026 06:04:04 +0000
Subject: [PATCH 3/3] arm64: dts: add support for A9 based Amlogic BY401
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-a9-baisc-dts-v1-3-1212b46f95a7@amlogic.com>
References: <20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com>
In-Reply-To: <20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770271444; l=5459;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=JhCz1Y1IOz9OdVW/Aed/kqLeeuwkxIYlT4hUhJxOrwE=;
 b=vZedrmy9syLNJKmc0Xin1CXTe/3bxIiCASzGl8eNYkKugQc3R1LsyEAd91Vv3tk2UY9Ju9HXF
 3opi9rMOVdzC0xZl8o45oKJG0iqGWRX5AMUFXsQPseT6ERkhiWDac5X
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12641-lists,linux-serial=lfdr.de,xianwei.zhao.amlogic.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,googlemail.com,baylibre.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_PROHIBIT(0.00)[0.0.2.88:email];
	TAGGED_RCPT(0.00)[linux-serial,dt];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:replyto,amlogic.com:email,amlogic.com:mid,ffa00000:email,0.0.2.188:email,0.0.1.144:email,0.0.0.200:email,0.0.0.0:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.100:email,0.0.1.44:email,1e000:email,0.0.1.244:email,0.76.75.64:email]
X-Rspamd-Queue-Id: C211BEEDF4
X-Rspamd-Action: no action

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add basic support for the A9 based Amlogic BY401 board, which describes
the following components: CPU, GIC, IRQ, Timer and UART.
These are capable of booting up into the serial console.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/amlogic-a9-a311y3-by401.dts   |  41 +++++++
 arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi        | 127 +++++++++++++++++++++
 3 files changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 15f9c817e502..57bc440fa55c 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-a5-a113x2-av400.dtb
+dtb-$(CONFIG_ARCH_MESON) += amlogic-a9-a311y3-by401.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c308l-aw419.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-s6-s905x5-bl209.dtb
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts b/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts
new file mode 100644
index 000000000000..ad35a3292d49
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2026 Amlogic, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "amlogic-a9.dtsi"
+/ {
+	model = "Amlogic A311DY3 BY401 Development Board";
+	compatible = "amlogic,by401", "amlogic,a9";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart_b;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 35 MiB reserved for ARM Trusted Firmware */
+		secmon_reserved: secmon@5000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x05000000 0x0 0x2300000>;
+			no-map;
+		};
+	};
+};
+
+&uart_b {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
new file mode 100644
index 000000000000..a3744547edde
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2026 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+		};
+
+		cpu4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x400>;
+			enable-method = "psci";
+		};
+
+		cpu5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x500>;
+			enable-method = "psci";
+		};
+
+		cpu6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x0 0x600>;
+			enable-method = "psci";
+		};
+
+		cpu7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x0 0x700>;
+			enable-method = "psci";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@ff800000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xff800000 0 0x1000>,
+			      <0x0 0xff840000 0 0x8000>;
+			interrupts = <GIC_PPI 9 0xf04>;
+		};
+
+		aobus: bus@ffa00000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xffa00000 0x0 0x100000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xffa00000 0x0 0x100000>;
+
+			uart_b: serial@1e000 {
+				compatible = "amlogic,a9-uart",
+					     "amlogic,meson-s4-uart";
+				reg = <0x0 0x1e000 0x0 0x18>;
+				interrupts = <GIC_SPI 66 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+		};
+	};
+};
+

-- 
2.52.0



