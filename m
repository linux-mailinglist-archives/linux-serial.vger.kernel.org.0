Return-Path: <linux-serial+bounces-12657-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IbqHFAviGlskgQAu9opvQ
	(envelope-from <linux-serial+bounces-12657-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Sun, 08 Feb 2026 07:38:08 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D8F108054
	for <lists+linux-serial@lfdr.de>; Sun, 08 Feb 2026 07:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C5393012C55
	for <lists+linux-serial@lfdr.de>; Sun,  8 Feb 2026 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF22D345724;
	Sun,  8 Feb 2026 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NNM1wJlH"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6A328B44;
	Sun,  8 Feb 2026 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770532684; cv=none; b=KCuJ6Lw5LpMj1rhw9sSa8KEzm4TcPlvWaDCC2oVI6MuE3FHwqHORGaEmZqJ4yzaqtzFSU72TEhADKzNGqRBE7+wA3jo3JWU/SV3/bRQ4lwav1KTmA+PwqEwByO6OoafvAW+ADmMxkv3bvM5FblDVww84eitJToeND2nuKrhPwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770532684; c=relaxed/simple;
	bh=XglIxpNMd3ZSm3gbbGnRlGz3p059cuocuimlbD4gsts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD+Fhkd33pT55wnM8R78Lxp3pOgPIkYt73SFcIKphnhZjVAore0iQTyIXgouNoq0nUPiYfVrijM7ASZjlP2NkznKCOVgpN+ca0E9O33C3Y5TDlxGm1NUJvWegQ3dVTDlNqFBlDUvNrcwkfUjktnPCSIIpJOboRgBnuxaVFCfXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NNM1wJlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB13DC4CEF7;
	Sun,  8 Feb 2026 06:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770532684;
	bh=XglIxpNMd3ZSm3gbbGnRlGz3p059cuocuimlbD4gsts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNM1wJlHEYKw0NU7qTDiSzYDGnnc0PApbE+HVBQbVbw+hE/GyW4yE8qIltrTDGjLl
	 HUsZaqCgt6ddhzzF45S9L9qBPDQXghr9HFHc+VKEjFFwsRbM9FQ/ZsvVF1bYWWOpKW
	 usgBUWHXU+RKyipiKgYc6oA2UAmTGF0slNPCEeL8=
Date: Sun, 8 Feb 2026 07:38:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	jikos@kernel.org, dsterba@suse.com, jirislaby@kernel.org,
	kuba@kernel.org, alexander.deucher@amd.com,
	akpm@linux-foundation.org, pkshih@realtek.com, tglx@kernel.org,
	mingo@kernel.org
Subject: Re: [PATCH] tty: ipwireless: Fix use-after-free in tasklet during
 device removal
Message-ID: <2026020828-unretired-mannish-8465@gregkh>
References: <20260208062538.29608-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208062538.29608-1-duoming@zju.edu.cn>
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
	TAGGED_FROM(0.00)[bounces-12657-lists,linux-serial=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,zju.edu.cn:email]
X-Rspamd-Queue-Id: C5D8F108054
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 02:25:38PM +0800, Duoming Zhou wrote:
> When IPWireless PCMCIA card is being detached, the ipw_hardware is
> deallocated in ipwireless_hardware_free(). However, the hw->tasklet may
> still be running or pending, leading to use-after-free bugs when the
> already freed ipw_hardware is accessed again in ipwireless_do_tasklet().

Nice, do you have this hardware to test this with?


> 
> One race condition scenario is as follows:
> 
> CPU 0 (cleanup)               | CPU 1 (interrupt)
> ipwireless_hardware_free()    | ipwireless_interrupt()
>   ipwireless_stop_interrupts()|   ipwireless_handle_v1_interrupt()
>     do_close_hardware()       |     tasklet_schedule()
>       synchronize_irq()       |
>   kfree(hw) //FREE            | ipwireless_do_tasklet() //handler
>                               |   hw = from_tasklet() //USE
>                               |   hw-> //USE
> 
> Fix this by ensuring hw->tasklet is properly canceled before ipw_hardware
> is released. Add tasklet_kill() in ipwireless_stop_interrupts() to
> synchronize with any pending or running tasklet. Since do_close_hardware()
> could prevent further interrupts, place tasklet_kill() after it to avoid
> the tasklet being rescheduled by ipwireless_interrupt().

How was this issue found and tested?

> Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

No CC: stable?  Why not?

thanks,

greg k-h

