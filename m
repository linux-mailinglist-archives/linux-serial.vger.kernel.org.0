Return-Path: <linux-serial+bounces-12659-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OcyG79siGmbpQQAu9opvQ
	(envelope-from <linux-serial+bounces-12659-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Sun, 08 Feb 2026 12:00:15 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BDB1086E6
	for <lists+linux-serial@lfdr.de>; Sun, 08 Feb 2026 12:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6687E300B9E4
	for <lists+linux-serial@lfdr.de>; Sun,  8 Feb 2026 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEAD346AD2;
	Sun,  8 Feb 2026 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="keorUYqh"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46217346A0D;
	Sun,  8 Feb 2026 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770548412; cv=none; b=uqIFi6O/aMzmIsWCUoK1sEsTuLXjsxv3MZ2IBzyRm+az+rLMw/CEzJPbNyOJJ9q+J6KmRpUpOJs6RTF8X9n/ZJy3feWsakMzws5w90CIpJwhiWXueojtuefm4WYL10ZWzJaWr+pMqfVbPWr6cy32GxcRk0eHcdcKKEk8k7CXKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770548412; c=relaxed/simple;
	bh=kcO3sL79yCwMDWMPkcCHsO4amKCRMLiBru3uGyKtGO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA8lLu2CLT7JZFap9hPIv1rOfXUV/du/J/mxSC49UhqriwA8d4vcFSmS+DxciXD2MqwSBocqVo/LBDAJOlLExiY13q2gVkJvYeCLxoGCetCfXdARWrNIGvGIwINNtkhmvaCs20pUSbVbSXdYw05mJLia+QBNePczU9J66U1OzQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=keorUYqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F949C4CEF7;
	Sun,  8 Feb 2026 11:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770548411;
	bh=kcO3sL79yCwMDWMPkcCHsO4amKCRMLiBru3uGyKtGO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keorUYqhkkBmg6QfeHCxJvTgAjd2u1fZRCummxY4yahyB1lbf7GkRCcV7oWWD1Tyy
	 ClKnG288hqCY3S/sBKqWntAFfz6kgvXyizaoelSUbRlM3Um5SUQBbrxjWTPckwgOr6
	 fPmmxnh25gp/mMOsZcIH2IppusDy2RgBlYb2JLC8=
Date: Sun, 8 Feb 2026 12:00:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: duoming@zju.edu.cn
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	jikos@kernel.org, dsterba@suse.com, jirislaby@kernel.org,
	kuba@kernel.org, alexander.deucher@amd.com,
	akpm@linux-foundation.org, pkshih@realtek.com, tglx@kernel.org,
	mingo@kernel.org
Subject: Re: [PATCH] tty: ipwireless: Fix use-after-free in tasklet during
 device removal
Message-ID: <2026020859-caretaker-duckbill-0fb3@gregkh>
References: <20260208062538.29608-1-duoming@zju.edu.cn>
 <2026020828-unretired-mannish-8465@gregkh>
 <41b47e38.6ddb4.19c3ccb8e4d.Coremail.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b47e38.6ddb4.19c3ccb8e4d.Coremail.duoming@zju.edu.cn>
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
	TAGGED_FROM(0.00)[bounces-12659-lists,linux-serial=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-serial@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0BDB1086E6
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 06:28:19PM +0800, duoming@zju.edu.cn wrote:
> On Sun, 8 Feb 2026 07:38:00 +0100 Greg KH wrote:
> > > When IPWireless PCMCIA card is being detached, the ipw_hardware is
> > > deallocated in ipwireless_hardware_free(). However, the hw->tasklet may
> > > still be running or pending, leading to use-after-free bugs when the
> > > already freed ipw_hardware is accessed again in ipwireless_do_tasklet().
> > 
> > Nice, do you have this hardware to test this with?
> 
> I don't have the real hardware. In order to reproduce the bug, I simulate 
> the IPWireless PCMCIA card in the qemu by allocating and configuring the 
> necessary resources(I/O ports, memory regions, interrupts and so on) to
> correspond with the hardware expected by the driver in the initialization 
> code of the virtual device.

I wonder if this device even is still around, given that pcmcia is all
but dead for a very long time.

> > > One race condition scenario is as follows:
> > > 
> > > CPU 0 (cleanup)               | CPU 1 (interrupt)
> > > ipwireless_hardware_free()    | ipwireless_interrupt()
> > >   ipwireless_stop_interrupts()|   ipwireless_handle_v1_interrupt()
> > >     do_close_hardware()       |     tasklet_schedule()
> > >       synchronize_irq()       |
> > >   kfree(hw) //FREE            | ipwireless_do_tasklet() //handler
> > >                               |   hw = from_tasklet() //USE
> > >                               |   hw-> //USE
> > > 
> > > Fix this by ensuring hw->tasklet is properly canceled before ipw_hardware
> > > is released. Add tasklet_kill() in ipwireless_stop_interrupts() to
> > > synchronize with any pending or running tasklet. Since do_close_hardware()
> > > could prevent further interrupts, place tasklet_kill() after it to avoid
> > > the tasklet being rescheduled by ipwireless_interrupt().
> > 
> > How was this issue found and tested?
> 
> The issue was found by static analysis. I test it through the following steps:
> 1. Simulating the IPWireless PCMCIA device in the qemu and enable it to trigger interrupts.
> 2. Controlling the removal and attachment of device via sysfs.

So this is with the bind/unbind logic, or some other way?  If you are
unloading the driver, that is something that only root can do, and this
is a debugging facility, not a "real" way to control drivers and devices
(yes, the virt drivers abuse this to no end, every time I see this I
laugh...)

> 3. Triggering interrupts by writing data to device registers via /dev/mem memory mapping
>    in userspace.

Interrupts would not happen if the device is removed.  Or is this only
if the driver is unbound?

> 4. In order to ensure that there are unfinished tasklet during the removal process, I
>    manually inject delays such as mdelay() into tasklet handler.

That's a lot of work for a piece of obsolete hardware, but hey, thanks
for doing this!

> > > Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
> > > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > 
> > No CC: stable?  Why not?
> 
> Thanks for checking, You are right, it should go to the stable.

Let's see what the maintainers of this driver say.

thanks,

greg k-h

