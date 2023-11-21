Return-Path: <linux-serial+bounces-80-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306CA7F3566
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 18:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCBC28275F
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD685B215;
	Tue, 21 Nov 2023 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhszuT5b"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962F18E;
	Tue, 21 Nov 2023 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700589407; x=1732125407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2/r5O9ktbRjHHos+aJ5yv6QP/Ema933SZY47PqTAdhM=;
  b=dhszuT5bveA8GlC+AZJUPYnOFeuWaFObdzngxxxnYCo/gqi6CJdO61fN
   Pheux+uRRM58BsBL987var1Pi4PSQEhdpdZeIH/RmEj8JJhAiK1smxLdM
   aoj44Rc6heylnevq2dcjFDuss98fFzMb8yrYHnodryU7Ww03OzpGSI4TB
   2kP7vAyGmc36Lled+LiprSaXUBm5sbI4JqL4iY93XMmIxeXBjCEFAZkJ1
   ZYvVwnTAPTmJOttvJuPxO+gBCoesq607m8j+6NeBR3oLfyClAWyJ/E/wE
   fwm4hstnLTvglkwtrCVGPmr19YL8Zb9Hl+SfbpQ7PZy/DYLq5HQm1kC4J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="382289970"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="382289970"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="766716011"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="766716011"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:56:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1r5UzH-0000000Fshq-0kmd;
	Tue, 21 Nov 2023 19:56:39 +0200
Date: Tue, 21 Nov 2023 19:56:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>, Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/3] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <ZVzvVpuMrWqjnqUC@smile.fi.intel.com>
References: <20231121113203.61341-1-tony@atomide.com>
 <20231121113203.61341-3-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121113203.61341-3-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 21, 2023 at 01:31:56PM +0200, Tony Lindgren wrote:
> We can now add hardware based addressing for serial ports. Starting with
> commit 84a9582fd203 ("serial: core: Start managing serial controllers to
> enable runtime PM"), and all the related fixes to this commit, the serial
> core now knows to which serial port controller the ports are connected.
> 
> The serial ports can be addressed with DEVNAME:0.0 style naming. The names
> are something like 00:04:0.0 for a serial port on qemu, and something like
> 2800000.serial:0.0 on platform device using systems like ARM64 for example.
> 
> The DEVNAME is the unique serial port hardware controller device name, AKA
> the name for port->dev. The 0.0 are the serial core controller id and port
> id.
> 
> Typically 0.0 are used for each controller and port instance unless the
> serial port hardware controller has multiple controllers or ports.
> 
> Using DEVNAME:0.0 style naming actually solves two long term issues for
> addressing the serial ports:
> 
> 1. According to Andy Shevchenko, using DEVNAME:0.0 style naming fixes an
>    issue where depending on the BIOS settings, the kernel serial port ttyS
>    instance number may change if HSUART is enabled
> 
> 2. Device tree using architectures no longer necessarily need to specify
>    aliases to find a specific serial port, and we can just allocate the
>    ttyS instance numbers dynamically in whatever probe order
> 
> To do this, let's match the hardware addressing style console name to
> the character device name used, and add a preferred console using the
> character device device name.

...

> +int serial_base_add_preferred_console(struct uart_driver *drv,
> +				      struct uart_port *port)
> +{
> +	const char *port_match __free(kfree);
> +	int ret;
> +
> +	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
> +			       port->ctrl_id, port->port_id);
> +	if (!port_match)
> +		return -ENOMEM;
> +
> +	/* Translate a hardware addressing style console=DEVNAME:0.0 */
> +	ret = add_preferred_console_match(port_match, drv->dev_name, port->line);
> +	if (ret && ret != -ENOENT)
> +		return ret;
> +
> +	return 0;

Maybe

	ret = add_preferred_console_match(port_match, drv->dev_name, port->line);
	if (ret == -ENOENT)
		return 0;

	return ret;

> +}

-- 
With Best Regards,
Andy Shevchenko



