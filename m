Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61478B38
	for <lists+linux-serial@lfdr.de>; Mon, 29 Jul 2019 14:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfG2MBD (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 29 Jul 2019 08:01:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:42527 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbfG2MBD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Jul 2019 08:01:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 05:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,322,1559545200"; 
   d="scan'208";a="162158693"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga007.jf.intel.com with ESMTP; 29 Jul 2019 05:01:00 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hs4Kp-0006Se-8q; Mon, 29 Jul 2019 15:00:59 +0300
Date:   Mon, 29 Jul 2019 15:00:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Aaron Sierra <asierra@xes-inc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Subject: Re: [PATCH v3] serial: 8250_exar: Move the Exar bits out from
 8250_port
Message-ID: <20190729120059.GD23480@smile.fi.intel.com>
References: <20190721142659.60773-1-andriy.shevchenko@linux.intel.com>
 <1785128142.57495.1564351929356.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1785128142.57495.1564351929356.JavaMail.zimbra@xes-inc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jul 28, 2019 at 05:12:09PM -0500, Aaron Sierra wrote:
> ----- Original Message -----
> > From: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
> > Sent: Sunday, July 21, 2019 9:26:59 AM
> 
> > There are Exar quirks in 8250_port which belong to 8250_exar module.
> > Move out them to the correct module and do not contaminate generic code
> > with it.
> 
> Andy,
> 
> Your changes seem functionally equivalent based on my review and testing.

Thank you for testing, my answers below.

> However, based on this commit description, I was expecting more of the
> Exar-specific code to be moved from 8250_port.c to 8250_exar.c. I think that
> can reasonably be achieved without too much additional effort.
> 
> There are two pieces of Exar-specific support in serial8250_do_startup():

Actually three.

> 1. The two reads to clear INT0, could be boiled down to a single read in
>    exar_pci_probe(), immediately after registering the common IRQ handler.
>    What do you think?

I'm not so familiar with the hardware, will it not give any side-effects?

> 2. The following block could be moved to a new exar_startup() function:
> 
> 	if (port->type == PORT_XR17V35X) {
> 		/*
> 		 * First enable access to IER [7:5], ISR [5:4], FCR [5:4],
> 		 * MCR [7:5] and MSR [7:0]
> 		 */
> 		serial_port_out(port, UART_XR_EFR, UART_EFR_ECB);
> 
> 		/*
> 		 * Make sure all interrups are masked until initialization is
> 		 * complete and the FIFOs are cleared
> 		 */
> 		serial_port_out(port, UART_IER, 0);
> 	}
> 
>    Do you agree?

I thought about this, but didn't come to a conclusion to move it right now.
It's not so straight forward. In the ->startup() we setup IO accessors in some
cases (perhaps doesn't apply to Exar case) and do some testing.

So, I prefer do this in a separate change, so we may see how it goes.

> The only thing that seems to need to stay put is UART_XR_EFR support in
> serial8250_do_set_termios().

Yes, though ideally it should be moved to 8250_exar as well.

> There are a couple additional notes below for you to find. One involves a
> compile warning.

> > #define UART_EXAR_INT0		0x80
> 
> My note above about cleaning up serial8250_do_startup() would eliminate
> the need for UART_EXAR_INT0 to be defined here, too.

I see.

> > -		goto out;
> 
> Take the "out" label as well to avoid introducing a compile warning.

Thanks, I missed it somehow.

-- 
With Best Regards,
Andy Shevchenko


