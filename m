Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426DF4CE96
	for <lists+linux-serial@lfdr.de>; Thu, 20 Jun 2019 15:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfFTNYa (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Jun 2019 09:24:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46351 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfFTNYa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jun 2019 09:24:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so2650850ljg.13
        for <linux-serial@vger.kernel.org>; Thu, 20 Jun 2019 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HhLOhhYqBLdrOA1DogbXLLJ4Nwua7/IpCpsFyqMX/RE=;
        b=OQbS3l0nVh3zF87ojg/qhcxYenR8iup8Vtb90TVGwu7UHWK9XJmK3vl7W6Nbr/Ul7E
         UW4yi7cZY8ucWwstC0y1RilHdjcFDrJal+CFfKyI5agxLcq4eLSvt3zmIQ9K2ePEuTaq
         fNhv5CU5SDBdmy8ZRhbpkzU17kxPBq8oOP9ryIXnS2pJB/xkGSSIgK9rdPJ8Mj+NATFu
         8g38rpQtBir3QgBe9RduxuIEHM7knENHWJzpocotTrwXsbMtPsmbJLDx5JvcvgBl+tmh
         ezH0/fUvxi34Svds5r64S8+f39zxVPzD0oIODrxGozpyx5nUbb15ZEbB4JYR7DFIR7IA
         7bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=HhLOhhYqBLdrOA1DogbXLLJ4Nwua7/IpCpsFyqMX/RE=;
        b=qjvebtKt9A35MAa1jJ/aklBj6Ws/43KNqu7Lzw6LyXhBNoQqAaH/MZWGzZJ6m5wGZZ
         9yXY55AWChPof/u56ytMDG0jFh6HN9DIcWYCVFRec3/PLszfgT+7ZO7CF483+EUzEQ5G
         1Fy1MDolQa0PI0C8eGtV1gRluphXk5iePpd/YHnT1n1pbq4ovD3uFSBDLqzM2jgc2Kp5
         9dDRIvgtygsM+gkoaBVqEiWfQE9rDCdXCfx/T7YDPfd4U3u2nUzkSk9KMRFO6CIVbdjB
         QER+0stKp49TRpgdBrYND9dD2g9YpRNtiJ1YcEYl4+h0T155c+ygHYstMeRvOfup4dUo
         fBBg==
X-Gm-Message-State: APjAAAUJL64I7WM18pMEHWQp1lmY2VdSDpxVMlH8CixmC1uqmXfUStP0
        DQ7q6jxrshRBIy3jWsCp/9c=
X-Google-Smtp-Source: APXvYqxLp7uwN2DyekkN7tJ03qheCXl7cZFSbRu8UAZUOK7xPINLgUChqIQltc0w/492yjLwIwE61A==
X-Received: by 2002:a2e:635d:: with SMTP id x90mr60580619ljb.140.1561037068945;
        Thu, 20 Jun 2019 06:24:28 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x1sm3511078ljx.61.2019.06.20.06.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 06:24:28 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RFC 4/7] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1560514294-29111-1-git-send-email-sorganov@gmail.com>
        <1560514294-29111-5-git-send-email-sorganov@gmail.com>
        <20190620093741.7wom6a475be2byob@pengutronix.de>
Date:   Thu, 20 Jun 2019 16:24:27 +0300
In-Reply-To: <20190620093741.7wom6a475be2byob@pengutronix.de> (Sascha Hauer's
        message of "Thu, 20 Jun 2019 11:37:41 +0200")
Message-ID: <878stwjsok.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sasha,

Sascha Hauer <s.hauer@pengutronix.de> writes:

> Hi Sergey,
>
> On Fri, Jun 14, 2019 at 03:11:31PM +0300, Sergey Organov wrote:
>> set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS (=TIOCM_RTS) is
>> cleared. Added corresponding check in imx_uart_rts_auto() to fix this.
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 17e2322..8ee910f 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
>>  /* called with port.lock taken and irqs caller dependent */
>>  static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
>>  {
>> -	*ucr2 |= UCR2_CTSC;
>> +	if (*ucr2 & UCR2_CTS)
>> +		*ucr2 |= UCR2_CTSC;
>>  }
>
> *ucr2 is set like this in imx_uart_set_termios():
>
> 	ucr2 = UCR2_SRST | UCR2_IRTS;
> 	if ((termios->c_cflag & CSIZE) == CS8)
> 		ucr2 |= UCR2_WS;
> 	...
> 	imx_uart_rts_auto(sport, &ucr2);
>
> So the UCR2_CTS bit is never set, hence UCR2_CTSC will never be set.
> You meant to pass in the actual register value of the UCR2 register.
>
> This is shifted around a bit in the following patches, as an end result
> we have:
>
> 	old_ucr2 = imx_uart_readl(sport, UCR2);
> 	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTSC);

This is rather the typo problem in my patches right here: it should have
been:

> 	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTS);

as we need to preserve RTS bit state USR2_CTS, not hardware handshake bit
UCR2_CCTS.

> 	...
> 	if (ucr2 & UCR2_CTS)
> 		ucr2 |= UCR2_CTSC;
>
> Again the test can never be true, it should probably be if (old_ucr2 &
> UCR2_CTS).

No, I believe it's different mistake on my part, see above.

>
> With this issue and the one Lothar has found fixed this series works for
> me.
>
> With these issues fixed I'd be happy to test this series and apply it in
> favour of my patch.

Thanks a lot for reviewing and volunteering to test! It's even more
appreciated as I can't easily test either on recent kernels and/or
without heavy patching of the kernel, and patching would diminish
applicability of my test results to mainstream kernel.

I think I'll better re-roll the series with these 2 corrections, right?

-- Sergey.
