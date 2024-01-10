Return-Path: <linux-serial+bounces-1288-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F340826053
	for <lists+linux-serial@lfdr.de>; Sat,  6 Jan 2024 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A01C2101E
	for <lists+linux-serial@lfdr.de>; Sat,  6 Jan 2024 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D34882E;
	Sat,  6 Jan 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsKfRhR3"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38CD847B;
	Sat,  6 Jan 2024 16:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F075C433CA;
	Sat,  6 Jan 2024 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704556947;
	bh=71uc0hK9NDOdEhHgFTZarT58L7adnWBofG0Y0tpQY4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dsKfRhR30bbGHBWMuzQEW2U4QLMWM7p885k0pgQV0RreZB1CnwvM44XfujnexGxjT
	 MLQUIvu3XkBWAtNnWZtlctWwoKvhIbY8DTz9uUqvepp/c9vKq6ov78WyAwgLPACC+X
	 SjGQ3KyPyrlKKxJA6wKHe2dyQRlXoP9px/8CM+Qyz3IpXd7yXCAHqCHkWOLgljcmnU
	 7Ik/Liu9GKOleP7jHGCMd8f8UQSXo53mc+DK/ExtgT/Smlr/G8oqncadEO7jMxhPrk
	 NM6YNMWyf9dVMv2y9UHt+d4KL70Od+QptUEmnBoN7ninIZU18z3b1DTCLuuQszKoOf
	 3Wnta0/IYa71w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E58DC4707C;
	Sat,  6 Jan 2024 16:02:27 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Date: Sat, 06 Jan 2024 17:02:25 +0100
Subject: [PATCH v4 2/3] dt-bindings: serial: allow onewire as child node
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-w1-uart-v4-2-7fe1378a8b3e@gmail.com>
References: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
In-Reply-To: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Christoph Winklhofer <cj.winklhofer@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704556945; l=827;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=BPcWb7esDB40/mUZFKo7VPDltCBO7/vmdkKQuHI4X3c=;
 b=+DOlTbh6Pw9avHCALYuaoty0WhiZY/A49sTN5hWHau/0sX1XxYyWXOtpj4rcgqsg59qSs8W+t
 2xfHNgN2lvYDML0E9yXwq9fDvrjZYP2ofeM2PEXZRhFYTf1IA7qNazs
X-Developer-Key: i=cj.winklhofer@gmail.com; a=ed25519;
 pk=lgjGjOt7hFKJT9UXhgUyrdthxvZ7DJ5F1U/7d9qdAsk=
X-Endpoint-Received:
 by B4 Relay for cj.winklhofer@gmail.com/20240104 with auth_id=111
X-Original-From: Christoph Winklhofer <cj.winklhofer@gmail.com>
Reply-To: <cj.winklhofer@gmail.com>

From: Christoph Winklhofer <cj.winklhofer@gmail.com>

The UART 1-Wire bus utilizes the Serial Device Bus to create the 1-wire
timing patterns.

Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 65804ca274ae..ffc9198ae214 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -88,7 +88,7 @@ properties:
       TX FIFO threshold configuration (in bytes).
 
 patternProperties:
-  "^(bluetooth|bluetooth-gnss|gnss|gps|mcu)$":
+  "^(bluetooth|bluetooth-gnss|gnss|gps|mcu|onewire)$":
     if:
       type: object
     then:

-- 
2.43.0


