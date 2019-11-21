Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E6104F4E
	for <lists+linux-serial@lfdr.de>; Thu, 21 Nov 2019 10:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKUJdX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 21 Nov 2019 04:33:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:57450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbfKUJdX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Nov 2019 04:33:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32A5AB11E;
        Thu, 21 Nov 2019 09:33:21 +0000 (UTC)
Date:   Thu, 21 Nov 2019 10:33:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Jonathan Richardson <jonathan.richardson@broadcom.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        sergey.senozhatsky@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: console output duplicated when registering additional consoles
Message-ID: <20191121093320.v6ki2zu2tktcj357@pathway.suse.cz>
References: <CAHrpVsUHgJA3wjh4fDg43y5OFCCvQb-HSRpyGyhFEKXcWw8WnQ@mail.gmail.com>
 <CAHrpVsW6jRUYK_mu+dLaBvucAAtUPQ0zcH6_NxsUsTrPewiY_w@mail.gmail.com>
 <20191114095737.wl5nvxu3w6p5thfc@pathway.suse.cz>
 <20191115043356.GA220831@google.com>
 <CAHrpVsWu54rKg3bGhY6WVj5d-myYxGSEkxGhOJKTyyc1EH4qOA@mail.gmail.com>
 <20191119003457.GA208047@google.com>
 <CAHrpVsV2Y4ZNRSJ58J0f_E0=aC8VfwvO56mfcdkXxCsJbAF3qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpVsV2Y4ZNRSJ58J0f_E0=aC8VfwvO56mfcdkXxCsJbAF3qA@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue 2019-11-19 10:46:22, Jonathan Richardson wrote:
> > > not just when a normal con replaces a bootconsole. A simple way of
> > > avoiding the problem I'm seeing is to not even set the CON_PRINTBUFFER
> > > flag on my consoles.
> >
> > This is up to the console driver to decide.
> >
> > > It skips the replay and the output on all consoles looks fine. The flag
> > > is only used by register_console(), although I don't think that is the
> > > intended usage? There are no console drivers that do this.
> >
> > Not sure I'm following. There are consoles that want all logbuf messages
> > once those consoles are available.
> 
> I meant mine would be the only driver that didn't set CON_PRINTBUFFER.
> Thanks for clarifying why it would be set. I guess what I didn't
> understand is why are all the consoles updated (potentially) when a
> new console is registered. As I mentioned before I can not set
> CON_PRINTBUFFER to avoid the issue but it's probably not what I want.
> I would possibly lose some of the log I guess if there was something
> in the buffer during registration of the new console.

Exactly, many things happen before and during the console
registration. There might already be (are) several messages when
new consoles are registered.

Now, people register more different consoles for different purpose.
For example, one is shown on a display, another can be stored by
an external device. It makes sense to show all messages on
all interfaces.

It can cause duplicated messages because there is no support to match
proper console with the early one. The current console registration
code somehow works only with one early console.

Best Regards,
Petr
