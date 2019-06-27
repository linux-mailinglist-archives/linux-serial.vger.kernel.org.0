Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE7257CA6
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2019 09:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfF0HB7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 27 Jun 2019 03:01:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38138 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfF0HB7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jun 2019 03:01:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so1182241ljg.5
        for <linux-serial@vger.kernel.org>; Thu, 27 Jun 2019 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Pvfj5IUJQ92pFQYuAu+C5YKHxoqdsKA2nN/i3c6nnRM=;
        b=HmWsV8yKXXVdET4q91MaKEi0sqE5IFmAgar6irfyeJah90ltAUtgRO0fAlkBFOaN30
         ZusLey9GuZJkPALI9pbZlCePjlos/9ReNoBOon8HswHg78lJWlDSgS1ZKW3ND95MY7p1
         GaJBpeYZhj+YGsQZrzqE3Xr2DLpG3IrC48vaxgR3I0z33fvQAqfqwunqH76P3u9TynYK
         HKdi+o4DbVrQBBdSk/B1QKwlSBE9/QaZi1HbwLp/oZK/hG9/xykeuw5nuqVl649gqgon
         e/Imu6A793VlC2f5dOJr1oPN/JOEzab8NcqltSPfGdCu5Mu7reCLyI4FtTALfTssx2Ow
         8YXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Pvfj5IUJQ92pFQYuAu+C5YKHxoqdsKA2nN/i3c6nnRM=;
        b=BDhOj6j0k2u5OfNhScAo+D3MeETsJufRDGfU+u0ClYB62iEcyn6q6tZ8ufrpPIFf8D
         j79VRZRhY6CbTZn6vxheFphw54O1Lw4OdHQEbMs9yGLuRA/E3Jcx4f1bse9h2L2H88O2
         TwCfePiv3msOP1++8b2thLwrXqLU3340b8953Ybi28nrdit/mUvhxy85a5XtGvKH4Kiv
         b4vYOFDHLqN8hg+kxSNblMty2m51ARdfkFFYdlY8wQAl5vPBP6GeqB7XllrVLEA704Er
         BbZuPtvui24XqOrKgdijFM0Ov68XTLb53WnsiMl7c52VN0/uq5p0yLwHGSs6Iz0bIhCU
         tQEw==
X-Gm-Message-State: APjAAAVub8717hZm6FI/ljeufmkCG9fos5FDAxA15jHSIkrGm1UniyRw
        MeTgEaQ4QWIHZQ3kqRqSxHA=
X-Google-Smtp-Source: APXvYqwwDeR3mG5V7MTsd1v77XqJ3MRQe8u0XvgvPm3cI08X9armX5Ba/ryUeZswyN7KohvGKiNvBw==
X-Received: by 2002:a2e:5c88:: with SMTP id q130mr1609327ljb.176.1561618916948;
        Thu, 27 Jun 2019 00:01:56 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u11sm222130ljd.90.2019.06.27.00.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 00:01:56 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 6/7] serial: imx: set_mctrl(): correctly restore autoRTS state
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1561558293-7683-1-git-send-email-sorganov@gmail.com>
        <1561558293-7683-7-git-send-email-sorganov@gmail.com>
        <20190627060537.brmgsmoh3usr4vo6@pengutronix.de>
Date:   Thu, 27 Jun 2019 10:01:54 +0300
In-Reply-To: <20190627060537.brmgsmoh3usr4vo6@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu, 27 Jun 2019 08:05:37
 +0200")
Message-ID: <87imsrik9p.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Wed, Jun 26, 2019 at 05:11:32PM +0300, Sergey Organov wrote:
>> imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
>> was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
>> turning handshake on only when CRTSCTS bit for the port is set.
>> 
>> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 4867f80..171347d 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -970,10 +970,19 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>>  	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
>>  		u32 ucr2;
>>  
>> +		/*
>> +		 * Turn off autoRTS (UCR2_CTSC) if RTS is lowered and restore
>> +		 * autoRTS setting if RTS is raised. Inverted UCR2_IRTS is set
>> +		 * if and only if CRTSCTS bit is set for the port, so we use it
>> +		 * to get the state to restore to.
>> +		 */
>
> The comment is quite complicated. I like the comments of Sascha's patch
> that addressed the same issue better.

This one is simply modeled after similar comments in other drivers,
then adding the specifics.

> Are you using UCR2_IRTS as an indicator if CRTSCTS is set? If it's that
> what you intend to express in the second sentence that is hard to grasp.
> Something like:
>
> 	UCR2_IRTS is unset iff the port is configured for CRTSCTS

Yeah, exactly. Fine, I'll change this, thanks!

>
> Also as the value of the CTS bit doesn't matter if CTSC is set, the
> order of the checks could be swapped to result in easier code (IMHO at
> least) that doesn't need a nested if.
>
> Something like:
>
> 	ucr2 = imx_uart_readl(sport, UCR2);
> 	ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
>
> 	/* UCR2_IRTS is unset iff the port is configured for CRTSCTS */
> 	crtscts = !(ucr2 & UCR2_IRTS);
>
> 	if (!(mctrl & TIOCM_RTS)) {
> 		/* Force RTS inactive, i.e. UCR2_CTS=0 and UCR2_CTSC=0 */
> 	} else if (crtscts) {
> 		/* let the receiver control RTS */
> 		ucr2 |= UCR2_CTSC;
> 	} else {
> 		/* Force RTS active */
> 		ucr2 |= UCR2_CTS;
> 	}

Right, this is functionally correct as well, and thus it's a matter of
taste, but I still believe that what I suggested is better:

	ucr2 = imx_uart_readl(sport, UCR2);
	ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
	if (mctrl & TIOCM_RTS) {
		ucr2 |= UCR2_CTS;
		if (!(ucr2 & UCR2_IRTS))
			ucr2 |= UCR2_CTSC;
	}

First, it always sets hardware RTS according to TIOCM_RTS, that IMHO is
less surprising than clearing hardware RTS bit when port is configured
CRTSCTS.

Second, (unfortunate) inter-dependency between TIOCM_RTS and CRTSCTS is
better isolated, so to get rid of it (even if only mentally), only
removals are required, that reduces the code to quite obvious:

	ucr2 = imx_uart_readl(sport, UCR2);
	ucr2 &= ~(UCR2_CTS);
	if (mctrl & TIOCM_RTS)
		ucr2 |= UCR2_CTS;

Thanks!

-- Sergey
