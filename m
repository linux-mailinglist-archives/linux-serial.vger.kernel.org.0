Return-Path: <linux-serial+bounces-2851-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06C886714
	for <lists+linux-serial@lfdr.de>; Fri, 22 Mar 2024 07:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A112834CF
	for <lists+linux-serial@lfdr.de>; Fri, 22 Mar 2024 06:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5B6101DE;
	Fri, 22 Mar 2024 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="r7M/5C0j"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDFAFBF2;
	Fri, 22 Mar 2024 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090137; cv=none; b=fqzhnSuKUTbHvqinT+0Zm0LiBXgdvbtqP8RDXxcAiLN9+NkdqbennBKFb7RM0EVyF7bk+2a8pki43jIV5pOBx1V+OQgqBy5/WTbC/mFat8yNlrxsHGITVcl99uqkkH3SVvvC0+xog3gRsbaxnR0KNEuaZczaEWFpuXR0sTQC/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090137; c=relaxed/simple;
	bh=8Eepz+qxaMUM5Qg1zmuWcMPWkKYM9LnmBhHtrJqPpR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyXW/Oo/+RvkuUWO4iOxXNld2Pn/Us8n9w6pxE86RRLm6gMrQOWIHabT9WGwcfmacR1ssk4b0Vr0INMY1BqkQbPd0F87pDO7+jLAVEFUunYuLKGMNlL6pmlQ3nXdyFh41pBQQ+TC6gaepLl/c2KeMYSggcmU7qigPEXPNM/tVZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=r7M/5C0j; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 9E893604D9;
	Fri, 22 Mar 2024 06:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711090135;
	bh=8Eepz+qxaMUM5Qg1zmuWcMPWkKYM9LnmBhHtrJqPpR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7M/5C0jiD13hl3IF5a4KmEGBBynwg/IygpT7+KpJpYcu1zi7dWIqAUj4EG0HgQUa
	 sfSs32ScNtZK0dAqvB7M+Od9GFKDMJ+LmfUsVPysbi/uCpCN4pvT5CGxoPSeUfZDG7
	 SfrS2hixMgQJJ6l1tHpAqo3Fbr8bX74EAZMVHHkieq4cFR39M6elltf8eWs8WdEYiW
	 UbGcPy7hiI1vvRT9r3gmI/9SKetG4sFagQGpI+XyVKwj5qvypkhcBDBZCrelxwq/H6
	 KqRukZzdWbcbfHngVf++FC9/Y/KYsyrrilITXgtd+XiZ99XepP7RToP2WVfC5R9SWJ
	 zSmPSVAnDVOyg==
Date: Fri, 22 Mar 2024 08:48:43 +0200
From: Tony Lindgren <tony@atomide.com>
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	regressions@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: PROBLEM: Sun Ultra 60 hangs on boot since Linux 6.8
Message-ID: <20240322064843.GC5132@atomide.com>
References: <d84baa5d-a092-3647-8062-ed7081d329d4@draconx.ca>
 <20240322051531.GA5132@atomide.com>
 <d7337014-09ac-8a35-7159-e75ecd2707b6@draconx.ca>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7337014-09ac-8a35-7159-e75ecd2707b6@draconx.ca>

* Nick Bowler <nbowler@draconx.ca> [240322 06:36]:
> On 2024-03-22 01:15, Tony Lindgren wrote:
> > Can you please test if the following change to add back the check for
> > !pm_runtime_active() is enough to fix the issue?
> 
> I applied the below patch on top of 6.8 and unfortunately it does _not_
> fix the problem (no obvious change in behaviour).

Hmm OK thanks for testing. I'll take a look and see if I can debug this
with qemu sparc as I no longer have any sparc boxes around.

Regards,

Tony



