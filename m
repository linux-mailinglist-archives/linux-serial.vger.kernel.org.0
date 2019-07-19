Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9E6E7D5
	for <lists+linux-serial@lfdr.de>; Fri, 19 Jul 2019 17:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfGSPN5 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 19 Jul 2019 11:13:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41235 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfGSPN4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jul 2019 11:13:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id d24so31122626ljg.8
        for <linux-serial@vger.kernel.org>; Fri, 19 Jul 2019 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kBSZftkmiJeVqwh2q+rU9tm8xADeFXVDTNxvaxitKn0=;
        b=IVtapoFamwSes/PlaroJZmI6o/IwTaQHuue2MeChN0yUiRuteDuKJh/x/xNIdKsvp4
         2ikKFssjz9Aamw1GACQfEvjNThtrepRm9H0HgjeyKKr8DWUBS8THothqW6rHDvvtJAul
         vwDV4Sh/4ngosmCfyre68U+5VcL2derx4+vQfLhMkXmks5jrn28QvgpVU1ovfJ/uDw2S
         KZHPHF8vN0qRajE/MQnxwOhrOr0wgvOQG7M9YxvImH6X/B4eCYWuo+n5MDUwsMKvUteH
         mUlbYP7xTd6/flVGAHNbJUz4tSsTNDTFlVgE3VK1+5aAc7i+uz5sfDdNGVUJsTc25FM/
         uomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=kBSZftkmiJeVqwh2q+rU9tm8xADeFXVDTNxvaxitKn0=;
        b=ara124qNgs1wFZbtydWK4f1/JukKynb7AOG4qxdAOoqnLqlvVC+XySoDG+3SDbAeZq
         zvN3J0B6bigZmAuL+q/Aj07UpMgtP9AbszJ2YN2aL+DYxDbLc4zM5+yPToD6CV9BP4PF
         giOkE4qzSMJc1nvkzFKn5NTkTgl5PsZ2XgmXQXK/QAj8/u2M4xWSL2VjY8C60LaZ9ldf
         E15m6ynAOw0mQU/EfOFpEtz98pJcr/TCDNRGiHeoR9myrrCcDyp97tL5PdtqhVvd1jzH
         TdPEyiTAn6iV1iSSOTd5fe3uSYvHXAKHgVbULftw/nSTWc9VECv3q6XTAtosFvqCfjF+
         QsBQ==
X-Gm-Message-State: APjAAAVGpLb2515OiJWXhpMOXpzOSZoHU8HIFGpwH+PF0q5m7Vb5Y5bk
        dx/4F9+MNWkxMfQSEbpVFmMZU6fN
X-Google-Smtp-Source: APXvYqyg+Bn0XD3WxZYgtdZxHkrxRBkFppKGe05Tz3Pwms90vFmp+NNCRfQdFnP6v/soxqqrYVmC7Q==
X-Received: by 2002:a2e:988b:: with SMTP id b11mr27510586ljj.110.1563549234917;
        Fri, 19 Jul 2019 08:13:54 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s19sm5638526lji.38.2019.07.19.08.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 08:13:54 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] serial: imx: set_termios(): do not enable autoRTS if RTS is unset
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1563526074-20399-1-git-send-email-sorganov@gmail.com>
        <1563526074-20399-2-git-send-email-sorganov@gmail.com>
        <20190719091143.uhjxeibtolgswq2l@pengutronix.de>
        <87h87idxq2.fsf@osv.gnss.ru>
        <20190719143151.gx43ndn2oy35h247@pengutronix.de>
Date:   Fri, 19 Jul 2019 18:13:52 +0300
In-Reply-To: <20190719143151.gx43ndn2oy35h247@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Fri, 19 Jul 2019 16:31:51
 +0200")
Message-ID: <87woge9hvz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Uwe,

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> Hello Sergey,
>
> On Fri, Jul 19, 2019 at 03:18:13PM +0300, Sergey Organov wrote:
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> > On Fri, Jul 19, 2019 at 11:47:52AM +0300, Sergey Organov wrote:
>> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> >> index 57d6e6b..95d7984 100644
>> >> --- a/drivers/tty/serial/imx.c
>> >> +++ b/drivers/tty/serial/imx.c
>> >> @@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
>> >>  /* called with port.lock taken and irqs caller dependent */
>> >>  static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
>> >>  {
>> >> -	*ucr2 |= UCR2_CTSC;
>> >> +	if (*ucr2 & UCR2_CTS)
>> >> +		*ucr2 |= UCR2_CTSC;
>> >
>> > I think this patch is wrong or the commit log is insufficient.
>> > imx_uart_rts_auto() has only a single caller and there ucr2 & UCR2_CTS is
>> > never true. And CTSC isn't restored anywhere, is it?
>> 
>> This is rebase to 'tty-next' branch, and you need to look at it in that
>> context. There, ucr2 & UCR2_CTS does already make sense, due to previous
>> fix that is already there.
>
> I looked at 57d6e6b which is the file you patched. And there
> imx_uart_rts_auto is only ever called with *ucr2 not having UCR2_CTS.
>
> If you still think I'm wrong, please improve the commit log
> accordingly.

I still think you are wrong, but I don't know how to improve commit log.

To check it once again, I just did:

$ git show 57d6e6b > imx.c

There, in imx_uart_set_termios(), I see:

1569:	old_ucr2 = imx_uart_readl(sport, UCR2);
1570:	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTS);

Here, current UCR2 value is read into 'old_ucr2' and then its /current/
UCR2_CTS bit is copied into 'ucr2' (along with 3 other bits).

Then, later in the same function:

1591:		imx_uart_rts_auto(sport, &ucr2);

is called that can check /current/ state of UCR2_CTS bit in '*ucr2'.

That's what the patch does, checks this bit.

Sorry, I fail to see how you came to conclusion that "*ucr2 not having
UCR2_CTS". Do we maybe still read different versions of the file?

-- Sergey
