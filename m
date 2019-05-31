Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233F1307F6
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 07:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfEaFBE (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 01:01:04 -0400
Received: from mail.javad.com ([54.86.164.124]:47232 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfEaFBE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 01:01:04 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 May 2019 01:01:03 EDT
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 485EA5453E;
        Fri, 31 May 2019 04:52:53 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=D6fbplbA;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1559278373;
        bh=TgQ9Enwu6nfLEEyDxoFWboTMBuKxJZVYiVkJUZ+vV1Q=; l=2142;
        h=Received:From:To:Subject;
        b=D6fbplbAA5yPe3MK+cLPctBr2rVv594oV8D5vxIeGqB5HEDAVH+COdhPoL1O2+492
         ws7suAcTz+tmv3dQ64bSNoJD3pvPl/pm/Rzml/3vOB2nT4mF0DXp2wLZgTNyoxszr+
         vA+WCFEctIjMoPa2zJ4gVvmYO1qzLbCyOtWfiS10=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1hWZX9-00037e-JR; Fri, 31 May 2019 07:52:51 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/8] serial: imx: fix DTR inversion
References: <20190530152950.25377-1-sorganov@gmail.com>
        <20190530152950.25377-2-sorganov@gmail.com>
        <20190530205313.uwue3q2t5tp2vwz6@pengutronix.de>
Date:   Fri, 31 May 2019 07:52:51 +0300
In-Reply-To: <20190530205313.uwue3q2t5tp2vwz6@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu, 30 May 2019 22:53:13
 +0200")
Message-ID: <87ftovw7h8.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Thu, May 30, 2019 at 06:29:43PM +0300, Sergey Organov wrote:
>> imx_set_mctrl() had TIOCM_DTR meaning inverted
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index dff75dc..e9e812a 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -974,7 +974,7 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>>  	}
>>  
>>  	ucr3 = imx_uart_readl(sport, UCR3) & ~UCR3_DSR;
>> -	if (!(mctrl & TIOCM_DTR))
>> +	if (mctrl & TIOCM_DTR)
>>  		ucr3 |= UCR3_DSR;
>>  	imx_uart_writel(sport, ucr3, UCR3);
>
> I'm not sure this is right and your commit log is too short to convince
> me otherwise.
>
> In the past I had several customers that used handshaking on an imx UART
> so I'd be surprised if such a bug would have stayed unnoticed until now.
>
> The i.MX25 Reference manual states:
>
> 	This bit [UCR3_DSR] used by software to control the DSR/DTR output pin
> 	for the modem interface. In DCE mode it applies to DSR and in DTE mode
> 	it applies to DTR.
>
> 		0 DSR/ DTR pin is logic zero
> 		1 DSR/ DTR pin is logic one
>
>
> Semantically if TIOCM_DTR is set in .set_mctrl, the DTR output should
> become active (i.e. low). Without testing I'm not sure if "active"
> corresponds to "logic one" which would make your patch correct.

Yeah, I was not sure myself, and this pin is not wired on my board, so
in fact I can't check either.

Unfortunately, the language in the manual is inconsistent. For CTS/ RTS
is clearly says:

0 The CTS_B pin is high (inactive)
1 The CTS_B pin is low (active)

and the code in the driver is:

		if (mctrl & TIOCM_RTS)
			ucr2 |= UCR2_CTS;

that works correct.

My best reasoning was that  DSR/ DTR is likely implemented the same as
CTS/ RTS in the metal, and I found other drivers where both RTS and DSR
are inverted, so I guessed it could be a remnant of old copy-paste.

-- Sergey
