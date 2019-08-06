Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7BC83550
	for <lists+linux-serial@lfdr.de>; Tue,  6 Aug 2019 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfHFPdg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 11:33:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:23524 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHFPdg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 11:33:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 08:31:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="192691170"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2019 08:31:12 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hv1Qc-0001Gw-Sz; Tue, 06 Aug 2019 18:31:10 +0300
Date:   Tue, 6 Aug 2019 18:31:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Robert Middleton <robert.middleton@rm5248.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
Message-ID: <20190806153110.GG30120@smile.fi.intel.com>
References: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
 <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
 <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com>
 <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
 <20190806152407.GF30120@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806152407.GF30120@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 06, 2019 at 06:24:07PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 06, 2019 at 09:40:41AM -0400, Robert Middleton wrote:
> > On Mon, Aug 5, 2019 at 10:22 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Aug 05, 2019 at 09:49:24AM -0400, Robert Middleton wrote:

> > > > Unfortunately this will re-introduce the bug that it was attempting to
> > > > solve, that is ensuring that the buffer in the kernel and the buffer
> > > > on the chip are clear before going into shutdown on the chip.
> > > > Breaking at the beginning of the loop means that the kernel has
> > > > written everything to the internal buffer on the chip, but until the
> > > > LSR bits are clear the bytes have not been transmitted yet.
> > >
> > > So, the difference here, that you have a long delay with mdelay(1) which
> > > "fixes" your issue.
> > 
> > The important fix is really this part:
> > lsr = serial_in(up, UART_LSR);
> > if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
> > 
> > Both of those bits must be set before the shutdown can occur.  The
> > msleep(1) is so that it is not a busy loop(maybe usleep_range would be
> > better?).
> > If the transmitter is not empty and the transmitter FIFO is
> > not empty, when the shutdown occurs the remaining data will be
> > discarded by the exar chip.  Assuming the FIFO on the exar is full(256
> > bytes to transmit), it would take ~250ms to transmit all of the bytes
> > at 9600 baud, so our check would happen ~250 times(assuming mdelay(1)
> > sleeps for 1ms and not up to 20).
> > 
> > This is based off of the reference driver from Max Linear:
> > https://github.com/rm5248/exar-driver/blob/5dcbac6aa564cf5604512ecd6c9e02c577b70fa2/xr17v35x.c#L1282
> 
> I see, you explicitly force to continue in your case.
> Thanks for explanation.

One more though. Let's consider your code carefully.

do {
	lsr = serial_in(up, UART_LSR);
	if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
		tx_complete = 1;
	else
		tx_complete = 0;

Here we set a boolean to be true or false, fine...

	msleep(1);

...wait for some undefined long time...

} while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);

...first conditional is to check kernel buffer for emptiness, and since it's an
AND operation in use, break if it false...

(In comparison to what I proposed, the difference is, that I'm not reading
 register and waiting for some milliseconds)

...then, you check a boolean variable...

(similar what I have done with a 'break' statement)

...and at last we have check the iteration counter.

(this same in both cases).

So, I'm puzzled how your cases works reliably if it based on msleep().
With enough slow baud rate you won't get fix working AFAIU.
Where am I wrong?

-- 
With Best Regards,
Andy Shevchenko


