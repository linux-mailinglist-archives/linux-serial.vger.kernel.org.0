Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63C986166
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 14:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfHHMLx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 08:11:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:65046 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfHHMLx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 08:11:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 05:11:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="374831655"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2019 05:11:50 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hvhGm-0002bH-36; Thu, 08 Aug 2019 15:11:48 +0300
Date:   Thu, 8 Aug 2019 15:11:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Robert Middleton <robert.middleton@rm5248.com>,
        Aaron Sierra <asierra@xes-inc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
Message-ID: <20190808121148.GT30120@smile.fi.intel.com>
References: <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
 <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com>
 <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
 <20190806152407.GF30120@smile.fi.intel.com>
 <20190806153110.GG30120@smile.fi.intel.com>
 <CAKpcJVYTC8MN6A51iip=cyvkfXVy2NS-c3FyhAi9qcxsgJkQRw@mail.gmail.com>
 <CAKpcJVaL-BqL0G=_hT6WHz6kCr05sHS1jDQnaM0s_WFWCb6n_A@mail.gmail.com>
 <20190807150425.GC30120@smile.fi.intel.com>
 <CAKpcJVYmTK-kw5eZJtcMWBSMmOk4ijqu-1oh9cEswi4q98QHAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKpcJVYmTK-kw5eZJtcMWBSMmOk4ijqu-1oh9cEswi4q98QHAg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 07, 2019 at 02:41:47PM -0400, Robert Middleton wrote:
> On Wed, Aug 7, 2019 at 11:04 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Aug 07, 2019 at 09:48:03AM -0400, Robert Middleton wrote:
> > > > I'll try to get some firm results in the morning; otherwise I won't be
> > > > able to check until early next week as I will be away from the
> > > > hardware.
> > >
> > > After doing more testing, I think that I finally have something that
> > > is working fully at all baud rates.  I've tested this at
> > > 115200,9600,and 4800, testing via: echo "the quick brown fox jumps
> > > over the lazy dog" > /dev/ttySx
> > >
> > > Removing the check to uart_circ_empty in the while loop makes it more
> > > reliable, however it will occasionally fail and only transmit the
> > > first part of the message(at 4800, it will transmit only "t", at
> > > 115200 it will transmit "the quick bro").
> >
> > I'm not sure about the loop for uart_circ_empty(). Can you try 2-3 kB of text
> > at lower baud rate, let's say 2400 or so?
> 
> So at the lower baud rate, it does not transmit all of the data,
> probably because the timeout eventually stops it.  However, it does
> get back into a very weird state that I have seen before, where
> opening up the port again will cause it to transmit some of the
> previously-buffered data.  See below for some more details.
> 
> > > I've found that breaking it
> > > into two loops, one checking the uart_circ_empty and the other doing
> > > the LSR check is reliable at all baud rates.
> >
> > If my suspicion is correct, the shutdown of the port will take ages which is
> > inappropriate.
> 
> The shutdown probably does take a while, but the fact that not all of
> the data is transmitted is what tripped me up in the first place and
> sent me down this track trying to figure out why all of the data was
> not being transmitted out of the serial port properly.
> 
> The previous hardware used an FTDI USB to serial converter to send
> serial data, and changing to the exar caused some of our applications
> to stop working. They do a similar thing to echoing from the terminal,
> that is they come up, send a command, and then exit.  I tried just now
> with an FTDI cable and got some interesting results vs. using the
> exar.  The data(3kB) gets fully transmitted when I do 'cat
> lorem-ipsum.txt > /dev/ttyUSB0', but when I do it via 'cat
> lorem-ipsum.txt > /dev/exar-serial' it will timeout after a second.
> Doing an 'echo "" > /dev/exar-serial' will send more of the text,
> until it stops again.  I have to do this about 5 times before all of
> the data gets transmitted over the serial port.  This is also at 2400
> baud on both the exar and the FTDI.

8250 driver has device nodes like /dev/ttySxxx. Just to be sure are you really
using kernel's native driver?

> At this point, this leads me to believe that there is actually a more
> fundamental problem with the 8250 driver and flushing data.  I was
> focusing more on the exar, since that is the only hardware that I have
> available that uses the 8250 driver.

Hmm... It's weird that no-one else had noticed so far an issue.

In any case I would recommend to include Exar driver related people in case of
specific behaviour of the hardware you are testing on.

I'm Cc'ing them now.

Sorry guys, I forgot to do this earlier, nevertheless I left the text of
Robert's last mail untouched.

-- 
With Best Regards,
Andy Shevchenko


