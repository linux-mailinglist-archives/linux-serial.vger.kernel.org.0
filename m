Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74713332FA
	for <lists+linux-serial@lfdr.de>; Mon,  3 Jun 2019 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfFCPAg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 3 Jun 2019 11:00:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34192 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfFCPAf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jun 2019 11:00:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id j24so16564372ljg.1
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2019 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Z0q56m29JKs/KSc5kZjLD8aOvRo5OnqtBUIzP0WVLuA=;
        b=GhMUbql6/srHaDxQoep3dj9gs65RWfp0h5ODaftQK5QSssSnZqtZ7Qrf/107svyxNh
         ryLfxSVOuF2IKPUqo5OjO0PjcrfERmKdi/4stKSI8nPjvzTZG06+tR/UU1yNygMuzVYg
         uQibPIYPzGH0eDdeEbDAZ3zq9UKs2ubO9dkEkfmqRL884HDE1cxFJYT9daJNbcSsnRWP
         s3qJdYk/m0Dt7AH4nbyrhMupXGmniK4BUM48TqMlfSk2a01Sb5qDe29wpGVkibfSIAzD
         viJIgLxkK+R4dKdHmC5rKufatOEc2vwHLLvMYc4zoirmEY0gRRO7le7rPYLFb6JIWO5M
         CYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Z0q56m29JKs/KSc5kZjLD8aOvRo5OnqtBUIzP0WVLuA=;
        b=al1VpRWw11LsBvDiTci4pL3hHZFfY5TEpMhn3hQnI91tskNB6eVjPd8hd9xrnCnSdz
         5s+vHzYbuNJbMbFp6xbPeWmnCHbuBH5Wt94sLhCjFHFjfRp6gEMfiihM2ZxGeaaatWtN
         M8rVpL5wKPIY3Blu3xIjvs5HlgCQQUtijigGVcbzvpJ5DKHmDU2Ar9xHH71ARqOP5mTC
         MANUCuQ7Mgep++Dzj2na6S6OXncG94xIOX2t36MYuIamiNPdwdHl0esYerJhIWFgCZE5
         9pkwMKGWfZCRQmkh/x8EWkcdvzQOeM6tQg3kw6//Ixd4L7vMebSXQVJOHn7BbCUDNp/y
         aFAA==
X-Gm-Message-State: APjAAAV7Sl0GezQCDvet6cDQkhztMp6sElJOrt/k1cHC+KMNUoI5xDdy
        gRlBLoSQWThoWzm1Bcf9kWjCZm2/UOs=
X-Google-Smtp-Source: APXvYqyGMVo9LXQvwTblQtU9w9An1tT1pdq3R8W7yI6CwFVnGxMQbten4xyhRLRN45ehPmsXz9e3Kw==
X-Received: by 2002:a2e:9d07:: with SMTP id t7mr6995203lji.43.1559574033691;
        Mon, 03 Jun 2019 08:00:33 -0700 (PDT)
Received: from osv ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r10sm1290983lja.29.2019.06.03.08.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:00:32 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 2/8] serial: imx: fix breaking RTS/CTS handshake by mctrl change
References: <20190530152950.25377-1-sorganov@gmail.com>
        <20190530152950.25377-3-sorganov@gmail.com>
        <20190530203931.n6b22ktbzuyg67sd@pengutronix.de>
Date:   Mon, 03 Jun 2019 18:00:31 +0300
In-Reply-To: <20190530203931.n6b22ktbzuyg67sd@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu, 30 May 2019 22:39:31
 +0200")
Message-ID: <87muiy3e9c.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:


[...]

> Independant of your patch I discussed a problem in imx_uart_set_mctrl()
> with Sascha and Russell (both added to Cc:) earlier this week. In the
> current implementation there are actually two problems.
>
> Currently imx_uart_set_mctrl does:
>
> 	if TIOCM_RTS is set:
> 		let the receiver control the RTS signal
> 	else:
> 		set RTS inactive
>
> The bigger problem is that if the UART is configured not to use
> handshaking (CRTSCTS unset) the mode "let the receiver control the RTS
> signal" should not be used.
>
> The smaller (and irrelevant for correctness) problem is that setting
> UCR2_CTS is a no-op when UCR2_CTSC is also set.
>
> We think the right thing to do is:
>
> 	ucr2 = imx_uart_readl(sport, UCR2);
> 	ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
>
> 	if (mctrl & TIOCM_RTS) {
> 		if (sport->crtscts)
> 			/* let the receiver control RTS */
> 			ucr2 |= UCR2_CTSC;
> 		else
> 			/* Force RTS active */
> 			ucr2 |= UCR2_CTS;
> 	} else {
> 		/* Force RTS inactive, i.e. CTS=0, CTSC=0 */
> 	}
>
> 	imx_uart_writel(sport, ucr2, UCR2);
>
> but AFAICT this isn't tested yet to an end in the use case that Sascha
> currently has and so there isn't a complete patch available yet.

This looks almost correct, except there is no sport->crtscts. Are you
going to add it? Other drivers use port->status & UPSTAT_AUTORTS for
that, and maybe it'd better to follow, except it seems you then need to
manage UPSTAT_AUTORTS yourself, no help from top-level :-(

However, I figure that it could rather be calculated right here as:

         !(ucr2 & UCR2_IRTS)

as autoCTS is set if and only if autoRTS is also set, and UCR2_IRTS
otherwise remains static.

... and then set_termios() should still be fixed, as it clears UCR2_CTS
bit on every invocation, but differently from my original patch (see
separate mail on that patch).

I'll try to come-up with new separate patches for this particular issue
(I mean RTS/CTS handshake handling).

-- Sergey
