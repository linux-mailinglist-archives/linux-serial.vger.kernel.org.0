Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB2A34616
	for <lists+linux-serial@lfdr.de>; Tue,  4 Jun 2019 14:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfFDMBP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 4 Jun 2019 08:01:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39525 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFDMBP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jun 2019 08:01:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id p24so9774660lfo.6
        for <linux-serial@vger.kernel.org>; Tue, 04 Jun 2019 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LZXmKmxHB28e5H6Cj2fVa7Dg7+npkYBZtnBQA5MXwXA=;
        b=YdeEKRwyOrj403/tRxpNu9Lnjqqz5T6QwKrIZKc45x/v5R9uffkkWGflfYlou4dPRT
         5KF/Aa3Y0lwUScq8MNSz2gLgFkIXuhsLP96UyUYhHTxAy+so/aYr4eNPPaW6OT7oahu2
         eZx1bCzrn2B3y8JYip6Y2SGoWiLq0ZtQD9KjWz/s2U5ij8XArcsN/LJKL8yOIz9+334S
         ivtpqw43a3wtHiM6qsmUyC/ANnFyZZtZfIwcc+Krn4lPvtO/eSqD/vWOtbZlcnnq2m5R
         nKaw6ZFfmi+P+Op2Sp0X1a8hdtBtuATFKTzBDXxDIM8eZDKpj+Abf0ojGGAgtok0HDax
         7Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=LZXmKmxHB28e5H6Cj2fVa7Dg7+npkYBZtnBQA5MXwXA=;
        b=Tw9ZVmzEWyERlkwz4Nddc0/qMSivOnpbQz68NNYpGzkfOaxLfskutMrXGBlPkpvtYy
         JMPJg/HtqhZfnyB8R+Twgx7Dw8yBSeEul5zkX3hdhMGeuqiUkip1ILXhlOwCa4OXJHiu
         bV/9Dmvn/9xPpkBq3UHJQvKQUVltqpdvc/OV1O958wVfqMN4jYHf5D+GdsQX6t8gvj3X
         3gRuB28wg5rQsb2n28L1XKG0nGQcKzdo9d2MuElxHiWqaX9CQvbeAD062Q83EI0pA8aB
         AHdQ5tWt5Zq+l9uPX0HqTJK30VHBdIvW+lkrKwCpZlUd8XguI8XhOmSC1WlyWvicajYp
         O/Tw==
X-Gm-Message-State: APjAAAXodh/04gtwlz3MYgaP88F7Zdl55uPKxy9RlYUZnsiUuqkZFhFE
        VUmqQDclYQYezGD+3K8JRJw=
X-Google-Smtp-Source: APXvYqzIu0pdlCbOTMwbjSYKvosqHdRl5OIH5b2uWY1L1AgEEAY6ltmfUeqGX5akEgSCXTVJIQIJ6A==
X-Received: by 2002:a19:9545:: with SMTP id x66mr15725329lfd.94.1559649673531;
        Tue, 04 Jun 2019 05:01:13 -0700 (PDT)
Received: from osv ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l25sm2204774lfh.49.2019.06.04.05.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 05:01:12 -0700 (PDT)
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
Date:   Tue, 04 Jun 2019 15:01:11 +0300
In-Reply-To: <20190531173734.umxt3kifjel5w4yi@shell.armlinux.org.uk> (Russell
        King's message of "Fri, 31 May 2019 18:37:34 +0100")
Message-ID: <87pnnty2yg.fsf@javad.com>
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

What driver(s) do you recommend as a good reference implementation that
manages decent hardware featuring FIFO and automatic RTS/CTS control?
DMA?

-- Sergey
