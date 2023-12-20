Return-Path: <linux-serial+bounces-1105-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BC381A56C
	for <lists+linux-serial@lfdr.de>; Wed, 20 Dec 2023 17:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5856E1F213A5
	for <lists+linux-serial@lfdr.de>; Wed, 20 Dec 2023 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC2641234;
	Wed, 20 Dec 2023 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="wuKj1pY3"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141274185C;
	Wed, 20 Dec 2023 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=7DWE80MpX5b5xDLz+z39HDenzmXZGJEBVw+/CVqzpdA=; b=wuKj1pY3nqNsSl0CZ4cOKhKvMi
	SkD6Eg8Z88H99iWCRsG8IlzcasI9Hp2LWILtfw+SvnLSoxfUZ/J9SJ+IuN/ZwYUm8fL7FF1xcNO2L
	W/aGDUM0+5Q+lo87e2T5B6tZYlZJqV+mY7ne7D34PCH+t/qhO1FDvK/Db1Y9MCZG9s08=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:45880 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFzaq-0007Cm-0w; Wed, 20 Dec 2023 11:38:48 -0500
Date: Wed, 20 Dec 2023 11:38:47 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20231220113847.b3dfc4b9a786b78c70cad2e8@hugovil.com>
In-Reply-To: <ZYMRBbPEwIa8K4NI@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<ZYMRBbPEwIa8K4NI@smile.fi.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 00/18] serial: sc16is7xx: fixes, cleanups and
 improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 20 Dec 2023 18:06:29 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Dec 19, 2023 at 12:18:44PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > Hello,
> > this patch series brings a few fixes, clean-ups and improvements to the
> > sc16is7xx driver.
> >=20
> > Some of the patches have been suggested by Andy Shevchenko following th=
is
> > dicussion:
> >=20
> > Link: https://lore.kernel.org/all/CAHp75VebCZckUrNraYQj9k=3DMrn2kbYs1Lx=
26f5-8rKJ3RXeh-w@mail.gmail.com/
>=20
> Thanks, good series (need a bit of additional work, though).
> What I really miss is the proper split of the driver. See
> 0f04a81784fe ("pinctrl: mcp23s08: Split to three parts: core, I=B2C, SPI")
> as an example of a such.

Hi Andy,
thank you for the reviews.

I was thinking of doing the split after this current serie, and I
will look at your example as a reference.

Hugo Villeneuve

