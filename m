Return-Path: <linux-serial+bounces-429-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC592802C63
	for <lists+linux-serial@lfdr.de>; Mon,  4 Dec 2023 08:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A30280CD7
	for <lists+linux-serial@lfdr.de>; Mon,  4 Dec 2023 07:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E5CC129;
	Mon,  4 Dec 2023 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="P+bely7r"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BAAF0;
	Sun,  3 Dec 2023 23:52:04 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 96BD36049B;
	Mon,  4 Dec 2023 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1701676323;
	bh=XWo9gVPTMw/Jq0RjiBpbhpIaqutznCtnJEvdD0CoMg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+bely7rNEVVgt2juKTgYntibbAPc4QjgIoWYc2/D4hZNw1OMxX1DmvuLTHKDujdO
	 eUpE7S7GNk6PTaLFtdNfq4QKQoQoDCqcFsBAuquHxq+NQVzf1bQGCw7Wqec/0GSaKp
	 TtVeEB308gFErEL+thsLamtqaKl9jI6GmYC/0ncvHTaqx+yGK3PB2iLwlcUcb2oddD
	 Tj7SykeS9eQKqMEOAQ6cXuwSQW5gOw9U33L63lIrrcIkWolbjIFsAfw14GNhp0r/j4
	 4Z9JkCUc+UX6iviCMwKRNVFZuHtEeQ+lLxkHdPwDNVKssLmlb7qrOfOPrIsJPtg4wE
	 fueDCrerrQ2gw==
Date: Mon, 4 Dec 2023 09:51:31 +0200
From: Tony Lindgren <tony@atomide.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add support for DEVNAME:0.0 style hardware based
 addressing
Message-ID: <20231204075131.GK5169@atomide.com>
References: <20231121113203.61341-1-tony@atomide.com>
 <ZWnvc6-LnXdjOQLY@alley>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWnvc6-LnXdjOQLY@alley>

* Petr Mladek <pmladek@suse.com> [231201 14:36]:
> Well, my understanding is that it solves the problem only for the newly
> added console=DEVICENAME:0.0 format. But it does not handle the
> existing problems with matching console names passed via earlycon=
> and console= parameters. Am I right?

Yes that's where the remaining problems are.

> Now, the bad news. This patchset causes regressions which are
> not acceptable. I have found two so far but there might be more.
> 
> I used the following kernel command line:
> 
>    earlycon=uart8250,io,0x3f8,115200 console=ttyS0,115200 console=tty0 ignore_loglevel log_buf_len=1M
> 
> 
> 1. The patchset caused that /dev/console became associated with
>    ttyS0 instead of tty0, see the "C" flag:
> 
> 	original # cat /proc/consoles
> 	tty0                 -WU (EC    )    4:1
> 	ttyS0                -W- (E  p a)    4:64
> 
>    vs.
> 
> 	patched # cat /proc/consoles
> 	ttyS0                -W- (EC p a)    4:64
> 	tty0                 -WU (E     )    4:1
> 
>    This is most likely caused by the different ordering of
>    __add_preferred_console() calls.

Yes I noticed that too. We can't drop the console parsing from
console_setup() until we have some solution for flagging
register_console() that we do have a console specified on the
kernel command line and try_enable_default_console() should not
be called. It seems some changes to the console_set_on_cmdline
handling might do the trick here.

>    The ordering is important because it defines which console
>    will get associated with /dev/console. It is a so called
>    preferred console defined by the last console= parameter.
> 
>    Unfortunately also the ordering of the other parameters
>    is important when a console defined by the last console=
>    parameter is not registered at all. In this case,
>    /dev/console gets associated with the first console
>    with tty binding according to the order on the command line.
> 
>    If you think that it is weird behavior then I agree.
>    But it is a historical mess. It is how people used it
>    when the various features were added. Many changes
>    in this code caused regressions and had to be reverted.

Yeah agreed it's a mess :)

>    See the following to get the picture:
> 
>        + commit c6c7d83b9c9e6a8 ("Revert "console: don't
> 	 prefer first registered if DT specifies stdout-path")
> 
>        + commit dac8bbbae1d0ccb ("Revert "printk: fix double
> 	 printing with earlycon"").

OK thanks.

> 2. The serial console gets registered much later with this
>    patchset:
> 
> 	original # dmesg | grep printk:
> 	[    0.000000] printk: legacy bootconsole [uart8250] enabled
> 	[    0.000000] printk: debug: ignoring loglevel setting.
> 	[    0.016859] printk: log_buf_len: 1048576 bytes
> 	[    0.017324] printk: early log buf free: 259624(99%)
> 	[    0.141859] printk: legacy console [tty0] enabled
> 	[    0.142399] printk: legacy bootconsole [uart8250] disabled
> 	[    0.143032] printk: legacy console [ttyS0] enabled
> 
>    vs.
> 
> 	patched # dmesg | grep printk:
> 	[    0.000000] printk: legacy bootconsole [uart8250] enabled
> 	[    0.000000] printk: debug: ignoring loglevel setting.
> 	[    0.018142] printk: log_buf_len: 1048576 bytes
> 	[    0.018757] printk: early log buf free: 259624(99%)
> 	[    0.160706] printk: legacy console [tty0] enabled
> 	[    0.161213] printk: legacy bootconsole [uart8250] disabled
> 	[    1.592929] printk: legacy console [ttyS0] enabled
> 
>    This is pretty bad because it would complicate or even prevent
>    debugging of the boot stage via serial console.

I think I have a patch coming for 8250 isa ports for that issue.
This issue should go away if we call add_preferred_console_match()
from serial8250_isa_init_ports() with options for the port like
"ttyS0", "ttyS", 0.

>    The graphical console is not usable when the system dies. Also
>    finding the right arguments for the earlycon= parameter is
>    tricky so that people enable it only when they have to debug
>    very early messages.
> 
> 
> I am going to look at the patches more closely to see if I could
> provide some hints.

Great, help with the early console handling is much appreciated.

I'll post an updated patchset this week that does not touch
console_setup() beyond saving the console options. And then we
hopefully have something that avoids the regressions and can be
used for further changes later on.

Regards,

Tony

