Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBAB12B03F
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 10:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfE0Ib6 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 04:31:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35559 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0Ib6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 04:31:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so6978243pfd.2
        for <linux-serial@vger.kernel.org>; Mon, 27 May 2019 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xerSC/mm9BOvVEW3oLYxPMIZLIQ4Oo4zyl2Y1qCU630=;
        b=Y8OG6hdNdi7fdyC2QwzE61zi/A6KQ3VCpEvTPDVkVXdAFdkhGh0RfyS3GXOgGTthRb
         SyfvzUbxX8YLlBaRIffij+zygrTZp2OsnWLQ9FkL0nhrlHHwwq/p5IkZ2YkWaeGZX7QY
         806ltaU7Ll5kNePVmwv13r493ash+PtEEWZ3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xerSC/mm9BOvVEW3oLYxPMIZLIQ4Oo4zyl2Y1qCU630=;
        b=GRkvkSTJqyenPs9bN3BIOVJj2HZKalWt9IcPZS3LlkK9h2SHEOBQGlmfGdnpH5WEsD
         PC68fURrkuyVFw1JfY+xpOBczNWyD6jiRTnXgTzeiZ8Y04Gq3JJWpcztQtG+VN+Dbqg3
         mDYVpMvUTDKYFXDB9EJSbvFP+zLfnzyfvUnIqbptzWE3T7OsY5QXDncF5zpSJcJFAHVv
         jHT3fUdYhMC9AY7yf2ZApjCAZDiyaV8xezM490XuGqR8SwY+88EfUN/1sZkcQqWxOHLs
         AeUk6MUgAhTL7Ie1FL5qW1VVz3p1sTBcHHCxjcpZbXHd6k6vcKnnwoyHPPqCNwwe7gfO
         +X4w==
X-Gm-Message-State: APjAAAXGAsCBf92BQGmz1N8krLGzn0ZWG5h9840Wk/Nw+ZucpUS99lZC
        xYu/oQ87DLQ+/Th/EdI6lbT13A==
X-Google-Smtp-Source: APXvYqwYpzLW2L4VKvjsw9Jx7gK6zcQzUn5PljZhwpAnXnEXGvRtf/gAft+ozerLkl2vTvlbc4e1Xw==
X-Received: by 2002:a63:ed09:: with SMTP id d9mr8070992pgi.419.1558945917619;
        Mon, 27 May 2019 01:31:57 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id b21sm13954636pfb.46.2019.05.27.01.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 01:31:57 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v3 1/2] dt-bindings: serial: add documentation for Rx in-band wakeup support
Date:   Mon, 27 May 2019 16:31:49 +0800
Message-Id: <20190527083150.220194-2-tientzu@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190527083150.220194-1-tientzu@chromium.org>
References: <20190527083150.220194-1-tientzu@chromium.org>
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
2.22.0.rc1.257.g3120a18244-goog

