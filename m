Return-Path: <linux-serial+bounces-770-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79FA80CA87
	for <lists+linux-serial@lfdr.de>; Mon, 11 Dec 2023 14:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B6B281ABF
	for <lists+linux-serial@lfdr.de>; Mon, 11 Dec 2023 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10113D967;
	Mon, 11 Dec 2023 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7uMfnvr"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3A8C4;
	Mon, 11 Dec 2023 05:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702300088; x=1733836088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=in3Ml1ewom3HGY0wz6izynRQKJrC6Dqyh0PwUcWn9Uc=;
  b=f7uMfnvr53n7jcC2+5ny90xOQkZdJa+M55RCeP/ziqZwTd9YJAd7x8i+
   kjqDQGu692rDYdhVhtuKF047hvoA1wglqYEI6fk1inXjU75oK+EKH/ZZp
   TughlxiF+nqLSPvIKCG1Aqm1mVzHfWUg08KD+DtQmKvuCGj3El4zPqprY
   7/RdliaV0jXybz4HwibKTkdIL/wkHXGqwADkERlEQ4R1tFzv4wB6m+Z/V
   DdcVH3sfqMmas/jFcUjOWmyPkWiSBTk1uZMvy3VxZWMibQOFGogDyMAxz
   fspyMlK3D7F5NYtBpqE/pNGHSZF0/dyPnku8FKEIQ26Btv4lflyrty/U4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="374802667"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="374802667"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 05:08:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1104469655"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1104469655"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 05:08:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rCg0u-00000004mmq-0OoA;
	Mon, 11 Dec 2023 15:08:00 +0200
Date: Mon, 11 Dec 2023 15:07:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Lukas Wunner <lukas@wunner.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"brenda.streiff@ni.com" <brenda.streiff@ni.com>,
	Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
	Tomas Paukrt <tomaspaukrt@email.cz>
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Message-ID: <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
 <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Dec 09, 2023 at 12:47:47PM +0100, Lino Sanfilippo wrote:
> On 06.12.23 16:42, Lino Sanfilippo wrote:

> >>>> Crescent CY Hsieh (+cc) is in parallel trying to add an RS-422 mode bit
> >>>> to struct serial_rs485:
> >>>>
> >>>> https://lore.kernel.org/all/20231121095122.15948-1-crescentcy.hsieh@moxa.com/
> >>>>
> >>>
> >>> That new flag was suggested by me instead of using SER_RS422_ENABLED, which
> >>> would mostly be redundant to SER_RS485_ENABLED.
> 
> A cleaner solution would probably be to not handle RS422 with the RS485 settings at
> all, but to introduce another set of ioctls to set and read it.
> 
> An own RS422 structure like
> 
> struct serial_rs422 {
> 	__u32	flags;
> #define SER_RS422_ENABLED		(1 << 0)
> #define SER_RS422_TERMINATE_BUS		(1 << 1)
> };
> 
> 
> could be used as the parameter for these new ioctls.
> 
> Any comments on this?

I have (maybe not so constructive) a comment. Please, at all means try to not
extend the existing serial data structures, we have too many ones with too many
fields already. For user space, though, one may use unions and flags, but for
internal ones it might be better ways, I think.

-- 
With Best Regards,
Andy Shevchenko



