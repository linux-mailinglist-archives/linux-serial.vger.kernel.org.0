Return-Path: <linux-serial+bounces-12564-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ3lLqbQeWk0zwEAu9opvQ
	(envelope-from <linux-serial+bounces-12564-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Wed, 28 Jan 2026 10:02:30 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0C9E931
	for <lists+linux-serial@lfdr.de>; Wed, 28 Jan 2026 10:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B360B301F153
	for <lists+linux-serial@lfdr.de>; Wed, 28 Jan 2026 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9537933C515;
	Wed, 28 Jan 2026 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SV+SE//Y"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911AE337BAA
	for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590929; cv=none; b=NilBu1rXNlNtgPROH1m2gnpckDd3O+FJON1AY1fOl6cH8jVvujVTlthdnrXbYOP9novWwVOiab7B8fhioKW9wg7sH9GuTvmEgF4pj4b/mtqkUQWf8nNbW1NjAqLRdEJEAI5VZEZKRESZiGEC8vGfkfb3QmC2soWquRqWKhrOJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590929; c=relaxed/simple;
	bh=1GPlGKZgcb1DldoonD0OPHNoXEsNDWUi3TBlJQ2/goc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8Urbhy7jYO+aW04n6SDh4zs5tMahUYol9dcJLIq69V3XspOLut6Y/xi4/OKrdyn1zDz7HcGRqCxydCHf2dS4vOejbz7UdW3SgyOyYzXHFRJlqKeSwJnXQrrKvBINaXX/7amWmC517cHGTPOfTQzQES1JGdhKefWiiF77uoeZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SV+SE//Y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-480706554beso2862955e9.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 01:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769590925; x=1770195725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qAOxIVYTEue9E0jsTADeINvfipVSQ2+6/g8YDctDKvU=;
        b=SV+SE//Y+5F3DksQv4y6lLM9JJhsuUk/LhKy1Z2iWviotqjZvZRuzivoJAUf4WS3pY
         HXaqPlqKFg2/zrSeftU2o/v6EYfI2efFxfwo8qFEf0oTjNaTXvxBDOdHtI9B4L+8IAxi
         PYs4KrRfSDTZvynb7RAzB6zzHXMGXPrKYqR9QRrqy1OS3QHDqgZK1i3DyIpSGDVXYjvq
         eWZmn6QbqnjdQf7mCyU/tMXpXux1KAdLdQ2mtL6KXp0WcaoLrNyitgrCbhSbO3VArfCH
         YoG9Hk3U8FOsTpoaFA+zTMu8bZDgVTlKx3rAK67wJ58HUos1YqQpRV0FK1Yu7O+iAIRW
         GZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769590925; x=1770195725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAOxIVYTEue9E0jsTADeINvfipVSQ2+6/g8YDctDKvU=;
        b=W8W+gFMXTKgcQ16ND4tgeUU5e0ZBh/xu9fQ/5HzvzgsBjk0frnRodNFukUOlfOvIvf
         xW5B070kRGg6pYlJIlwMvOtsBhUyZSJd9vxauXDUaOop1a1pUiCPZ/ZoDDXSp8SIs1Ti
         qXjbCU3pyuUHRVaCC0GiagwBurUBKhldH8qRvRPC17I63rAMkZPeM3m1AgAPhSSKM7Ml
         zzVUzQuwLPPfCfVqZl9unHFO5pJTZExbI21hFEHgTuA6ZJxO/yQbYdEQ6oTrj+qWRLPJ
         La7SNeldIIbuKDsh0rLpz7+HswS/xj1VglOI1HDSWbl7/EgahgT8PDFKdTkg61AXZCjs
         mNIg==
X-Forwarded-Encrypted: i=1; AJvYcCVmg59rHFf+qzosm/1mHd9Lbb+kwuunlxXurpNXhcNE62K+PwH9pTRqYxCdQzVN3jfPPnxUeIK9ahcxado=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPV7/lfml7kXVzDJ3VUK8tQyagqBeGbLa0wzOyO+osNjTnPyJk
	UEDaoHjveXw5hg8pEPAl8G6nkZxgLMtebOMkhLpwT1PKEch/NSmLVA9F5VR2ccBKWRo=
X-Gm-Gg: AZuq6aI/YoTaikAiMvSvKlaWxH03rf9HYB1aUZ9mWmrN3ng9dKFs2mvfk0vOqSEOPYM
	hJH9m20Pfryd52Mj/IdRFQk/LqM6SopR2p6K8Q1H+f/F+SN0S15G8q2KMS3BxHQbMFW1dTSKxje
	Q9Hl24jMXTQ6kyiOeOrWcb1muAQtZqrJm201tp7Ou8sUQy9SWO1iFUF0Jp3QwjYm1hMbk7s2k4g
	4ggosIzFzMlEBk37RhlYOFQFePE+Wb4CKD2mbjdz40BDrJgYSoJL1gv4VV2toBstuII1z5NBZ9W
	Hn8bFM1B/MaMqadf28w1btwe1Ndxs24beDp9nWamXSKaSiL/NhSMwFa1576hJQR24ePxK37MmrW
	TclA7jcm2fjr6yZCC7upeEQDbq3RfzxPD3nRE13v16SPQeKo1DEeZ68Decj3V8HlcS6GwVXjm+D
	0FdJwCw4/u2dF3Gw==
X-Received: by 2002:a05:600c:3154:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-48069c1a7ebmr50821355e9.11.1769590924606;
        Wed, 28 Jan 2026 01:02:04 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm122234435e9.4.2026.01.28.01.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:02:04 -0800 (PST)
Date: Wed, 28 Jan 2026 10:02:01 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] printk, vt, fbcon: Remove console_conditional_schedule()
Message-ID: <aXnQiSBskXo4RDAL@pathway.suse.cz>
References: <20260126180836.SNCdMW2f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126180836.SNCdMW2f@linutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linux.dev,goodmis.org,linutronix.de,chromium.org,linuxfoundation.org,kernel.org,ffwll.ch,gmx.de];
	TAGGED_FROM(0.00)[bounces-12564-lists,linux-serial=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[suse.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-fbdev.vger.kernel.org:query timed out];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,linux-serial@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,lists.freedesktop.org:email,linutronix.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ffwll.ch:email,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: 3CF0C9E931
X-Rspamd-Action: no action

On Mon 2026-01-26 19:08:36, Sebastian Andrzej Siewior wrote:
> do_con_write(), fbcon_redraw.*() invoke console_conditional_schedule()
> which is a conditional scheduling point based on printk's internal
> variables console_may_schedule. It may only be used if the console lock
> is acquired for instance via console_lock() or console_trylock().
> 
> Prinkt sets the internal variable to 1 (and allows to schedule)
> if the console lock has been acquired via console_lock(). The trylock
> does not allow it.
> 
> The console_conditional_schedule() invocation in do_con_write() is
> invoked shortly before console_unlock().
> The console_conditional_schedule() invocation in fbcon_redraw.*()
> original from fbcon_scroll() / vt's con_scroll() which originate from a
> line feed.
> 
> In console_unlock() the variable is set to 0 (forbids to schedule) and
> it tries to schedule while making progress printing. This is brand new
> compared to when console_conditional_schedule() was added in v2.4.9.11.
> 
> In v2.6.38-rc3, console_unlock() (started its existence) iterated over
> all consoles and flushed them with disabled interrupts. A scheduling
> attempt here was not possible, it relied that a long print scheduled
> before console_unlock().
> 
> Since commit 8d91f8b15361d ("printk: do cond_resched() between lines
> while outputting to consoles"), which appeared in v4.5-rc1,
> console_unlock() attempts to schedule if it was allowed to schedule
> while during console_lock(). Each record is idealy one line so after
> every line feed.
> 
> This console_conditional_schedule() is also only relevant on
> PREEMPT_NONE and PREEMPT_VOLUNTARY builds. In other configurations
> cond_resched() becomes a nop and has no impact.
> 
> I'm bringing this all up just proof that it is not required anymore. It
> becomes a problem on a PREEMPT_RT build with debug code enabled because
> that might_sleep() in cond_resched() remains and triggers a warnings.
> This is due to
> 
>  legacy_kthread_func-> console_flush_one_record ->  vt_console_print-> lf
>    -> con_scroll -> fbcon_scroll
> 
> and vt_console_print() acquires a spinlock_t which does not allow a
> voluntary schedule. There is no need to fb_scroll() to schedule since
> console_flush_one_record() attempts to schedule after each line.
> !PREEMPT_RT is not affected because the legacy printing thread is only
> enabled on PREEMPT_RT builds.
> 
> Therefore I suggest to remove console_conditional_schedule().
> 
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Fixes: 5f53ca3ff83b4 ("printk: Implement legacy printer kthread for PREEMPT_RT")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Just for record. This change looks OK from printk() POV.
printk() does console_trylock() and calls console_unlock()
with preemption disabled anyway, see vprintk_emit().

VT code still synchronizes some operations using console_lock().
It is possible that some non-printk related operations rely
on this. But it is hard to say. It might actually be a good
idea to find it out.

Also I have seen many printk-related softlockups. But they
were always caused by slow serial consoles. I can't remember
any in VT code.

Feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com> # from printk() POV

Best Regards,
Petr

