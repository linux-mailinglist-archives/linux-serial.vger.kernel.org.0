Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A8057BAD
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2019 07:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfF0F6K (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 27 Jun 2019 01:58:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39553 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0F6K (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jun 2019 01:58:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so1010412ljh.6
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2019 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Jg1u7BG7wu6GjScXMtGk/VeNhSa0IfS4GRE9+vAXXPE=;
        b=DET1rfD5GeoeMSPoCV1yXNcu7VVU7oW0POg811KEjlSgnmdapJRNkkttJk89kMcYiF
         WnbsQJWWzCz0Y8i0kx3GuC2e6VIQqS56JshveAdrTi+iQSID1E32SvB/5Q8oXT1KpNK+
         s27Q1+PNO3bP17qDjm6F9szQYoiuBvvRwh746tu9dUeYO6iw6kckxda0fHW+XGu20cQ/
         f88NJJSSNHGS2vc6Yl0QzjNK7UDin2RE9OQKj9YDqDDGyId1r4h/fpaPDcHlXNNDAaFe
         +EPGCzMEdAJTusSS+n0wkk0C0kdzt1vMc5SNV98ivAMU+K/r6iM3lLoxtN3SB3XpFkLh
         QCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Jg1u7BG7wu6GjScXMtGk/VeNhSa0IfS4GRE9+vAXXPE=;
        b=YeETZS3E4Pq+xqg1JsnbOjT4bMYbGLaG8Ly/cbx3Yfn9i5S7/6HnUt3hJDZkBIsdu+
         lzsPAuiikTqe3a7XqMxSRXKQ8/9003eV8tEBJnbVnzGq3l7MjmpEDpBQvJQ2QJnyJH5f
         OI65S9Hg27AcuEJppgRyoctlEjBnTvp+ILy7G+AtlV1flVaW3HCXB1w0pduSCGh26l5k
         79y86oT0SHsFGMkGLpBTQGrR10N8umKSyCwbXBhySXYo7LuYH2pcnHXT6hmrSD9PqUwW
         LjaAWCvOtJDkKZTxJN4YzVDPJhuS3hqcHwq5nSmQ1R5bmIKyObuuoeWVl0+nMKgyF+WA
         AjlQ==
X-Gm-Message-State: APjAAAVlkBqKun8fMIhVsdFBobtAIEtwMXRwOvLHN/vDt+hqm5nlek6D
        3qldCbnbqYjJdzX67k4kSsA=
X-Google-Smtp-Source: APXvYqwo7atdj7D9mV8TXhVmxKQUQXt4DpXmXA+E3gMAlbvHsHaAURJGHEv8q2XZ0Nsl4ikV/6a2GA==
X-Received: by 2002:a2e:854d:: with SMTP id u13mr1412795ljj.236.1561615088185;
        Wed, 26 Jun 2019 22:58:08 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c15sm172330lja.79.2019.06.26.22.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 22:58:07 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 3/7] serial: imx: set_termios(): clarify RTS/CTS bits calculation
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1561558293-7683-1-git-send-email-sorganov@gmail.com>
        <1561558293-7683-4-git-send-email-sorganov@gmail.com>
        <20190627052652.ey7cmzkztylfy7k3@pengutronix.de>
Date:   Thu, 27 Jun 2019 08:58:06 +0300
In-Reply-To: <20190627052652.ey7cmzkztylfy7k3@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu, 27 Jun 2019 07:26:52
 +0200")
Message-ID: <87k1d7k1sh.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Wed, Jun 26, 2019 at 05:11:29PM +0300, Sergey Organov wrote:
>> Avoid repeating the same code for rs485 twice.
>> 
>> Make it obvious we clear CRTSCTS bit in termios->c_cflag whenever
>> sport->have_rtscts is false.
>> 
>> Make it obvious we clear UCR2_IRTS whenever CRTSCTS is set.
>> 
>> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 36 +++++++++++++-----------------------
>>  1 file changed, 13 insertions(+), 23 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 87802fd..17e2322 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1567,35 +1567,25 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>>  	if ((termios->c_cflag & CSIZE) == CS8)
>>  		ucr2 |= UCR2_WS;
>>  
>> -	if (termios->c_cflag & CRTSCTS) {
>> -		if (sport->have_rtscts) {
>> -			ucr2 &= ~UCR2_IRTS;
>> +	if (!sport->have_rtscts)
>> +		termios->c_cflag &= ~CRTSCTS;
>>  
>> -			if (port->rs485.flags & SER_RS485_ENABLED) {
>> -				/*
>> -				 * RTS is mandatory for rs485 operation, so keep
>> -				 * it under manual control and keep transmitter
>> -				 * disabled.
>> -				 */
>> -				if (port->rs485.flags &
>> -				    SER_RS485_RTS_AFTER_SEND)
>> -					imx_uart_rts_active(sport, &ucr2);
>> -				else
>> -					imx_uart_rts_inactive(sport, &ucr2);
>> -			} else {
>> -				imx_uart_rts_auto(sport, &ucr2);
>> -			}
>> -		} else {
>> -			termios->c_cflag &= ~CRTSCTS;
>> -		}
>> -	} else if (port->rs485.flags & SER_RS485_ENABLED) {
>> -		/* disable transmitter */
>> +	if (port->rs485.flags & SER_RS485_ENABLED) {
>> +		/*
>> +		 * RTS is mandatory for rs485 operation, so keep
>> +		 * it under manual control and keep transmitter
>> +		 * disabled.
>> +		 */
>>  		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
>>  			imx_uart_rts_active(sport, &ucr2);
>>  		else
>>  			imx_uart_rts_inactive(sport, &ucr2);
>> -	}
>>  
>> +	} else if (termios->c_cflag & CRTSCTS)
>> +		imx_uart_rts_auto(sport, &ucr2);
>
> Here a set of braces is needed even if the body has only a single
> line.

Really? scripts/checkpatch.pl didn't catch this.

If needed, is it essential enough to fix here, as final result has this
chunk different anyway (and with braces)?

>
>> +
>> +	if (termios->c_cflag & CRTSCTS)
>> +		ucr2 &= ~UCR2_IRTS;
>>  
>>  	if (termios->c_cflag & CSTOPB)
>>  		ucr2 |= UCR2_STPB;
>
> Is this patch intended to not change semantic? I wonder if it hides a
> fix because if imx_uart_set_termios() was called with termios->c_cflag
> & CRTSCTS and !sport->have_rtscts the rs485 block was not reached. Now
> it is.

As comment says "RTS is mandatory for rs485 operation", I assumed
SER_RS485_ENABLED and !sport->have_rtscts are incompatible, so
there should be no actual semantic change here. I mean:

	if (port->rs485.flags & SER_RS485_ENABLED) {
        	assert(sport->have_rtscts);

should never fire.

Do you think I rather need to put additional check for
sport->have_rtscts inside the SER_RS485_ENABLED case?

Thanks!

-- Sergey
