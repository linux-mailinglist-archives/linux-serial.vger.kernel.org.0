Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A334043991E
	for <lists+linux-serial@lfdr.de>; Mon, 25 Oct 2021 16:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhJYOuf (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 25 Oct 2021 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhJYOuZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Oct 2021 10:50:25 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377DCC061745;
        Mon, 25 Oct 2021 07:48:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B2D8F41E57;
        Mon, 25 Oct 2021 14:47:55 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v2 6/8] arm64: dts: apple: t8103: Add the UART PMGR tree
Date:   Mon, 25 Oct 2021 23:47:16 +0900
Message-Id: <20211025144718.157794-7-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025144718.157794-1-marcan@marcan.st>
References: <20211025144718.157794-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Note that the UART driver does not currently support runtime-pm, so this
effectively always keeps the UART0 device on. However, this does clockgate
all the other UARTs, as those are not currently instantiated.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 116 +++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 9f60f9e48ea0..1d0fac1747c7 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -122,6 +122,7 @@ serial0: serial@235200000 {
 			 */
 			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
 			status = "disabled";
 		};
 
@@ -131,5 +132,120 @@ aic: interrupt-controller@23b100000 {
 			interrupt-controller;
 			reg = <0x2 0x3b100000 0x0 0x8000>;
 		};
+
+		pmgr: power-management@23b700000 {
+			compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <0x2 0x3b700000 0x0 0x14000>;
+
+			ps_sio_busif: power-controller@1c0 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x1c0>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "sio_busif";
+			};
+
+			ps_sio: power-controller@1c8 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x1c8>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "sio";
+				power-domains = <&ps_sio_busif>;
+			};
+
+			ps_uart_p: power-controller@220 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x220>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "uart_p";
+				power-domains = <&ps_sio>;
+			};
+
+			ps_uart0: power-controller@270 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x270>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "uart0";
+				power-domains = <&ps_uart_p>;
+			};
+
+			ps_uart1: power-controller@278 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x278>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "uart1";
+				power-domains = <&ps_uart_p>;
+			};
+
+			ps_uart2: power-controller@280 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x280>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "uart2";
+				power-domains = <&ps_uart_p>;
+			};
+
+			ps_uart3: power-controller@288 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x288>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "uart3";
+				power-domains = <&ps_uart_p>;
+			};
+
+			ps_uart4: power-controller@290 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x290>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "uart4";
+				power-domains = <&ps_uart_p>;
+			};
+
+			ps_uart5: power-controller@298 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x298>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "uart5";
+				power-domains = <&ps_uart_p>;
+			};
+
+			ps_uart6: power-controller@2a0 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x2a0>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "uart6";
+				power-domains = <&ps_uart_p>;
+			};
+
+			ps_uart7: power-controller@2a8 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x2a8>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "uart7";
+				power-domains = <&ps_uart_p>;
+			};
+
+			ps_uart8: power-controller@2b0 {
+				compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+				reg = <0x2b0>;
+				#power-domain-cells = <0>;
+				#reset-cells = <0>;
+				label = "uart8";
+				power-domains = <&ps_uart_p>;
+			};
+		};
 	};
 };
-- 
2.33.0

