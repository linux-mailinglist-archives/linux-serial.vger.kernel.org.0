Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E3835619
	for <lists+linux-serial@lfdr.de>; Wed,  5 Jun 2019 07:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfFEFCn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 5 Jun 2019 01:02:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34207 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfFEFCn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jun 2019 01:02:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id y198so7597549lfa.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Jun 2019 22:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Vv5BNt8UV0wEEWTnOpq36ubv6OlyHL1lKwu8V954TOo=;
        b=SQHIMMGgyigO8FsrlHx2ANEjk3o4URXvtadPWl46U8RAdVZjHkliS7QmuNfQQRBzbK
         oDSvsYYNGFslFFRSg4ma9ViMD19yD8QlNRfcC60bko8kKqamjPzy/zyLon7EAHNXgwC+
         PvJNdKIGFb/eqJ4Q3MJolfpJpqwg5r6BNCnHPdMzol2hfzcNkjxzNDSRif0gmj46KzTP
         Af2iPJLGQJ9MhmUSozXEOkua/MvekPTEjOmGyLNSH/UU8ni5dtI9SbHcWdOHKA77L+yL
         lp2GDl5O0sfz0ylFfXvSPFpNDk4LfIvUgZKvr1Tn2g7u9qjNreMmw2X6IXlgoRZucCpc
         dnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Vv5BNt8UV0wEEWTnOpq36ubv6OlyHL1lKwu8V954TOo=;
        b=Z8RlYoyQKAPvi3JlcNnqOE9kdpD7kEaFLCdriN3l68nJK5c3e9Inrlp7UGXGXCDtsI
         dZy0i765nV20uU70xCKppQw0tzIuUtFZk9BGuN5+UqY5fKAgR4RVTtK4CeeEtUnDcoab
         McbDItiFSFlsZjVCeey2Cc9MnX3gWauQ26mGzSQX2F0Yzy/owvJYwoyyiU7oGZPa2bIp
         VVtS71MrmcRfPiFkIfTbdgDumLQyhZ0YA4EJtW+PyRf2+xj+CoeXzM1dD0Ijh7mEh4Jz
         AUEacYntafMhR2wY6rMWlNqKOBNTkwLgO3KXXSx0Yq3eA9VW4hVO3YRcq3ZA/BkI8alZ
         vZnw==
X-Gm-Message-State: APjAAAX/iR6ITTVS30sx9W/X0z+XpRG8AxHTKVKM+jXTWrakiMQmXmnQ
        iPeUIkOHRBA8mFyXOOO5JsA=
X-Google-Smtp-Source: APXvYqyB1Z78vV9aZvZtt64ZGt0VKTajNnF9bvcJt62g2N+ykLhjo3pXXCDuMG8qI5DggjLyjew1vQ==
X-Received: by 2002:a19:4f50:: with SMTP id a16mr18318066lfk.24.1559710961827;
        Tue, 04 Jun 2019 22:02:41 -0700 (PDT)
Received: from osv ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q7sm3906036ljc.45.2019.06.04.22.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 22:02:41 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 4/8] serial: imx: get rid of unbounded busy-waiting loop
References: <20190530152950.25377-1-sorganov@gmail.com>
        <20190530152950.25377-5-sorganov@gmail.com>
        <20190530210059.xt7qlyk57cf3zaux@pengutronix.de>
        <87imtrup3z.fsf@javad.com>
        <20190531064248.qh4tecbv6ejvroyw@pengutronix.de>
        <87k1e6bnxi.fsf@javad.com>
        <20190531164848.jnxib6ju7bdudfyx@pengutronix.de>
        <20190531173734.umxt3kifjel5w4yi@shell.armlinux.org.uk>
Date:   Wed, 05 Jun 2019 08:02:40 +0300
In-Reply-To: <20190531173734.umxt3kifjel5w4yi@shell.armlinux.org.uk> (Russell
        King's message of "Fri, 31 May 2019 18:37:34 +0100")
Message-ID: <87a7ewvd3j.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:

> On Fri, May 31, 2019 at 06:48:48PM +0200, Uwe Kleine-König wrote:
>> On Fri, May 31, 2019 at 07:15:21PM +0300, Sergey Organov wrote:
>> > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> > > The first (and only) driver I checked does. (sa1100.c)
>> > 
>> > I think I'd rather take 8250 as reference implementation, as being most
>> > widely used. Can anybody please tell how 8250 code handles this? Does it
>> > attempt to drain Tx FIFO on termios changes?
>> 
>> Well, there are so many 8250 variants that the driver is rather
>> complicated. Also the original 8250 doesn't have a FIFO at all.
>> 
>> Given that it might not be so easy to judge if a given driver drains the
>> FIFO and transmitter without consulting the reference manual I'd rather
>> rely on an authority for the serial core. (Apart from that I bet we're
>> finding examples for both variants.)
>> 
>> @gregkh, rmk: What do you think?
>
> Let me also clarify something above.  Yes, sa1100.c is good to use as
> a reference driver - it was carefully converted to serial_core by me
> along with 8250, and I made sure the semantics in the driver were
> correct for what the hardware supports.
>
> The key thing is "what the hardware supports" though - the serial
> block has no hardware flow control signals, and it is expected that
> GPIOs or other arrangements would be made where such signals were
> necessary:

What driver would you recommend as a good reference implementation that
manages decent hardware featuring FIFO and automatic RTS/CTS control,
preferably with DMA support as well?

-- Sergey
