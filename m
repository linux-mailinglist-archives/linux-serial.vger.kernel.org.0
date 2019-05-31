Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96B6131137
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfEaPXx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 11:23:53 -0400
Received: from mail.javad.com ([54.86.164.124]:57122 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfEaPXv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 11:23:51 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id D368C3E8ED;
        Fri, 31 May 2019 15:23:49 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=gXxyZRFO;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1559316230;
        bh=QMr8ldr7ud8h6i9SGmbIA7ScYZkdCuC+qiGejlno6Fg=; l=1135;
        h=Received:From:To:Subject;
        b=gXxyZRFOG5U/LPfEzHwgztjNldKwVJseDpnjCjJ0ySve+mR3Z+yl8HUmZ1CGBnTF0
         j+a9XY8Hp/J3Pkgp5umPgBFyDmZGFx7j494m5zQax+Kvf65quto8QqgfnYXdia6hVP
         MDwU1z0j/6YlrCB3s1gor6HU71ISmigfNzw/Lr/g=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1hWjNk-0002MS-7m; Fri, 31 May 2019 18:23:48 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/8] serial: imx: fix DTR inversion
References: <20190530152950.25377-1-sorganov@gmail.com>
        <20190530152950.25377-2-sorganov@gmail.com>
        <20190530205313.uwue3q2t5tp2vwz6@pengutronix.de>
        <87ftovw7h8.fsf@javad.com>
        <20190531051430.yojydtk63vkuektg@pengutronix.de>
        <87ef4fup0h.fsf@javad.com>
        <20190531064448.llskliwcqdeagjb4@pengutronix.de>
Date:   Fri, 31 May 2019 18:23:48 +0300
In-Reply-To: <20190531064448.llskliwcqdeagjb4@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Fri, 31 May 2019 08:44:48
 +0200")
Message-ID: <877ea6d4vv.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> Hello Sergey,
>
> On Fri, May 31, 2019 at 09:17:02AM +0300, Sergey Organov wrote:
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> 
>> > On Fri, May 31, 2019 at 07:52:51AM +0300, Sergey Organov wrote:
>> >> My best reasoning was that  DSR/ DTR is likely implemented the same as
>> >> CTS/ RTS in the metal, and I found other drivers where both RTS and DSR
>> >> are inverted, so I guessed it could be a remnant of old copy-paste.
>> >
>> > This is not a good enough reason to "fix" that.
>> 
>> Yeah, I agree. I rather mostly kept it in the series not to forget about
>> the issue. I should have said that in the comments, sorry.
>
> Then also sort this to the end of the series to allow clean application
> of the patches you are sure about and mark the questionable patches as
> RFC or RFT.

I'm not sure we shouldn't actually fix it. Can we get help from NXP for
clarification on the issue? I'm still 90% sure it's a bug.

The rest of the series should apply clearly independent on this one, but
I'll re-check anyway.

-- Sergey
