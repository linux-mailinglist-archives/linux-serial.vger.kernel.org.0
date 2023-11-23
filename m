Return-Path: <linux-serial+bounces-187-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE687F68B5
	for <lists+linux-serial@lfdr.de>; Thu, 23 Nov 2023 22:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33EC1C209E0
	for <lists+linux-serial@lfdr.de>; Thu, 23 Nov 2023 21:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD59156D0;
	Thu, 23 Nov 2023 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0JOUSiE"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413581B6;
	Thu, 23 Nov 2023 13:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700775459; x=1732311459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a9vuTp+5HGIasH4n8zztYclp8mSI7lzeBuXs6F3Akaw=;
  b=U0JOUSiExZx1AFmFp85Za7zO95WNeYNf+4kOAYuo1J0wyi5+CdxKUdig
   FWxaqNNvQtDtz5MkLu1YOkgo/3e3N35xYJ7gl1HievpEAeKuVS0W1ERLq
   0/L0SMTz+jT9q3eAvhyU0ASVRIs1lyrBlrosrS2Gyyk2Nydr3ruPY+qs3
   iZ3U49tnjMymgx2c99HpJMsF9DftIBKwUK4//yxrj84escC3Dg9L5btn7
   AytCUdtSCIAUMnAAElAuvPeT7uy37v3fs5KjX1zHyvRvgPMgQu+6o//Go
   TAfhSI9HgXG4ZzZ60EwQ0qCJYinoecJ3d+Tgf0xZamdnqQ1vyMTRMXf6o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382730665"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="382730665"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 13:37:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837893805"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="837893805"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 13:37:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1r6HO9-0000000GYZt-2UPV;
	Thu, 23 Nov 2023 23:37:33 +0200
Date: Thu, 23 Nov 2023 23:37:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, lech.perczak@camlingroup.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: improve regmap debugfs by using one
 regmap per port
Message-ID: <ZV_GHRhqCdeCHV_a@smile.fi.intel.com>
References: <20231030211447.974779-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030211447.974779-1-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 30, 2023 at 05:14:47PM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> With this current driver regmap implementation, it is hard to make sense
> of the register addresses displayed using the regmap debugfs interface,
> because they do not correspond to the actual register addresses documented
> in the datasheet. For example, register 1 is displayed as registers 04 thru
> 07:
> 
> $ cat /sys/kernel/debug/regmap/spi0.0/registers
>   04: 10 -> Port 0, register offset 1
>   05: 10 -> Port 1, register offset 1
>   06: 00 -> Port 2, register offset 1 -> invalid
>   07: 00 -> port 3, register offset 1 -> invalid
>   ...
> 
> The reason is that bits 0 and 1 of the register address correspond to the
> channel (port) bits, so the register address itself starts at bit 2, and we
> must 'mentally' shift each register address by 2 bits to get its real
> address/offset.
> 
> Also, only channels 0 and 1 are supported by the chip, so channel mask
> combinations of 10b and 11b are invalid, and the display of these
> registers is useless.
> 
> This patch adds a separate regmap configuration for each port, similar to
> what is done in the max310x driver, so that register addresses displayed
> match the register addresses in the chip datasheet. Also, each port now has
> its own debugfs entry.
> 
> Example with new regmap implementation:
> 
> $ cat /sys/kernel/debug/regmap/spi0.0-port0/registers
> 1: 10
> 2: 01
> 3: 00
> ...
> 
> $ cat /sys/kernel/debug/regmap/spi0.0-port1/registers
> 1: 10
> 2: 01
> 3: 00
> 
> As an added bonus, this also simplifies some operations (read/write/modify)
> because it is no longer necessary to manually shift register addresses.

This change might be problematic, i.e. ...

...

>  		regmap_update_bits(
>  			s->regmap,
> -			SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
> +			SC16IS7XX_IOCONTROL_REG,
>  			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
>  			SC16IS7XX_IOCONTROL_MODEM_B_BIT, s->mctrl_mask);

...if this happens inside another regmap operation it might collide with this
as there is no more shared locking (and if driver is going to be converted to
use an external lock, the one in regmap might be disabled). But I haven't
checked anyhow deeply this, so just a heads up for the potential issue.

...

> -	ret = regmap_read(regmap,
> -			  SC16IS7XX_LSR_REG << SC16IS7XX_REG_SHIFT, &val);
> +	ret = regmap_read(regmaps[0], SC16IS7XX_LSR_REG, &val);

Here is a probe, most likely no issues.

>  	if (ret < 0)
>  		return -EPROBE_DEFER;

...

> +static const char *sc16is7xx_regmap_name(unsigned int port_id)
> +{
> +	static char buf[6];
> +
> +	snprintf(buf, sizeof(buf), "port%d", port_id);

Should be %u.

> +	return buf;
> +}

-- 
With Best Regards,
Andy Shevchenko



