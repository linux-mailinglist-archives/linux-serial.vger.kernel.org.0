Return-Path: <linux-serial+bounces-3776-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F80F8AE7BA
	for <lists+linux-serial@lfdr.de>; Tue, 23 Apr 2024 15:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E89FB22CC1
	for <lists+linux-serial@lfdr.de>; Tue, 23 Apr 2024 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97332134CFE;
	Tue, 23 Apr 2024 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="TRw6q4KG"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49D12C528;
	Tue, 23 Apr 2024 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878112; cv=none; b=tw7MOYjPNK77YHbDdWinR4wxNPsj9eVgGpamYYRkIsXMjnWT6KX2izmYSgracdSuRk922xV3+18gKok+KhV+oTvAF/1E1jyt+Gaky/ZeH811+qFgTT50YfKuAk5+nfxXsPWAkCRaRfCwXQO4ebIMlCxBDGtSBANSxFxUyn/2MJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878112; c=relaxed/simple;
	bh=eoL82GhaGYq+lfS47zzKXSJvd038+FhPCAlsOKUMiq8=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=P4z6rvJWtAfbKcIcqFqbwtkXUxXTI+Bqv7E08Sf/jRU09w2vcy6ML9IPxKDwq4FGwhDNV/ZxzucbY3TX8+rNBtcuvoMZNYje9i11AhSaLMbVCpeyP4vA1B0VatwTJhD1+FstGIkrKL0SqVV1kSHt8rgzh91myYhunF2/AhKGlXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=TRw6q4KG; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=5qT/W6eCQAh4jPbV7AbYXYgCoERo6S0byM6/Gy6sea8=; b=TRw6q4KGxuwYMu7k98GlVWyHu4
	dqo4Tf5AYXN18m5ZFvnBGzS955j2qDdGExYLgmHvxdput9m5xrhj9q1MesmM9VlRKIQg5a3RGjP47
	gErgmMyT78HTCpty76t336aJaBF+3IyCqT9fjQr83PTivVVspQewtOo6+ewBHyhaRWwU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54284 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rzFzD-0006jV-Dz; Tue, 23 Apr 2024 09:15:03 -0400
Date: Tue, 23 Apr 2024 09:15:02 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, peterz@infradead.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20240423091502.021afd2e88cb9a9373c793eb@hugovil.com>
In-Reply-To: <CAHp75VcB0LH6pBHfJ4=N4s6Q_=pGhW6MHEHWkB7E+A5m758AnQ@mail.gmail.com>
References: <20240409154253.3043822-1-hugo@hugovil.com>
	<20240409154253.3043822-4-hugo@hugovil.com>
	<CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
	<CAMuHMdWBYnhVvDMditnf9bh17TeBhrZmuz--7x9QEejivCCyJg@mail.gmail.com>
	<CAHp75VcB0LH6pBHfJ4=N4s6Q_=pGhW6MHEHWkB7E+A5m758AnQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -2.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v4 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue, 23 Apr 2024 13:37:37 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Apr 23, 2024 at 1:03 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Apr 23, 2024 at 12:01 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Tue, Apr 9, 2024 at 5:48 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> ...
> 
> > Or just rename SERIAL_SC16IS7XX_CORE back to SERIAL_SC16IS7XX.
> 
> Since we do not know how many configurations elsewhere rely on this
> and we have a real use case this suggestion seems plausible to me.

Agreed.

I will look into it.

Hugo.

