Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A631C44E
	for <lists+linux-serial@lfdr.de>; Tue, 14 May 2019 10:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfENIA6 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 14 May 2019 04:00:58 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com ([46.30.210.185]:27244
        "EHLO mailrelay4-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbfENIA6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 May 2019 04:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=QlmDVaRpqxxukroinxw3TPJxyM76gDhPC9ypTGUAIq4=;
        b=xtQ7y135cx8t5EkkC0nUAPWeX3hcy1sfumg5qyLt2aA9a9M++qdmephxzHIhiMEhFD94mRNcfx9sX
         4MXCDOxNMX9nGm6X1cqXH8j0Uxuu8N6EqYOi6n4DUf99ec2AwhTszry9zU96x/QoC0dvMiKybErnpD
         P9tqCsoxK3hee0nA=
X-HalOne-Cookie: 3c078f0ae0e520a51c24966b95c318af61496e8f
X-HalOne-ID: 664b6b39-761e-11e9-abc4-d0431ea8bb10
Received: from localhost (unknown [193.163.1.7])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 664b6b39-761e-11e9-abc4-d0431ea8bb10;
        Tue, 14 May 2019 08:00:55 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD function
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-3-esben@geanix.com> <20190507114905.GB29524@dell>
        <87o94ejwrx.fsf@haabendal.dk> <20190507133844.GA6194@dell>
Date:   Tue, 14 May 2019 10:00:54 +0200
In-Reply-To: <20190507133844.GA6194@dell> (Lee Jones's message of "Tue, 7 May
        2019 14:38:44 +0100")
Message-ID: <87bm05mpmx.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> On Tue, 07 May 2019, Esben Haabendal wrote:
>
>> Lee Jones <lee.jones@linaro.org> writes:
>> 
>> > On Fri, 26 Apr 2019, Esben Haabendal wrote:
>> >
>> >> The serial8250-mfd driver is for adding 8250/16550 UART ports as functions
>> >> to an MFD driver.
>> >> 
>> >> When calling mfd_add_device(), platform_data should be a pointer to a
>> >> struct plat_serial8250_port, with proper settings like .flags, .type,
>> >> .iotype, .regshift and .uartclk.  Memory (or ioport) and IRQ should be
>> >> passed as cell resources.
>> >
>> > What?  No, please!
>> >
>> > If you *must* create a whole driver just to be able to use
>> > platform_*() helpers (which I don't think you should), then please
>> > call it something else.  This doesn't have anything to do with MFD.
>> 
>> True.
>> 
>> I really don't think it is a good idea to create a whole driver just to
>> be able to use platform_get_*() helpers.  And if I am forced to do this,
>> because I am unable to convince Andy to improve the standard serial8250
>> driver to support that, it should be called MFD.  The driver would be
>
> I assume you mean "shouldn't"?

Of-course.

>> generally usable for all usecases where platform_get_*() works.
>> 
>> I don't have any idea what to call such a driver.  It really would just
>> be a fork of the current serial8250 driver, just allowing use of
>> platform_get_*(), supporting exactly the same hardware.
>> 
>> I am still hoping that we can find a way to improve serial8250 to be
>> usable in these cases.
>
> Me too.

Unfortunately, I don't seem to be able to convince Andy to accept
something like that.

I might have to do this out-of-tree :(

/Esben
