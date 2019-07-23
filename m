Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD471718
	for <lists+linux-serial@lfdr.de>; Tue, 23 Jul 2019 13:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbfGWLaF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 23 Jul 2019 07:30:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34382 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfGWLaE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jul 2019 07:30:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so21850833lfq.1
        for <linux-serial@vger.kernel.org>; Tue, 23 Jul 2019 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1RHyF9qXjsrJ4Imj3sCEb7pI13dFgft3fe1rSgcBWPY=;
        b=KgJkiCOCiijCBe5yyX6r8kKrpnhVCnIT/b8Pur6uzpVdWcc30WxFhJWhVQudW1GxDL
         O9PxaLdZknJ6WNdUeD7rTv1l0zTHdUfuEEL+4/jUnVkwcqEnUmGqM3pQtZ1gZSLp10tQ
         GmevIClMzqFdkZlV9fnum0QI2Ey7UUIVzwIjtGy3Yq58KkSzrIukWOfQaQZwMFj7pOIW
         niNRkXYnaeFMi8J0y7OQQXKOXRzlXKy/scyv2pAOIzeoTTDBfB9kKJQfn5Kr1CbTsrJm
         CJeB6cuW7Pi62Y82OXNC3c71VkizAvhvqYgewkbBSKDOzc9fC+Gz8uk1hS/DjUkZVtum
         69Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=1RHyF9qXjsrJ4Imj3sCEb7pI13dFgft3fe1rSgcBWPY=;
        b=f4RIAy1nzjwbEPFvNkEXIGB+UAJnAAO1RRMqiDgwzWHFvn5uQo0cPLNpaVH2y8nW4U
         xlAs0z3rrQLr+8tBtixwU0B0mq7lua2HqZTn4cFhKjNj2N8Yt4W5T4lP6m/lf1udKHiT
         xIHEIrlf6iOYGReiyaHo2Fk3WLvbrpK606DQShH1XYdMyK17LthHX7Oeu5HZnrfdCjHR
         qJ0oUuwRRvET5sSAU0Oznl7xTbkZ3444wcZFgM0ACJgg5NRMIYvTpUpDTpajL7WanCna
         D4cDDOIwYI8r90RKSjul6KJW8rJN33FoRJVWBYzMlXIHewuOLvLHebYk40DmsbFxawPp
         X6UQ==
X-Gm-Message-State: APjAAAVkH9iquWT9O1joXiPUYVbLb83KhBIALblcnp6iC3TJlpX3XILa
        acLu3tMiVSXk/NlbHCWIR68=
X-Google-Smtp-Source: APXvYqxcgejQR0ron6TFu1X9eCmTlvgCwIlYwXtEvtZulKsL1TRqO4BZiYxcQfhVbojmmHtsUn3cDA==
X-Received: by 2002:ac2:48bc:: with SMTP id u28mr23076767lfg.126.1563881402701;
        Tue, 23 Jul 2019 04:30:02 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w6sm6405289lff.80.2019.07.23.04.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 04:30:02 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v6 2/3] serial: imx: set_mctrl(): correctly restore autoRTS state
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1563823331-5629-1-git-send-email-sorganov@gmail.com>
        <1563823331-5629-3-git-send-email-sorganov@gmail.com>
        <20190722202406.hr74mg64sxoovah7@pengutronix.de>
        <87h87d1509.fsf@osv.gnss.ru>
        <20190723094902.r7v5wzu4lkicrs3o@pengutronix.de>
Date:   Tue, 23 Jul 2019 14:30:01 +0300
In-Reply-To: <20190723094902.r7v5wzu4lkicrs3o@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Tue, 23 Jul 2019 11:49:02
 +0200")
