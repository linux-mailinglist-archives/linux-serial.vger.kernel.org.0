Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1444730819
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 07:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfEaFdS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 01:33:18 -0400
Received: from mail.javad.com ([54.86.164.124]:32944 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaFdS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 01:33:18 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A229854540;
        Fri, 31 May 2019 05:33:16 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=jt/F4ioV;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1559280797;
        bh=K0T/OnmBWVRW4hkdN1iuzne2RnBgwAHrwCt1fsfUh7w=; l=3563;
        h=Received:From:To:Subject;
        b=jt/F4ioVqqaQml3l1yij5cJ38SrXUrmRoC9c+bsYridYamHwb6aF73cF7xDln/3uJ
         pBJXaQ8lOGzHAay1C3/D7eWQaVmhj/l5OtW+5iS4VoONKwshgj7yuHC7uCXPEfP13k
         8Rc1HqozjXjCp9hTjHrmS3plsEDN9CN9D3J0LmRg=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1hWaAF-0003Ak-3c; Fri, 31 May 2019 08:33:15 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 2/8] serial: imx: fix breaking RTS/CTS handshake by mctrl change
References: <20190530152950.25377-1-sorganov@gmail.com>
        <20190530152950.25377-3-sorganov@gmail.com>
        <20190530203931.n6b22ktbzuyg67sd@pengutronix.de>
Date:   Fri, 31 May 2019 08:33:15 +0300
In-Reply-To: <20190530203931.n6b22ktbzuyg67sd@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu, 30 May 2019 22:39:31
 +0200")
Message-ID: <87woi7ur1g.fsf@javad.com>
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
> On Thu, May 30, 2019 at 06:29:44PM +0300, Sergey Organov wrote:
>> imx_set_mctrl() stop fiddling with UCR2_CTSC bit
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index e9e812a..6577552 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -967,9 +967,9 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>>  		u32 ucr2;
>>  
>>  		ucr2 = imx_uart_readl(sport, UCR2);
>> -		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
>> +		ucr2 &= ~UCR2_CTS;
>>  		if (mctrl & TIOCM_RTS)
>> -			ucr2 |= UCR2_CTS | UCR2_CTSC;
>> +			ucr2 |= UCR2_CTS;
>>  		imx_uart_writel(sport, ucr2, UCR2);
>>  	}
>
> I'm sure this patch is wrong. And your change log fails to point out
> what you want to achieve.

Sorry, I somehow thought it's obvious when in fact it appears it isn't.

When user calls ioctl() to set/clear TIOCM_RTS bit from user space, the
RTS/CTS automatic handshake must not be affected. Without this patch
setting TIOCM_RTS to logic 0 turns off RTS/CTS handshake in hardware,
and setting it to logic 1 turns on RTS/CTS handshake in hardware, that
is wrong thing to do in both cases.

I'm sure the patch is the right thing to do here (see below for more
discussion). Just stop fiddling with RTS/CTS handshake bit in
set_mctrl(), and it will work as expected.

>
> Independant of your patch I discussed a problem in imx_uart_set_mctrl()
> with Sascha and Russell (both added to Cc:) earlier this week. In the
> current implementation there are actually two problems.
>
> Currently imx_uart_set_mctrl does:
>
> 	if TIOCM_RTS is set:
> 		let the receiver control the RTS signal
> 	else:
> 		set RTS inactive

Worse. In fact it breaks current UCR2_CTSC state on both branches of the
if, and thus breaks correspondence between CRTSCTS and UCR2_CTSC that
the driver should preserve at all times.

> The bigger problem is that if the UART is configured not to use
> handshaking (CRTSCTS unset) the mode "let the receiver control the RTS
> signal" should not be used.

Once again, that's exactly why we need to stop touching UCR2_CTSC in
set_mctrl().

> The smaller (and irrelevant for correctness) problem is that setting
> UCR2_CTS is a no-op when UCR2_CTSC is also set.

It's not a problem at all. When user wants to drive RTS manually, he
turns off RTS/CTS handshake. When RTS/CTS handshake is turned on,
setting/clearing TIOCM_RTS usually has no effect on the level of the RTS
pin. 

>
> We think the right thing to do is:
>
> 	ucr2 = imx_uart_readl(sport, UCR2);
> 	ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
>
> 	if (mctrl & TIOCM_RTS) {
> 		if (sport->crtscts)
> 			/* let the receiver control RTS */
> 			ucr2 |= UCR2_CTSC;
> 		else
> 			/* Force RTS active */
> 			ucr2 |= UCR2_CTS;
> 	} else {
> 		/* Force RTS inactive, i.e. CTS=0, CTSC=0 */
> 	}
>
> 	imx_uart_writel(sport, ucr2, UCR2);
>
> but AFAICT this isn't tested yet to an end in the use case that Sascha
> currently has and so there isn't a complete patch available yet.

This is still wrong, as it turns off RTS/CTS handshake in hardware on
TIOCM_RTS=0. Once again, set_mctrl() should not touch UCR2_CTSC, -- it's
as simple as that.

I still think it's rather what I did in the patch above is the right
thing to do. It's simple and does the job, no surprises.

-- Sergey
