Return-Path: <linux-serial+bounces-544-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D9580598D
	for <lists+linux-serial@lfdr.de>; Tue,  5 Dec 2023 17:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC81F21876
	for <lists+linux-serial@lfdr.de>; Tue,  5 Dec 2023 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3493863DF4;
	Tue,  5 Dec 2023 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOCIUyOy"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D850197;
	Tue,  5 Dec 2023 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701792608; x=1733328608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9VlXC9T0HJrRA8I/AjcRFH7MOmlq9IpZCfivuySrewU=;
  b=fOCIUyOyTlLx/fc3rdBbjdpBrUu4NQHGbX3+2SksLvlGwXkfZ7JYmCX2
   7n7MneTLdbeYcTCTUfOfOZmOWDFAyqkmLvSpNm4BQ+M7NYpEsTc+q4bGr
   x3FeqVnvHTdiC4Tl8dqYE8cjN7q0o19AOWRGPoLyEkdUkQt5PAel26OY/
   n1ong6QDEdAWIeom7bEt3I9UPR4l/nQLxbXmOO1OmkOeSwSghvWzels3N
   UfvKKcaGC/vfUE56MlF7OPTrCn/H86iFuMDiOcRYNBsofkWvMyzkTKgmE
   kzMdWcKF59i88ObRKeYXTTkHUpEzZw92W8c3o6swwjoWWmUC3a89g2rrq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392780281"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="392780281"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="888992817"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="888992817"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:10:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rAXzk-0000000251u-3cM9;
	Tue, 05 Dec 2023 18:10:00 +0200
Date: Tue, 5 Dec 2023 18:10:00 +0200
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
Subject: Re: [PATCH v4 4/4] serial: 8250: Add preferred console in
 serial8250_isa_init_ports()
Message-ID: <ZW9LWNzV78Xb_-Uj@smile.fi.intel.com>
References: <20231205073255.20562-1-tony@atomide.com>
 <20231205073255.20562-5-tony@atomide.com>
 <ZW9LBXc8ars-rrh6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW9LBXc8ars-rrh6@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 05, 2023 at 06:08:37PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 05, 2023 at 09:32:36AM +0200, Tony Lindgren wrote:

...

> > +	pr_err("Could not add preferred console for %s idx %i\n",
> > +	       serial8250_reg.dev_name, idx);

And, btw, you can simply reuse name here

	pr_err("Could not add preferred console for %s\n", name);

Would it work?

-- 
With Best Regards,
Andy Shevchenko



