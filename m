Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CCE247D05
	for <lists+linux-serial@lfdr.de>; Tue, 18 Aug 2020 05:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHRDkV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 17 Aug 2020 23:40:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44892 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgHRDkR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 23:40:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4AC772016E6;
        Tue, 18 Aug 2020 05:40:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 437C82016E5;
        Tue, 18 Aug 2020 05:40:08 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6E8E4402E1;
        Tue, 18 Aug 2020 05:39:59 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, gregkh@linuxfoundation.org,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 5/5] dt-bindings: serial: Convert NXP lpuart to json-schema
Date:   Tue, 18 Aug 2020 11:34:45 +0800
Message-Id: <1597721685-9280-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597721685-9280-1-git-send-email-Anson.Huang@nxp.com>
References: <1597721685-9280-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the NXP lpuart binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V2:
	- update maintainer, the original owner's email address is no longer valid,
	  use one of the patch contributors as well as NXP's UART owner as maintainer.
---
 .../devicetree/bindings/serial/fsl-lpuart.txt      | 43 ------------
 .../devicetree/bindings/serial/fsl-lpuart.yaml     | 79 ++++++++++++++++++++++
 2 files changed, 79 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/fsl-lpuart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
deleted file mode 100644
index e7448b9..0000000
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* Freescale low power universal asynchronous receiver/transmitter (lpuart)
-
-Required properties:
-- compatible :
-  - "fsl,vf610-lpuart" for lpuart compatible with the one integrated
-    on Vybrid vf610 SoC with 8-bit register organization
-  - "fsl,ls1021a-lpuart" for lpuart compatible with the one integrated
-    on LS1021A SoC with 32-bit big-endian register organization
-  - "fsl,ls1028a-lpuart" for lpuart compatible with the one integrated
-    on LS1028A SoC with 32-bit little-endian register organization
-  - "fsl,imx7ulp-lpuart" for lpuart compatible with the one integrated
-    on i.MX7ULP SoC with 32-bit little-endian register organization
-  - "fsl,imx8qxp-lpuart" for lpuart compatible with the one integrated
-    on i.MX8QXP SoC with 32-bit little-endian register organization
-  - "fsl,imx8qm-lpuart" for lpuart compatible with the one integrated
-    on i.MX8QM SoC with 32-bit little-endian register organization
-- reg : Address and length of the register set for the device
-- interrupts : Should contain uart interrupt
-- clocks : phandle + clock specifier pairs, one for each entry in clock-names
-- clock-names : For vf610/ls1021a/ls1028a/imx7ulp, "ipg" clock is for uart
-  bus/baud clock. For imx8qxp lpuart, "ipg" clock is bus clock that is used
-  to access lpuart controller registers, it also requires "baud" clock for
-  module to receive/transmit data.
-
-Optional properties:
-- dmas: A list of two dma specifiers, one for each entry in dma-names.
-- dma-names: should contain "tx" and "rx".
-- rs485-rts-active-low, linux,rs485-enabled-at-boot-time: see rs485.txt
-
-Note: Optional properties for DMA support. Write them both or both not.
-
-Example:
-
-uart0: serial@40027000 {
-		compatible = "fsl,vf610-lpuart";
-		reg = <0x40027000 0x1000>;
-		interrupts = <0 61 0x00>;
-		clocks = <&clks VF610_CLK_UART0>;
-		clock-names = "ipg";
-		dmas = <&edma0 0 2>,
-			<&edma0 0 3>;
-		dma-names = "rx","tx";
-	};
diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
new file mode 100644
index 0000000..e82c2cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/fsl-lpuart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale low power universal asynchronous receiver/transmitter (lpuart)
+
+maintainers:
+  - Fugang Duan <fugang.duan@nxp.com>
+
+allOf:
+  - $ref: "rs485.yaml"
+
+properties:
+  compatible:
+    enum:
+      - fsl,vf610-lpuart
+      - fsl,ls1021a-lpuart
+      - fsl,ls1028a-lpuart
+      - fsl,imx7ulp-lpuart
+      - fsl,imx8qxp-lpuart
+      - fsl,imx8qm-lpuart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: ipg clock
+      - description: baud clock
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: baud
+    minItems: 1
+    maxItems: 2
+
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for RX
+      - description: DMA controller phandle and request line for TX
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  rs485-rts-active-low: true
+  linux,rs485-enabled-at-boot-time: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/vf610-clock.h>
+
+    serial@40027000 {
+        compatible = "fsl,vf610-lpuart";
+        reg = <0x40027000 0x1000>;
+        interrupts = <0 61 0x00>;
+        clocks = <&clks VF610_CLK_UART0>;
+        clock-names = "ipg";
+        dmas = <&edma0 0 2>, <&edma0 0 3>;
+        dma-names = "rx","tx";
+    };
-- 
2.7.4

