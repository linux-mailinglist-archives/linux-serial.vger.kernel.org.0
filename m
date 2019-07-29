Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94FE78EC9
	for <lists+linux-serial@lfdr.de>; Mon, 29 Jul 2019 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbfG2PLz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 29 Jul 2019 11:11:55 -0400
Received: from xes-mad.com ([162.248.234.2]:45894 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387402AbfG2PLy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Jul 2019 11:11:54 -0400
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id 2C18C2029F;
        Mon, 29 Jul 2019 10:11:53 -0500 (CDT)
Date:   Mon, 29 Jul 2019 10:11:51 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Message-ID: <708985591.123086.1564413111128.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20190729120059.GD23480@smile.fi.intel.com>
References: <20190721142659.60773-1-andriy.shevchenko@linux.intel.com> <1785128142.57495.1564351929356.JavaMail.zimbra@xes-inc.com> <20190729120059.GD23480@smile.fi.intel.com>
Subject: Re: [PATCH v3] serial: 8250_exar: Move the Exar bits out from
 8250_port
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.7.5_GA_1764 (ZimbraWebClient - GC75 (Linux)/8.7.5_GA_1764)
Thread-Topic: serial: 8250_exar: Move the Exar bits out from 8250_port
Thread-Index: LKY8uapdw0TXHEg8gX9LDd25a6BSiQ==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

----- Original Message -----
> From: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
> To: "Aaron Sierra" <asierra@xes-inc.com>
> Sent: Monday, July 29, 2019 7:00:59 AM

> On Sun, Jul 28, 2019 at 05:12:09PM -0500, Aaron Sierra wrote:
>> ----- Original Message -----
>> > From: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
>> > Sent: Sunday, July 21, 2019 9:26:59 AM
>> 
>> > There are Exar quirks in 8250_port which belong to 8250_exar module.
>> > Move out them to the correct module and do not contaminate generic code
>> > with it.
>> 
>> Andy,
>> 
>> Your changes seem functionally equivalent based on my review and testing.
> 
> Thank you for testing, my answers below.
> 
>> However, based on this commit description, I was expecting more of the
>> Exar-specific code to be moved from 8250_port.c to 8250_exar.c. I think that
>> can reasonably be achieved without too much additional effort.
>> 
>> There are two pieces of Exar-specific support in serial8250_do_startup():
> 
> Actually three.

Andy,

Were you counting "areas" of Exar code? I was counting "classes" of Exar code.
Did I miss something?
 
>> 1. The two reads to clear INT0, could be boiled down to a single read in
>>    exar_pci_probe(), immediately after registering the common IRQ handler.
>>    What do you think?
> 
> I'm not so familiar with the hardware, will it not give any side-effects?

Clearing INT0 prevents PCI interrupts from getting stuck, either on in the
case of level-sensitive interrupts (e.g. INTx) or apparently-off in the case
of edge-sensitive interrupts (e.g. MSI), due to sources outside of the
typical 8250 serial port scope. Interrupts due to port wake-up after
idle/sleep are the best documented problem case.

I do not think it was ever ideal that each port cleared INT0 multiple times
during startup. Clearing INT0 after we register the interrupt handler
responsible for INT0 should be enough to ensure that we won't run into either
case. The handler runs even if no ports are "up", so individual ports don't
have to worry so much.

My original suggestion was incomplete in its handling of PCI device
suspense/resume. A complete solution would read INT0 in exar_resume(), too.

>> 2. The following block could be moved to a new exar_startup() function:
>> 
>> 	if (port->type == PORT_XR17V35X) {
>> 		/*
>> 		 * First enable access to IER [7:5], ISR [5:4], FCR [5:4],
>> 		 * MCR [7:5] and MSR [7:0]
>> 		 */
>> 		serial_port_out(port, UART_XR_EFR, UART_EFR_ECB);
>> 
>> 		/*
>> 		 * Make sure all interrups are masked until initialization is
>> 		 * complete and the FIFOs are cleared
>> 		 */
>> 		serial_port_out(port, UART_IER, 0);
>> 	}
>> 
>>    Do you agree?
> 
> I thought about this, but didn't come to a conclusion to move it right now.
> It's not so straight forward. In the ->startup() we setup IO accessors in some
> cases (perhaps doesn't apply to Exar case) and do some testing.
> 
> So, I prefer do this in a separate change, so we may see how it goes.

I think it's fine to defer this change to a later patch, but I would like to
see the commit message body for the current patch be more explicit that it is
not moving *all* Exar quirks. I wonder, too, if these should be broken
down into separate patches for the three classes of quirks that you move:

  * autoconfig_16550a()
  * serial8250_do_[get|set]_divisor()
  * serial8250_set_sleep()

-Aaron

>> The only thing that seems to need to stay put is UART_XR_EFR support in
>> serial8250_do_set_termios().
> 
> Yes, though ideally it should be moved to 8250_exar as well.

Yes, ideally.

> 
>> There are a couple additional notes below for you to find. One involves a
>> compile warning.
> 
>> > #define UART_EXAR_INT0		0x80
>> 
>> My note above about cleaning up serial8250_do_startup() would eliminate
>> the need for UART_EXAR_INT0 to be defined here, too.
> 
> I see.
> 
>> > -		goto out;
>> 
>> Take the "out" label as well to avoid introducing a compile warning.
> 
> Thanks, I missed it somehow.
> 
> --
> With Best Regards,
> Andy Shevchenko
