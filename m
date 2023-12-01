Return-Path: <linux-serial+bounces-390-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10CE801590
	for <lists+linux-serial@lfdr.de>; Fri,  1 Dec 2023 22:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7A0281C8E
	for <lists+linux-serial@lfdr.de>; Fri,  1 Dec 2023 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B726459B5B;
	Fri,  1 Dec 2023 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="L9H9um3k"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B22FE6;
	Fri,  1 Dec 2023 13:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=r/q53G/cSiatCOhG7xswwAt/NMI7k5B5sYhHKO2N/yc=; b=L9H9um3kspw8xuVxBmJgV6W9OF
	Zg8JDQBgcX+fISjS2Y9J8XJn+nSdn8psC7q6Jw3han8nDEF5Vi8K1KDmNWnGr6bi7PIuYmcR7aWr5
	jPbowOuOSO37kF2ggLPd2F2h8dZKeEf9hjijFmj/DTLKIqdNJPRjFdo3kxLM5K6GAFDs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41064 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r9BDj-0006T2-Fk; Fri, 01 Dec 2023 16:38:47 -0500
Date: Fri, 1 Dec 2023 16:38:46 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jan =?ISO-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, linux-serial@vger.kernel.org, Andy Shevchenko
 <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org
Message-Id: <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
In-Reply-To: <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
	<20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
	<ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Fri, 1 Dec 2023 18:34:38 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Dec 01, 2023 at 01:27:36PM -0500, Hugo Villeneuve wrote:
> 
> > it is funny, as I am preparing to send a patch for the sc16is7xx driver
> > to convert FIFO R/W to use the _noinc_ versions of regmap functions,
> > inspired by your patch 3f42b142ea11 ("serial: max310x: fix IO data
> > corruption in batched operations").
> 
> If you're working on that driver it'd also be good to update the current
> use of cache bypass for the enhanced features/interrupt identification
> register (and anything else in there, that did seem to be the only one)
> to use regmap ranges instead - that'd remove the need for the efr_lock
> and be a much more sensible/idiomatic use of the regmap APIs.

Hi Mark,
agreed, and I have already removed all cache bypass code (after some
fix for volatile registers)...

I will also look to remove the efr_lock, altough it has more
implications since this ship has some registers that share a common
address, and selected by bits in other registers, and I think this
is why there is this efr_lock.

I need to run more tests to make sure everything is ok, but so far
so good, and I should be submitting some of these patches soon.

Hugo Villeneuve.

