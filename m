Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4911315F27B
	for <lists+linux-serial@lfdr.de>; Fri, 14 Feb 2020 19:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389430AbgBNSJh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Feb 2020 13:09:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:58327 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389420AbgBNSJg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 13:09:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 10:09:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="227445807"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 14 Feb 2020 10:09:33 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j2fPD-001Qi1-Hn; Fri, 14 Feb 2020 20:09:35 +0200
Date:   Fri, 14 Feb 2020 20:09:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 5/8] serial: 8250_port: Don't use power management for
 kernel console
Message-ID: <20200214180935.GP10400@smile.fi.intel.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-6-andriy.shevchenko@linux.intel.com>
 <20200214133918.GP25745@shell.armlinux.org.uk>
 <20200214171348.GP16391@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214171348.GP16391@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 14, 2020 at 09:13:48AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux admin <linux@armlinux.org.uk> [200214 13:40]:
> > On Fri, Feb 14, 2020 at 01:43:36PM +0200, Andy Shevchenko wrote:
> > > Doing any kind of power management for kernel console is really bad idea.
> > > 
> > > First of all, it runs in poll and atomic mode. This fact attaches a limitation
> > > on the functions that might be called. For example, pm_runtime_get_sync() might
> > > sleep and thus can't be used. This call needs, for example, to bring the device
> > > to powered on state on the system, where the power on sequence may require
> > > on-atomic operations, such as Intel Cherrytrail with ACPI enumerated UARTs.
> > > That said, on ACPI enabled platforms it might even call firmware for a job.
> > > 
> > > On the other hand pm_runtime_get() doesn't guarantee that device will become
> > > powered on fast enough.
> > > 
> > > Besides that, imagine the case when console is about to print a kernel Oops and
> > > it's powered off. In such an emergency case calling the complex functions is
> > > not the best what we can do, taking into consideration that user wants to see
> > > at least something of the last kernel word before it passes away.
> > > 
> > > Here we modify the 8250 console code to prevent runtime power management.
> > 
> > It's probably also worth noting (and documenting) that this will likely
> > cause a PM regression for OMAP platforms since the serial port will no
> > longer be idled, and therefore the power domains will not hit retention
> > state.  Please wait for Tony to confirm.
> 
> Well with patch 4 in this series we can now attach and detach the serial
> console as we've discussed earlier.
> 
> This should remove the need for PM during serial console use hopefully :)
> 
> I'll try to test this series ASAP.

Tony, I have realized that last patch (two patches) makes a regression. So,
I'll drop them in next version, please do not include them in your testing
bucket.

-- 
With Best Regards,
Andy Shevchenko


