Return-Path: <linux-serial+bounces-11019-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719A6BC470B
	for <lists+linux-serial@lfdr.de>; Wed, 08 Oct 2025 12:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9C6188DAAD
	for <lists+linux-serial@lfdr.de>; Wed,  8 Oct 2025 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A102F60CC;
	Wed,  8 Oct 2025 10:50:42 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E22EB86B;
	Wed,  8 Oct 2025 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920642; cv=none; b=QI2JO9mop8HUhkeo2JrJIvLyeu+PSe3cyHR29gzK6quD4QGFMZiS/RrE+uOZzTWjHCepGmTdZjV3Eg15wjrioYFjV6iN1WOIQuVT89185J0dDqNIZGmjsYDB5PbGQaGmvZpeCzwgfeP3X9OhpiSEm2xVgs1rBnkB3XewDMihlow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920642; c=relaxed/simple;
	bh=DF/eTkjbnkVCcxvdQiZyC5OR93vto4Pon7J7V58aJEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0tNpsuGbltw8MsJubG5AXHPRzahBh6t6KZtrmQdA2IE7oPXZ3+3DtzyCScxlfZUvhUSUFPi0m8S08899fdO5Jbc39oBr8IDvXUoXNRVF4njeiO3T7AOJez+O62QSm4Cbt5sYQbh2HcpUMfecFfJQVIuNcS2MlZKa6132BCn8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BEAC4CEF4;
	Wed,  8 Oct 2025 10:50:39 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: serial: sh-sci: Fix r8a78000 interrupts
Date: Wed,  8 Oct 2025 12:50:36 +0200
Message-ID: <09bc9881b31bdb948ce8b69a2b5acf633f5505a4.1759920441.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SCIF instances on R-Car Gen5 have a single interrupt, just like on
other R-Car SoCs.

Fixes: 6ac1d60473727931 ("dt-bindings: serial: sh-sci: Document r8a78000 bindings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index e925cd4c3ac8a47e..72483bc3274d5582 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -197,6 +197,7 @@ allOf:
               - renesas,rcar-gen2-scif
               - renesas,rcar-gen3-scif
               - renesas,rcar-gen4-scif
+              - renesas,rcar-gen5-scif
     then:
       properties:
         interrupts:
-- 
2.43.0


