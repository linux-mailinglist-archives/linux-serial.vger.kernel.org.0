Return-Path: <linux-serial+bounces-12841-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGGJMRyzpmn9SgAAu9opvQ
	(envelope-from <linux-serial+bounces-12841-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Tue, 03 Mar 2026 11:08:28 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 972BD1EC65C
	for <lists+linux-serial@lfdr.de>; Tue, 03 Mar 2026 11:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AAA83070EC4
	for <lists+linux-serial@lfdr.de>; Tue,  3 Mar 2026 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D323921D6;
	Tue,  3 Mar 2026 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXxVvjLh"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8E391515;
	Tue,  3 Mar 2026 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532389; cv=none; b=JvIfgxkF3QrYrJ24C5u26WyI8x9Wu5oPlNT06IYX0eLMU/Kccy33LEI4QBsBv6TIUmLKyuVAVUPfr3IQDyQiEo4dZ7+wcp4Wrdrahb/QnYgXYdrbKUsPAoECxbXdSSG0BoqiQALzGH+Rclg2uuuL87gMtTYKW0Eml/fdH4P2WUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532389; c=relaxed/simple;
	bh=xDY2zUL4lo50XwlAxftH7mcEOPS7xG11OXc5XAcUsug=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WLA2Kk5Td0wYnq9tbAdD+XDDqCvevhGT6AKa3JYjn8mj7QuyvdE1z/MGaXplBajuKBqgs2ZIc4x3X6zEjqAdbo6m7yTVfhS0wZmY9YdYXMDqYy+YWPMsYyXa96mmu/hTVOFnEG5EJyaqUiKPuYUpmJzfCGLEzbqE3rcstAcl17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXxVvjLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C475DC116C6;
	Tue,  3 Mar 2026 10:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772532388;
	bh=xDY2zUL4lo50XwlAxftH7mcEOPS7xG11OXc5XAcUsug=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kXxVvjLhASHctIxoRdS9tBfadNQBHtdcCXyHpOdeVvjMrL7RtFGkx8fxwCt0P7Pij
	 LEFk4LLja5qorRCzcjQMSDucBnGcpohEEkrnghbxk4xLccE9r141VNJCWuPB6+CCSS
	 LdylA9vOig0Uv3vycPFCxgXJsXPxVyviW6/2dCUqCU/q9f/aMzJgLB+oxsmY0R4KQk
	 twbQw84Yzcah/qAQFs5ixWNSTmoPjZSBIFRyZHt4NRT1rz6pj4daHPg/uw6M+0QhXt
	 FRtxKZn3U/2Nn2bs5fdwo2jKKpTMwCdGL9L7qRYjfLQoQ6bcc5i40+GP9jB6mwkKUr
	 yYvKmhKg3V2wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94F1EC048A;
	Tue,  3 Mar 2026 10:06:28 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/2] basic devicetree support for Amlogic A9
Date: Tue, 03 Mar 2026 10:06:24 +0000
Message-Id: <20260303-a9-baisc-dts-v3-0-4bf21001f05c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKCypmkC/3XMSw7CIBSF4a00jMXAtQ/qyH0YB0Bv25vYYqAhm
 oa9SztSE4fnJN+/soCeMLBzsTKPkQK5OY/ToWB21POAnLq8GQioBYiK65YbTcHybgncGmMQUMh
 eCZbJw2NPzz13veU9Ulicf+31KLf3TyhKLrgECaas+7bSzUVPdzeQPVo3sS0V4YOD+uGQedmUq
 u0qa6VW3zyl9AZjGApq6QAAAA==
X-Change-ID: 20260205-a9-baisc-dts-cbbbe2e01f80
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772532387; l=1285;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=xDY2zUL4lo50XwlAxftH7mcEOPS7xG11OXc5XAcUsug=;
 b=K7ff/AITnNBzEaAERMwOvCVFbtGofqTk6HA3TRi2H7p6R37aiNO599ue4wYKwUWZgmtq0HIwJ
 wD/cL9vnwNkDHbE8Uf35G+xwW7GDC1fHUUYmnZo29fZQXTMFnirHrNQ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Rspamd-Queue-Id: 972BD1EC65C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12841-lists,linux-serial=lfdr.de,xianwei.zhao.amlogic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,googlemail.com,baylibre.com,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-serial@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-serial,dt];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amlogic.com:replyto,amlogic.com:email,amlogic.com:mid]
X-Rspamd-Action: no action

Add the new A9 SoC/board device tree and related bindings.

Since the serial submission has removed this patch as a separate patch.
The dtb check needs to be relied upon for serial submission mereged, or
check failed, when run "make ARCH=arm64 dtbs_check W=1".

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v3:
- Remove serial bindings from this patches and will send it independently.
- Link to v2: https://lore.kernel.org/r/20260228-a9-baisc-dts-v2-0-47489d5cc1a8@amlogic.com

Changes in v2:
- Move default interrupt-parent into dtsi.
- Link to v1: https://lore.kernel.org/r/20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com

---
Xianwei Zhao (2):
      dt-bindings: arm: amlogic: add A311Y3 support
      arm64: dts: add support for A9 based Amlogic BY401

 Documentation/devicetree/bindings/arm/amlogic.yaml |   6 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/amlogic-a9-a311y3-by401.dts   |  40 +++++++
 arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi        | 128 +++++++++++++++++++++
 4 files changed, 175 insertions(+)
---
base-commit: e3194dfb772304a1b7ca3bcfccacefec3468b7bf
change-id: 20260205-a9-baisc-dts-cbbbe2e01f80

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



