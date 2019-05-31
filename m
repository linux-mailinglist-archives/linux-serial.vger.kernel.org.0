Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1276314D4
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 20:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfEaSik (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 14:38:40 -0400
Received: from mail.javad.com ([54.86.164.124]:58417 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfEaSik (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 14:38:40 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 703A03E8ED;
        Fri, 31 May 2019 18:38:38 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=ICdSKqRy;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1559327918;
        bh=hKrTGCxM0NoMXLNCiA6SWJ0YRx6cjDtPdfglKmC6JdM=; l=2783;
        h=Received:From:To:Subject;
        b=ICdSKqRyxLklEM6/9nf+qEWPGUA6dqxAa9v6KqLDKpbQ8wFUMGFYiGc39wlS1i6Ez
         7XYTMFXZ/wNSRjKy4fVzpdYrRYVzskft7TcJZhmEXIggmeHIK0wDDRpyl6/s9tH/sM
         6lyXqXVrebqOJNOyKBwswMjaqYpcPGTmEOKs7Thg=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1hWmQH-0002XS-18; Fri, 31 May 2019 21:38:37 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Russell King <rmk@armlinux.org.uk>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/8] serial: imx: fix breaking RTS/CTS handshake by mctrl change
References: <20190530152950.25377-1-sorganov@gmail.com>
        <20190530152950.25377-3-sorganov@gmail.com>
        <20190530203931.n6b22ktbzuyg67sd@pengutronix.de>
        <87woi7ur1g.fsf@javad.com>
        <20190531062809.nacg54russc3wvcz@pengutronix.de>
        <20190531135438.bqrpek6niddnrqmo@shell.armlinux.org.uk>
Date:   Fri, 31 May 2019 21:38:37 +0300
In-Reply-To: <20190531135438.bqrpek6niddnrqmo@shell.armlinux.org.uk> (Russell
        King's message of "Fri, 31 May 2019 14:54:38 +0100")
Message-ID: <87r28ea2qa.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Russell King <rmk@armlinux.org.uk> writes:

> Uwe, this is more ment for Sergey, I don't seem to have his emails
> obviously to hand...
>
> On Fri, May 31, 2019 at 08:28:09AM +0200, Uwe Kleine-König wrote:
>> Hello,
>> 
>> On Fri, May 31, 2019 at 08:33:15AM +0300, Sergey Organov wrote:
>> > This is still wrong, as it turns off RTS/CTS handshake in hardware on
>> > TIOCM_RTS=0. Once again, set_mctrl() should not touch UCR2_CTSC, -- it's
>> > as simple as that.
>
> That is incorrect.
>
> The point of hardware flow control is to stop the remote end when the
> buffers at the receiver fill up, and by "buffers" I mean _either_ the
> FIFO or the kernel's buffers.

I thought it should work automagically when there is proper hardware
RTS/CTS support, and I'm still not convinced it doesn't.

> With serial ports that do not have hardware RTS support, the kernel
> can only notify the remote end that the kernel buffers are full, and
> it does this by calling set_mctrl() to deassert RTS.
>
> Some serial ports have additional hardware that allows them to
> automatically deassert the RTS signal when the receive FIFO is in
> danger of overflowing - this is entirely supplementary to the above
> mechanism, so the conditions for deasserting the RTS signal when
> CRTSCTS is set become:
>
>    If the kernel buffers fill up, and the kernel calls set_mctrl()
>    with RTS false, _or_ the hardware decides that the FIFO is close
>    to overflowing and itself decides to deassert RTS, then RTS should
>    be deasserted.
>
> Ergo, if the driver's set_mctrl() is called with RTS=0, then RTS must
> be force-deasserted whether or not hardware assisted flow control is
> enabled.

I admittedly didn't expect upper level to call set_mctrl() to deassert
RTS manually when driver has claimed hardware flow control, but even if
it does, it seems like it could be safely ignored, see below.

> If this is not done, data loss will occur: characters will be received
> from the FIFO, and the attempt to place them into the kernel buffer
> will fail, resulting in the characters being discarded.  This would not
> be an effective hardware flow control implementation.

Why? Doesn't kernel stop its receiving machinery anyway when software
receive buffers get filled?

If it does, that seems logical, then it will rather stop reading from
FIFO, and once FIFO fills above threshold (if at all), hardware will
de-assert RTS by itself, no complications required.

OTOH, if kernel doesn't stop receiving, and RTS/CTS handshake is off or
is not obeyed by sender, kernel will continue to read from FIFO (and
discard data) even when software buffers are full, potentially
indefinitely. Somehow I doubt it's indeed the case.

What do I miss?

-- Sergey
