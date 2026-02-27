Return-Path: <linux-serial+bounces-12811-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IXJF0BwoWm6swQAu9opvQ
	(envelope-from <linux-serial+bounces-12811-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Fri, 27 Feb 2026 11:21:52 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB021B5F28
	for <lists+linux-serial@lfdr.de>; Fri, 27 Feb 2026 11:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 455E8301FFBF
	for <lists+linux-serial@lfdr.de>; Fri, 27 Feb 2026 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9A13B52ED;
	Fri, 27 Feb 2026 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="em5jrlx0"
X-Original-To: linux-serial@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB53D1CBE
	for <linux-serial@vger.kernel.org>; Fri, 27 Feb 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187709; cv=none; b=ibwcUSAbqUYrNw7nX4Zdgzd30cYtMkiRpuB6RJ9VFDMMr2IYfz0kfQ+coAOJmWIZ8SUrQY8zxyDSD8YC9+LD4D9ptTu6snJOeC94AhIIpcHEuJCivU6iHpAvkM+zrcp2ZzBemGd0YO3H5ZoF42FYDzMaG2oXWmy3y1bO6SSEr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187709; c=relaxed/simple;
	bh=VBiYdkQoEqAHAdWh3vj0qeS1ckZVVsowH7HLju9ynZ8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZEC9GmViFCnCPukaYW65/+xUeOVerdWXvDsW7KDam9Sc1XbvUE+tNrT+HGZ6ZCL7Sh9zUyHCpxok6zX8uHb2meGzNr2csd79Szwj5chzE0k0q4lgI+BfZxaGq7qYhxAzj9b5XFbz2uM+31hmVrwRV9ncHCmhDDY3ZACrrrKj14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=em5jrlx0; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772187705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXfrCI3mgkpsLfqiAi5yqQBNesc4wEz0O2OqhGqmiwc=;
	b=em5jrlx0jNNNqBWv9XVE6blN1Q+yLqGSDL5BcZ6JPKMdVF5UXJpLcPIsjcfw/451If4qIC
	m2yHjlBqJ1whtCAx03klzEA+ioKoyCiS+ltEV+D2QReL/MqXS7FOIQUndDD3JtO9hNHfWk
	4uUsrBBsaAdiTPcUdbWCa5qqprNa7Ms=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] tty: vt/keyboard: Hoist and reuse variable in
 vt_do_kdgkb_ioctl
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <78bf91c6-8dd7-4c69-bd9f-61551990f02d@kernel.org>
Date: Fri, 27 Feb 2026 11:21:11 +0100
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexey Gladkov <legion@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
 Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4B0BE9EF-7A00-4DE0-B627-32B902E87D06@linux.dev>
References: <20260226123419.737669-1-thorsten.blum@linux.dev>
 <78bf91c6-8dd7-4c69-bd9f-61551990f02d@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12811-lists,linux-serial=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-serial@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-serial];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 9AB021B5F28
X-Rspamd-Action: no action

On 27. Feb 2026, at 08:22, Jiri Slaby wrote:
> On 26. 02. 26, 13:34, Thorsten Blum wrote:
>> Hoist 'len' and use it in both cases.
>> The last 'kbs' assignment is useless and a leftover from commit
>> bfb24564b5fd ("tty: vt/keyboard: use __free()"). Remove it.
> 
> No, kbs is set to NULL by vt_kdskbsent() when it should NOT be freed.

Ugh thanks, I'll drop this part then.


