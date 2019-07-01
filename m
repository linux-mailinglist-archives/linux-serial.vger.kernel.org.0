Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885A42B0E1
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 11:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfE0JFa (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 05:05:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51184 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726492AbfE0JF3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 05:05:29 -0400
X-UUID: 2815c3e606ae4dc1851170f0a21f3f80-20190527
X-UUID: 2815c3e606ae4dc1851170f0a21f3f80-20190527
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 185662721; Mon, 27 May 2019 17:05:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 27 May 2019 17:05:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 27 May 2019 17:05:05 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, <eddie.huang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: [PATCH v11 1/6] arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and Makefile
Date:   Mon, 27 May 2019 17:04:42 +0800
Message-ID: <1558947887-31084-2-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
References: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Ben Ho <Ben.Ho@mediatek.com>

Add basic chip support for Mediatek 8183, include
uart node with correct uart clocks, pwrap device

Add clock controller nodes, include topckgen, infracfg,
apmixedsys and subsystem.

Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  31 +++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 311 ++++++++++++++++++++++++++++
 3 files changed, 343 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index e8f952f..458bbc4 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -7,3 +7,4 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
new file mode 100644
index 0000000..9b52559
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Ben Ho <ben.ho@mediatek.com>
+ *	   Erin Lo <erin.lo@mediatek.com>
+ */
+
+/dts-v1/;
+#include "mt8183.dtsi"
+
+/ {
+	model = "MediaTek MT8183 evaluation board";
+	compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
new file mode 100644
index 0000000..08274bf
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Ben Ho <ben.ho@mediatek.com>
+ *	   Erin Lo <erin.lo@mediatek.com>
+ */
+
+#include <dt-bindings/clock/mt8183-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "mediatek,mt8183";
+	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x000>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x001>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x002>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x003>;
+			enable-method = "psci";
+		};
+
+		cpu4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x100>;
+			enable-method = "psci";
+		};
+
+		cpu5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x101>;
+			enable-method = "psci";
+		};
+
+		cpu6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x102>;
+			enable-method = "psci";
+		};
+
+		cpu7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x103>;
+			enable-method = "psci";
+		};
+	};
+
+	pmu-a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster0>;
+	};
+
+	pmu-a73 {
+		compatible = "arm,cortex-a73-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster1>;
+	};
+
+	psci {
+		compatible      = "arm,psci-1.0";
+		method          = "smc";
+	};
+
+	clk26m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <4>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0x0c000000 0 0x40000>,  /* GICD */
+			      <0 0x0c100000 0 0x200000>, /* GICR */
+			      <0 0x0c400000 0 0x2000>,   /* GICC */
+			      <0 0x0c410000 0 0x1000>,   /* GICH */
+			      <0 0x0c420000 0 0x2000>;   /* GICV */
+
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+			ppi-partitions {
+				ppi_cluster0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
+				};
+				ppi_cluster1: interrupt-partition-1 {
+					affinity = <&cpu4 &cpu5 &cpu6 &cpu7>;
+				};
+			};
+		};
+
+		mcucfg: syscon@c530000 {
+			compatible = "mediatek,mt8183-mcucfg", "syscon";
+			reg = <0 0x0c530000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		sysirq: interrupt-controller@c530a80 {
+			compatible = "mediatek,mt8183-sysirq",
+				     "mediatek,mt6577-sysirq";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			reg = <0 0x0c530a80 0 0x50>;
+		};
+
+		topckgen: syscon@10000000 {
+			compatible = "mediatek,mt8183-topckgen", "syscon";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg: syscon@10001000 {
+			compatible = "mediatek,mt8183-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		apmixedsys: syscon@1000c000 {
+			compatible = "mediatek,mt8183-apmixedsys", "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pwrap: pwrap@1000d000 {
+			compatible = "mediatek,mt8183-pwrap";
+			reg = <0 0x1000d000 0 0x1000>;
+			reg-names = "pwrap";
+			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_MUX_PMICSPI>,
+				 <&infracfg CLK_INFRA_PMIC_AP>;
+			clock-names = "spi", "wrap";
+		};
+
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt8183-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x1000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk26m>, <&infracfg CLK_INFRA_UART0>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		uart1: serial@11003000 {
+			compatible = "mediatek,mt8183-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x1000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk26m>, <&infracfg CLK_INFRA_UART1>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		uart2: serial@11004000 {
+			compatible = "mediatek,mt8183-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11004000 0 0x1000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk26m>, <&infracfg CLK_INFRA_UART2>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		audiosys: syscon@11220000 {
+			compatible = "mediatek,mt8183-audiosys", "syscon";
+			reg = <0 0x11220000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		mfgcfg: syscon@13000000 {
+			compatible = "mediatek,mt8183-mfgcfg", "syscon";
+			reg = <0 0x13000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		mmsys: syscon@14000000 {
+			compatible = "mediatek,mt8183-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys: syscon@15020000 {
+			compatible = "mediatek,mt8183-imgsys", "syscon";
+			reg = <0 0x15020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys: syscon@16000000 {
+			compatible = "mediatek,mt8183-vdecsys", "syscon";
+			reg = <0 0x16000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vencsys: syscon@17000000 {
+			compatible = "mediatek,mt8183-vencsys", "syscon";
+			reg = <0 0x17000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ipu_conn: syscon@19000000 {
+			compatible = "mediatek,mt8183-ipu_conn", "syscon";
+			reg = <0 0x19000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ipu_adl: syscon@19010000 {
+			compatible = "mediatek,mt8183-ipu_adl", "syscon";
+			reg = <0 0x19010000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ipu_core0: syscon@19180000 {
+			compatible = "mediatek,mt8183-ipu_core0", "syscon";
+			reg = <0 0x19180000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ipu_core1: syscon@19280000 {
+			compatible = "mediatek,mt8183-ipu_core1", "syscon";
+			reg = <0 0x19280000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys: syscon@1a000000 {
+			compatible = "mediatek,mt8183-camsys", "syscon";
+			reg = <0 0x1a000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+	};
+};
-- 
1.8.1.1.dirty

