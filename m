Return-Path: <linux-serial+bounces-12638-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO+QJNoyhGll0wMAu9opvQ
	(envelope-from <linux-serial+bounces-12638-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Thu, 05 Feb 2026 07:04:10 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A712EEDAD
	for <lists+linux-serial@lfdr.de>; Thu, 05 Feb 2026 07:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 852FE30065F4
	for <lists+linux-serial@lfdr.de>; Thu,  5 Feb 2026 06:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF9C332EC5;
	Thu,  5 Feb 2026 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZV8p2Iw"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21A2D47F1;
	Thu,  5 Feb 2026 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770271446; cv=none; b=RPylu5eW68SSDzygVEkdbNRy5YaWAi793JTPYWETuyoogsj+X6J6GKwrgV8YIoZ1QNXrqts8zhK+7IILpGE2JjWpya/+Sa6XNrSEzax1RL7R+Prl9jj4g/C+F4AzsaeyklT4z5sZpUPOcGRmnDlUAxfq1I3wofYKDQklPLJsLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770271446; c=relaxed/simple;
	bh=ps7j2+Z67QCIPw991CX7xaz/DhDRBR1m3knxUYmHUEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hYp4FJIiUILANkjMKR8AJYMYh5Lz4O7B9bFwGDHZx5taVTysNTikduTu11RdTf20jWyqqnMQqEB5IlrVFSAhuTuOgxl1a5WRqifacWZh9TVJhqZwelBRZPmoffClzMclTvoZUxFv/tuFXUuMRfLHw4H2x7MWysM9qhQZT1qIwKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZV8p2Iw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD55BC4CEF7;
	Thu,  5 Feb 2026 06:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770271445;
	bh=ps7j2+Z67QCIPw991CX7xaz/DhDRBR1m3knxUYmHUEk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RZV8p2IwkhcO4+zokH5xJsweYtkag2g+8gpUvEwo+cJDnWJLyHNJATUWnNvLZTF7m
	 bm6CfH2g9q0jTH7wKx0fEkGSbls97UOEvcNtF+hxT4rLkc58NcTARdXFIAmzVKa8iX
	 l5Sk1opzAJlydj/CPpOzeCo9c9TgmrCU6G7yjFSAwkt+4ZbBX/3xnFJd9K95WCSjm9
	 ScB9PvVVrh/4MXwmuGkgrdDyMc/stZNqnmh6AERZlnZjfMNGJiKeBDTtoDwfONwGOD
	 WpgqXzkfAQ2CnTFmjkE57bJjQaFNl1PWTKXjaiJ9ZpoylSpdZfVc0Cq3qoXuU/fPSW
	 0WdcYy1eyVDJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B092CE91263;
	Thu,  5 Feb 2026 06:04:05 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] baisc devicetree support for Amlogic A9
Date: Thu, 05 Feb 2026 06:04:01 +0000
Message-Id: <20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANEyhGkC/x3MMQqAMAxA0atIZgNpQVGvIg5tTTVLlUZEKN7d4
 viG/wsoZ2GFqSmQ+RaVI1WYtoGwu7QxyloNlmxPljp0I3onGnC9FIP3ni2TiQNBTc7MUZ5/Ny/
 v+wGIh2F0XgAAAA==
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
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770271444; l=870;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=ps7j2+Z67QCIPw991CX7xaz/DhDRBR1m3knxUYmHUEk=;
 b=a/G09XieespzzJlySSaPDZ0TgKEJThWA1puCkS6knfHGGWUWbLvYbDZKpVmF0Xd1NCxulbqAx
 R4kjdoSHiYDDIqCUmlxkhluqDOhCAktxMfVEDPOTxXOnDV/GDsFK54a
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12638-lists,linux-serial=lfdr.de,xianwei.zhao.amlogic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,googlemail.com,baylibre.com,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-serial@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-serial,dt];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:replyto,amlogic.com:email,amlogic.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A712EEDAD
X-Rspamd-Action: no action

Add the new A9 SoC/board device tree and related bindings.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (3):
      dt-bindings: arm: amlogic: add A311Y3 support
      dt-bindings: serial: amlogic,meson-uart: Add compatible string for A9
      arm64: dts: add support for A9 based Amlogic BY401

 Documentation/devicetree/bindings/arm/amlogic.yaml |   6 +
 .../bindings/serial/amlogic,meson-uart.yaml        |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/amlogic-a9-a311y3-by401.dts   |  41 +++++++
 arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi        | 127 +++++++++++++++++++++
 5 files changed, 176 insertions(+)
---
base-commit: e3194dfb772304a1b7ca3bcfccacefec3468b7bf
change-id: 20260205-a9-baisc-dts-cbbbe2e01f80

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



