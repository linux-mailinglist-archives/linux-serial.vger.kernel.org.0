Return-Path: <linux-serial+bounces-7210-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C265E9EDA0D
	for <lists+linux-serial@lfdr.de>; Wed, 11 Dec 2024 23:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C7D282431
	for <lists+linux-serial@lfdr.de>; Wed, 11 Dec 2024 22:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E692054E8;
	Wed, 11 Dec 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3Y1qtdQ"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D61A2054E1;
	Wed, 11 Dec 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956366; cv=none; b=ISE2wBX6wQaWtnlqvJZd5IY4AVdX+QU9+OM5LXc8QHiqfbOEKOlcaqmYwGXZT9hSHtlTev8Mo4jAEpb3Cv0IXFzhhto+mOaxvLAU0PeuCHp/aVg3y8UUaOEPZMAVrPecObeHT3YyV5IMEjch2GxZ7/7d+vp1BRRjBDq9r6p61Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956366; c=relaxed/simple;
	bh=obLml54yrC6BtPAvZAw6oHrG+DacnU6UkXbWYex96uQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oo9+ILpnnnWiLdbUwzmSu6E6DjgReNrTjEpQvlNSBKErvLmIrqRL2pt9guCxmRJuvC9WnPxIHPtFRF1JXf9aQWOkI7RpJc0+M68FL2qvyGxdwqXtBBlPKiDNwOeiHIQnBbppbKeRTwkpIZs6/nuPWjzy3rec2jnS3Jni9sWv6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3Y1qtdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79A4C4CED3;
	Wed, 11 Dec 2024 22:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956366;
	bh=obLml54yrC6BtPAvZAw6oHrG+DacnU6UkXbWYex96uQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f3Y1qtdQGdMFCfSboCawizXobcUgw2E7uyX0u9TS6LZTranNNUaLvizV5M/uf4JVv
	 6wdmmp8rH+8i5m7TDTkpBHaE/I70OTc9JhThdUfSx3tMET3XZRz3zgJx4jSrVXJ6HK
	 dTPyhioPrnGp6zxdsD3eF4F8YZQ3I5CjQKcrRg4ZBz9eHhfjQUrDsJPYq9LRO/KTCg
	 T7m+GxeewLN/pL8waq9uyekOdC5ANOLUDgb9UavzspL2WMo2wy06I2tG4Z/xQIBh4E
	 z0ntxLpzXUXPJVxWipK8pwZUYY/lL+bSO3CqM3XaUNyCzVMe2gbJnloJauVfuRTHGa
	 jdVL399dsPxRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCE380A965;
	Wed, 11 Dec 2024 22:33:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 00/10] riscv: add initial support for SpacemiT K1
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395638199.1729195.1529576042123666894.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:01 +0000
References: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
In-Reply-To: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, cyy@cyyself.name, daniel.lezcano@linaro.org,
 tglx@linutronix.de, samuel.holland@sifive.com, anup@brainfault.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, lkundrak@v3.sk,
 devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, jesse@rivosinc.com, conor.dooley@microchip.com,
 inochiama@outlook.com, zhangmeng.kevin@spacemit.com, jszhang@kernel.org,
 matthias.bgg@kernel.org, kevin.z.m@hotmail.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Conor Dooley <conor.dooley@microchip.com>:

On Tue, 30 Jul 2024 00:28:03 +0000 you wrote:
> SpacemiT K1 is an ideal chip for some new extension such as RISC-V Vector
> 1.0 and Zicond evaluation now. Add initial support for it to allow more
> people to participate in building drivers to mainline for it.
> 
> This kernel has been tested upon Banana Pi BPI-F3 board on vendor U-Boot
> bootflow generated by Armbian SDK[1] and patched OpenSBI[2] to enable
> Zicboz, which does not in the vendor dts on its U-Boot. Then successfully
> booted to busybox on initrd with this log[3].
> 
> [...]

Here is the summary with links:
  - [v5,01/10] dt-bindings: vendor-prefixes: add spacemit
    https://git.kernel.org/riscv/c/7cf3e9bfc63d
  - [v5,02/10] dt-bindings: riscv: Add SpacemiT X60 compatibles
    (no matching commit)
  - [v5,03/10] dt-bindings: riscv: add SpacemiT K1 bindings
    (no matching commit)
  - [v5,04/10] dt-bindings: timer: Add SpacemiT K1 CLINT
    (no matching commit)
  - [v5,05/10] dt-bindings: interrupt-controller: Add SpacemiT K1 PLIC
    (no matching commit)
  - [v5,06/10] dt-bindings: serial: 8250: Add SpacemiT K1 uart compatible
    (no matching commit)
  - [v5,07/10] riscv: add SpacemiT SoC family Kconfig support
    (no matching commit)
  - [v5,08/10] riscv: dts: add initial SpacemiT K1 SoC device tree
    (no matching commit)
  - [v5,09/10] riscv: dts: spacemit: add Banana Pi BPI-F3 board device tree
    (no matching commit)
  - [v5,10/10] riscv: defconfig: enable SpacemiT SoC
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



