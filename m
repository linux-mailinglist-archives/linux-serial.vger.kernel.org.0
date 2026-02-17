Return-Path: <linux-serial+bounces-12728-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sL3tIdITlGlf/wEAu9opvQ
	(envelope-from <linux-serial+bounces-12728-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Tue, 17 Feb 2026 08:08:02 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B76149204
	for <lists+linux-serial@lfdr.de>; Tue, 17 Feb 2026 08:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 739FE3015738
	for <lists+linux-serial@lfdr.de>; Tue, 17 Feb 2026 07:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1042C21F6;
	Tue, 17 Feb 2026 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NAAYlrD/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IvE3jiB/"
X-Original-To: linux-serial@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165952BCF5D;
	Tue, 17 Feb 2026 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771312079; cv=none; b=erEDHM4ymX0UWj/SfmaHO80MYcD6J4wWw7U9ZtN145VIdgUq2xe7VfyNKJl7V2ew/MjZM7dRuJ/pKPUpgxYz27l7DjRPOqSwNEmXehriU9ksQeDta+p9X2l5dDnzJusC4q/i7g71SThUwqK5uGVO0B3M2k9hHNcMZtPWZUvrL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771312079; c=relaxed/simple;
	bh=4pRFY6G60I0r+UOtFLu3ntd6y7DabgtdX73gpV9QRpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdceE2qOCxlRrFuBlRElwGFCykc9d2iC59YNluwDrFQIrku64tVCeOuLK7WR0AVV0AxYMYDJjlvxKSAVx0xemvinNm5Bmsz5r2goanTzpQHFkQvZO90TkU5jJbGJtXozKYM15MkZZTXt1YOTCTfwJGfjH40O5jHM8IYtcaZ6kO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NAAYlrD/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IvE3jiB/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 08:07:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771312076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4pRFY6G60I0r+UOtFLu3ntd6y7DabgtdX73gpV9QRpU=;
	b=NAAYlrD/Rae99xXpUzk0gHDQV6J4m0jotKlUIElrsFSDc9NvihK+LGMyk5xkQn+P/y2fnu
	gtFmsT+sZVh/mbifvboKS6wynSTLbZ7KrnONLTrRxU5u+Um/oh0paw9E6I42PI5LefKVsC
	/VkYQ+m5MCOnlT4fyGDjrS9mU9EjF4jXUp46k8uIgruiMpik/RmVNcXBJZUvey2mKfsRjm
	+eIRTlftkI1zqH5zXTWpbrEznE48+w8LDzFIFEQ1An7nskgdqSL7giK/LbZSnftn1oF5oz
	NiQGrcbKJLoeyk2Vku0Oq62bCgqQoSzW6sunlsnMy2tAR1pMKe1t1GO1t9AwPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771312076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4pRFY6G60I0r+UOtFLu3ntd6y7DabgtdX73gpV9QRpU=;
	b=IvE3jiB/J2UiyTGawTyvPv8uMfY+bRg/qy9GtG9wOwdR+MNtLibli8ruFdImvVfwQtzA5u
	zMhzL44n0xoulPDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Clark Williams <clrkwllms@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: printk, vt: sleep from invalid context bug
Message-ID: <20260217070754.Y4BolmnM@linutronix.de>
References: <87v7fwdsln.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7fwdsln.fsf@yellow.woof>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12728-lists,linux-serial=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-serial];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8B76149204
X-Rspamd-Action: no action

On 2026-02-17 09:14:12 [+0700], Nam Cao wrote:
> Hi,

Hi,

> Since commit 1bc9a28f076f ("printk: Use console_flush_one_record for
> legacy printer kthread"), I see this warning:

https://lore.kernel.org/all/20260126180836.SNCdMW2f@linutronix.de/T/#u

Sebastian

