Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B7330869
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 08:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfEaGRG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 02:17:06 -0400
Received: from mail.javad.com ([54.86.164.124]:60892 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaGRF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 02:17:05 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 589A13E8A4;
        Fri, 31 May 2019 06:17:04 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=gBQ86ZFv;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1559283424;
        bh=TmONL/oPUm+h9UBZaEZTVtqe0XCjK6T84hf9fAT03nY=; l=2722;
        h=Received:From:To:Subject;
        b=gBQ86ZFvqbp++9cHpoMlyJ/U3IjpyRCw6ZVC2W7pL3Kzhv/B7M24wtAF75r78zqXi
         la2LoO3kcYvBYFzYrKWA/RtQ9N2LI/FGdJXlte6CkUot0xu65Z1ammldq5Qrp0v/LF
         NZlhQvcrpmsH3rEyS24fjE+iocPfrRcmASnDtS4Q=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1hWaqc-0003EH-JK; Fri, 31 May 2019 09:17:02 +0300
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
Date:   Fri, 31 May 2019 09:17:02 +0300
In-Reply-To: <20190531051430.yojydtk63vkuektg@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Fri, 31 May 2019 07:14:30
 +0200")
Message-ID: <87ef4fup0h.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Fri, May 31, 2019 at 07:52:51AM +0300, Sergey Organov wrote:
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> 
>> > On Thu, May 30, 2019 at 06:29:43PM +0300, Sergey Organov wrote:
>> >> imx_set_mctrl() had TIOCM_DTR meaning inverted
>> >> 
>> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> >> ---
>> >>  drivers/tty/serial/imx.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> 
>> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> >> index dff75dc..e9e812a 100644
>> >> --- a/drivers/tty/serial/imx.c
>> >> +++ b/drivers/tty/serial/imx.c
>> >> @@ -974,7 +974,7 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>> >>  	}
>> >>  
>> >>  	ucr3 = imx_uart_readl(sport, UCR3) & ~UCR3_DSR;
>> >> -	if (!(mctrl & TIOCM_DTR))
>> >> +	if (mctrl & TIOCM_DTR)
>> >>  		ucr3 |= UCR3_DSR;
>> >>  	imx_uart_writel(sport, ucr3, UCR3);
>> >
>> > I'm not sure this is right and your commit log is too short to convince
>> > me otherwise.
>> >
>> > In the past I had several customers that used handshaking on an imx UART
>> > so I'd be surprised if such a bug would have stayed unnoticed until now.
>> >
>> > The i.MX25 Reference manual states:
>> >
>> > 	This bit [UCR3_DSR] used by software to control the DSR/DTR output pin
>> > 	for the modem interface. In DCE mode it applies to DSR and in DTE mode
>> > 	it applies to DTR.
>> >
>> > 		0 DSR/ DTR pin is logic zero
>> > 		1 DSR/ DTR pin is logic one
>> >
>> >
>> > Semantically if TIOCM_DTR is set in .set_mctrl, the DTR output should
>> > become active (i.e. low). Without testing I'm not sure if "active"
>> > corresponds to "logic one" which would make your patch correct.
>> 
>> Yeah, I was not sure myself, and this pin is not wired on my board, so
>> in fact I can't check either.
>> 
>> Unfortunately, the language in the manual is inconsistent. For CTS/ RTS
>> is clearly says:
>> 
>> 0 The CTS_B pin is high (inactive)
>> 1 The CTS_B pin is low (active)
>
> Ack.
>
> @NXP: Maybe you can pick up this and improve the documentation here.
>
>> and the code in the driver is:
>> 
>> 		if (mctrl & TIOCM_RTS)
>> 			ucr2 |= UCR2_CTS;
>> 
>> that works correct.
>> 
>> My best reasoning was that  DSR/ DTR is likely implemented the same as
>> CTS/ RTS in the metal, and I found other drivers where both RTS and DSR
>> are inverted, so I guessed it could be a remnant of old copy-paste.
>
> This is not a good enough reason to "fix" that.

Yeah, I agree. I rather mostly kept it in the series not to forget about
the issue. I should have said that in the comments, sorry.

-- Sergey
