Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF63C531
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 09:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404100AbfFKHe3 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 03:34:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37353 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404104AbfFKHe2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 03:34:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id d11so662303lfb.4
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2019 00:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ufg3h5u9LcNKqYE5PDdDmuHYHMQr9JWn7kPO6+UqlJo=;
        b=B3M1FoDGfhZE5E9bg0vmvdoWSbP7TDYheHMko9lmoJ1JOe3nlJJ3j85eVtN5D8UwEX
         TQ33bD3pne7/3SXqXeUSiXxO0kAYEUH3iVB2cNDi96XaID1+N/Ao+EtsohE0R4mWrTGb
         IOWwSTUDr+EydK1AWxAVymzflYr7Wlhenk5xkmQwcjVFLN4cwJJAulY9/SsWPN0BGPI6
         K/C8FpW9xe6zmDxOYpWcGDcqYR/W+t7ohi7mCCI0I2UeW0pcoCYrPaO6YMvzDFvqMLMa
         GsS7rSlKMRKL0UO3xYuBtTFpXnFMRK7yPJ5kjJb/vK7E8wygfvR6lS0meClAwI48Rx24
         F6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=ufg3h5u9LcNKqYE5PDdDmuHYHMQr9JWn7kPO6+UqlJo=;
        b=C6PV6jtQDoM1DrOKS/dSxTuTDl3C4rGfUhOqz9klDutqZ0dcnfUKP6Mt+l0W1l7Py5
         1R68PMbh0hAQDBVlgeYZBN8JHjEeZ2N07Cf/dHzQBYP7m7FGexbn2/3/GFMJe87SgtED
         bHWcoqyPbeae7W+AcVw3WIcnKcVGqh7UsrlI1gAsNmx2QEmlOZIPQX5Tgavsf7s9wN0P
         LnvD//+Tw/DoBiIJzKFf7hZk9OxlP6ct33c4S70SoPr3rYeNfJwY+evpobHEqZEgT8sj
         +poD2Bg+iNBoENuwttIPNs3V45gJep+c9o+kCTNkT3HVoc09FEdphVWhc9p5+dFJfSzx
         57PQ==
X-Gm-Message-State: APjAAAVPwnZzVQDhbQCGyqs/dKMbBd479nBKCfHhO2WYJlGKSRC0VKSS
        84AODwRwq2jiGaKK+XMrpqs=
X-Google-Smtp-Source: APXvYqwUwFwjVut0lqwLeg8CNVsxuNKgJ+Oz8LAgqVLOGdCkaccbq8IQyPuC04A4GYZEvAb6NVpgeg==
X-Received: by 2002:ac2:514f:: with SMTP id q15mr399308lfd.145.1560238466647;
        Tue, 11 Jun 2019 00:34:26 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l15sm2943097ljh.0.2019.06.11.00.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 00:34:25 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH RFC] serial: imx: fix locking in set_termios()
References: <1559807977-4598-1-git-send-email-sorganov@gmail.com>
        <20190611071024.xpnxrx7sdys43hnf@pengutronix.de>
Date:   Tue, 11 Jun 2019 10:34:24 +0300
In-Reply-To: <20190611071024.xpnxrx7sdys43hnf@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Tue, 11 Jun 2019 09:10:24
 +0200")
Message-ID: <87ef40tw1r.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Thu, Jun 06, 2019 at 10:59:37AM +0300, Sergey Organov wrote:
>> imx_uart_set_termios() called imx_uart_rts_active(), or
>> imx_uart_rts_inactive() before taking port->port.lock.
>> 
>> As a consequence, sport->port.mctrl that these functions modify
>> could have been changed without holding port->port.lock.
>> 
>> Moved locking of port->port.lock above the calls to fix the issue.
>
> I'm convinced. The issue looks real.

Good! I mean: baaad :)

>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 24 ++++++++++++++----------
>>  1 file changed, 14 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index dff75dc..cb95ff71 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1550,6 +1550,20 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>>  		old_csize = CS8;
>>  	}
>>  
>> +	del_timer_sync(&sport->timer);
>> +
>> +	/*
>> +	 * Ask the core to calculate the divisor for us.
>> +	 */
>> +	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
>> +	quot = uart_get_divisor(port, baud);
>> +
>> +	/*
>> +	 * Take port lock before imx_uart_rts_*() calls, as they change
>> +	 * sport->port.mctrl
>> +	 */
>> +	spin_lock_irqsave(&sport->port.lock, flags);
>> +
>
> You can move this block a bit down (and so grab the lock later). The
> check for CSIZE doesn't need protection.

I considered it, but decided putting lock inside UCR2 initialization
sequence would negatively affect readability of the code. OTOH, 2-3 more
asm instructions under the lock shouldn't be a big deal, right?

In addition, I've got further patches on top of this one, and there I
need to read-modify-write the UCR2, so I need to take the lock before
taking initial value.

I'll move the lock down in this patch if you still think it's worth it.

> Assuming you respin: Several functions are annotated to have to be
> called with the lock taken; I would put the comment to imx_uart_rts_* in
> the same way, instead of in imx_uart_set_termios.

Yeah, I will. I assume you mean

/* called with port.lock taken and irqs off */ 

comment? The "and irqs off" part doesn't seem to be true for calls from
set_termios() though, so I'd need to get rid of it for these new
comments, right?

Thanks!

-- Sergey
