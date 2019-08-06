Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6A183528
	for <lists+linux-serial@lfdr.de>; Tue,  6 Aug 2019 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfHFPYL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 11:24:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:26709 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbfHFPYL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 11:24:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 08:24:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="374086563"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2019 08:24:09 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hv1Jn-0001D5-Qd; Tue, 06 Aug 2019 18:24:07 +0300
Date:   Tue, 6 Aug 2019 18:24:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Robert Middleton <robert.middleton@rm5248.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
Message-ID: <20190806152407.GF30120@smile.fi.intel.com>
References: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
 <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
 <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com>
 <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 06, 2019 at 09:40:41AM -0400, Robert Middleton wrote:
> On Mon, Aug 5, 2019 at 10:22 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Aug 05, 2019 at 09:49:24AM -0400, Robert Middleton wrote:
> >
> > Thanks for testing, my comments below.
> >
> > > Unfortunately this will re-introduce the bug that it was attempting to
> > > solve, that is ensuring that the buffer in the kernel and the buffer
> > > on the chip are clear before going into shutdown on the chip.
> > > Breaking at the beginning of the loop means that the kernel has
> > > written everything to the internal buffer on the chip, but until the
> > > LSR bits are clear the bytes have not been transmitted yet.
> >
> > So, the difference here, that you have a long delay with mdelay(1) which
> > "fixes" your issue.
> 
> The important fix is really this part:
> lsr = serial_in(up, UART_LSR);
> if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
> 
> Both of those bits must be set before the shutdown can occur.  The
> msleep(1) is so that it is not a busy loop(maybe usleep_range would be
> better?).
> If the transmitter is not empty and the transmitter FIFO is
> not empty, when the shutdown occurs the remaining data will be
> discarded by the exar chip.  Assuming the FIFO on the exar is full(256
> bytes to transmit), it would take ~250ms to transmit all of the bytes
> at 9600 baud, so our check would happen ~250 times(assuming mdelay(1)
> sleeps for 1ms and not up to 20).
> 
> This is based off of the reference driver from Max Linear:
> https://github.com/rm5248/exar-driver/blob/5dcbac6aa564cf5604512ecd6c9e02c577b70fa2/xr17v35x.c#L1282

I see, you explicitly force to continue in your case.
Thanks for explanation.

> > I guess the third patch in this series makes it again not-working.
> > Can you check and confirm that?
> 
> I don't see a third patch.

It's here [1].

> > Or even better, replace entire loop with one usleep_range() call and play with
> > numbers there, like (10, 20), (100, 150), (1000, 1100). Probably you can start
> > with udelay(2) followed up by above list.
> >
> > If my theory is correct you will see at some point the problem will disappear.
> 
> It would probably disappear, but if you remove the entire loop and LSR
> check you can't be sure that the data has actually been transmitted
> out of the exar chip.  Likely this would result in a different number
> of bytes being dropped depending on the baud rate and how large the
> buffer was when shutdown occurs.

I had sent v3 [2] without altering the algorithm, just one refactoring (patch 1)
and switching to usleep_range() for delay (patch 2).

Can you test that conversion still works for you?

[1]: https://www.spinics.net/lists/linux-serial/msg35412.html
[2]: https://www.spinics.net/lists/linux-serial/msg35444.html

-- 
With Best Regards,
Andy Shevchenko


