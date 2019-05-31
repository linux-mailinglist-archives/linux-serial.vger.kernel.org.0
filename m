Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1C03137B
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEaRJj (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 13:09:39 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34818 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaRJj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 13:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1Rkox7jOrdLNN7lHqoRROEFt4t679Ck3GvBblbKj54s=; b=OM1lTLQGb2OKsrutaKXskyqgu
        dfvUpyGMespvSpD7sRlhjKilpOLfsFFzaxKYlPd35rIaUYssfhrIbBA108FBljplRx2uE6BIk6LQD
        PDMAtB9JtX3dIujAOSpmWP/Jjd/mlV5LQLSLWTQFjLlYdFAYfn+k4LFeHVeIDXtKNckc4Chi4WjzG
        o7Mjy3idIlLNkYEvstadUqrVzrCTzjBWm1Iw8X1h4bo/A8mSijwtw26nzLGzub8NzyDaVQuZJ/ATb
        moKDjBVBLwRt3qZwnNOAQyEThBRvqg4MctLnn8WGHyZ66OQV7gYCDuYk3rPr1W6/et8QDzIYbLzZR
        dEPGgWWMw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:56116)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hWl25-00023h-CF; Fri, 31 May 2019 18:09:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hWl22-0006WK-P0; Fri, 31 May 2019 18:09:30 +0100
Date:   Fri, 31 May 2019 18:09:30 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 4/8] serial: imx: get rid of unbounded busy-waiting loop
Message-ID: <20190531170930.hh5lj5uokdmprw2b@shell.armlinux.org.uk>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-5-sorganov@gmail.com>
 <20190530210059.xt7qlyk57cf3zaux@pengutronix.de>
 <87imtrup3z.fsf@javad.com>
 <20190531064248.qh4tecbv6ejvroyw@pengutronix.de>
 <87k1e6bnxi.fsf@javad.com>
 <20190531164848.jnxib6ju7bdudfyx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531164848.jnxib6ju7bdudfyx@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 06:48:48PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> TL;DR: The key question in this thread is, if a driver should drain fifo
> and transmitter in .set_termios or not.
> 
> On Fri, May 31, 2019 at 07:15:21PM +0300, Sergey Organov wrote:
> > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> > > On Fri, May 31, 2019 at 09:14:56AM +0300, Sergey Organov wrote:
> > >> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> > >> 
> > >> > On Thu, May 30, 2019 at 06:29:46PM +0300, Sergey Organov wrote:
> > >> >> imx_set_termios(): remove busy-waiting "drain Tx FIFO" loop. Worse
> > >> >> yet, it was potentially unbounded wait due to RTS/CTS (hardware)
> > >> >> handshake.
> > >> >> 
> > >> >> Let user space ensure draining is done before termios change, if
> > >> >> draining is needed in the first place.
> > >> >
> > >> > I don't know for sure what the intended behaviour is here, but I tend to
> > >> > think that changing the unbounded wait to a timeout and then return
> > >> > -EBUSY (?) would be more suitable.
> > >> 
> > >> No, please! Bytes in Tx FIFO are not an excuse to exit with error
> > >> instead of setting new termios as asked to. 
> > >
> > > Well, my suggestion is more defensive. It at least tells the user that
> > > they do something wrong. If they already care for having the FIFO and
> > > transmitter empty before changing the baud rate the behaviour of both
> > > your and my approach are identical. With yours however it undefined if
> > > characters written to the device before the change are sent with the old
> > > or new settings. So my suggestions yields a deterministic behaviour
> > > which is good. And it tells the user when they do something wrong, which
> > > is good, too.
> > >
> > >> > With your change you're possibly breaking existent software.
> > >> 
> > >> Well, I suspect the software is already broken then, as most widely used
> > >> drivers out there seem to do no Tx FIFO draining on set_termios() call,
> > >> or do they?
> > >> 
> > >> I mean I tried to find similar code in some of the other drivers, to
> > >> replicate it, but I failed to find one.
> > >
> > > The first (and only) driver I checked does. (sa1100.c)
> > 
> > I think I'd rather take 8250 as reference implementation, as being most
> > widely used. Can anybody please tell how 8250 code handles this? Does it
> > attempt to drain Tx FIFO on termios changes?
> 
> Well, there are so many 8250 variants that the driver is rather
> complicated. Also the original 8250 doesn't have a FIFO at all.
> 
> Given that it might not be so easy to judge if a given driver drains the
> FIFO and transmitter without consulting the reference manual I'd rather
> rely on an authority for the serial core. (Apart from that I bet we're
> finding examples for both variants.)
> 
> @gregkh, rmk: What do you think?

We generally follow POSIX general terminal interface for TTY stuff.
The behaviour when setting termios is set out very clearly there,
and it's up to the application to decide how what it wants: it
may be important for the serial protocol to conform exactly to this.
This is what POSIX says:

  The tcsetattr() function shall set the parameters associated with the
  terminal referred to by the open file descriptor fildes (an open file
  descriptor associated with a terminal) from the termios structure
  referenced by termios_p as follows:

  * If optional_actions is TCSANOW, the change shall occur immediately.

  * If optional_actions is TCSADRAIN, the change shall occur after all
    output written to fildes is transmitted. This function should be
    used when changing parameters that affect output.

  * If optional_actions is TCSAFLUSH, the change shall occur after all
    output written to fildes is transmitted, and all input so far
    received but not read shall be discarded before the change is made.

This is very explicit, and is what we implement.  These are implemented
via the TCSETSF*, TCSETSW* and TCSETS* ioctls(), which use
uart_wait_until_sent() to implement the "wait for output data written
to be transmitted".  Low level drivers implement this via their
tx_empty() callback, which returns zero if the transmitter is not
empty, or non-zero if the transmitter is empty.

However, we bound that by 2x the amount of time to send a FIFO-full
worth of data.

Hence, there is no requirement to implement any transmiter draining
in the .set_termios method - the core code already handles that for
drivers according to the requests of the userspace program.
.set_termios does not have sufficient information to know whether
it should or should not drain the transmitter (the transmitter
should have been drained, except when a timeout situation occurs
or the userspace program requests an immediate change of termios.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
