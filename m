Return-Path: <linux-serial+bounces-12651-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC5dNHYdh2mbTwQAu9opvQ
	(envelope-from <linux-serial+bounces-12651-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Sat, 07 Feb 2026 12:09:42 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E1C105B9E
	for <lists+linux-serial@lfdr.de>; Sat, 07 Feb 2026 12:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F21CB301AA69
	for <lists+linux-serial@lfdr.de>; Sat,  7 Feb 2026 11:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2528C340A49;
	Sat,  7 Feb 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PH1yYcKQ"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F111D6193;
	Sat,  7 Feb 2026 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770462580; cv=none; b=TbHTeu1/cMxuwzirGuUf3XdNwiskIQHPKEGz4NR/b3aXbAAOVCkGGAQd9BetzQu0HOa9Oa7/kgAAGgAS/Y4A6bJsSOsgRLGLBjx8V6838HLadIoHE46x+URnlu1/z5F31wTmq15DeFQJrE12WyY1UoqqJ03EtgaAPoLMUGEFTpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770462580; c=relaxed/simple;
	bh=OIwmG7ylTwl4hisHz0Q19ZZnRiXWGfi075fX99Cag7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+3dxFToFDZsJZUnYHABX6871v1zJphGXy0oIwLxUYROIRvVepaxB1AwvjaO0nns9GoZr84KhyeGq1KmASPwRIOpC1wUtDCDg74kwVt4mpphCANJVl4bSSOjRVm9dvtvHSjaPoJ4R9Nwdyvfkbp6AtNTfVRRod/7szdTqTjqR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PH1yYcKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177DDC116D0;
	Sat,  7 Feb 2026 11:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770462579;
	bh=OIwmG7ylTwl4hisHz0Q19ZZnRiXWGfi075fX99Cag7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PH1yYcKQkjUSbd3pr9eI9NKoJaKw8BegVjZtlwxIBX/jzcyRU3hJbX1yib0csIqFy
	 wFeZ61PAxKsQp0DoaJukUvVQFaSnBA96kXEim6ymJkkHwgOZtbY7kiTdSd+K9wYJJJ
	 bERHBSPsH51PXzMd1D6DR16eAS1aSG/HZ3waFlKs=
Date: Sat, 7 Feb 2026 12:09:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, heiko@sntech.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Fabio Estevam <festevam@nabladev.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 07/11] dt-bindings: serial: snps-dw-apb-uart: Add support
 for RV1103B
Message-ID: <2026020723-despise-panoramic-2bef@gregkh>
References: <20260206181309.2696095-1-festevam@gmail.com>
 <20260206181309.2696095-8-festevam@gmail.com>
 <20260207-unselfish-gorgeous-duck-cfc1ce@quoll>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207-unselfish-gorgeous-duck-cfc1ce@quoll>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12651-lists,linux-serial=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,sntech.de,kernel.org,vger.kernel.org,lists.infradead.org,nabladev.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55E1C105B9E
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 11:59:06AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Feb 06, 2026 at 03:13:05PM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <festevam@nabladev.com>
> > 
> > The UART used in the RV1103B SoC is still the same dw-apb-uart compatible
> > type as on the SoCs that came before, so add the RV1103B to the list
> > of variants.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-serial@vger.kernel.org
> > Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> 
> Greg expressed MANY times that patches for him should be sent
> separately.

It's easy, I just ignore them now :)

