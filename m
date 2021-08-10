Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53323E4822
	for <lists+linux-serial@lfdr.de>; Mon,  9 Aug 2021 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhHIOzk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 9 Aug 2021 10:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235300AbhHIOzW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Aug 2021 10:55:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A68AC610EA;
        Mon,  9 Aug 2021 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628520896;
        bh=Tj1KoLbRx36Cai5tD6gjvLCZPUH6QNJdzsfNne47jbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htc7ntiNVjjtRoqW5Df/SjpGSqBwa5+lIWvnrkcmiyK66/JM83IPoj3QnnToLcn2H
         3od8AyqjaEHy32nQREMGBqBXIFRSILjIWWbgxDhVDDnCDIzNo5NByj0/XFYRAggaWL
         gQHkItcE+0QwY40Rwg4Swz6iuAF/UfPM0GgrrmjqhvjSDDir/fskavMvhEeq570YKj
         rrx273dHAQeQ8gRLORWbpQozghWTL68cRElT1eQijF5PXEopxTnh8QSizx+xQRmRJQ
         69vgwX7VXqafPHVStykQecLaU3WboM4RnmSCU2h5cfOqush5Kl6kbwPwYmMD9H9lUS
         cDyvauDd3ETPw==
Received: by pali.im (Postfix)
        id C9F0228E5; Mon,  9 Aug 2021 16:54:54 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 4/6] dt-bindings: mvebu-uart: update information about UART clock
Date:   Mon,  9 Aug 2021 16:53:27 +0200
Message-Id: <20210809145329.24177-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210809145329.24177-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210809145329.24177-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Device "marvell,armada-3700-uart" should use
"marvell,armada-3700-uart-clock" compatible clock.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/devicetree/bindings/serial/mvebu-uart.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/mvebu-uart.txt b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
index 2d0dbdf32d1d..a062bbca532c 100644
--- a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
@@ -14,7 +14,10 @@ Required properties:
       is provided (possible only with the "marvell,armada-3700-uart"
       compatible string for backward compatibility), it will only work
       if the baudrate was initialized by the bootloader and no baudrate
-      change will then be possible.
+      change will then be possible. When provided it should be UART1-clk
+      for standard variant of UART and UART2-clk for extended variant
+      of UART. TBG clock (with UART TBG divisors d1=d2=1) or xtal clock
+      should not be used and are supported only for backward compatibility.
 - interrupts:
     - Must contain three elements for the standard variant of the IP
       (marvell,armada-3700-uart): "uart-sum", "uart-tx" and "uart-rx",
@@ -34,7 +37,7 @@ Example:
 	uart0: serial@12000 {
 		compatible = "marvell,armada-3700-uart";
 		reg = <0x12000 0x18>;
-		clocks = <&xtalclk>;
+		clocks = <&uartclk 0>;
 		interrupts =
 		<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 		<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
@@ -45,7 +48,7 @@ Example:
 	uart1: serial@12200 {
 		compatible = "marvell,armada-3700-uart-ext";
 		reg = <0x12200 0x30>;
-		clocks = <&xtalclk>;
+		clocks = <&uartclk 1>;
 		interrupts =
 		<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
 		<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
-- 
2.20.1

