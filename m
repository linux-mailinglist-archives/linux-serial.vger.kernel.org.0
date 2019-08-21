Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908B897302
	for <lists+linux-serial@lfdr.de>; Wed, 21 Aug 2019 09:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfHUHHI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 21 Aug 2019 03:07:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:20492 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfHUHHI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Aug 2019 03:07:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 00:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,411,1559545200"; 
   d="scan'208";a="195939741"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 00:07:04 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 2/2] dt-bindings: lantiq: Update for new SoC
Date:   Wed, 21 Aug 2019 15:06:52 +0800
Message-Id: <ffb6855d4c8d47412775b5fa4ce6ae4dd1161cb8.1566370151.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
References: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
References: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Intel Lightning Mountain(LGM) reuses Lantiq ASC serial controller IP.
Update the dt bindings to support LGM as well.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/serial/lantiq,asc.yaml     | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/lantiq,asc.yaml b/Documentation/devicetree/bindings/serial/lantiq,asc.yaml
index 72ea2a3d75c9..14241ef37e8a 100644
--- a/Documentation/devicetree/bindings/serial/lantiq,asc.yaml
+++ b/Documentation/devicetree/bindings/serial/lantiq,asc.yaml
@@ -15,12 +15,14 @@ allOf:
 properties:
   compatible:
     enum:
+      - intel,lgm-asc
       - lantiq,asc
 
   reg:
     maxItems: 1
 
   interrupts:
+    minItems: 1
     maxItems: 3
 
   clocks:
@@ -38,6 +40,29 @@ required:
   - reg
   - interrupts
 
+if:
+  properties:
+    compatible:
+      enum:
+        - intel,lgm-asc
+
+then:
+  properties:
+    interrupts:
+      minItems: 1
+      maxItems: 1
+      items:
+        - description: combined interrupt for tx, rx & err
+
+else:
+  properties:
+    interrupts:
+      minItems: 3
+      maxItems: 3
+      items:
+        - description: tx interrupt
+        - description: rx interrupt
+        - description: err interrupt
 
 examples:
   - |
@@ -52,4 +77,14 @@ examples:
             clock-names = "freq", "asc";
     };
 
+  - |
+    asc0: serial@e0a00000 {
+            compatible = "intel,lgm-asc";
+            reg = <0xe0a00000 0x1000>;
+            interrupt-parent = <&ioapic1>;
+            interrupts = <128 1>;
+            clocks = <&cgu0 LGM_CLK_NOC4>, <&cgu0 LGM_GCLK_ASC0>;
+            clock-names = "freq", "asc";
+    };
+
 ...
-- 
2.11.0

