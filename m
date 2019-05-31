Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A013083E
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 08:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfEaGED (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 02:04:03 -0400
Received: from mail.javad.com ([54.86.164.124]:43521 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaGED (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 02:04:03 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id BDB8F3E8A0;
        Fri, 31 May 2019 06:04:01 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=lEYMMnUc;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1559282642;
        bh=p57IBuvPgZzeK8FM94zeODCLBWMV+V4glny4yqODchE=; l=2161;
        h=Received:From:To:Subject;
        b=lEYMMnUcseWXnJM08MChWY4RJMJ/8HQD9qA9dyOT/xUj4aDorZdaYlmRp7Ru7G+dj
         +2H8c3YPf/Ylkpxy7Cc80DCIKVUeHyTo3vVWbbpVvBLGGK1dtWiKjMyynT0TfG6rh6
         rfY8VqbcsS+JUBR2ddK9ru+APjxW2Dp59c+m9asY=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1hWae0-0003DB-0v; Fri, 31 May 2019 09:04:00 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 3/8] serial: imx: preserve RTS state over termios change
References: <20190530152950.25377-1-sorganov@gmail.com>
        <20190530152950.25377-4-sorganov@gmail.com>
        <20190530210824.rf2aaxumcc3cnc5c@pengutronix.de>
Date:   Fri, 31 May 2019 09:03:59 +0300
In-Reply-To: <20190530210824.rf2aaxumcc3cnc5c@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu, 30 May 2019 23:08:24
 +0200")
Message-ID: <87r28fupm8.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Thu, May 30, 2019 at 06:29:45PM +0300, Sergey Organov wrote:
>> imx_set_mctrl() cleared RTS on every call
>
>
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 6577552..13face9 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1648,7 +1648,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>>  
>>  	/* then, disable everything */
>>  	imx_uart_writel(sport, old_ucr2 & ~(UCR2_TXEN | UCR2_RXEN | UCR2_ATEN), UCR2);
>> -	old_ucr2 &= (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN);
>>  
>>  	/* custom-baudrate handling */
>>  	div = sport->port.uartclk / (baud * 16);
>> @@ -1686,7 +1685,8 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>>  
>>  	imx_uart_writel(sport, old_ucr1, UCR1);
>>  
>> -	/* set the parity, stop bits and data size */
>> +	/* Set parity, stop bits, data size, etc. Keep bits we don't compute. */
>> +	old_ucr2 &= (UCR2_CTS | UCR2_TXEN | UCR2_RXEN | UCR2_ATEN);
>
> I wonder if that fixes a certain usecase and breaks another.
>
> If I change the baud rate of the UART the sequence I actually want to
> have is:
>
> 	clear RTS (to not encourage the other side to send data)
> 	disable receiver
> 	reconfigure requested settings
> 	reenable receiver
> 	(maybe) reactivate RTS to signal being ready again

Sorry, I fail to see how this patch breaks anything here. It just now
correctly does:

> 	(maybe) reactivate RTS to signal being ready again

step, touching nothing else.

Please notice that the line

>> -	old_ucr2 &= (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN);

just changes internal variable, and changed to:

>> +	old_ucr2 &= (UCR2_CTS | UCR2_TXEN | UCR2_RXEN | UCR2_ATEN);

exactly to restore RTS state at exit.

It's then moved down to where it's used, to make code and comments
clearer. I decided it's too much granularity to break this into 2
separate patches.

-- Sergey
