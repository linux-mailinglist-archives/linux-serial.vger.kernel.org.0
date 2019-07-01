Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7FA26813
	for <lists+linux-serial@lfdr.de>; Wed, 22 May 2019 18:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfEVQVT (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 22 May 2019 12:21:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59370 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbfEVQVI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 May 2019 12:21:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4MGKdI2037691;
        Wed, 22 May 2019 11:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558542039;
        bh=NHGPWtIBtgCaIRfzn2pY4Joyz5HN6po2SvcIC4DkkMU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V8dAIqL5X+4hefMSssRkIut7wYFjJgbloh2SRmA3cR+POQ6fJ+qEzPAfZ+NP6nNEv
         pxe/i9D7N7Pd1xHiQxMZbeRBvWXsAQhRazuFYrVaonambtOeQTcr+wQKl0dXOtlAeD
         GW3lwzAjZuQdeAzQqjuoaxECxDRFT/bAeR1uyv1M=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4MGKdLk099362
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 May 2019 11:20:39 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 22
 May 2019 11:20:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 22 May 2019 11:20:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4MGKcW6126463;
        Wed, 22 May 2019 11:20:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/6] dt-bindings: serial: 8250_omap: Add compatible for J721E UART controller
Date:   Wed, 22 May 2019 11:19:17 -0500
Message-ID: <20190522161921.20750-3-nm@ti.com>
X-Mailer: git-send-email 2.21.0.777.g83232e38648b
In-Reply-To: <20190522161921.20750-1-nm@ti.com>
References: <20190522161921.20750-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

J721e uses a UART controller that is compatible with AM654 UART.
Introduce a specific compatible to help handle the differences if
necessary.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
NOTE:
 - If Greg is ok, we can pick up the uart compatibility via the k3 tree,
   else, I can spawn it off the series into it's own patch, but it
   seemed better in a logical order.

 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 0a9b5444f4e6..dcba86b0a0d0 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -1,6 +1,7 @@
 OMAP UART controller
 
 Required properties:
+- compatible : should be "ti,j721e-uart", "ti,am654-uart" for J721E controllers
 - compatible : should be "ti,am654-uart" for AM654 controllers
 - compatible : should be "ti,omap2-uart" for OMAP2 controllers
 - compatible : should be "ti,omap3-uart" for OMAP3 controllers
-- 
2.21.0.777.g83232e38648b

