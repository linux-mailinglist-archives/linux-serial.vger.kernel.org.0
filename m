Return-Path: <linux-serial+bounces-99-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F767F3E18
	for <lists+linux-serial@lfdr.de>; Wed, 22 Nov 2023 07:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEA4282813
	for <lists+linux-serial@lfdr.de>; Wed, 22 Nov 2023 06:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882B015ADD;
	Wed, 22 Nov 2023 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="RY7AHEEi"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E20CBB;
	Tue, 21 Nov 2023 22:23:37 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 9B64560852;
	Wed, 22 Nov 2023 06:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1700634216;
	bh=7l8RYfSv+Xt+pXcLeRVZNV78n1VkGJsOJq4cyIHNZ2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RY7AHEEi03COXU08D3dl1hmNCiQVZwbml+LgwDKpjXDS9wMpcP61T3e9Yl2mf75GC
	 sc/Q5HDOGd3hZXskcWgkbE+Lm0B0v09qXFzitE9iUsd0py3fVqAsCf25q23n7e5aVO
	 KhqLryduelrBTbaclcOFlDnculfmIaHWpvn1aCblCRQldP8ahViBVnykG6wax7eJck
	 YuPV9B+468z4/a6gIg3KvWn+bf4WZ5KJWjfwGPZtebcBZJQ6V04ytJ5nmSmu9cGF1g
	 kBsqBxiGkbwAigoFVLLoaW2Gbp+rfHhc6XM8QiiqgpBSd5pEzBeJK1joHrydsZZCxN
	 QntdvDAEje7sw==
Date: Wed, 22 Nov 2023 08:23:04 +0200
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Move console character device
 handling from printk
Message-ID: <20231122062304.GE5169@atomide.com>
References: <20231121113203.61341-1-tony@atomide.com>
 <20231121113203.61341-4-tony@atomide.com>
 <ZVzwKeALJ4swIdj0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVzwKeALJ4swIdj0@smile.fi.intel.com>

* Andy Shevchenko <andriy.shevchenko@intel.com> [231121 18:00]:
> On Tue, Nov 21, 2023 at 01:31:57PM +0200, Tony Lindgren wrote:
> > +	ret = add_preferred_console_match(name, drv->dev_name, port->line);
> > +	if (ret && ret != -ENOENT)
> > +		return ret;
> > +
> > +	return 0;
> 
> 2nd time and so on, perhaps deserves a helper?
> 
> static inline int add_preferred_console...(...)
> {
> 	int ret;
> 
> 	ret = add_preferred_console_match(name, drv->dev_name, port->line);
> 	if (ret == -ENOENT)
> 		return 0;
> 	return ret;
> 
> }
> 
> ?

Yes good idea, thanks.

Tony

