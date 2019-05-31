Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 981FE3120B
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfEaQPY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 12:15:24 -0400
Received: from mail.javad.com ([54.86.164.124]:56179 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfEaQPY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 12:15:24 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 15BC13E93B;
        Fri, 31 May 2019 16:15:23 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=b5GxG2eW;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1559319323;
        bh=D3Ta9ei/J2Rm0qPOfCKtB5kSyLzqMc6XNvzDXaPHm9k=; l=2060;
        h=Received:From:To:Subject;
        b=b5GxG2eWWIW9engR2FcNXP1uvFXVI1igeo/KojUJrsdjCOS6ythtaJ62pYc/lG/HY
         9B/cmLWTSLTl2JzDCzmsRHjXLx3THA//CewDtjFWnbQxZK51i0vnsXt5TAlZv3seB0
         5Seu0ZxnIOxGqRpVYV12wDmhXs8IsBLUmirWYcvg=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1hWkBd-0002Pa-Gy; Fri, 31 May 2019 19:15:21 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 4/8] serial: imx: get rid of unbounded busy-waiting loop
References: <20190530152950.25377-1-sorganov@gmail.com>
        <20190530152950.25377-5-sorganov@gmail.com>
        <20190530210059.xt7qlyk57cf3zaux@pengutronix.de>
        <87imtrup3z.fsf@javad.com>
        <20190531064248.qh4tecbv6ejvroyw@pengutronix.de>
Date:   Fri, 31 May 2019 19:15:21 +0300
In-Reply-To: <20190531064248.qh4tecbv6ejvroyw@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Fri, 31 May 2019 08:42:48
 +0200")
Message-ID: <87k1e6bnxi.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> Hello,
>
> On Fri, May 31, 2019 at 09:14:56AM +0300, Sergey Organov wrote:
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> 
>> > On Thu, May 30, 2019 at 06:29:46PM +0300, Sergey Organov wrote:
>> >> imx_set_termios(): remove busy-waiting "drain Tx FIFO" loop. Worse
>> >> yet, it was potentially unbounded wait due to RTS/CTS (hardware)
>> >> handshake.
>> >> 
>> >> Let user space ensure draining is done before termios change, if
>> >> draining is needed in the first place.
>> >
>> > I don't know for sure what the intended behaviour is here, but I tend to
>> > think that changing the unbounded wait to a timeout and then return
>> > -EBUSY (?) would be more suitable.
>> 
>> No, please! Bytes in Tx FIFO are not an excuse to exit with error
>> instead of setting new termios as asked to. 
>
> Well, my suggestion is more defensive. It at least tells the user that
> they do something wrong. If they already care for having the FIFO and
> transmitter empty before changing the baud rate the behaviour of both
> your and my approach are identical. With yours however it undefined if
> characters written to the device before the change are sent with the old
> or new settings. So my suggestions yields a deterministic behaviour
> which is good. And it tells the user when they do something wrong, which
> is good, too.
>
>> > With your change you're possibly breaking existent software.
>> 
>> Well, I suspect the software is already broken then, as most widely used
>> drivers out there seem to do no Tx FIFO draining on set_termios() call,
>> or do they?
>> 
>> I mean I tried to find similar code in some of the other drivers, to
>> replicate it, but I failed to find one.
>
> The first (and only) driver I checked does. (sa1100.c)

I think I'd rather take 8250 as reference implementation, as being most
widely used. Can anybody please tell how 8250 code handles this? Does it
attempt to drain Tx FIFO on termios changes?

-- Sergey
