Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8042AEFD
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 08:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfE0G4J (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 02:56:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42909 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfE0G4J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 02:56:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id 33so5591589pgv.9
        for <linux-serial@vger.kernel.org>; Sun, 26 May 2019 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xerSC/mm9BOvVEW3oLYxPMIZLIQ4Oo4zyl2Y1qCU630=;
        b=EDgH5Tg9MUT8wYSX/I/78TQjfnAIT45trMeoMBxgaFYHM1TO+jBWiChGX7XajfMBnB
         MkS7f2c3xhe8TniPVbPck/A5K0qG5QG5WbIU5T6t9OvsEz1XVH6WOXUEodhBCNm0iBpL
         hKxByL47EP/kaoaHQcPGIzAwij9MXXBk47SHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xerSC/mm9BOvVEW3oLYxPMIZLIQ4Oo4zyl2Y1qCU630=;
        b=ehBb0qW4z50gvgPhPTml8FuRAkcU3x+CWVSXL6z7IvRVwY+lO/II0KTtzKL2mUkmIw
         EXJkI20cYp8VFNIryKhyUUMFYTH4KXuEYv93HIv2ZnmACrkA7jn9DITSim62RnzxBI23
         wbspMSwV294/8Bwz5Zi2ntUA7PWTEiYRj1pDsoQVrozJC4YH4txXvS9gXkpWa9/j7jZU
         RwV4nkUINn+sS+TYP70kyvovWZlYmeHs8esj1BYvomSg9LF4nXh/C1EIJHwfX0k9j63n
         vGUyoIeDoMRbtMXMjx5Fm/nZFPFXPoBwzpviN6XY0eBni1AZBZZrz/tSyU166eUo4i/k
         cmGA==
X-Gm-Message-State: APjAAAWNr/weDFcODcwIK4ObnuuHki9M8JZcomAV8VTcKrjIhloWcc3O
        a2PdlPTfia+oNLMwv4g3namXNQ==
X-Google-Smtp-Source: APXvYqw4h01MnpXR8PN73d+xU/KEzLyn1lrestfUFNb41t3906mgw1QVTlC9zUCTvfgyK87gcqhScw==
X-Received: by 2002:a63:6ac3:: with SMTP id f186mr124627918pgc.326.1558940168746;
        Sun, 26 May 2019 23:56:08 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id j26sm13529000pgl.31.2019.05.26.23.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 23:56:08 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v2 1/2] dt-bindings: serial: add documentation for Rx in-band wakeup support
Date:   Mon, 27 May 2019 14:55:58 +0800
Message-Id: <20190527065559.66056-2-tientzu@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190527065559.66056-1-tientzu@chromium.org>
References: <20190527065559.66056-1-tientzu@chromium.org>
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

