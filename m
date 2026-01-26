Return-Path: <linux-serial+bounces-12539-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNN2A2ajd2mWjgEAu9opvQ
	(envelope-from <linux-serial+bounces-12539-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 18:24:54 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DC28B6CC
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 18:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25E5B300DD4F
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE15E34C9A1;
	Mon, 26 Jan 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="CzxVNjqH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RG6aVPxk"
X-Original-To: linux-serial@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A31D22425B;
	Mon, 26 Jan 2026 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448277; cv=none; b=W2GduG8EUtTYI/y9HHZUcJQe332JgdaiRyEJ6UUox0NY04hTKGz0//I4MEr/ggyiJFdTU+fs/otar2wCnRmVRyjFqG7+9rLMEcadXqMd7g1FIbG5qTQ6bUnxEvyKddW9ZDKIDBB0yhEX4t1HANaHzABETFnmX6wEgvFxi8WyMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448277; c=relaxed/simple;
	bh=cN/j0q0oUdv4JvH3BK3eEDmUOf9hQa1hZba6S1cQbTI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sNToVPMyE8BOZ2SQvhMdVKpkki559+8UhNv8ZzatI20nU2Jr7Q/EzdHrS/wyhUMzWUm4QBlcZHfUP6IC0P9Ll+wNMIqTDOxCZBh6vFWRGWwDipHj8Jyc2NqoAr74fqjKPZS8Va1Fzl2F+WRY/JVhSJaagRQfJ9XAABdS0zQqs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=CzxVNjqH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RG6aVPxk; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3151D7A0139;
	Mon, 26 Jan 2026 12:24:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 26 Jan 2026 12:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769448275; x=1769534675; bh=LWWDql48IZ
	1VwA/Cq+VsKE6kXvwG/0YyTjdIqs03ZuU=; b=CzxVNjqHdFAyBB1LZkv3G5cIAn
	Jt2uqpbInfdhHW458LwiPIz78kL14vz2vUl7vSahLWqv5twb801Puy+XCgmIbTAu
	lHN9ogku/qOEiebuoS7ED70Sda+oNWQLfeARM4QRQL6AxANJhemDLazImrYEcU6w
	0NJiuWEuaZcWJVDG4xuyZ/6KdQa9++9b1fiy/UD7u2F+eMppzOaF+t7F/mKH2SoN
	/hIowl3rZUtiWiWAwKFQsFJTTt/sDQV4if9o6HhwpkghgivoNxpeVmproVlvFFN/
	jEV8PX3DMxE0DLasw7NruOA91lgwxQX5ASJTNuwYl9EgEPc28Jkpsfw7VpiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769448275; x=1769534675; bh=LWWDql48IZ1VwA/Cq+VsKE6kXvwG/0YyTjd
	Iqs03ZuU=; b=RG6aVPxkNS3wOjJuSeO2rIVpxpViGtRm6BOd5KaB4gu+BF1Gg6X
	gbB+ODGUmnyShSVeloekem8LfXHgBaGEW2GvzfRj/FzlpLHbk/YD+iPWIwWlf1r9
	0DCHSjicHQ/DQRsvk9UoPUIsOVhskedguFqiRfnLlaBAfeXerEpVVDYupQfWHR38
	DZNEmb0kDOUqh+C+f8MIW7Q63/RFpE8mdfy0LnKohZRQdSH7g8KuRf9xmxKlRHZU
	bsL9Iw/MBGG8nc1HdQM0k4VKZric8l5x2Qr0BU1ibkAfxHdqBF8aaqV0U9C99ovX
	MICUQEXSgQFIx/SfVH7tkBjMmBpCfT8HZWQ==
X-ME-Sender: <xms:UqN3aeyoEmVXslXuZLtTXoaQcLSgaYYQDXZSuARJBY80QHWl3B4N6Q>
    <xme:UqN3aTlkMxIyfLRo6HP-iz8Alzk1VRl0DRG6hnQJzrd7DMvFzvGkkwpJ1XMunDnki
    l-Zdbaycpt3GegffPzGYZQ1DmZaTohSTHNP7NvgS9sMSJtFRp5O4u4>
X-ME-Received: <xmr:UqN3aXmx7iSFeoELMNrqTnSv7sodq0UehNDmxGDY_kQBDy6fxRMeDz4fUQYWDSI3EScL6lT8TdMRnHbU2VIE4zIG5Oo6q8pdruBwPfJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefpihgtohhlrghs
    ucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrh
    hnpefgvedvhfefueejgefggfefhfelffeiieduvdehffduheduffekkefhgeffhfefveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtoh
    esfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheptggrlhhigihtvgdrphgvrhhnohhtsehgrhgvnhhosghlvgdqih
    hnphdrohhrghdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopehjfhgrlhgvmhhpvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UqN3aVxl0EUs48lUZDWzjc1ve74dpfGZfVcITwgM-HLVrIGLdB7jeA>
    <xmx:UqN3acpGpDsJTkWkw7OMt_hB4KZujqb7BO-pl9XEe_c2F2ieqs_bfg>
    <xmx:UqN3aU6kkWnnj3bn2GGBiJQrtc72dOHYkqw3uLO9XQdj2xQMKQsr2w>
    <xmx:UqN3aTflzNMjof0_Oz3uQT91tn6z20wfiHrkKhnduM2K3koNhpxv2g>
    <xmx:U6N3aQo34_ZemCV80FOCyOedUNxMlImUvmWg1_S6BslNwe_UM5r9mz1e>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 12:24:34 -0500 (EST)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id AACA6150FE9B;
	Mon, 26 Jan 2026 12:24:33 -0500 (EST)
Date: Mon, 26 Jan 2026 12:24:33 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jocelyn Falempe <jfalempe@redhat.com>, Jiri Slaby <jirislaby@kernel.org>, 
    Calixte Pernot <calixte.pernot@grenoble-inp.org>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Add enable module parameter
In-Reply-To: <2026012620-retool-gloater-6cd3@gregkh>
Message-ID: <28snspp2-3912-rs5o-04s0-1648504sq90r@syhkavp.arg>
References: <20260126092234.713465-1-jfalempe@redhat.com> <2026012613-cotton-jellied-b67a@gregkh> <48be84fb-bee4-4a22-bde4-0d0c78282f80@redhat.com> <2026012648-vantage-mummified-2a43@gregkh> <45526d98-57b6-456e-babc-61b7331318c0@redhat.com>
 <2026012642-threefold-atypical-a3ad@gregkh> <99371939-e9b2-4114-8e27-e605ebf941de@redhat.com> <2026012653-designer-capably-d575@gregkh> <286bfe2e-796e-4c71-a75c-4967450edaab@redhat.com> <2026012620-retool-gloater-6cd3@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fluxnic.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fluxnic.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12539-lists,linux-serial=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,syhkavp.arg:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fluxnic.net:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[nico@fluxnic.net,linux-serial@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 76DC28B6CC
X-Rspamd-Action: no action

On Mon, 26 Jan 2026, Greg Kroah-Hartman wrote:

> On Mon, Jan 26, 2026 at 02:05:36PM +0100, Jocelyn Falempe wrote:
> > I think that one of the reason, is that if you switch off VT, of course some
> > users will complain, as it has a lot of implications.
> 
> Again, that's a distro's policy decision to make, don't force the kernel
> to support a wishy-washy distro's decision :)

As a daily VT user for my primary Linux interface due to accessibility 
needs, I'm baffled by the idea of distributions removing this support. 

Of course this has lots of implications. For many users with 
disabilities, VT is not optional - it's the only _fully_ usable 
interface.

Consider this my official objection. Just don't do that.


Nicolas

