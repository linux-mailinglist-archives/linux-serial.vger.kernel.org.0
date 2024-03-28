Return-Path: <linux-serial+bounces-2689-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75A879035
	for <lists+linux-serial@lfdr.de>; Tue, 12 Mar 2024 10:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A2E281D6B
	for <lists+linux-serial@lfdr.de>; Tue, 12 Mar 2024 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6AF77F1E;
	Tue, 12 Mar 2024 09:01:08 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CCBC8DD
	for <linux-serial@vger.kernel.org>; Tue, 12 Mar 2024 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234068; cv=none; b=NwdJJB4rmbJZYP1TUWpvvgRS3a0alkspMUPhmDNUQCRcf3Pe76nizOwrOHUv2iTt+WaP5nKwn+ydipnJwTbr0AWHDKoVRzSgZX8qdN0CioXxT2t5FcWhsXH8L2EDtL1w056G+FUdpCuz8EPfgI0LxR6F350sfbqCkqcwSSBvnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234068; c=relaxed/simple;
	bh=5EAyyFdwi0ye4lKLVNkrjW/MSy194QmY5ZjYirXbGDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UjyS404fESu6dVztVEBD463DnGI5DkDgcNyduidfg1jOvNrtGiYcSKrnCk7oO77CZcGeZBZEFS+uOPtrwpcEYsQ02bZMUAt22sBgO4LKrEKJuu8yhn6iCfvsX/9al6CsaVRqdAr6gaw9cpuhmbQcbpsX4AgDa/HncWhJpY8cqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by albert.telenet-ops.be with bizsmtp
	id xl0y2B00H0SSLxL06l0y2H; Tue, 12 Mar 2024 10:00:59 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rjy02-003Qku-Dp;
	Tue, 12 Mar 2024 10:00:58 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rjy0I-005m5B-J2;
	Tue, 12 Mar 2024 10:00:58 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Nghia Nguyen <nghia.nguyen.jg@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: serial: renesas,scif: Document r8a779h0 bindings
Date: Tue, 12 Mar 2024 10:00:55 +0100
Message-Id: <49b854603c2c3ed6b2edd441f1d55160e0453b70.1709741175.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nghia Nguyen <nghia.nguyen.jg@renesas.com>

R-Car V4M (R8A779H0) SoC has the R-Car Gen4 compatible SCIF ports, so
document the SoC specific bindings.

Signed-off-by: Nghia Nguyen <nghia.nguyen.jg@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes compared to the BSP:
  - Split in separate HSCIF and SCIF commits.
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 4610a5bd580c2389..f3a3eb2831e9fd5f 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -68,6 +68,7 @@ properties:
               - renesas,scif-r8a779a0     # R-Car V3U
               - renesas,scif-r8a779f0     # R-Car S4-8
               - renesas,scif-r8a779g0     # R-Car V4H
+              - renesas,scif-r8a779h0     # R-Car V4M
           - const: renesas,rcar-gen4-scif # R-Car Gen4
           - const: renesas,scif           # generic SCIF compatible UART
 
-- 
2.34.1