Message-ID: <87blxlyona.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Tue, Jul 23, 2019 at 12:20:38PM +0300, Sergey Organov wrote:
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> 
>> > On Mon, Jul 22, 2019 at 10:22:10PM +0300, Sergey Organov wrote:
>> >> imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
>> >> was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
>> >> turning handshake on only when CRTSCTS bit for the port is set.
>> >>
>> >> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> Oh, you added my Ack for patches 2 and 3, too, even before I looked
> again on those :-|
>
>> >> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
>> >> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
>> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> >> ---
>> >>  drivers/tty/serial/imx.c | 16 ++++++++++++++--
>> >>  1 file changed, 14 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> >> index 32f36d8..059ba35 100644
>> >> --- a/drivers/tty/serial/imx.c
>> >> +++ b/drivers/tty/serial/imx.c
>> >> @@ -974,10 +974,22 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>> >>  	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
>> >>  		u32 ucr2;
>> >>
>> >> +		/*
>> >> +		 * Turn off autoRTS if RTS is lowered and restore autoRTS
>> >> +		 * setting if RTS is raised.
>> >
>> > "lower" and "raising" are misleading here. I recommend sticking to
>> > "active" and "inactive".
>> 
>> This is copy-pasted from the 8250 driver. I'd prefer to leave it as is.
>
> I'd prefer to fix the 8250 accordingly. "raised" is just misleading
> because the handshaking signals are low-active and you always have to
> think if the logical or the physical signal is raising. "active" is
> clear in this regard.

You are free to do it in one bunch for all the drivers it appears in
then. For now I prefer consistency between drivers, even though I do
agree the wording could be improved.

>> >> +		 */
>> >>  		ucr2 = imx_uart_readl(sport, UCR2);
>> >>  		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
>> >> -		if (mctrl & TIOCM_RTS)
>> >> -			ucr2 |= UCR2_CTS | UCR2_CTSC;
>> >> +		if (mctrl & TIOCM_RTS) {
>> >> +			ucr2 |= UCR2_CTS;
>> >> +			/*
>> >> +			 * UCR2_IRTS is unset if and only if the port is
>> >> +			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
>> >> +			 * to get the state to restore to.
>> >> +			 */
>> >> +			if (!(ucr2 & UCR2_IRTS))
>> >> +				ucr2 |= UCR2_CTSC;
>> >> +		}
>> >
>> > If you teach imx_uart_rts_auto about IRTS this function could be reused
>> > here I think.
>> 
>> Yeah, but imx_uart_rts_auto_if_crtscts_and_rts_is_active() ? I feel
>> somewhat uncomfortable about that mixing of different purposes.
>> 
>> Besides, one of the purposes of these patch series was to get rid of
>> imx_uart_rts_auto() as its name is confusing in the context of existing
>> imx_uart_rts_active() and imx_uart_rts_inactive(), as I already
>> explained before.
>> 
>> We can rename the function to avoid confusion, add yet another check to
>> it, and call it from 2 places, but it's still questionable if it's an
>> improvement, and could be done as a follow-up step anyway. It will look
>> something like this then:
>> 
>>  -- >8 --
>> 
>>     serial: imx: factor out common code into new imx_uart_set_auto_rts()
>> 
>> 	Modified   drivers/tty/serial/imx.c
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index d9a73c7..c8b847e 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -954,6 +954,20 @@ static unsigned int imx_uart_get_mctrl(struct uart_port *port)
>>  	return ret;
>>  }
>> 
>> +/*
>> + * Compute and set auto RTS in 'ucr2' according to the current state of RTS
>> + * signal and CRTSCTS state of port configuration.
>> + *
>> + * Use inverted UCR2_IRTS to get the state of CRTSCTS, and don't let receiver
>> + * control RTS output if RTS is inactive.
>> + *
>> + */
>> +static void imx_uart_set_auto_rts(u32 *ucr2)
>> +{
>> +	if ((*ucr2 & UCR2_CTS) && !(*ucr2 & UCR2_IRTS))
>> +		*ucr2 |= UCR2_CTSC;
>> +}
>> +
>
> this looks fine and is what I intended to suggest. The comment isn't
> optimal yet, I'd write something like:
>
>   /*
>    * Enable hardware control of the RTS output iff handshaking is in use
>    * and software requested RTS to be active.
>    * "handshaking is in use" can be determined from the IRTS bit that is
>    * set when handshaking is not used. The requested state by software
>    * is represented in the CTS bit.
>    */

I don't like it as this function doesn't enable or disable anything. It
just computes needed state of one bit taking into account two
conditions.

Independent on comment, for more clarity, it could have been:

static void imx_uart_set_auto_rts(u32 *ucr2)
{
	if ((*ucr2 & UCR2_CTS) && !(*ucr2 & UCR2_IRTS))
		*ucr2 |= UCR2_CTSC;
	else
		*ucr2 &= ~UCR2_CTSC;
}

to be independent of the current state of UCR2_CTSC.

>
> IMHO go directly to imx_uart_set_auto_rts() before introducing the
> second open coding of its logic.

Actually, it looks clearer the way I've suggested, I think, as I didn't
in fact introduce second open coding of its logic, it's just we later
decided that 2 different logics (restore autoRTS on RTS raise, and set
autoRTS on user request) could be merged into single function.

-- Sergey
