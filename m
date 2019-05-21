Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5185024AAB
	for <lists+linux-serial@lfdr.de>; Tue, 21 May 2019 10:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfEUIrL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 May 2019 04:47:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42351 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUIrL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 May 2019 04:47:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so8099336pln.9
        for <linux-serial@vger.kernel.org>; Tue, 21 May 2019 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbIYnI/VuFFwbv+frc2rDwm8FqsGAeYyQ+Gv4X0pQVU=;
        b=jlU8vfwtVbFsFAM5HrN4A5L8ttaVJnpkZPW1FwGn5/oJ46YAf7UzRd7ClUbD5vXRBF
         F9XUgnEXMtYgr0yhrCW5gIoaQPWHe72/BdSpCbj6R83h9DcTzg8Lxr1m6sm7CFaYDAlt
         Q5XGE6xeZCCVfSjHBqWvkjm5urquxV/IJomMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbIYnI/VuFFwbv+frc2rDwm8FqsGAeYyQ+Gv4X0pQVU=;
        b=iOpAHUgnNjc1Wb+IKO7TSEoSWH14yOyKEboR6aS3BRypz1Y7jzotW+FB41uU75V1S8
         oYHvG38ylOW8usER56ZMnhU/iX5tP/+6/hEEjzZ4cDgxuJUiuQTt3yW6EkgbruY/Wt7d
         cO4ta+tiuv+8Z4VbuzrHzD41F8QYR2imyjs9f5xiEdP/b8+DiAs2eNVe+HIFAcjavt7j
         vBRRIHPTR5ZcLocEYiaf6O/9GM8AzTdoUJWQa5FYjfN0W3uLKTPlH7uduA7xi7kznMjl
         N72UKQYKvMVpZh4dCoRulD6Ri4Y/aIP+fsIYiPZ/PCiMF/7ByGwJvcFitRD+sCuvG21t
         f8JA==
X-Gm-Message-State: APjAAAU9wjRaXMDL1QnkXihs3So5aE18pdoqQKf1XIouvFp4pvwwYJVk
        EpbDfkNkdF1IB4t+LApur9QYUQ==
X-Google-Smtp-Source: APXvYqwOpDMi3QE0eZKeh6+ut9rvIQ0mpck24ub50PPYm9NBbXzYBOqc/YYsdqI00D3J4MVkUKYjVA==
X-Received: by 2002:a17:902:18a:: with SMTP id b10mr55469413plb.277.1558428431205;
        Tue, 21 May 2019 01:47:11 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id s24sm24304839pfe.57.2019.05.21.01.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:47:10 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH 1/2] dt-bindings: serial: add documentation for Rx in-band wakeup support
Date:   Tue, 21 May 2019 16:47:00 +0800
Message-Id: <20190521084701.100179-2-tientzu@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190521084701.100179-1-tientzu@chromium.org>
References: <20190521084701.100179-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 .../devicetree/bindings/serial/mtk-uart.txt         | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index c6b5262eb352..11966de2a4b3 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -23,7 +23,12 @@ Required properties:
 
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
@@ -39,7 +44,11 @@ Example:
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
2.21.0.1020.gf2820cf01a-goog

