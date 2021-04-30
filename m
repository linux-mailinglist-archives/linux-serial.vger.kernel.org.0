Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87A236FAF7
	for <lists+linux-serial@lfdr.de>; Fri, 30 Apr 2021 14:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhD3Myk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 30 Apr 2021 08:54:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:57689 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232291AbhD3Myj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Apr 2021 08:54:39 -0400
IronPort-SDR: os7v8CntnBKRHHHain7lDoMCaZlZNqkty7Tl5l4wJAHrRvX+fdOvIsVZ3DutDWhwuXFgNQa0pU
 fAPPGk0gQgKg==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197365380"
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="197365380"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 05:53:49 -0700
IronPort-SDR: 0rB17DpXMJC5/pBfj56152hcy6UD/jSFD1qUjHHiS1PQs07xvdx7dGVPGVSA95VfQlN4NyrGuw
 HFpq35LkY9gQ==
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="537754564"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 05:53:47 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lcSeO-008Q0T-O4; Fri, 30 Apr 2021 15:53:44 +0300
Date:   Fri, 30 Apr 2021 15:53:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: fix a timeout loop condition
Message-ID: <YIv92DBnaVotWd9Y@smile.fi.intel.com>
References: <YIpd+kOpXKMpEXPf@mwanda>
 <YIqTvcZ6ZrAEL7WE@smile.fi.intel.com>
 <20210429130215.GE21598@kadam>
 <YIvDz7hEhwm66R8G@smile.fi.intel.com>
 <20210430114106.GF1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430114106.GF1981@kadam>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 30, 2021 at 02:41:06PM +0300, Dan Carpenter wrote:
> On Fri, Apr 30, 2021 at 11:46:07AM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 29, 2021 at 04:02:15PM +0300, Dan Carpenter wrote:
> > > On Thu, Apr 29, 2021 at 02:08:45PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Apr 29, 2021 at 10:19:22AM +0300, Dan Carpenter wrote:
> > > > > This loop ends on -1 so the error message will never be printed.
> > > > > 
> > > > > Fixes: 4bcf59a5dea0 ("serial: 8250: 8250_omap: Account for data in flight during DMA teardown")
> > > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > 
> > > > ...
> > > > 
> > > > >  			       poll_count--)
> > > > >  				cpu_relax();
> > > > >  
> > > > > -			if (!poll_count)
> > > > > +			if (poll_count == -1)
> > > > 
> > > > Why not to change poll_count-- to --poll_count?
> > > >
> > > 
> > > Either one is fine.  I considered several different ways and wrote the
> > > patch twice.  The downside of --poll_count is that it's an off by one
> > > in that the author clearly intended to loop 25 times.  It doesn't really
> > > matter if we only loop 24 but off by ones are aesthetically unpleasant.
> > 
> > I didn't get. If you use --poll_count you get exactly 25 times and moreover,
> > you may convert variable to unsigned type.
> > 
> 
> Here is a small test to show that it loops 24 times.
> 
> #include <stdio.h>
> 
> int main(void)
> {
>         int i = 25;
> 
>         while (--i)
>                 printf("%d\n", i);
> 
>         return 0;
> }
> 
> gcc test.c
> ./a.out | tac
> 
> Why would I make it unsigned?  As a static analysis developer,
> pointlessly unsigned variables are one of the leading causes for the
> bugs I see.
> 
> There are times where a iterator counter needs to be unsigned long, or
> u64 but I have never seen a case where changing an iterator from
> "int i;" to "unsigned int i;" solves a real life kernel bug.  It only
> introduces bugs.

See my followup to that, I meant

unsigned int count;

do {
	...
} while (--count);

It doesn't solve bug, but prevents the code be read incorrectly like what you
are fixing can be avoided with do {} while (); along with unsigned type.

-- 
With Best Regards,
Andy Shevchenko


