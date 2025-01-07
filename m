Return-Path: <linux-serial+bounces-7412-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD2A0457D
	for <lists+linux-serial@lfdr.de>; Tue,  7 Jan 2025 17:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87011884A5C
	for <lists+linux-serial@lfdr.de>; Tue,  7 Jan 2025 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E1B1F470F;
	Tue,  7 Jan 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nEUN+74p"
X-Original-To: linux-serial@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C11F2C25;
	Tue,  7 Jan 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266120; cv=none; b=rwSgCziiTKBtGy89kf0MXzRXViAjVPptEfH3faFJqtWNF9eciyacUWHUcuXRu/b0vtm65RNT3vZq/4YI1oNRRf/ZU9rCoxxg1cd175qpEBE3/kJPGVafxTjh4tCOQsUs028ut7QgijNqIOFwcu9bsGZhBLK/pXQHHOFvFI1F8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266120; c=relaxed/simple;
	bh=VUT45XGlDSMQNHusgz0mY/5e3jHIdDXBnlb8O2girPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSHdpW4ur92q2AIGSB9AamHe8XH+TAZ1as0z2sEerfEXVmJoQdm1QNPt9Y0Jq7Hhz9vKY5lMrgktmpaIHBD6i4vhFLUE402W7U+P6/LMsiyBT1E7/souN6u69GK1wtz+Fu/VxQrGmnc0U3fX9ZtK4y6ZpPPpQo4Yug5OiVVjwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nEUN+74p; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736266116; x=1767802116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUT45XGlDSMQNHusgz0mY/5e3jHIdDXBnlb8O2girPc=;
  b=nEUN+74pvOXonDQfXpNQf4/Emp04hsHpm1RVa9ci+77C8THylixBfkHE
   QsrPT/lC/qn/QIhesy0o/CJ6SBR4E7EHnx4KVjCS3gjrPEx6+1uCB9XCa
   AcHyVtu5pO13UdK9YKtR0zN/B3//iR4GMLGEkzrfMBhjJNbhffZ8ao6pP
   TByFby3REkZCg6v5AGjlhcHoA5hYqwgqAhqRjeATu141X59du3pouSFdC
   Pb1Q0T0p79gRI67/1IUn9MGRLMwvAAMVojApmJLR8dQaya2IY2bybGdIx
   jv33Le3CI28HAMPZyrgO2Ub7CP8Sli75CFTvlqleEPeTql2ZunNVaO4Hm
   g==;
X-CSE-ConnectionGUID: lqpfnJzJQpCXzb9QKpQeRA==
X-CSE-MsgGUID: qZ8ajRtFTXKuCSFks2gq8Q==
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="40091248"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jan 2025 09:08:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 Jan 2025 09:08:17 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 7 Jan 2025 09:08:17 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<arnd@arndb.de>
CC: <dharma.b@microchip.com>, <mihai.sain@microchip.com>,
	<romain.sioen@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v5 1/5] dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity
Date: Tue, 7 Jan 2025 09:07:23 -0700
Message-ID: <20250107160850.120537-2-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
References: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Romain Sioen <romain.sioen@microchip.com>

Document device tree binding of the Microchip SAMA7D65 Curiosity board.

Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 7160ec80ac1b..0ec29366e6c2 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -180,6 +180,13 @@ properties:
           - const: atmel,sama5d4
           - const: atmel,sama5
 
+      - description: Microchip SAMA7D65 Curiosity Board
+        items:
+          - const: microchip,sama7d65-curiosity
+          - const: microchip,sama7d65
+          - const: microchip,sama7d6
+          - const: microchip,sama7
+
       - items:
           - const: microchip,sama7g5ek # SAMA7G5 Evaluation Kit
           - const: microchip,sama7g5
-- 
2.43.0


