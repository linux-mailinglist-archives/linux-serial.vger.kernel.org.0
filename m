Return-Path: <linux-serial+bounces-79-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BC77F3556
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 18:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83DC1C20CC2
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616D920DF7;
	Tue, 21 Nov 2023 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NN+/OPC7"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA53418E;
	Tue, 21 Nov 2023 09:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700589202; x=1732125202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wbvLSSVCATMX1TnkhVx4rea6C+nVCD+ipXsQ0+QGSkU=;
  b=NN+/OPC7wBIFzVoxQcgyhjMomsTjnOzR112V6lw2bvqytupC0W7DLe9y
   rZg5IgIzgCVhkXQN1hftvhUxnlr9XLSEiKjbe+ib9IZj5aoaQ56klRvKs
   DVr1FEAQAZuwoqo3lnS5rwDwW0ATwyGaXeRIOxLMio6K1AI/wg4574yol
   G2BzoRY9Pi8HS680b35hoFWGGpmZRwRftfQd8lrrqnktsZo/L2f3gyEeY
   AX1nAtZnBURnzzhXRPxCZFDlN+Qw25GClm/NWbzyxSAfZZujq2U6dqNX7
   QGB0vTlo6CxQzxnYzcuyKkkE8+63jWadW+FlUHqYv/52nOGarfO9UXiK9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="395816145"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="395816145"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="743124922"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="743124922"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:53:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1r5Uvz-0000000FsgA-03lj;
	Tue, 21 Nov 2023 19:53:15 +0200
Date: Tue, 21 Nov 2023 19:53:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 1/3] printk: Save console options for
 add_preferred_console_match()
Message-ID: <ZVzuih3Aw3hdfj2s@smile.fi.intel.com>
References: <20231121113203.61341-1-tony@atomide.com>
 <20231121113203.61341-2-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121113203.61341-2-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 21, 2023 at 01:31:55PM +0200, Tony Lindgren wrote:
> Driver subsystems may need to translate the preferred console name to the
> character device name used. We already do some of this in console_setup()
> with a few hardcoded names, but that does not scale well.
> 
> The console options are parsed early in console_setup(), and the consoles
> are added with __add_preferred_console(). At this point we don't know much
> about the character device names and device drivers getting probed.
> 
> To allow drivers subsystems to set up a preferred console, let's save the
> kernel command line console options. To add a preferred console, let's add
> a new function add_preferred_console_match().
> 
> This allows the serial core layer to support console=DEVNAME:0.0 style
> hardware based addressing in addition to the current console=ttyS0 style
> naming. And we can start moving console_setup() character device parsing
> to the driver subsystem specific code.
> 
> We use a separate array from the console_cmdline array as the character
> device name and index may be unknown at the console_setup() time. And we do
> not want to call __add_preferred_console() until the character device name
> and index are known.
> 
> Adding the console name in addition to the character device name, and a
> flag for an added console, could be added to the struct console_cmdline.
> And the console_cmdline array handling modified accordingly. But that
> complicates things compared saving the console options, and then adding
> the consoles when the subsystems handling the consoles are ready.

...

> +#include <linux/console.h>

> +#include <linux/kernel.h>

I think instead of kernel.h you may want to see these:

linux/init.h
linux/string.h

asm/errno.h

> +#include "console_cmdline.h"

...

> +/**
> + * console_opt_save - Saves kernel command line console option for driver use
> + * @str: Kernel command line console name and option
> + *
> + * Saves a kernel command line console option for driver subsystems to use for
> + * adding a preferred console during init. Called from console_setup() only.

	scripts/kernel-doc -v -none -Wall ...

most likely will complain (no Return section).

> + */
> +int __init console_opt_save(char *str)

str is not const? Hmm...

-- 
With Best Regards,
Andy Shevchenko



