Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95336F390
	for <lists+linux-serial@lfdr.de>; Sun, 21 Jul 2019 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfGUNvw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 21 Jul 2019 09:51:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:16740 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfGUNvw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Jul 2019 09:51:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2019 06:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,290,1559545200"; 
   d="scan'208";a="252645136"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2019 06:51:24 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hpCFH-00049D-Dj; Sun, 21 Jul 2019 16:51:23 +0300
Date:   Sun, 21 Jul 2019 16:51:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Aaron Sierra <asierra@xes-inc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Rob Groner <rgroner@rtd.com>
Subject: Re: [PATCH v2] serial: 8250_exar: Move the Exar bits from 8250_port
Message-ID: <20190721135123.GQ9224@smile.fi.intel.com>
References: <20190719143052.67038-1-andriy.shevchenko@linux.intel.com>
 <1370607771.276118.1563564968480.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370607771.276118.1563564968480.JavaMail.zimbra@xes-inc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 19, 2019 at 02:36:08PM -0500, Aaron Sierra wrote:
> ----- Original Message -----
> > From: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
> > Sent: Friday, July 19, 2019 9:30:52 AM
> 
> > There are Exar quirks in 8250_port which belong to 8250_exar module.
> > Move them to the correct module and do not contaminate generic code
> > with it.
> > 
> > Cc: Aaron Sierra <asierra@xes-inc.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > in v2:
> > - rebase on top of latest vanilla / serial-next
> > - move divisor callbacks
> > - drop RFC
> > - compile tested only on my side, please, who has a hardware, test it
> 
> Andy,
> 
> I'll do some testing on v3 of this patch :P  See explanation below.

Thanks, v3 is on its way!

> > +/*
> > + * These Exar UARTs have an extra interrupt indicator that could
> > + * fire for a few unimplemented interrupts.  One of which is a
> > + * wakeup event when coming out of sleep.  Put this here just
> > + * to be on the safe side that these interrupts don't go unhandled.
> > + */
> > +static int exar_handle_irq(struct uart_port *port)
> > +{
> > +	unsigned int iir = serial_port_in(port, UART_IIR);
> > +	int ret = 0;
> > +
> > +	if (serial_port_in(port, UART_EXAR_INT0) != 0)
> > +		ret = 1;
> > +
> > +	ret |= serial8250_handle_irq(port, iir);
> > +
> > +	return ret;
> > +}
> 
> This seems to (accidentally) reintroduce the per-port INT0 clearing that was
> eliminated in c7e1b4059075 (tty: serial: exar: Relocate sleep wake-up handling)
> and further polished in 60ab0fafc4b6 (serial: 8250_exar: Read INT0 from slave device, too)

Oh, what a nice catch! I forgot about the changes which you did and I reviewed :-)

-- 
With Best Regards,
Andy Shevchenko


