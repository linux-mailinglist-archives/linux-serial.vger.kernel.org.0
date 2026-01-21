Return-Path: <linux-serial+bounces-12486-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEhiKY7mcGk+awAAu9opvQ
	(envelope-from <linux-serial+bounces-12486-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Wed, 21 Jan 2026 15:45:34 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF83589A3
	for <lists+linux-serial@lfdr.de>; Wed, 21 Jan 2026 15:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70DCB6A6AEF
	for <lists+linux-serial@lfdr.de>; Wed, 21 Jan 2026 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56DC30F547;
	Wed, 21 Jan 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ASnqlzt4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYcni2pH"
X-Original-To: linux-serial@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044024E4A1;
	Wed, 21 Jan 2026 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003861; cv=none; b=eqqrFt5RgjMMK5oZ5VHYuLKWCV5dh9U+lF6LBmLkXYCYfDzgovIfZdmZbEtqIhqBkN8yYDPY94NWtymuR47/EBkJRJEIokOD9+SVgJeG42nQENJqcprv3J03wKOaS7barqH+DPIYkDPWH6YhFSxwiiDSCkbN8PupF/gnMBK1Z54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003861; c=relaxed/simple;
	bh=wSPdDkmaR2oLTKdM5UZFvldkjCJjlp8RfQU/vVzwLZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiGN2z43YACy1G12+CBG15dn8Pa/kuzkOKCjGPt5vOzZx/s33CpnLiqdOl3rfmOuJrC93eGEP1mtwhc4P1d4pFa4uNMF1p7GWu3QtLhJrZ1323CYr1gX0lK+KvoPhzMMKu+0eLk6SphaX3Zz1XhxkqCthD/yJ2eru70gKBkqbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ASnqlzt4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYcni2pH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Jan 2026 14:57:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769003858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XtaOIk/r681dTPWE+vL6KdTw0FgtZxHPlUAckidcxY=;
	b=ASnqlzt4GcV1oVN8LfPOrlMDm5BxCEhO+WcxckWt50kHOXfonmQXgdqr8jQo1OuLBZ7Nxc
	cNSM7GSdc2KGNgjFcZrf3o3Xvmd8E2S/ZiYNga2H0KxU/mdJrYtzgQJSt4Ebhrc2JAMthJ
	gkEKQYO40C4GZJR8MDram7OIDcQkT4NS11tOWPxghQm28rQ8Uvr3yaSNdpuLykrNTGOevL
	RnHAR+htW4jiUYK1NVqi5ZZ4yMu3vXkNqH/5jUUg5Vi1lqRnBF5LCvBCzLs96qjLvjVa8p
	Nz6zheqVF+8OWs47Zh6gd5SsOSbkSNK4jkfIf3scYf8G9dwvOEiPSMHMp/4OPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769003858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XtaOIk/r681dTPWE+vL6KdTw0FgtZxHPlUAckidcxY=;
	b=MYcni2pHVylUTmaae9KyjpwHZtrHI3VOHI7rLrb4mw4xgaDYEVHy7QAXA8GgGT5sDcMdd6
	RzrB1J1rQrPgk0AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Subject: Re: printk's threaded legacy console + fbcon => schedule where it
 should not
Message-ID: <20260121135737.K7b-4M5r@linutronix.de>
References: <20260114145955.d924Z-zu@linutronix.de>
 <20260120110845.2922a91a@gandalf.local.home>
 <aXDYEVlkFgxdSVSG@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXDYEVlkFgxdSVSG@pathway.suse.cz>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	FREEMAIL_CC(0.00)[goodmis.org,vger.kernel.org,linutronix.de,chromium.org,linuxfoundation.org,kernel.org,ffwll.ch,gmx.de];
	TAGGED_FROM(0.00)[bounces-12486-lists,linux-serial=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6FF83589A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-01-21 14:43:45 [+0100], Petr Mladek wrote:
> I know that there was a plan to get rid of cond_resched().
> But what is the status now, please?

It is slowly moving => https://lore.kernel.org/all/20251219101502.GB1132199@noisy.programming.kicks-ass.net/

> I still see more that 1k cond_resched() calls in the code:
> 
>   $> git grep cond_resched\(\) | grep "\.c:" | wc -l
>   1263
> 
> And config PREEMPT_VOLUNTARY still talks about the explicit
> preemption points.
> 
> > Should we just remove it and see what breaks?
> 
> Honestly, I do not feel comfortable with removing it. It is true that
> it has no effect in the printk() code path. But the vt code is used
> also when working on the terminal.
> 
> The vt code still uses console_lock() because it was intertwined
> with printk console code since very old days. console_lock is a kind
> of big kernel lock there.

Do you a have path which loops and would mandate it? I found a few which
do not matter and have their own cond_resched() around. So I don't see a
reason to keep it. And I found one which breaks things so a removal
makes sense.

> Alternative solution is to get rid of the spin_trylock(). The only
> purpose is to prevent race in console_flush_on_panic(). It used
> to be a simple bit operation. The spin_lock() was added just to
> get barriers right. But we have a great atomic_t API these days.
> 
> IMHO, it is a win-win solution because a preemptive context is
> always better.

So why do we keep warts again? Just because it *might* be required?
Keeping things preemptible makes sense but this is locking with no
annotation what so ever.

Again. printk has its cond_resched, the tty has it, too.
I'm with Steven on the removal side.

Sebastian

