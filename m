Return-Path: <linux-serial+bounces-9981-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FFFAEC1EC
	for <lists+linux-serial@lfdr.de>; Fri, 27 Jun 2025 23:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCDE1BC06BA
	for <lists+linux-serial@lfdr.de>; Fri, 27 Jun 2025 21:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98203272E45;
	Fri, 27 Jun 2025 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvrNs1FS"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897E271479;
	Fri, 27 Jun 2025 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751059373; cv=none; b=ZfsrTWmDAG4RF6CuKxoxWcS2EQgnSeWS02opIyYMQShhBgqo5Es75ext2BpH1OdG1zeuMgpK86eY6EHLCnxyXSwKbYNZ+iZZyjL5XPw1fl+Rm8X8YSqPf77t7kHd1gA5Dtd+QthfQqmYIpxpOAsqKg0O7RB+6f06cQ+bBEe8oAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751059373; c=relaxed/simple;
	bh=dKyxY/bPjE3fZt8bSWNegDuc+jZKxTxZmy1Wiiwm/TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6cYy0fR6+wkj1iVhaN1xqAWTmgfg0HDZE1lVjJp3GhltYmC3+Og/KWQPy0k25m/qYaFuRdMshZkEglDR+vVMTdzeR7woHMYxeSqwKX4FZxHWA93bzkXjBkvMNTafa89uyBFCRFMdPLf/ZJkQ2X+e8MfvyQUbgfVuZIoZm8KEuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvrNs1FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0189C4CEE3;
	Fri, 27 Jun 2025 21:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751059373;
	bh=dKyxY/bPjE3fZt8bSWNegDuc+jZKxTxZmy1Wiiwm/TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvrNs1FSoHgcTi1oM2A35k2hTcOFuUXZERNsEOILi3zQ/qDyZ+BRxqyPoBLRXq0hh
	 Bb3sqzGHEDPkbS7LYG7VZLtnmwZqMPR+zTBfk3mMvKAzpfI6YtJeSuThUSVUhOm/2u
	 5vEvnhCRSivsdt9/bJkKCAYWWJwVXmhUV7rs/eGXHaTg0j73SVPGMICz19cXE7GXi3
	 moGAgD1P7Gi3uKP5wzsgXV9YVp87G1b0eo/x25VrroxeadQ3YHPTjwF75S26kp84pG
	 2zh0KgZzNW2okXRc5jG4H/x/KNINz0vtuOjdCluV/CVrMYoJdULalOowMNh79pkety
	 6oI1zRv8I2CMg==
Date: Fri, 27 Jun 2025 16:22:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Max Shevchenko <wctrl@proton.me>
Cc: linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-watchdog@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] dt-bindings: timer: mediatek: add MT6572
Message-ID: <175105937161.165965.1627946015902524006.robh@kernel.org>
References: <20250626-mt6572-v2-0-f7f842196986@proton.me>
 <20250626-mt6572-v2-3-f7f842196986@proton.me>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626-mt6572-v2-3-f7f842196986@proton.me>


On Thu, 26 Jun 2025 11:53:56 +0300, Max Shevchenko wrote:
> Add a compatible string for timer on the MT6572 SoC.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Max Shevchenko <wctrl@proton.me>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


