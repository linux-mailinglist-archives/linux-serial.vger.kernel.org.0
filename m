Return-Path: <linux-serial+bounces-12535-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAX4HyRid2n8eQEAu9opvQ
	(envelope-from <linux-serial+bounces-12535-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 13:46:28 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CF2886F6
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 13:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0204C300B05C
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FFD33711E;
	Mon, 26 Jan 2026 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zulG9fyy"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A93370E5;
	Mon, 26 Jan 2026 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431577; cv=none; b=pbUjn2TSOBF51K4IzjT6MgUa3cOGst7E5i2ymv89rJxpXa8jDWCNJJBWeJB/na36Y8/mwx8CfLBSFPRCG9Q3yff7CWBJuMXn/C/TxbHo2v0+AaM/0j2v2KiQv2AHF/JKtxLiLmRYehtJV8U66ncfXlrYODrE9Wda+3cDU4ZrqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431577; c=relaxed/simple;
	bh=k18hCT2YpytEknYRaduTylJOgowbaIZE4KZSXA/VR18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzA8ka/eiZSgEToe4S++5CpQAYJonAc4cbMP5SOtLVSOju/ONa0LvSBWJ9rojqnJFdnaJ30syS4punAzRFe6Uel2MW3swpoqg1PDUSlZbOdkjqUQ4X6mDvEXdYSjkdqLcfpb3Zg1k4YBvM2aV9FNdZC5NFP/Fi2lgbnDgOfsTzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zulG9fyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E019C2BC86;
	Mon, 26 Jan 2026 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769431576;
	bh=k18hCT2YpytEknYRaduTylJOgowbaIZE4KZSXA/VR18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zulG9fyyzWdwTf51ApuMhC0r25/NqTYV9r3ebym2GbML+3uS8heB9Y/SuGzYngAZP
	 75g4R1tmXEQLuO3mb5eKgf4cFniVq2W94KWiBnRsFyT7ni5VmNBA6avZatDUGwx5Lq
	 yKs5mMiN+zg0T2ecA/2bn+LYAuC97fdPOMNbsKwM=
Date: Mon, 26 Jan 2026 13:46:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Add enable module parameter
Message-ID: <2026012653-designer-capably-d575@gregkh>
References: <20260126092234.713465-1-jfalempe@redhat.com>
 <2026012613-cotton-jellied-b67a@gregkh>
 <48be84fb-bee4-4a22-bde4-0d0c78282f80@redhat.com>
 <2026012648-vantage-mummified-2a43@gregkh>
 <45526d98-57b6-456e-babc-61b7331318c0@redhat.com>
 <2026012642-threefold-atypical-a3ad@gregkh>
 <99371939-e9b2-4114-8e27-e605ebf941de@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99371939-e9b2-4114-8e27-e605ebf941de@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12535-lists,linux-serial=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-serial];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1CF2886F6
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 01:26:34PM +0100, Jocelyn Falempe wrote:
> On 26/01/2026 11:59, Greg Kroah-Hartman wrote:
> > On Mon, Jan 26, 2026 at 11:48:50AM +0100, Jocelyn Falempe wrote:
> > > On 26/01/2026 11:20, Greg Kroah-Hartman wrote:
> > > > On Mon, Jan 26, 2026 at 10:43:35AM +0100, Jocelyn Falempe wrote:
> > > > > On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
> > > > > > On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
> > > > > > > This allows to build the kernel with CONFIG_VT enabled, and choose
> > > > > > > on the kernel command line to enable it or not.
> > > > > > 
> > > > > > This says what is happening, but not why?
> > > > > > 
> > > > > > > Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
> > > > > > 
> > > > > > Why are we using a 1990's technology for a new feature?  What is this
> > > > > > going to allow to have happen?  Who needs/wants this?  Who will use it?
> > > > > > For what?
> > > > > 
> > > > > The goal is to ease the transition to disable CONFIG_VT.
> > > > > 
> > > > > So if this is merged, you can boot without VT on any Linux distribution,
> > > > > without rebuilding the kernel.
> > > > 
> > > > But that's a distro-specific thing, the distro should be enabling or
> > > > disabling the option as it needs, it should not be a user-configurable
> > > > boot-time selection option as userspace depends entirely on this either
> > > > being there or not.  Why would you have a kernel with both options but
> > > > userspace without that?
> > > 
> > > Actually the userspace side works with or without VT, at least with Fedora,
> > > I've my Gnome session in both cases.
> > 
> > Great!  Then why is this even needed?  Who wants such a "let's not make
> > up our mind until we boot" type of system?
> > 
> > Given that traditionally the command line is a "secure" thing, that is
> > locked down by distros and orginizations, who would ever be able to be
> > changing this type of thing?  Who would want to support userspace that
> > handles both at the same time?
> > 
> > I don't see the issue here, if a distro doesn't want to support VT, then
> > disable it in the kernel and all is good.  If they do want to support
> > it, than enable it.  Don't do both :)
> 
> Maybe the real issue is that VT cannot be built as a module.
> That way the userspace would be able to load it only if it needs it.
> 
> That's probably more complex than my 3 lines patch, but I can try.
> Would you prefer it that way?

If that would make it simpler for a distro to handle this, perhaps.  Try
it and see, I think the last time this came up, unwinding this into a
module just wasn't possible, but that might have been a long time ago, I
can't recall.

But again, why wouldn't a distro pick a "this is what we are going to
support" line and stick with it?  Why would they want to support both?

thanks,

greg k-h

