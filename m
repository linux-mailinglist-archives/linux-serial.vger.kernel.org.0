Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBBD6FC03
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 11:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfGVJUH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 05:20:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42937 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfGVJUG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 05:20:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id s19so26096397lfb.9
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=plSsouCihSrvy+XJa8kqnNsfu5JW0L2stXgngIJDoK0=;
        b=sklfs8oF8tk6iN3uIdr1jYUBE9kDukXheMXJRC57/Y1adkZlvN2FpLXKew0/EI6H94
         RLyP/IUj0Dn7ij2jJ63bul8eARR0Hjj+993oAX4AU15bchmgOyKnrtPHOtKjUlByiGJL
         86Trch8pUCwfWVL752ApcCJTYsu1zkecccgcbyBM7jdZ6otwSMQWOgl0uiirk7pukqHi
         Ah1z68llsYFPR+8JF/TzPMaDxz1PwJ44QreM05/8/GAdPZ9qFIjS4YbH45LwCcRCGA1i
         jbqAJv1/yhpXlcy1M3/JqUm6Vm8wE4Q6srq//+faxBBk2GiSUkIFwkyQr4y9vRriH72u
         jpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=plSsouCihSrvy+XJa8kqnNsfu5JW0L2stXgngIJDoK0=;
        b=l0m2tKyfsZH6aNJflioU0qF9bAYwgCA7VyfnZczd/jP6Secgo3zZMGaIpqFHALVUWc
         dG8K+zGqI+e1gv/Ngl15tefjrCZERimqPhjgB5n8PKtyEByfoPk9wKiHy9LRdjloFo/Z
         xcfjBWYdtwawsahikW4opIG6AKJHY1zMq3kdJUkxbhbg1LDKD/yJeUlU43aGDhLs9HCd
         C/5XbGogakQRIQuAjilgdIpdovLLTsxAtNYSDD4i4YzgHT8Vb2otvrw/lFoi4SyHOYmR
         R+TL5uAhUjuVB0TvuYEoiZVj6wTWDTqNFoBloFiGWXYSEKibtIyucwhnGZ9NSawbqyzu
         J95w==
X-Gm-Message-State: APjAAAXEKKxhmJgZ/JIs265WPMxmfn0o0STSWjv13ef6WPXCWklqB18B
        8XSj8lgCa+WB9qqG1Vtq0Qg=
X-Google-Smtp-Source: APXvYqwJvKdtPe2MH65q+nOk5fdMIx3fYwg3dB22Jp061jGCK6qNBZZHQuhpeVMCzKDTl+VqZLb43w==
X-Received: by 2002:a19:9104:: with SMTP id t4mr11400657lfd.179.1563787203856;
        Mon, 22 Jul 2019 02:20:03 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h4sm7483579ljj.31.2019.07.22.02.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 02:20:03 -0700 (PDT)
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
        <87ftmy8qgu.fsf@osv.gnss.ru>
        <20190722075107.cc3tvf6gmxhaeh5m@pengutronix.de>
Date:   Mon, 22 Jul 2019 12:20:02 +0300
In-Reply-To: <20190722075107.cc3tvf6gmxhaeh5m@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Mon, 22 Jul 2019 09:51:07
 +0200")
Message-ID: <87lfwq77el.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Mon, Jul 22, 2019 at 10:42:57AM +0300, Sergey Organov wrote:
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> 
>> > On Fri, Jul 19, 2019 at 06:13:52PM +0300, Sergey Organov wrote:
>> >> Hello Uwe,
>> >> 
>> >> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> >> > Hello Sergey,
>> >> >
>> >> > On Fri, Jul 19, 2019 at 03:18:13PM +0300, Sergey Organov wrote:
>> >> >> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> >> >> > On Fri, Jul 19, 2019 at 11:47:52AM +0300, Sergey Organov wrote:
>> >> >> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> >> >> >> index 57d6e6b..95d7984 100644
>> >> >> >> --- a/drivers/tty/serial/imx.c
>> >> >> >> +++ b/drivers/tty/serial/imx.c
>> >> >> >> @@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
>> >> >> >>  /* called with port.lock taken and irqs caller dependent */
>> >> >> >>  static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
>> >> >> >>  {
>> >> >> >> -	*ucr2 |= UCR2_CTSC;
>> >> >> >> +	if (*ucr2 & UCR2_CTS)
>> >> >> >> +		*ucr2 |= UCR2_CTSC;
>> >> >> >
>> >> >> > I think this patch is wrong or the commit log is insufficient.
>> >> >> > imx_uart_rts_auto() has only a single caller and there ucr2 & UCR2_CTS is
>> >> >> > never true. And CTSC isn't restored anywhere, is it?
>> >> >> 
>> >> >> This is rebase to 'tty-next' branch, and you need to look at it in that
>> >> >> context. There, ucr2 & UCR2_CTS does already make sense, due to previous
>> >> >> fix that is already there.
>> >> >
>> >> > I looked at 57d6e6b which is the file you patched. And there
>> >> > imx_uart_rts_auto is only ever called with *ucr2 not having UCR2_CTS.
>> >> >
>> >> > If you still think I'm wrong, please improve the commit log
>> >> > accordingly.
>> >> 
>> >> I still think you are wrong, but I don't know how to improve commit log.
>> >> 
>> >> To check it once again, I just did:
>> >> 
>> >> $ git show 57d6e6b > imx.c
>> >> 
>> >> There, in imx_uart_set_termios(), I see:
>> >> 
>> >> 1569:	old_ucr2 = imx_uart_readl(sport, UCR2);
>> >> 1570:	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTS);
>> >> 
>> >> Here, current UCR2 value is read into 'old_ucr2' and then its /current/
>> >> UCR2_CTS bit is copied into 'ucr2' (along with 3 other bits).
>> >> 
>> >> Then, later in the same function:
>> >> 
>> >> 1591:		imx_uart_rts_auto(sport, &ucr2);
>> >> 
>> >> is called that can check /current/ state of UCR2_CTS bit in '*ucr2'.
>> >> 
>> >> That's what the patch does, checks this bit.
>> >> 
>> >> Sorry, I fail to see how you came to conclusion that "*ucr2 not having
>> >> UCR2_CTS". Do we maybe still read different versions of the file?
>> >
>> > No, it's just that I failed to see that UCR2_CTS is in the set of bits
>> > that are retained even when looking twice :-|
>> 
>> Ah, that one... How familiar :-)
>
> I thought again a bit over the weekend about this. I wonder if it's
> correct to keep RTS active while going through .set_termios. Shouldn't
> it maybe always be inactive to prevent the other side sending data while
> we are changing the baud rate?

I don't think it's a good idea to change RTS state over .set_terimios,
as it doesn't in fact solve anything (notice that the other end should
also change baud rate accordingly), and changes visible state (even if
temporarily) that it was not asked to change, that could in turn lead to
utter surprises.

Correct changing of baud rates, bits, etc., could only be implemented at
communication protocol level (read: application level), and there are
all the tools in the kernel to do it right, provided driver does not do
what it was not asked to do.

-- Sergey
