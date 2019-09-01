Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6CFA4809
	for <lists+linux-serial@lfdr.de>; Sun,  1 Sep 2019 09:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfIAHMC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 1 Sep 2019 03:12:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41793 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfIAHMC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 1 Sep 2019 03:12:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so5181723pls.8
        for <linux-serial@vger.kernel.org>; Sun, 01 Sep 2019 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vKTwNtpfVl/ofq1lszN6uNSXidoJKzu+EuY1m89tIBg=;
        b=nkBdHU1bLcqhB0Pu13xor/HRU8pRbyHtm401VWyDRE09OfgA47ny3+8CsXdIm62QgZ
         6sHuK8HnBmweVy81dP9vA2W6dmBiqC1Wb2mwfWlx3HwjwizUmBrxbTuqmLrYh5IQwUOg
         IeW4PL+tq0zAmAdoH6vgWAyB2sWk8xxbWIW1BwIQWmrP6XANhXQsPToLBlSxOdm11P/L
         TzcS/bG13nyF32qDIcsfaZk/QGb96vFzNz5+5Sno225zTqGNgLp80wKsvaWlFFr1wYY+
         xpoqw0Ig04OhxhMkl+ckQhegRFM6pm1FtEXAlVhDyqCnen3hY4gdIqwBMcg3kQMN082o
         tX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vKTwNtpfVl/ofq1lszN6uNSXidoJKzu+EuY1m89tIBg=;
        b=Fe7BA+EZLLSDhMvSbETDdUmbnfRtwTp8REMUv9wgpFG+cK3Ug5FnnGvrlr04PQiGB7
         ziiExVms9/P8919L93f1xbNcW0tA1rTlceJ1uTQyLA3vBlPlcB/ljhev6UYNXocTVNyo
         BDY3FNN3xLq+xObnBAbztVLm7S3xuPTdWdE7xY0u8uFX4fGAoIBWhK+ukl5r9UrncB8C
         SYo+ngnqwlAcho4DwYv01muUgqr3LnuEPUxojPZrCgevEiAsAQEC3p3XK9/4ABdQtTkE
         N6SnEsZ5bL3Hs7fI6NZArm/9RtxnRajDmJiZyM5EMiELahojEYbE/g/1iF6Lp5Y7DudQ
         QOiA==
X-Gm-Message-State: APjAAAUntdPZxBvkXlVMxS4v298xDUWAWno/rAJwEA2E7J31XKWxbU6B
        WNSgI0Ipb2WolczHCcZh4TGmEA==
X-Google-Smtp-Source: APXvYqwQny1Nmrz/C5sgtbnJWlSSGimvrNW83Dy1il6BLDq9WjeTfmJnQVGgEdpz2lT6oF5Pw/kQ/g==
X-Received: by 2002:a17:902:f216:: with SMTP id gn22mr25329995plb.59.1567321921847;
        Sun, 01 Sep 2019 00:12:01 -0700 (PDT)
Received: from localhost.localdomain ([103.81.243.14])
        by smtp.gmail.com with ESMTPSA id b185sm6968998pfg.14.2019.09.01.00.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Sep 2019 00:12:01 -0700 (PDT)
From:   Pragnesh Patel <pragnesh.patel@sifive.com>
To:     palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Convert riscv,sifive-serial to json-schema
Date:   Sun,  1 Sep 2019 12:39:21 +0530
Message-Id: <1567321765-3738-1-git-send-email-pragnesh.patel@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the riscv,sifive-serial binding to DT schema using json-schema.

Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
---
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
index 0000000..56fa935
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
+    enum:
+      - sifive,fu540-c000-uart
+      - sifive,uart0
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

