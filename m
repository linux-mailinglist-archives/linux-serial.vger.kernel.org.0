Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F68E7E034
	for <lists+linux-serial@lfdr.de>; Thu,  1 Aug 2019 18:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfHAQbI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 1 Aug 2019 12:31:08 -0400
Received: from xes-mad.com ([162.248.234.2]:11915 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfHAQbI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Aug 2019 12:31:08 -0400
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id E4BD3202C3;
        Thu,  1 Aug 2019 11:31:07 -0500 (CDT)
Date:   Thu, 1 Aug 2019 11:31:05 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <206899620.184134.1564677065784.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20190801151202.GA24347@kroah.com>
References: <20190731174545.8192-1-asierra@xes-inc.com> <20190801151202.GA24347@kroah.com>
Subject: Re: [PATCH] serial: 8250_exar: Absorb remaining 8250_port INT0
 support
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.7.5_GA_1764 (ZimbraWebClient - GC75 (Linux)/8.7.5_GA_1764)
Thread-Topic: serial: 8250_exar: Absorb remaining 8250_port INT0 support
Thread-Index: 6E3km9d404fvblDarSrp021IOXq3YQ==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

----- Original Message -----
> From: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> To: "Aaron Sierra" <asierra@xes-inc.com>
> Sent: Thursday, August 1, 2019 10:12:02 AM

> On Wed, Jul 31, 2019 at 12:45:45PM -0500, Aaron Sierra wrote:
>> Move INT0 clearing out of common, per-port serial8250_do_startup()
>> into PCI device probe/resume.
>> 
>> As described in commit 2c0ac5b48a35 ("serial: exar: Fix stuck MSIs"),
>> the purpose of clearing INT0 is to prevent the PCI interrupt line from
>> becoming stuck asserted, "which is fatal with edge-triggered MSIs".
>> 
>> Like the clearing via interrupt handler that moved from common code in
>> commit c7e1b4059075 ("tty: serial: exar: Relocate sleep wake-up
>> handling"), this clearing at startup can be better handled at the PCI
>> device level.
>> 
>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>> Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> 
>> The embedded patch is written to follow this patch from Andy Shevchenko:
>> [PATCH v4 3/3] serial: 8250_exar: Move custom divisor support out from 8250_port
> 
> It does not apply to my tree after that patch, are you sure about this?
> 
> Please rebase against my tty-testing branch and resend.

Greg,

Sorry about that. I'm running through testing now. I'll submit v2 shortly.

Aaron
