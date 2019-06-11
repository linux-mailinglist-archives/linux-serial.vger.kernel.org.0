Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2337A3CAD8
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfFKMPR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 08:15:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42127 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfFKMPR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 08:15:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so7319080pff.9
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2019 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=277jozT1EhnETi89SmaTO49VB6Qbwp9X0r3PGVGxDhE=;
        b=Ww63+Xlbz4oK1Jz/cqksi2ICwOtBWEdsmgvx/5beLkK+ZscdTZpdNY/fzSYmG1IQNC
         ijDQoWRysxire9m9Qk+h2v9FlroD70SbecgOXOKOyU+eYo9qPQO3P3wc6UhrCCpjMor+
         9zZqGBVNEAHNFTWtPvNK5T4gGf+FOW4xxeSLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=277jozT1EhnETi89SmaTO49VB6Qbwp9X0r3PGVGxDhE=;
        b=i3Okir2yTlbqFomu48lwGsjM8jAp/RQvfHrJnK8zSQLSqPYdUeSawI3K/9Eny1ObYw
         RCKz/bOrsPP0zUOA/+a5VuiU+lKnl4FSrnRnbh37uDMq1PcbRwEsWecDuYLLmxT7O6Q5
         9YrqYQ70FSBCcP4UGWG9iJJnb9ycW1xqSylzCSpYQyKlO/XvvOUo0ZJLx/ALVkz55RZV
         OG+d3NZKgxEqDr4PdKEVwmuye+mm6uStDO3pbflz7P6IT8B5NGB17r1NmX2xWXskqDm6
         Gs1txPe1CqOGesN9F04v9K0fmr+/suRuLWw16VMJUYmX7Pvbv3kUE8NSMrNPwdC+5k1t
         BkzQ==
X-Gm-Message-State: APjAAAV2cd3hfIsHD0QfOkNoa0M4MWk6h9dIOrbrvfdELuvcsRinBzQY
        d9Q40+Ne/SHlazk60rbchqWKdw==
X-Google-Smtp-Source: APXvYqzfL5/fYY3pUluAdCK4To2DjW6uJoqnkuLN+CDF0FrDaPtwWj5bx6sBBXQh8lVRyRN6c4BC2w==
X-Received: by 2002:a17:90a:30aa:: with SMTP id h39mr6385861pjb.32.1560255316897;
        Tue, 11 Jun 2019 05:15:16 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id d4sm2416832pju.19.2019.06.11.05.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 05:15:16 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh+dt@kernel.org
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        drinkcat@chromium.org, changqi.hu@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] dt-bindings: serial: add documentation for Rx in-band wakeup support
Date:   Tue, 11 Jun 2019 20:15:10 +0800
Message-Id: <20190611121510.260188-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

To support Rx in-band wakeup, one must create an interrupt specifier with
edge sensitivity on Rx pin and an addtional pinctrl to reconfigure Rx pin
to normal GPIO in sleep state. Driver will switch to sleep mode pinctrl and
enable irq wake before suspend and restore to default settings when
resuming.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
Resending this patch since I forgot to cc device tree maintainers/mailing list.
The 2/2 patch in this series[1] is already in tty-next[2].

[1] https://patchwork.kernel.org/patch/10962299/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?h=tty-testing

 .../devicetree/bindings/serial/mtk-uart.txt         | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index bcfb13194f16..3488b6e24e0c 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -21,7 +21,12 @@ Required properties:
 
 - reg: The base address of the UART register bank.
 
-- interrupts: A single interrupt specifier.
+- interrupts or interrupts-extended:
+  index 0: an interrupt specifier for the UART controller itself
+  index 1: optional, an interrupt specifier with edge sensitivity on Rx pin to
+           support Rx in-band wake up. If one would like to use this feature,
+           one must create an addtional pinctrl to reconfigure Rx pin to normal
+           GPIO before suspend.
 
 - clocks : Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
@@ -37,7 +42,11 @@ Example:
 	uart0: serial@11006000 {
 		compatible = "mediatek,mt6589-uart", "mediatek,mt6577-uart";
 		reg = <0x11006000 0x400>;
-		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&sysirq GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>,
+				      <&gpio 121 IRQ_TYPE_EDGE_FALLING>;
 		clocks = <&uart_clk>, <&bus_clk>;
 		clock-names = "baud", "bus";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&uart_pin>;
+		pinctrl-1 = <&uart_pin_sleep>;
 	};
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

