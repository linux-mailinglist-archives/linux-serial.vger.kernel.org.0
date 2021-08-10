Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784A13E481A
	for <lists+linux-serial@lfdr.de>; Mon,  9 Aug 2021 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhHIOzY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 9 Aug 2021 10:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235220AbhHIOzQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Aug 2021 10:55:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA4D261077;
        Mon,  9 Aug 2021 14:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628520896;
        bh=wLgsCp5CDUhRCXB4S/ViBhPh4kOWYhkFzV2F5QKfBPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAlLXGNt18Ga8tTosXLBXfS6LziOk5bmtooax2CFFfpVe0/S762P7pYCKq5aDDU2f
         G8tZcaFK9DUAiw/hipmydekcjk3aQtFF7rFn+ICWm1klorlzYoeLGxUzsW09BSdzJN
         bI9L/xUd8FwgpmdWZt3zLceEvKZg6JWR5RRz12oHuY2+lhSyC1UWUb2xDEx6cwyzxz
         7eZYN/LRbsHWGY/wzyvDdv/eY3NeqGunak9mtVgvuouXw456Qap1RerixHHYEUEiOO
         TjqyO4gb5Sbj3G3eYqKBcNMmDsZCucZ/nn26z17fPXiXtHuwfLjBtG0Y64145P2Djn
         w7SkaNa9Z4H2Q==
Received: by pali.im (Postfix)
        id 63D702ACE; Mon,  9 Aug 2021 16:54:55 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 5/6] arm64: dts: marvell: armada-37xx: add device node for UART clock and use it
Date:   Mon,  9 Aug 2021 16:53:28 +0200
Message-Id: <20210809145329.24177-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210809145329.24177-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210809145329.24177-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This change defines DT node for UART clock "marvell,armada-3700-uart-clock"
and use this UART clock as a base clock for all UART devices.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts    |  4 ++++
 .../boot/dts/marvell/armada-3720-espressobin.dtsi |  4 ++++
 .../boot/dts/marvell/armada-3720-turris-mox.dts   |  4 ++++
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts  |  4 ++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi      | 15 +++++++++++++--
 5 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 3e5789f37206..accf014a6a1e 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -191,6 +191,10 @@
 	};
 };
 
+&uartclk {
+	status = "okay";
+};
+
 /*
  * Exported on the micro USB connector CON30(V2.0)/CON32(V1.4) through
  * an FTDI (also on CON24(V2.0)/CON26(V1.4)).
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 5fc613d24151..d03c7cdfbfb3 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -117,6 +117,10 @@
 	};
 };
 
+&uartclk {
+	status = "okay";
+};
+
 /* Exported on the micro USB connector J5 through an FTDI */
 &uart0 {
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index cacf2a05fb22..972c6d400f8b 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -167,6 +167,10 @@
 	status = "disabled";
 };
 
+&uartclk {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 95d46e8d081c..c8217440b8dd 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -183,6 +183,10 @@
 	phy-names = "usb2-utmi-otg-phy";
 };
 
+&uartclk {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 20dd9d9e9d58..d9bdd374cf45 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -132,10 +132,21 @@
 				reg = <0x11500 0x40>;
 			};
 
+			uartclk: uartclk@12000 {
+				compatible = "marvell,armada-3700-uart-clock";
+				reg = <0x12010 0x4>, <0x12210 0x4>;
+				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
+					<&tbg 3>, <&xtalclk>;
+				clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S",
+					"TBG-B-S", "xtal";
+				#clock-cells = <1>;
+				status = "disabled";
+			};
+
 			uart0: serial@12000 {
 				compatible = "marvell,armada-3700-uart";
 				reg = <0x12000 0x18>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 0>;
 				interrupts =
 				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
@@ -147,7 +158,7 @@
 			uart1: serial@12200 {
 				compatible = "marvell,armada-3700-uart-ext";
 				reg = <0x12200 0x30>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 1>;
 				interrupts =
 				<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
 				<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
-- 
2.20.1

