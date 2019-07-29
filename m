Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43D0787EE
	for <lists+linux-serial@lfdr.de>; Mon, 29 Jul 2019 11:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfG2JDM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 29 Jul 2019 05:03:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42700 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG2JDM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Jul 2019 05:03:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so57803826lje.9
        for <linux-serial@vger.kernel.org>; Mon, 29 Jul 2019 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=oRmCUEiChCoW94cQNYLaR9KTEtEzgUmnh/eXSREmLoo=;
        b=XDK5T1uqsEwyRad6yFoKHni9nZ6pOkbflWCH6VtnW/ydkArnwal11AYkczOGtlDBz9
         XBoioC4KDPI+p0tSxPC9vLU6p03p9gkyhV8VFHpStUIuIvvMpykJy7+EEzBeAmB0ZV9n
         G4mhByX7v7mx6ULOkhTY9tj36Sxnqw4WXxE1XcvG97pSK6P6ArnRpwndOAq1bn57mkLX
         7lCkLxxujaoug4XeJ1DiPklRVbFsd5lO+KHfaEJmmunVt09jPl+HrXJRuSsXJEHTfBfV
         34m3iLsZCJokwBT7rfd+5sfW9fE/7g9qGBrHgzKUhIUpD5/tJ5SB7Y4c8Hfy/npVkDVX
         SfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=oRmCUEiChCoW94cQNYLaR9KTEtEzgUmnh/eXSREmLoo=;
        b=RB0XmdhKm6DRUcsY2JrJD3q7HZcgItLF87NyZRDwv2s6iMYe3Nxb/gaIzXHAi2aaZ1
         Tx1yKnLqBKHt4OHNl69YvGBUMYo8IP/d36/zr+A3Oj+VDNUFedo2yOywUKIzIaPvctGo
         AOVLfwTG850Ek4vhth6yl/cGOcRN0yy72Zawvt/u9C3i+NttmGhZVPKXW6dMDEWlpmUv
         c1xd7TIs5/81MvzkbxHWZhhLGRb2r5+piFoZEnzDyU1I/S6eNkZRn17vLhL35h5a7kW7
         MqKZxV6WorNv5DCx1OWEZv1uPoxa0Opa52WkVpNghLsYC+jFkf50d3r3oM/mUgxrg3dm
         Hv1Q==
X-Gm-Message-State: APjAAAV+mnnIA8KYXMONat/y6Xa2xTQrZ7nxlHa9idwmxAcf4bm0IGdR
        I8THRdcfAhtRs3H/ussce/g=
X-Google-Smtp-Source: APXvYqziQ+uMeeFKh0OFXM4bjzEorUGeAne1BCLOInZ4uNj3i/ppf4P3Y2qJ1OtP2/1JdKXSmulTYg==
X-Received: by 2002:a2e:8ecb:: with SMTP id e11mr18775649ljl.218.1564390990253;
        Mon, 29 Jul 2019 02:03:10 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 27sm12619361ljw.97.2019.07.29.02.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:03:09 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v7 3/3] serial: imx: get rid of imx_uart_rts_auto()
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1564167161-3972-1-git-send-email-sorganov@gmail.com>
        <1564167161-3972-4-git-send-email-sorganov@gmail.com>
        <20190726192940.jy4frulgbetf5d2v@pengutronix.de>
Date:   Mon, 29 Jul 2019 12:03:07 +0300
In-Reply-To: <20190726192940.jy4frulgbetf5d2v@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Fri, 26 Jul 2019 21:29:40
 +0200")
Message-ID: <87wog1xlf8.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Fri, Jul 26, 2019 at 09:52:41PM +0300, Sergey Organov wrote:
>> Called in only one place, for RS232, it only obscures things, as it
>> doesn't go well with 2 similar named functions,
>> imx_uart_rts_inactive() and imx_uart_rts_active(), that both are
>> RS485-specific.
>
> I don't share the critic. IMHO the name is fine. imx_uart_rts_inactive
> sets rts to its inactive level,
> imx_uart_rts_active() to its active level

Not exactly, in fact both do more than that, in a similar manner.

> imx_uart_rts_auto() lets the output drive automatically by the
> receiver.

And this one was different and it was rather confusing when I've tried
to grok the logic of the driver.

> The name started to be a bit wrong in patch 1 of the series however.

The function was different from first two even before the patch, as it
does not do any of those additional things the first two do.

> And I still object removing this function because with the semantic
> this function got in patch 1 it is suiteable to be used in
> imx_uart_set_mctrl().

It is not, as it does require change to be used there, as we've already
seen, and then it becomes very different function from what it was at
the beginning.

Even then, the end result I've shown you when attempting to somehow preserve
some re-incarnation of this function still seems more cumbersome to me
than the end result of these patches.

That said, this a matter of taste and style, not correctness, and could
be changed as a follow-up, not to risk breaking already tested patch
series.

Thanks,

-- Sergey
