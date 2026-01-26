Return-Path: <linux-serial+bounces-12526-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B+zIGY1d2nhdAEAu9opvQ
	(envelope-from <linux-serial+bounces-12526-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 10:35:34 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F15D286168
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 10:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8519300820F
	for <lists+linux-serial@lfdr.de>; Mon, 26 Jan 2026 09:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200DA329C5A;
	Mon, 26 Jan 2026 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R6gsH/Af"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1F3019C5;
	Mon, 26 Jan 2026 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419992; cv=none; b=S7dM6M9gND115fDkLKF5hbU82QV+0g3q9yx712x6OVTxhi0413PlLHFVCYQjtZ5Lpknp+MGMLZuSI4DTheGNJjmQ2LxFMcQ7eJJYES+FE9uLeLzKFA0b9almiP0mI++T52YFf9pkcAxkupTFi4Vt/i7gzXAfKUB0fUR4gb9y69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419992; c=relaxed/simple;
	bh=PS5mbIMuADDlufHPrnaGyWbJ4OxAS8gn1/pM0v3KfYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqnBbfLwEWdXhawcvt5j0IcvGRwRU5HtvKcEg26p1QEmKtXm044aRJt5uBIXEnXixx5sMdIgCDZkdRLPAm6QabWQ8917cW855XOoLZrl06xoMYF9f1S19If7T8hmJxMJQ5PerwHpRJLfHaDMDP1EocEQT0MsvinQfCvt3qbqFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6gsH/Af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3E0C116C6;
	Mon, 26 Jan 2026 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769419991;
	bh=PS5mbIMuADDlufHPrnaGyWbJ4OxAS8gn1/pM0v3KfYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6gsH/Af0jcCLaDhut9lUdds0pzT3XP3M8Fkyufp48cyY4RF85FpzwqFYd2iTlkGL
	 UjeLR0fkQxECuKthOvsMI73e18iB7KobmcZvEjjUh19G1MWsxvA8rGVywTEMQhcLDD
	 hRwoFOn0sCQ34ApcLEgFj4j7QI7fnvKIgc2J94mg=
Date: Mon, 26 Jan 2026 10:33:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Add enable module parameter
Message-ID: <2026012613-cotton-jellied-b67a@gregkh>
References: <20260126092234.713465-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126092234.713465-1-jfalempe@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12526-lists,linux-serial=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-serial@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: F15D286168
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
> This allows to build the kernel with CONFIG_VT enabled, and choose
> on the kernel command line to enable it or not.

This says what is happening, but not why?

> Add vt.enable=1 to force enable, or vt.enable=0 to force disable.

Why are we using a 1990's technology for a new feature?  What is this
going to allow to have happen?  Who needs/wants this?  Who will use it?
For what?

> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/tty/Kconfig | 13 +++++++++++++
>  drivers/tty/vt/vt.c |  5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 149f3d53b7608..2b94c2710687a 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -41,6 +41,19 @@ config VT
>  	  If unsure, say Y, or else you won't be able to do much with your new
>  	  shiny Linux system :-)
>  
> +config VT_ENABLE
> +	depends on VT
> +	default y
> +	bool "enable VT terminal" if EXPERT

So no one will ever really use this config option?

And you are doing 2 things in this patch, not just one, unlike what the
changelog said :(

thanks,

greg k-h

