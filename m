Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF383325A
	for <lists+linux-serial@lfdr.de>; Mon,  3 Jun 2019 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfFCOmP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 3 Jun 2019 10:42:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38289 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbfFCOmP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jun 2019 10:42:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so13824975lfa.5
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2019 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=y9jjv4B5ZEIqBTQG0IWdSaLZKyZ1iTMA3qmY6LYWbAQ=;
        b=Fc2Gr02OwALs7olgFwXlhg7tn54OfTLP2H9Ni5Y4NhJxrqMi1fGag7TtsVFslt+Q6C
         wG2G8bGpLMxzs3Ql6RsK0ZGkpbhIZJF/LmWRoUtZrWyQBG4KB3YXhqpFKo/F+KnrCcM5
         gf+GozDNBkjBfWLaE8d/fj9hsOp2xX0LdbaGmyRLpDBQeNz71KoB8/Dz6W3HyvLFVzAM
         TFctbLES8sfCzuQ/Gy81IWTYMp1JSeJTU21gJiYZ3G5imjF/cbEJbz2UhXPHBRzS+cbG
         ko4Q8FiE9beNEJXiRkk1cCQJNRBNBp4yh2EaheAxoWHGLLBJ7ZvFgA0GuQN8u3xWxhBW
         GCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=y9jjv4B5ZEIqBTQG0IWdSaLZKyZ1iTMA3qmY6LYWbAQ=;
        b=AJ1oUe9uJgR3Fd22gkC8Aei02GzxX28jYkrYGDowbJCf/kXNNJadPylx+/m3cmCFc+
         EceZ1OehOVdgfyN+Alyyen7HkCRONr7LzhNBPEMttTglHtayPK8ihVs8E9MaFu7Seenu
         O08PysJ0TDcvG77J5oIxMyKMO63s/sQHRdNaHQ3wgxicjtPJps/NNjaIgEFDi9+yUyXK
         Boaq3kQn/etzkhxLyoli/rAqakwOmkLBNLqU2tIpROLGygJ6fbynUZntI+bcn6R7C8Fk
         cBui5dOEL8TqyUku91QDvK22rvQOBHmiqDEv+dKmXYRNOQ2ZTfLvgf1Uk7Xusmt4xTZ0
         ve4g==
X-Gm-Message-State: APjAAAWxg/U80u6VaZk+q6i/HegajeyYvUJ4stl+RWhMYruyQVi5dVZ5
        vgiUgCQkfQlQoJJYnKURxtY=
X-Google-Smtp-Source: APXvYqxi/JBhmWViz9ezy09MgxguonsCMH4MkRsJAwNgJ6ZccsoRkhsj8up9vXTOUiCdRUfx76PP/Q==
X-Received: by 2002:ac2:569c:: with SMTP id 28mr1085507lfr.147.1559572933367;
        Mon, 03 Jun 2019 07:42:13 -0700 (PDT)
Received: from osv ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm3201547lfm.7.2019.06.03.07.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 07:42:12 -0700 (PDT)
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
Date:   Mon, 03 Jun 2019 17:42:11 +0300
In-Reply-To: <20190530210824.rf2aaxumcc3cnc5c@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu, 30 May 2019 23:08:24
 +0200")
Message-ID: <87v9xm3f3w.fsf@javad.com>
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
>
> So I think your approach is too simple.

This patch in fact should be dropped, but for different reason:

It will set back UCR2_CTS that was cleared by imx_uart_rts_active(),
i.e., it'd break RS485 mode.

... provided it's not broken anyway as:

static void imx_uart_rts_active(struct imx_port *sport, u32 *ucr2)
{
	*ucr2 &= ~(UCR2_CTSC | UCR2_CTS);
	sport->port.mctrl |= TIOCM_RTS;
	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
}

Seems to have inverted logic between TIOCM_RTS and UCR2_CTS (once again
intentional? with no comments?), compared to set_mctrl():

		if (mctrl & TIOCM_RTS)
			ucr2 |= UCR2_CTS;

Moreover, imx_uart_rts_active() is called from set_termios() before

          spin_lock_irqsave(&sport->port.lock, flags);

is called, yet it changes sport->port.mctrl. A bug?

-- Sergey
