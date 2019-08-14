Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBCEB8CE47
	for <lists+linux-serial@lfdr.de>; Wed, 14 Aug 2019 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfHNIWv (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 14 Aug 2019 04:22:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:61816 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbfHNIWu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Aug 2019 04:22:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 01:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,384,1559545200"; 
   d="scan'208";a="194453103"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2019 01:22:47 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 2/2] dt-bindings: lantiq: Update for new SoC
Date:   Wed, 14 Aug 2019 16:22:35 +0800
Message-Id: <f901ea1aaf6272b1e538772c3c6bb17adad5d003.1565770074.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
References: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
References: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Intel Lightning Mountain(LGM) SoC reuses Lantiq ASC serial controller IP.
This patch updates the dt bindings to support LGM as well.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/serial/lantiq_asc.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
index 9757f0a24232..d552fd31c16c 100644
--- a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
+++ b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
@@ -17,6 +17,7 @@ properties:
     oneOf:
       items:
         - const: lantiq,asc
+        - const: intel,lgm-asc
 
   reg:
     maxItems: 1
@@ -28,6 +29,12 @@ properties:
       - description: tx or combined interrupt
       - description: rx interrupt
       - description: err interrupt
+    description:
+      For lantiq,asc compatible, it supports 3 separate
+      interrupts for tx rx & err. Whereas, for intel,lgm-asc
+      compatible, it supports combined single interrupt for 
+      all of tx, rx & err interrupts.
+
 
   clocks:
     description:
@@ -67,4 +74,14 @@ examples:
             interrupts = <112 113 114>;
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

