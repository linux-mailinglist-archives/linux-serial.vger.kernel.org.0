Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E9B7B5F7
	for <lists+linux-serial@lfdr.de>; Wed, 31 Jul 2019 00:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfG3W6v (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 30 Jul 2019 18:58:51 -0400
Received: from xes-mad.com ([162.248.234.2]:1210 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfG3W6v (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Jul 2019 18:58:51 -0400
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id 4413F2024D;
        Tue, 30 Jul 2019 17:58:44 -0500 (CDT)
Date:   Tue, 30 Jul 2019 17:58:42 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Message-ID: <1516192036.531051.1564527522157.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20190730090159.GH23480@smile.fi.intel.com>
References: <20190721142659.60773-1-andriy.shevchenko@linux.intel.com> <1785128142.57495.1564351929356.JavaMail.zimbra@xes-inc.com> <20190729120059.GD23480@smile.fi.intel.com> <708985591.123086.1564413111128.JavaMail.zimbra@xes-inc.com> <20190730090159.GH23480@smile.fi.intel.com>
Subject: Re: [PATCH v3] serial: 8250_exar: Move the Exar bits out from
 8250_port
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.7.5_GA_1764 (ZimbraWebClient - GC75 (Linux)/8.7.5_GA_1764)
Thread-Topic: serial: 8250_exar: Move the Exar bits out from 8250_port
Thread-Index: DyR+zYHS+AAS+nzmx3EHBjj0SPflQg==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

----- Original Message -----
> From: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
> To: "Aaron Sierra" <asierra@xes-inc.com>
> Sent: Tuesday, July 30, 2019 4:01:59 AM

> On Mon, Jul 29, 2019 at 10:11:51AM -0500, Aaron Sierra wrote:
>> ----- Original Message -----
>> > From: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
>> > To: "Aaron Sierra" <asierra@xes-inc.com>
>> > Sent: Monday, July 29, 2019 7:00:59 AM
>> > On Sun, Jul 28, 2019 at 05:12:09PM -0500, Aaron Sierra wrote:
>> >> ----- Original Message -----
>> >> > From: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
>> >> > Sent: Sunday, July 21, 2019 9:26:59 AM
> 
>> > I'm not so familiar with the hardware, will it not give any side-effects?
>> 
>> Clearing INT0 prevents PCI interrupts from getting stuck, either on in the
>> case of level-sensitive interrupts (e.g. INTx) or apparently-off in the case
>> of edge-sensitive interrupts (e.g. MSI), due to sources outside of the
>> typical 8250 serial port scope. Interrupts due to port wake-up after
>> idle/sleep are the best documented problem case.
>> 
>> I do not think it was ever ideal that each port cleared INT0 multiple times
>> during startup. Clearing INT0 after we register the interrupt handler
>> responsible for INT0 should be enough to ensure that we won't run into either
>> case. The handler runs even if no ports are "up", so individual ports don't
>> have to worry so much.
>> 
>> My original suggestion was incomplete in its handling of PCI device
>> suspense/resume. A complete solution would read INT0 in exar_resume(), too.
> 
> Thanks for explanation, perhaps you can prepare a follow up on top on my series.

Andy,

Sure, I can do that. You're saying that you'd submit a patch for the INT0
removal as the last patch in your series?

>> > So, I prefer do this in a separate change, so we may see how it goes.
>> 
>> I think it's fine to defer this change to a later patch, but I would like to
>> see the commit message body for the current patch be more explicit that it is
>> not moving *all* Exar quirks. I wonder, too, if these should be broken
>> down into separate patches for the three classes of quirks that you move:
>> 
>>   * autoconfig_16550a()
>>   * serial8250_do_[get|set]_divisor()
>>   * serial8250_set_sleep()
> 
> Yes, this will be better in case if some problems would be discovered in the
> future, hope none.
> 
> So, let me split this to three, and then, if you have a chance to provide the
> one described above, I will chain it to the series.

I'll send it to you privately.

Aaron

> --
> With Best Regards,
> Andy Shevchenko
