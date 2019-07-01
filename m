Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 235F925276
	for <lists+linux-serial@lfdr.de>; Tue, 21 May 2019 16:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfEUOpi (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 May 2019 10:45:38 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com ([46.30.210.184]:61012
        "EHLO mailrelay3-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728127AbfEUOpi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 May 2019 10:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=yF1kMxbfKY3mIBf7ir1NBO1NbSFFsSvtntMmQyMq9Aw=;
        b=ZhV6rE2WAMz9SU9zP8bAHcLFgqC1u4PEToUb2Q5BR3ZghoTPLhTZyvTVIZgCSHa/4OI6avgNyHblE
         kedcV520GR18HmJzOw54xadc3hRSfzE9KlTr9ti2HXlTqi03WA8tGtxgzuiB32LngZtvGakwk7EnXR
         SbBHEL7Ngbmh6BXM=
X-HalOne-Cookie: 2a52dc17793368b569374440271801bbe3f97668
X-HalOne-ID: 172c70b3-7bd7-11e9-a0e1-d0431ea8bb03
Received: from localhost (unknown [193.163.1.7])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 172c70b3-7bd7-11e9-a0e1-d0431ea8bb03;
        Tue, 21 May 2019 14:45:35 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Enrico Weigelt <lkml@metux.net>, Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] serial: 8250: Add support for using platform_device resources
References: <20190430140416.4707-1-esben@geanix.com>
        <20190521113426.16790-1-esben@geanix.com>
        <20190521131131.GA19685@kroah.com>
Date:   Tue, 21 May 2019 16:45:34 +0200
In-Reply-To: <20190521131131.GA19685@kroah.com> (Greg Kroah-Hartman's message
        of "Tue, 21 May 2019 15:11:31 +0200")
Message-ID: <878suzn9wx.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, May 21, 2019 at 01:34:26PM +0200, Esben Haabendal wrote:
>> Allow getting memory resource (mapbase or iobase) as well as irq from
>> platform_device resources.
>> 
>> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
>> resources are to be used.  When not set, driver behaves as before.
>
> Nothing actually sets this flag in this patch, so I can't take this as
> you are adding new features that no one uses :(
>
> Where is the driver that sets this?

It sits here.  It is a rather big and clunky mfd driver, not ready for
upstreaming in its current form.  I hope to get around to clean it up.
But it is for a very specific hardware that is really available or
usable for anybody else.  Does it make sense to spend effort on
submitting such a driver?

/Esben
