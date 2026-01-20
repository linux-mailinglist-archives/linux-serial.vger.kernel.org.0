Return-Path: <linux-serial+bounces-12477-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBZHJl3Ub2mgMQAAu9opvQ
	(envelope-from <linux-serial+bounces-12477-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Tue, 20 Jan 2026 20:15:41 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C134A1F8
	for <lists+linux-serial@lfdr.de>; Tue, 20 Jan 2026 20:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9352E9EE3C2
	for <lists+linux-serial@lfdr.de>; Tue, 20 Jan 2026 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE5C34E751;
	Tue, 20 Jan 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LwZRQQAT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jsctWo8O"
X-Original-To: linux-serial@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FE34D4CA;
	Tue, 20 Jan 2026 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928812; cv=none; b=A4tcEtC9hva92Wf332BeEKYb3jK3/zbboUKKIb0ncT0MZwdMDJSxjPaQp6X/OvJtJO9V64E3PPXixdy5jad2P35gGli8eAHpYUTij5Aqz0Bh8IIgSnx8vcSFTnVnPhn1cWwPFoqqInExGZL7LH21bQh6QFdCbmjY0WiYDQ++5r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928812; c=relaxed/simple;
	bh=dEvlUtxZI8Xu4sN9v8qOvDFNakR7FMiLucKHsMP/Xtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxuErDspfkvlfSGit/WLMdkwXW8Yyu1sZlJ6SB32xDQMhXSPRBZxVfkBD2/+Jb9CPb3ZJKR+LzEyNTeVXyUEB2nhKE2fZsAvyNbxLAB3fotPrcqEKeWqho+ZvKYOB9vl57bIUyXmksOoFn38uC/9ytTrzqasEr6+feak4h03GCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LwZRQQAT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jsctWo8O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Jan 2026 18:06:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768928803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OH02W9MmnmkSi6OKgfl51Ayf8ukDBvIRUey9mL5wHOc=;
	b=LwZRQQATLQZs2sJN0C+9ILbGmGcS5IbexcUdCzmz4BvyVvrk1yfuVnebaNJhgt6CWjn5Ra
	oq5clajxGvYFsd6XXcTH3ShaWNrryeC4Jt5aBZFQmsUyQktbGhhpIJeJT59+4gVwMWsenf
	y9hg2j75jpYEVsAQxm+TlrvoUWXHULolAMrh0WkD1dDZVXdjRm6Pi1NHLJgeG2r1JnQndw
	3w7OvlBV7YpCL0+PLBEa5FpOJoAVsmqC6oFKtE+GHK9KOqQpgIk7mA0rpdKasBTjuM/Z3C
	ZnXuXDeij983iWisYdRdpykFIMkkAQjHRvZ4s3Jv2MznR3MXmHZpZhqcY6d39A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768928803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OH02W9MmnmkSi6OKgfl51Ayf8ukDBvIRUey9mL5wHOc=;
	b=jsctWo8ONKzYjeOcRah+UmorTKxAHqeGuVMBb8+/4by29lAJPO3MRt2r7S/rGdyXfEYAt7
	DrC37KXr8GHxIvCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Subject: Re: printk's threaded legacy console + fbcon => schedule where it
 should not
Message-ID: <20260120170642.3V-1SE3J@linutronix.de>
References: <20260114145955.d924Z-zu@linutronix.de>
 <20260120110845.2922a91a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120110845.2922a91a@gandalf.local.home>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,linutronix.de,chromium.org,linuxfoundation.org,kernel.org,ffwll.ch,gmx.de];
	TAGGED_FROM(0.00)[bounces-12477-lists,linux-serial=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-serial@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 07C134A1F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-01-20 11:08:45 [-0500], Steven Rostedt wrote:
> 
> I'm assuming this likely isn't needed anymore. I don't know of any reason
> it needs to stay.
> 
> Should we just remove it and see what breaks?

I would say so.

> -- Steve

Sebastian

