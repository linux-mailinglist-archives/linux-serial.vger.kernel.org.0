Return-Path: <linux-serial+bounces-12528-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHeNN0tAd2mMdQEAu9opvQ
	(envelope-from <linux-serial+bounces-12528-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 11:22:03 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FA886C09
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 11:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EEF7302E430
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4EE329E47;
	Mon, 26 Jan 2026 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vmGqoAUM"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7982C11F3;
	Mon, 26 Jan 2026 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422824; cv=none; b=FPKWsbLgW35kef1uCmfEAOIOPMLtfth54dkE0E+7UqWY68YhXOVzSvX51hIfJI1NYehqLX7uUCDi15hyGgzFI5+XjrINXZcBTNeIvWcjaRBLyLe1WeUloMlYJmAaxMqirwbnaRE8XtM+TTJZzHQp4DHfbOz8zqWboYI2FYOpKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422824; c=relaxed/simple;
	bh=3Qjxcn0PwBkzPv88WTwPwBNc0qOvf7TEIuRjsKBYNRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORX46ANqTq/GlqWn1kL3tZTpu3cMt/McI3AijDhOtongoMj1sHNw8tNvJw0uM30KMem4zMfCDx1aKCp5LTaBbQE7mntjzoKJaffXRUkKFgidwbt5hdemXOH7I7kLw4yiKv9eU9hi1ahWWpdXA+nmS0TqL7Ju2tNiabpgjotSTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vmGqoAUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1588CC116C6;
	Mon, 26 Jan 2026 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769422824;
	bh=3Qjxcn0PwBkzPv88WTwPwBNc0qOvf7TEIuRjsKBYNRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vmGqoAUM7J7Xc7xHnIDb9CpAfNik3zuoxIYKkxcFoa2yaIm+Q/55yv8s60lmdulG7
	 BW+SR6KZ0gSQJjtRrAUZLAx4AlNaT3rTZUsG+snsc2Q+886V7De828xLbPbtnUUGil
	 qD3E6P4xn3U7IlMspkoWBwCXXtTzwSLEEGy4PJkg=
Date: Mon, 26 Jan 2026 11:20:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Add enable module parameter
Message-ID: <2026012648-vantage-mummified-2a43@gregkh>
References: <20260126092234.713465-1-jfalempe@redhat.com>
 <2026012613-cotton-jellied-b67a@gregkh>
 <48be84fb-bee4-4a22-bde4-0d0c78282f80@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48be84fb-bee4-4a22-bde4-0d0c78282f80@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12528-lists,linux-serial=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,neocities.org:url,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 40FA886C09
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:43:35AM +0100, Jocelyn Falempe wrote:
> On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
> > On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
> > > This allows to build the kernel with CONFIG_VT enabled, and choose
> > > on the kernel command line to enable it or not.
> > 
> > This says what is happening, but not why?
> > 
> > > Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
> > 
> > Why are we using a 1990's technology for a new feature?  What is this
> > going to allow to have happen?  Who needs/wants this?  Who will use it?
> > For what?
> 
> The goal is to ease the transition to disable CONFIG_VT.
> 
> So if this is merged, you can boot without VT on any Linux distribution,
> without rebuilding the kernel.

But that's a distro-specific thing, the distro should be enabling or
disabling the option as it needs, it should not be a user-configurable
boot-time selection option as userspace depends entirely on this either
being there or not.  Why would you have a kernel with both options but
userspace without that?

> This option will also allow a distribution to disable VT by default, but
> users that really wants this can enable it on the kernel command line,
> without rebuilding the kernel.

Why would a user want that?  If a user really wants it enabled, why
would userspace even still work and why would they want to not rebuild
the kernel?

> It will also avoid hacky solution in userspace like this:
> https://overhead.neocities.org/blog/systemd-logind-seat/#very-hacky-solutions

Surely that can't be the only way, why can't userspace just handle this
"properly" if it wants to?

> > > Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> > > ---
> > >   drivers/tty/Kconfig | 13 +++++++++++++
> > >   drivers/tty/vt/vt.c |  5 +++++
> > >   2 files changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > > index 149f3d53b7608..2b94c2710687a 100644
> > > --- a/drivers/tty/Kconfig
> > > +++ b/drivers/tty/Kconfig
> > > @@ -41,6 +41,19 @@ config VT
> > >   	  If unsure, say Y, or else you won't be able to do much with your new
> > >   	  shiny Linux system :-)
> > > +config VT_ENABLE
> > > +	depends on VT
> > > +	default y
> > > +	bool "enable VT terminal" if EXPERT
> > 
> > So no one will ever really use this config option?
> > 
> > And you are doing 2 things in this patch, not just one, unlike what the
> > changelog said :(
> 
> I can split that in two if you prefer.

I'm objecting to the patch doing something other than what the changelog
describes, which as you know is not a good thing.

> Adding a module parameter, and adding a Kconfig option, to choose the
> default for this module parameter.

I really don't like adding new module parameters that we are going to
have to now support for forever.  Why not just rely on the config option
being there or not as-is?  That's why we allowed it to be turned off at
all, because userspace was going to be moved to not need it anymore.
Why would we want to support "both" at the same time in the kernel?

thanks,

greg k-h

