Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8113081EF0
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2019 16:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfHEOWU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 5 Aug 2019 10:22:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:53811 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfHEOWU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Aug 2019 10:22:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 07:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="164665736"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2019 07:21:49 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hudrv-0000lB-MW; Mon, 05 Aug 2019 17:21:47 +0300
Date:   Mon, 5 Aug 2019 17:21:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Robert Middleton <robert.middleton@rm5248.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
Message-ID: <20190805142147.GK23480@smile.fi.intel.com>
References: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
 <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
 <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 05, 2019 at 09:49:24AM -0400, Robert Middleton wrote:

Thanks for testing, my comments below.

> Unfortunately this will re-introduce the bug that it was attempting to
> solve, that is ensuring that the buffer in the kernel and the buffer
> on the chip are clear before going into shutdown on the chip.
> Breaking at the beginning of the loop means that the kernel has
> written everything to the internal buffer on the chip, but until the
> LSR bits are clear the bytes have not been transmitted yet.

So, the difference here, that you have a long delay with mdelay(1) which
"fixes" your issue.

I guess the third patch in this series makes it again not-working.
Can you check and confirm that?

Or even better, replace entire loop with one usleep_range() call and play with
numbers there, like (10, 20), (100, 150), (1000, 1100). Probably you can start
with udelay(2) followed up by above list.

If my theory is correct you will see at some point the problem will disappear.

> I'm not positive that the uart_circ_empty needs to be checked in the
> first place; I had put it in because the serial8250_tx_chars does that
> before stopping the tx, and I assume that there could be a potential
> race condition where the kernel has not yet written all the data to
> the exar, but the exar has finished transmitting all the data in its
> transmit buffer(I am not sure how likely this is to happen).

tty gets uninitialized before ->shutdown() happen, it also set's TTY IO error
condition, which has been checked in tty_write(). I'm sure new data will not
come at this point.

-- 
With Best Regards,
Andy Shevchenko


