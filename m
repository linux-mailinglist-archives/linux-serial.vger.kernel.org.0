Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96EA803D
	for <lists+linux-serial@lfdr.de>; Wed,  4 Sep 2019 12:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfIDKUJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 4 Sep 2019 06:20:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34113 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbfIDKUJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Sep 2019 06:20:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so11011384pgc.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2019 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J/+/1jhl4CuoY9Z/mhDhMnmKOIqzxcucbYzyGMDV3bY=;
        b=CORLaL/CvcphzgxSNJFn4X4v7kP4bDjHR6i/EX1ozp9IxvsGPO5SOgJVs12qRzD9zq
         9FP+oVjN/1UAwoWfnjwhcQCUem38ccuPN2q9PM+47l+u31chxAQ+QyytYx8QyUj12sVZ
         yVJSvxJdNti3TuNpf7Fn/Km5A4itymNTEnpIRzEjtvDSJOKJmgZw6bNxmbI5VVkhZyl5
         iYUqxGHivRS6JP6SO1VcgPMlvtwFaTUdt5bNyqvW7pOp3AKQyA5KdFC3BrJ/RL0wWlve
         MavDd6/n8d2fbjyajYj1s0NOlOf16VCs+HrORUVsiiwBV2BHKDD5AF0Gp0pVYImxXnC+
         s5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J/+/1jhl4CuoY9Z/mhDhMnmKOIqzxcucbYzyGMDV3bY=;
        b=dfunmJp3sDPX8GC4Z6LrOdn3nZFBz69D2XLs03P1j8ScIIGnef1gPcHyW2TU6ptMZV
         ccrE3mpPwl19wPDhO9wELbtaU6rdcYO74da9EDlEB6cA7nOgbibqEl6BuaeY1Hy05nOw
         vO1JLx5ViP55sGpnUNckIafzLiZKZqkXZeX0IisPyn1viIwyCXfnL2MPgJ2UWAK81l/o
         h+aIOrkwc46j8qs82eeFKr/gS7Zmdw4tSQC9aVL9BRQl38fc4apjuhdgZg1QPbHvDZ0a
         SFIZXnNQF1bfiu7Y1ALdhjX5ZzPaHbB5EY9J0i5RBLJlevqgPhQ4bjAiM85oO5OlT5yy
         wjzw==
X-Gm-Message-State: APjAAAWc/6gN988NVEwB2L30QOesNIUzIsOkTNXOGAOYFp4VufWeP9Jw
        6pOFRA2dQYAmaeof25ER8n+Ffw==
X-Google-Smtp-Source: APXvYqwfTQYhLAozNtIm8UdrAyXLSg8j912XKe8r8DrSl6YP/T2n5628nUBZNbwocefVP9R/TCS0Fg==
X-Received: by 2002:aa7:87d3:: with SMTP id i19mr31973373pfo.57.1567592408536;
        Wed, 04 Sep 2019 03:20:08 -0700 (PDT)
Received: from pragneshp.open-silicon.com ([114.143.65.226])
        by smtp.gmail.com with ESMTPSA id p20sm22806882pgi.81.2019.09.04.03.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Sep 2019 03:20:08 -0700 (PDT)
From:   Pragnesh Patel <pragnesh.patel@sifive.com>
To:     palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: Convert riscv,sifive-serial to json-schema
Date:   Wed,  4 Sep 2019 15:49:11 +0530
Message-Id: <1567592383-8920-1-git-send-email-pragnesh.patel@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the riscv,sifive-serial binding to DT schema using json-schema.

Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
---

Changes in v2:
- Replace enum with items in compatible property

 .../devicetree/bindings/serial/sifive-serial.txt   | 33 ------------
 .../devicetree/bindings/serial/sifive-serial.yaml  | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.yaml

diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
deleted file mode 100644
index c86b1e5..0000000
--- a/Documentation/devicetree/bindings/serial/sifive-serial.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-SiFive asynchronous serial interface (UART)
-
-Required properties:
-
-- compatible: should be something similar to
-	      "sifive,<chip>-uart" for the UART as integrated
-	      on a particular chip, and "sifive,uart<version>" for the
-	      general UART IP block programming model.	Supported
-	      compatible strings as of the date of this writing are:
-	      "sifive,fu540-c000-uart" for the SiFive UART v0 as
-	      integrated onto the SiFive FU540 chip, or "sifive,uart0"
-	      for the SiFive UART v0 IP block with no chip integration
-	      tweaks (if any)
-- reg: address and length of the register space
-- interrupts: Should contain the UART interrupt identifier
-- clocks: Should contain a clock identifier for the UART's parent clock
-
-
-UART HDL that corresponds to the IP block version numbers can be found
-here:
-
-https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
-
-
-Example:
-
-uart0: serial@10010000 {
-	compatible = "sifive,fu540-c000-uart", "sifive,uart0";
-	interrupt-parent = <&plic0>;
-	interrupts = <80>;
-	reg = <0x0 0x10010000 0x0 0x1000>;
-	clocks = <&prci PRCI_CLK_TLCLK>;
-};
diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
new file mode 100644
index 0000000..e8d3aed
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/sifive-serial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive asynchronous serial interface (UART)
+
+maintainers:
+  - Pragnesh Patel <pragnesh.patel@sifive.com>
+  - Paul Walmsley  <paul.walmsley@sifive.com>
+  - Palmer Dabbelt <palmer@sifive.com>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu540-c000-uart
+      - const: sifive,uart0
+
+    description:
+      Should be something similar to "sifive,<chip>-uart"
+      for the UART as integrated on a particular chip,
+      and "sifive,uart<version>" for the general UART IP
+      block programming model.
+
+      UART HDL that corresponds to the IP block version
+      numbers can be found here -
+
+      https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/clock/sifive-fu540-prci.h>
+      serial@10010000 {
+        compatible = "sifive,fu540-c000-uart", "sifive,uart0";
+        interrupt-parent = <&plic0>;
+        interrupts = <80>;
+        reg = <0x0 0x10010000 0x0 0x1000>;
+        clocks = <&prci PRCI_CLK_TLCLK>;
+      };
+
+...
-- 
2.7.4

