Return-Path: <linux-serial+bounces-9912-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB2AE3878
	for <lists+linux-serial@lfdr.de>; Mon, 23 Jun 2025 10:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6763B1DEF
	for <lists+linux-serial@lfdr.de>; Mon, 23 Jun 2025 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981C022FAC3;
	Mon, 23 Jun 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D4CMFtbL"
X-Original-To: linux-serial@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B122DF92;
	Mon, 23 Jun 2025 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667711; cv=none; b=qNMZIhmorO8gzmumnBaBxOjRRUEWYvnHE9VH5kwV5O2kNKUqrbxhLtUMJkUENLZs4z3lJ0yGNHPWlf2hNYIDn2bmdBmaY6fR07cDVxTS5Fu5TRQvvYVRRINklYXELMfkrItdKim6SB9r9hpsG4u8kdxgs1xPtqGrA8DnMHh6+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667711; c=relaxed/simple;
	bh=AdZQo7KUXRvps+IrCJbIJguh27l3FFVuyIGfWdEa30Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLcov1eZXqrt+42WNQ2xILrZfZQ3/xcX2oxRYGfchmGi0nGPSBDAH+moJIDcSO0sBvmSJ2TxnTgJFyqoIA/asWPhGeAQ595qo0UraHa2R7AVFCmQyjAjYLjfKosAAlHEEpfjxIQHm6ZO2LYh0CW7t5ENzyVpmtMQNZyVi0vzzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D4CMFtbL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750667707;
	bh=AdZQo7KUXRvps+IrCJbIJguh27l3FFVuyIGfWdEa30Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D4CMFtbLJCn4Uko6KbzQZCht5t+T3uefiOtpfzYRRj7HVMUQHb3jJTJE5l7qaTRFj
	 J95Uk7eb2j8m3AgZ02/fzfNQ6RFf/j9b2bi5/NYNqL+NSByPkWjoRTmvJmQdLjh+8x
	 wQccxV/oR3C8a9sqpTUpKM9a8jzHlaxrlwnSdqbVvS6EOzgu7L6dauaapkFDKi1Xos
	 vhmVBERm5w2WhAGDRVkNQZ8+AztWiHMhn6MC2a8eUQTTeSoCbQ8DVFTUwLLXBbKZQh
	 tdWVb6z53IWa8XuReH9D6Aa7fEV1KTLKi0OrkqlDw8pGOIOS3kIkCdBqaGm04FcH9A
	 Han9/fwFTEeHQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E633217E0109;
	Mon, 23 Jun 2025 10:35:06 +0200 (CEST)
Message-ID: <4c2249b2-5e05-4471-a624-0f012ee3f1af@collabora.com>
Date: Mon, 23 Jun 2025 10:35:06 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] dt-bindings: arm: mediatek: add boards based on the
 MT6572 SoC
To: wctrl@proton.me, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Sean Wang <sean.wang@mediatek.com>,
 Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org
References: <20250620-mt6572-v1-0-e2d47820f042@proton.me>
 <20250620-mt6572-v1-6-e2d47820f042@proton.me>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250620-mt6572-v1-6-e2d47820f042@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/06/25 17:40, Max Shevchenko via B4 Relay ha scritto:
> From: Max Shevchenko <wctrl@proton.me>
> 
> Add entries for the JTY D101 tablet and the Lenovo A369i smartphone.
> 
> Signed-off-by: Max Shevchenko <wctrl@proton.me>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



