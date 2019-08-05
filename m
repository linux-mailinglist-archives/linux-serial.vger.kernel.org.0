Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A148E818C1
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2019 14:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfHEMDe (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 5 Aug 2019 08:03:34 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38943 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbfHEMDe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Aug 2019 08:03:34 -0400
Received: by mail-wm1-f41.google.com with SMTP id u25so62379832wmc.4
        for <linux-serial@vger.kernel.org>; Mon, 05 Aug 2019 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03cjrsP0RDgNB463NC5l+ar2rIPSWRGFuDWfbzKJer4=;
        b=bvHJb3/6rwm4ri0PWxAXqnx3tGsomLKgntrlR6roxjbfUP6TEBJURIDqmlmcSRxvPl
         fimBqtk8WQSAlH9LrMqsF9EmNosdDF36A800TTFj/lVL6VodbYKGqPaHntux/YWADAa7
         Ei33K9eY8iK/Thb3RpTv/AU3l8LkQRen5fAEJUshRIcPclZw4Cu7Q9+N3YBZTibaRDhK
         ljuJoHKVDwCteZkH+J8kAfOHTENu+wOVpDYIslaHSJ21GRdB82HSYhNqgaDvZ9SPtSdK
         gHjYtUsui5gFXpHlmnn3t1844q+M2rAKUkkMsRdl2cA3TLV7sGLHF6Yk+IcM+zwiWjw5
         DBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03cjrsP0RDgNB463NC5l+ar2rIPSWRGFuDWfbzKJer4=;
        b=X4mjnQI0tskXTBjhFk8T1gjwWkgV8X2QpH48PI8KHzAWE5c0DhRtxm0gbIvtz7uSM2
         pkmRcmSVqN9DD2jZ2rAAHcU2fdvtggz+aEP4hmd1+jSnY+MuMqfi4FfEY2bJb60Ft60c
         2yRl0kFa8IZeBgcN7NQDacFkWm8uS7mjk/7B9hIbxT/fkbpoyuKyU+v94Wjjwfv6TM92
         y0EKUR7RdxMwCqLb2OSwai2hxDXV9GOapQnZoqQgFaDQIJnjg/nCmW7mqAW//5Hjxn0p
         QYsDA6VEbCcimno61lSYaulN5nxtgAHeiGCynRLru8LhvTS6J7g0mu0JqFq0fP1sDRj1
         zlDw==
X-Gm-Message-State: APjAAAUzSEgFszVbmZqW/xM6pLlwEbeutMoYDFE6C9M1+QRs7jip5gXj
        gtL1mpVhThorMvee8/0/vmJBgA==
X-Google-Smtp-Source: APXvYqywE8Dp7JVC/Lpdsu06qvWsy2pnvNdftrd1iabEJoCm13l1U9u7UmUh513R4CWlvucD+q1S+A==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr19568536wmj.44.1565006611348;
        Mon, 05 Aug 2019 05:03:31 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x6sm88683668wrt.63.2019.08.05.05.03.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:03:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [RFCv2 8/9] dt-bindings: serial: meson-uart: convert to yaml
Date:   Mon,  5 Aug 2019 14:03:19 +0200
Message-Id: <20190805120320.32282-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805120320.32282-1-narmstrong@baylibre.com>
References: <20190805120320.32282-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now that we have the DT validation in place, let's convert the device tree
bindings for the Amlogic UART Serial controller over to a YAML schemas.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/serial/amlogic,meson-uart.txt    | 38 ----------
 .../bindings/serial/amlogic,meson-uart.yaml   | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
deleted file mode 100644
index c06c045126fc..000000000000
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Amlogic Meson SoC UART Serial Interface
-=======================================
-
-The Amlogic Meson SoC UART Serial Interface is present on a large range
-of SoCs, and can be present either in the "Always-On" power domain or the
-"Everything-Else" power domain.
-
-The particularity of the "Always-On" Serial Interface is that the hardware
-is active since power-on and does not need any clock gating and is usable
-as very early serial console.
-
-Required properties:
-- compatible : compatible: value should be different for each SoC family as :
-	- Meson6 : "amlogic,meson6-uart"
-	- Meson8 : "amlogic,meson8-uart"
-	- Meson8b : "amlogic,meson8b-uart"
-	- GX (GXBB, GXL, GXM) : "amlogic,meson-gx-uart"
-	eventually followed by : "amlogic,meson-ao-uart" if this UART interface
-	is in the "Always-On" power domain.
-- reg : offset and length of the register set for the device.
-- interrupts : identifier to the device interrupt
-- clocks : a list of phandle + clock-specifier pairs, one for each
-	   entry in clock names.
-- clock-names :
-   * "xtal" for external xtal clock identifier
-   * "pclk" for the bus core clock, either the clk81 clock or the gate clock
-   * "baud" for the source of the baudrate generator, can be either the xtal
-	or the pclk.
-
-e.g.
-uart_A: serial@84c0 {
-	compatible = "amlogic,meson-gx-uart";
-	reg = <0x0 0x84c0 0x0 0x14>;
-	interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
-	/* Use xtal as baud rate clock source */
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
-	clock-names = "xtal", "pclk", "baud";
-};
diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
new file mode 100644
index 000000000000..5d48a8c04aa9
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/amlogic,meson-uart.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson SoC UART Serial Interface
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+description: |
+  The Amlogic Meson SoC UART Serial Interface is present on a large range
+  of SoCs, and can be present either in the "Always-On" power domain or the
+  "Everything-Else" power domain.
+
+  The particularity of the "Always-On" Serial Interface is that the hardware
+  is active since power-on and does not need any clock gating and is usable
+  as very early serial console.
+
+properties:
+  compatible:
+    oneOf:
+      - description: Allways-on power domain UART controller
+        items:
+        - enum:
+          - amlogic,meson6-uart
+          - amlogic,meson8-uart
+          - amlogic,meson8b-uart
+          - amlogic,meson-gx-uart
+        - const: amlogic,meson-ao-uart
+      - description: Everything-Else power domain UART controller
+        enum:
+        - amlogic,meson6-uart
+        - amlogic,meson8-uart
+        - amlogic,meson8b-uart
+        - amlogic,meson-gx-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: external xtal clock identifier
+      - description: the bus core clock, either the clk81 clock or the gate clock
+      - description: the source of the baudrate generator, can be either the xtal or the pclk
+
+  clock-names:
+    items:
+      - const: xtal
+      - const: pclk
+      - const: baud
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    serial@84c0 {
+          compatible = "amlogic,meson-gx-uart";
+          reg = <0x84c0 0x14>;
+          interrupts = <26>;
+          clocks = <&xtal>, <&pclk>, <&xtal>;
+          clock-names = "xtal", "pclk", "baud";
+    };
-- 
2.22.0

