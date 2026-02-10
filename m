Return-Path: <linux-serial+bounces-12678-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EUJHe7VimnrOAAAu9opvQ
	(envelope-from <linux-serial+bounces-12678-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Tue, 10 Feb 2026 07:53:34 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2705511786A
	for <lists+linux-serial@lfdr.de>; Tue, 10 Feb 2026 07:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BB1C3025F4E
	for <lists+linux-serial@lfdr.de>; Tue, 10 Feb 2026 06:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7F0329E4F;
	Tue, 10 Feb 2026 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NsOmj2nx"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3672EA151;
	Tue, 10 Feb 2026 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770706410; cv=none; b=BzjVh6kIQsmWyI+E/5EkAUakWBQtw1Z4TnYKjQXGxTF9dqUJF4+MT3Eb0+vHX5mVkNHooB+Dw5rqEUMOZXT31Wv8NdltC9pk9vpaAxUorO7Ldh06NQgyZYR7bCAAYmRxeqA6AwsyzvlFnl/7ovaXbt14jhoe3Se3sfJPBAC8z8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770706410; c=relaxed/simple;
	bh=xVXyYN7PILNq1uUB17W25uzrYNIffb8r/nrMJ+n7v3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5PcbCOsXh1LHqVYrFxO+kWT6qTGFAaavYydbkMmPxO6S6d6ZzqXpkXmPLciB0KbpMwnUw43sgeNW3QlRut8yfOuL76FmHA55V88lnm3bHx01xfVsKTviRpnOg4KAzduVZR6vfdLg86+gbW9dcNS+yH/8XrmBnUxoAvnAm1/17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NsOmj2nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F49CC116C6;
	Tue, 10 Feb 2026 06:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770706410;
	bh=xVXyYN7PILNq1uUB17W25uzrYNIffb8r/nrMJ+n7v3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsOmj2nxApzlEiKZJ+cOicAg+bGYoWCDYrK59L3kXSc7pI+GWI7/uQKJHRf51of+m
	 vUCvA26pySav8z1nxUw/c7Rr+fBAnJWwEXEmKeewqPtfxTCUel4tPEBUIJt7xu+CaR
	 KqGO4UYLskHbJVXo1cuH/ss0gkjsacr3o/PEJkHg=
Date: Tue, 10 Feb 2026 07:53:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] vt: add modifier support to cursor and navigation
 keys
Message-ID: <2026021006-reenact-suave-c86c@gregkh>
References: <20260203045457.1049793-1-nico@fluxnic.net>
 <2026020851-bullhorn-glitch-0e37@gregkh>
 <q19s9nr3-6o47-4pq9-7r49-8q25p0021o1q@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q19s9nr3-6o47-4pq9-7r49-8q25p0021o1q@syhkavp.arg>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12678-lists,linux-serial=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-serial];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,lkml.org:url]
X-Rspamd-Queue-Id: 2705511786A
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 11:22:27AM -0500, Nicolas Pitre wrote:
> On Sun, 8 Feb 2026, Greg Kroah-Hartman wrote:
> 
> > Argh, sorry, I saw this patch series too late for this merge window.
> > I'll review it after -rc1 is out.
> 
> Too bad.
> 
> But please at least consider  this one now
> https://lkml.org/lkml/2026/1/27/1886
> and queue it for the stable tree as well.

Sorry, that slipped through as well, I'll grab it after -rc1 is out and
get it backported to stable kernels.

thanks,

greg k-h

