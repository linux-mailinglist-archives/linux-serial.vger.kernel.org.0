Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDAA35C96
	for <lists+linux-serial@lfdr.de>; Wed,  5 Jun 2019 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfFEMWn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 5 Jun 2019 08:22:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42710 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfFEMWm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jun 2019 08:22:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id go2so9621646plb.9;
        Wed, 05 Jun 2019 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h7Wqs4RLm0aox802Dc4SmD3OrJyMD+UrUqdzdFWaGn0=;
        b=t71JZ9F5bbwF+dqf+ccMRhz2p1H7LlFOIJKP9FfBJWAQxeRe7BrxevdOIi7K17v2au
         wmZ9A/bJi1k5jIVKzvjt0/IxfYclJuKbFbaN7wM0AIgr0G8n1To/PfSOXP5iNgm5TTmG
         m6XYSIi/qYeyvK5Tb7lKi3hGP8acGO4vvG544FWdD9wb73Bza6GdLOC3aMm4WNK8QZMa
         PQezM2jWnaX4PtwMqobgNRd24ps2i7I+biTiHwFuuYeoRPcKPGbfhsdmUzHqB+F5BQa2
         kIbWrb6yrE0z0fLKZrABFQGT9NwVQ4mPnUw9BSXnroD8Y+GCnU5xBMnmco1lR4yy5/+c
         v8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h7Wqs4RLm0aox802Dc4SmD3OrJyMD+UrUqdzdFWaGn0=;
        b=auOCE6YRWKgEZUn/La5Gy8md2bHIe5O6a9O93QcmDAa/VXj4ntFGN7QuTSQiL4tG/4
         ztRIC9/t3JLV3KKJWpsru12TM5gmE1NXAjTkALaLJ8+s71R+TCcC/i6K6Xe3GnfivkpX
         m558SuuP2ZVE88OIYUbvUNhlmyHRZ3FSnXip9urQm5rVOSS0mjFf5ipZI2oswjD9QWjZ
         lULkp1U/aiBgczR8ua2FRKvGi1Exw1pHMRgG2U4Dxox45qiBC5a6klxYUBpoXMmQl3a5
         z2UdRyL4munHtDcOjThKljTC8ut1iilbeulq6h0hvkFPV/YdWiZWRWZoSvYU1gAGiBHN
         bciA==
X-Gm-Message-State: APjAAAWQZxsf5zK2PC459XlmQH5gCyywIeTNPFCZHSazIMI+tlc6iJq4
        UFun/2w4pFDF1L8U9ltHm1k=
X-Google-Smtp-Source: APXvYqznAoC5mH04itOtkT9+dnHps/OKKuip/dZHjMUEmZmPQI5T1LsM9TbBg5aR0ENoJ55ZmCiJdQ==
X-Received: by 2002:a17:902:290b:: with SMTP id g11mr42540866plb.26.1559737361692;
        Wed, 05 Jun 2019 05:22:41 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id q22sm3322094pff.63.2019.06.05.05.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 05:22:41 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com
Cc:     sudheer Kumar veliseti <sudheer.open@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch 3/5] DT nodes for AST2500 DMA UART driver
Date:   Wed,  5 Jun 2019 17:53:13 +0530
Message-Id: <1559737395-28542-4-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
References: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: sudheer Kumar veliseti <sudheer.open@gmail.com>

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 21 +++++++
 arch/arm/boot/dts/aspeed-g5.dtsi         | 71 ++++++++++++++++++++++--
 2 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 5dbb33c10c4f..4da09fbe94df 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -64,6 +64,27 @@
 	status = "okay";
 };
 
+&ast_uart_sdma {
+	status = "okay";
+};
+
+&dma_uart1 {
+	status = "okay";
+};
+
+&dma_uart2 {
+	status = "okay";
+};
+
+&dma_uart3 {
+	status = "okay";
+};
+
+&dma_uart4 {
+	status = "okay";
+};
+
+
 &mac0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 674746513031..fb7b3ed463de 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -23,10 +23,10 @@
 		i2c11 = &i2c11;
 		i2c12 = &i2c12;
 		i2c13 = &i2c13;
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
-		serial3 = &uart4;
+		serial0 = &dma_uart1;
+		serial1 = &dma_uart2;
+		serial2 = &dma_uart3;
+		serial3 = &dma_uart4;
 		serial4 = &uart5;
 		serial5 = &vuart;
 		peci0 = &peci0;
@@ -497,6 +497,69 @@
 				status = "disabled";
 			};
 
+			ast_uart_sdma: uart_sdma@1e79e000 {
+				compatible = "aspeed,ast-uart-sdma";
+				reg = <0x1e79e000 0x400>;
+				interrupts = <50>;
+				status = "disabled";
+			};
+
+			dma_uart1: dma_uart1@1e783000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e783000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <9>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+				dma-channel = <0>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd1_default
+							 &pinctrl_rxd1_default>;
+				status = "disabled";
+			};
+
+			dma_uart2: dma_uart2@1e78d000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78d000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <32>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
+				dma-channel = <1>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd2_default
+							 &pinctrl_rxd2_default>;
+				status = "disabled";
+			};
+
+			dma_uart3: dma_uart3@1e78e000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78e000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <33>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
+				dma-channel = <2>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd3_default
+							 &pinctrl_rxd3_default>;
+				status = "disabled";
+			};
+
+			dma_uart4: dma_uart4@1e78f000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78f000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <34>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
+				dma-channel = <3>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd4_default
+							 &pinctrl_rxd4_default>;
+				status = "disabled";
+			};
+
 			i2c: bus@1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
-- 
2.17.1

