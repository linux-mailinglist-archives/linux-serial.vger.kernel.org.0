Return-Path: <linux-serial+bounces-12644-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPtaGZ+fhGmI3wMAu9opvQ
	(envelope-from <linux-serial+bounces-12644-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Thu, 05 Feb 2026 14:48:15 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA4FF384F
	for <lists+linux-serial@lfdr.de>; Thu, 05 Feb 2026 14:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FCD33004906
	for <lists+linux-serial@lfdr.de>; Thu,  5 Feb 2026 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542D3D669E;
	Thu,  5 Feb 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi8S1yML"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A7527E049;
	Thu,  5 Feb 2026 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299293; cv=none; b=UgXItGEv6zbouF1CoPmGxdcxKpzyTARoytFAsLr++DEmVnsM1OBIel7zuJyULwjdDLc9wy/KMIKRgk8FmtUfcyA1zUV3BDJ0BBjypS1kPcxC6QrDLdoDV/XEkOaN4DHTZtY+4jmSI+rB/zXt52Rwk2fh8Mpb9S8EQJkATiEZFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299293; c=relaxed/simple;
	bh=1wC56N7As0NIexxSGFO55ZSK9LgfEt1xFbSYfs02cRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW2qwagcGXlHwxR8hTuT1MO50yw/6+XDPg1ItWXs5NyY+TAQ4eYRpMUIxMdetTMIyOw7SHelgsaAMXQoYbGmgu0MdT/3fpKkmAqmOhZZN3N0vmunhiTV+wtWyzdrEP6y91/247QPXlsSVxf07bgYvNWb0t8HCaeH576qK4rsZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi8S1yML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446D9C4CEF7;
	Thu,  5 Feb 2026 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770299292;
	bh=1wC56N7As0NIexxSGFO55ZSK9LgfEt1xFbSYfs02cRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pi8S1yMLdcEKbNNY9SnG+1h6Kbwq9byZUFHW6n/CD9CYTV0kw46EfkKx9q41HStAs
	 tzHRWBQPkub/Oq+YJA6na7mchjYKBupWIWvuylOZBi/IQKGJaJjfSpjKWmfMWwm3RK
	 LuPvXyEwXKWf04TcMzv5dOI249QK3ZlM3VizBz6AZ3ijlbmrlZBaWwX41vZ/JaNCGZ
	 1necQQ+mB90VdPc1YuNs4DpfOiZz2qfFq6PiPhe6LtKbX9y07Kri/wPtkUFE3USld5
	 2gf8SRtKCM2EIkfeLPD/K/ww61PXu8rf2mIVURDUdFabGjF87qgGqUdVEosrhm+efl
	 QewgdMY2XEMOQ==
Date: Thu, 5 Feb 2026 14:48:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: amlogic: add A311Y3 support
Message-ID: <20260205-abstract-oriole-of-purring-316531@quoll>
References: <20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com>
 <20260205-a9-baisc-dts-v1-1-1212b46f95a7@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205-a9-baisc-dts-v1-1-1212b46f95a7@amlogic.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12644-lists,linux-serial=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,googlemail.com,baylibre.com,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-serial,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,amlogic.com:email]
X-Rspamd-Queue-Id: 2BA4FF384F
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 06:04:02AM +0000, Xianwei Zhao wrote:
> Add bindings for the Amlogic BY401 board, using A311Y3 Soc from
> Amlogic A9 family chip.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


