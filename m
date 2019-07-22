Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740076FA85
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 09:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfGVHnB (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 03:43:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41763 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfGVHnB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 03:43:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so21003130lfa.8
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 00:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3PMu8WKLSHH9AHwB3m+He0cpFsjv9J7xW+4o1jsaXQw=;
        b=Rydv+EgmgqLi+IIHj2yz4gGGj2B/JrhRa6SHS+DLnqNjV2/ZlG8DjYRpQ3gOmrkb5g
         NJTx9kDYBR2apFNo0cc8ZcvhBtmBAyprBh0Az3N3Pf+e/xyn9yVrWecAfWl0y/5zN7K5
         X+rnUBTLQhAxlqkn+iezFQUmPrekGfvIsZxfuSK00NUFEIgmqPjTlXzUUGJgBV7vow/U
         HZH6mwyF0iUQyijb9QazZyCy3QFaLNXPFG6epHbciPQglsYSBqA3yJRVH3/LVodM9O9V
         vLlMwpbAs5f6VM9CqVow0IrIKQ2Uad/B5WL1E2sHXGxdIy1gTNMWAGASC23zfCmykI1y
         c56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=3PMu8WKLSHH9AHwB3m+He0cpFsjv9J7xW+4o1jsaXQw=;
        b=AfAq4BojSqVWOIZukZ42TqZ7W8HYh6/7jHitbrbhyuX5CVuDGTG4zH+h7xANUfaLJl
         YWQGjNCJDsTAU6mc6npAPT/lDuaYYO6n05oY98ZlFMtbCQ9MWQPP6cEY3LwpZI0ATvUk
         XBxz+IX0mc8JrPTBh7kmd/bx2/yjeWOL5G+YfBuc/eR8p2TT3NWsDcv4VUbQEUjjuqoz
         p5o6yUvMP+0uyGPyk+xO/QYgqycCfks7xEtorFuJ77r1YdqImnTwZ+qfPPa8q9gIbpUl
         zsIvzS2vSF/Xo+coXveq4AEFxrTYNl9i/P2x37x2shuI90OihpVduKPdU4CDwGD0aEwM
         uIaw==
X-Gm-Message-State: APjAAAXYJvKiysJyDN7xU4b1qZdzYL0URsHfF9eQY6NauDe79a741H8K
        B64GQb0h7Ucgp24ZQFXFBWw=
X-Google-Smtp-Source: APXvYqz1ffzkA9NGjXdlOLU/c7kHpBEBfUI2muxloQadjts/O/fXQHBOiXc3M1ZdCE8lXgw1bFZsgw==
X-Received: by 2002:ac2:5492:: with SMTP id t18mr32281130lfk.41.1563781379123;
        Mon, 22 Jul 2019 00:42:59 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w1sm8460317ljm.81.2019.07.22.00.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 00:42:58 -0700 (PDT)
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
        <87woge9hvz.fsf@osv.gnss.ru>
        <20190719201949.ldqlcwjhcmt7wwhg@pengutronix.de>
Date:   Mon, 22 Jul 2019 10:42:57 +0300
In-Reply-To: <20190719201949.ldqlcwjhcmt7wwhg@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Fri, 19 Jul 2019 22:19:49
 +0200")
Message-ID: <87ftmy8qgu.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Fri, Jul 19, 2019 at 06:13:52PM +0300, Sergey Organov wrote:
>> Hello Uwe,
>> 
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> > Hello Sergey,
>> >
>> > On Fri, Jul 19, 2019 at 03:18:13PM +0300, Sergey Organov wrote:
>> >> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> >> > On Fri, Jul 19, 2019 at 11:47:52AM +0300, Sergey Organov wrote:
>> >> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> >> >> index 57d6e6b..95d7984 100644
>> >> >> --- a/drivers/tty/serial/imx.c
>> >> >> +++ b/drivers/tty/serial/imx.c
>> >> >> @@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
>> >> >>  /* called with port.lock taken and irqs caller dependent */
>> >> >>  static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
>> >> >>  {
>> >> >> -	*ucr2 |= UCR2_CTSC;
>> >> >> +	if (*ucr2 & UCR2_CTS)
>> >> >> +		*ucr2 |= UCR2_CTSC;
>> >> >
>> >> > I think this patch is wrong or the commit log is insufficient.
>> >> > imx_uart_rts_auto() has only a single caller and there ucr2 & UCR2_CTS is
>> >> > never true. And CTSC isn't restored anywhere, is it?
>> >> 
>> >> This is rebase to 'tty-next' branch, and you need to look at it in that
>> >> context. There, ucr2 & UCR2_CTS does already make sense, due to previous
>> >> fix that is already there.
>> >
>> > I looked at 57d6e6b which is the file you patched. And there
>> > imx_uart_rts_auto is only ever called with *ucr2 not having UCR2_CTS.
>> >
>> > If you still think I'm wrong, please improve the commit log
>> > accordingly.
>> 
>> I still think you are wrong, but I don't know how to improve commit log.
>> 
>> To check it once again, I just did:
>> 
>> $ git show 57d6e6b > imx.c
>> 
>> There, in imx_uart_set_termios(), I see:
>> 
>> 1569:	old_ucr2 = imx_uart_readl(sport, UCR2);
>> 1570:	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTS);
>> 
>> Here, current UCR2 value is read into 'old_ucr2' and then its /current/
>> UCR2_CTS bit is copied into 'ucr2' (along with 3 other bits).
>> 
>> Then, later in the same function:
>> 
>> 1591:		imx_uart_rts_auto(sport, &ucr2);
>> 
>> is called that can check /current/ state of UCR2_CTS bit in '*ucr2'.
>> 
>> That's what the patch does, checks this bit.
>> 
>> Sorry, I fail to see how you came to conclusion that "*ucr2 not having
>> UCR2_CTS". Do we maybe still read different versions of the file?
>
> No, it's just that I failed to see that UCR2_CTS is in the set of bits
> that are retained even when looking twice :-|

Ah, that one... How familiar :-)

> So you convinced me that you are right and if you update the commit log
> as agreed already before and even add a comment in imx_uart_rts_auto
> along the lines of
>
> 	/*
> 	 * Only let the receiver control RTS output if we were not
> 	 * requested to have RTS inactive (which then should take
> 	 * precedence).
> 	 */
>
> you can have my Ack.

OK, will do

Thanks!

-- Sergey
