Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5B27CA10
	for <lists+linux-serial@lfdr.de>; Wed, 31 Jul 2019 19:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfGaRNx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 31 Jul 2019 13:13:53 -0400
Received: from xes-mad.com ([162.248.234.2]:30951 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfGaRNx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Jul 2019 13:13:53 -0400
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id 1DF252026D;
        Wed, 31 Jul 2019 12:13:52 -0500 (CDT)
Date:   Wed, 31 Jul 2019 12:13:50 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Message-ID: <161836634.223880.1564593230004.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20190731170511.GQ23480@smile.fi.intel.com>
References: <20190721142659.60773-1-andriy.shevchenko@linux.intel.com> <1785128142.57495.1564351929356.JavaMail.zimbra@xes-inc.com> <20190729120059.GD23480@smile.fi.intel.com> <708985591.123086.1564413111128.JavaMail.zimbra@xes-inc.com> <20190730090159.GH23480@smile.fi.intel.com> <1516192036.531051.1564527522157.JavaMail.zimbra@xes-inc.com> <20190731170511.GQ23480@smile.fi.intel.com>
Subject: Re: [PATCH v3] serial: 8250_exar: Move the Exar bits out from
 8250_port
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.7.5_GA_1764 (ZimbraWebClient - GC75 (Linux)/8.7.5_GA_1764)
Thread-Topic: serial: 8250_exar: Move the Exar bits out from 8250_port
Thread-Index: 2HhVXydau/Z6IvQFscH7Lfgbx5U6bA==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

----- Original Message -----
> From: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
> To: "Aaron Sierra" <asierra@xes-inc.com>
> Sent: Wednesday, July 31, 2019 12:05:11 PM

> On Tue, Jul 30, 2019 at 05:58:42PM -0500, Aaron Sierra wrote:
> 
>> Sure, I can do that. You're saying that you'd submit a patch for the INT0
>> removal as the last patch in your series?
> 
> I meant to add to the bunch, but since I'm about to send a new version and
> didn't see anything from you it can be sent separately with dependency
> reference.

Andy,

No problem. I had a patch ready yesterday, but had a last minute question
for Sudip about suspend/resume. I got his answer this morning and I just
completed my testing.

Aaron
