Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A53084F66
	for <lists+linux-serial@lfdr.de>; Wed,  7 Aug 2019 17:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfHGPE2 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 7 Aug 2019 11:04:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:53877 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbfHGPE2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Aug 2019 11:04:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 08:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="325989167"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga004.jf.intel.com with ESMTP; 07 Aug 2019 08:04:27 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hvNUH-0003pw-Ei; Wed, 07 Aug 2019 18:04:25 +0300
Date:   Wed, 7 Aug 2019 18:04:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Robert Middleton <robert.middleton@rm5248.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
Message-ID: <20190807150425.GC30120@smile.fi.intel.com>
References: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
 <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
 <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com>
 <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
 <20190806152407.GF30120@smile.fi.intel.com>
 <20190806153110.GG30120@smile.fi.intel.com>
 <CAKpcJVYTC8MN6A51iip=cyvkfXVy2NS-c3FyhAi9qcxsgJkQRw@mail.gmail.com>
 <CAKpcJVaL-BqL0G=_hT6WHz6kCr05sHS1jDQnaM0s_WFWCb6n_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKpcJVaL-BqL0G=_hT6WHz6kCr05sHS1jDQnaM0s_WFWCb6n_A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 07, 2019 at 09:48:03AM -0400, Robert Middleton wrote:
> > I'll try to get some firm results in the morning; otherwise I won't be
> > able to check until early next week as I will be away from the
> > hardware.
> 
> After doing more testing, I think that I finally have something that
> is working fully at all baud rates.  I've tested this at
> 115200,9600,and 4800, testing via: echo "the quick brown fox jumps
> over the lazy dog" > /dev/ttySx
> 
> Removing the check to uart_circ_empty in the while loop makes it more
> reliable, however it will occasionally fail and only transmit the
> first part of the message(at 4800, it will transmit only "t", at
> 115200 it will transmit "the quick bro").

I'm not sure about the loop for uart_circ_empty(). Can you try 2-3 kB of text
at lower baud rate, let's say 2400 or so?

> I've found that breaking it
> into two loops, one checking the uart_circ_empty and the other doing
> the LSR check is reliable at all baud rates.

If my suspicion is correct, the shutdown of the port will take ages which is
inappropriate.

> I can do a formal patch later, but I just wanted to see if this made
> sense first.  The second loop is now much simpler, and does not do the
> buffer check at the same time, which was probably causing some
> problems with the previous version.

Thank you for this wise move, I appreciate.

-- 
With Best Regards,
Andy Shevchenko


