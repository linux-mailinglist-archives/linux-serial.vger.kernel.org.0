Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1957313F6
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 19:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfEaRhn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 13:37:43 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35160 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaRhm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 13:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AFqZomqiqVjjgqlME+6UiypZdvB+dd4pkJWIoqbuxKA=; b=aowzMWQL4iHOYW86R66rdICsk
        y74HO3jsWwWr9ZiKmoIf0ha9oFS0+iYPxqOQGpW0PpDrugglFDRHfOsLWEBOUrLCXElD0rp+ppE8u
        vWHV1SUGVwTkveTr65nCW87bsB2CAwvPQmT1WyiDYss8yS43FmvgiEmJnHAC7vy57+y3BYhVZ6kDb
        bOasDZAcGGXKQPfDuP6LqN9g4GyrlMHk0SZwpRoo044EzhluxFXQp+9zc+/AF4QDt2nek4e6k85In
        xf3Wi4lLwgRj9xneMNEOHmqZCS0EbqKPAK3xirl+ufqbUEG/Q2uBX+GuF+7LQmT5ZH5zTkYzd6lga
        yu8+qOvLw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38422)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hWlTE-0002BE-PC; Fri, 31 May 2019 18:37:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hWlTC-0006Wb-EU; Fri, 31 May 2019 18:37:34 +0100
Date:   Fri, 31 May 2019 18:37:34 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 4/8] serial: imx: get rid of unbounded busy-waiting loop
Message-ID: <20190531173734.umxt3kifjel5w4yi@shell.armlinux.org.uk>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-5-sorganov@gmail.com>
 <20190530210059.xt7qlyk57cf3zaux@pengutronix.de>
 <87imtrup3z.fsf@javad.com>
 <20190531064248.qh4tecbv6ejvroyw@pengutronix.de>
 <87k1e6bnxi.fsf@javad.com>
 <20190531164848.jnxib6ju7bdudfyx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531164848.jnxib6ju7bdudfyx@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 06:48:48PM +0200, Uwe Kleine-König wrote:
> On Fri, May 31, 2019 at 07:15:21PM +0300, Sergey Organov wrote:
> > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
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

Let me also clarify something above.  Yes, sa1100.c is good to use as
a reference driver - it was carefully converted to serial_core by me
along with 8250, and I made sure the semantics in the driver were
correct for what the hardware supports.

The key thing is "what the hardware supports" though - the serial
block has no hardware flow control signals, and it is expected that
GPIOs or other arrangements would be made where such signals were
necessary:

   Modem control signals (RTS, CTS, DTR, and DSR) are not implemented
   in this block, but can be implemented using the general-purpose I/O
   port (GPIO) pins. See Chapter 9, ■System Control Module■.

So, there's no way for the CTS signal input to actually stop the
transmitter from draining its FIFO - much like 16550A devices.
We are pretty much guaranteed that the transmitter will drain, and
given that is likely to be a short time (it's only 8 characters deep)
we wait for it.

However, we do not wait for the data queued in the kernel buffers to
also be sent.

This is the only way to ensure that we perform a clean change of
termios settings *on this hardware* without provoking errors at the
receiver in the case of a TCSANOW change where none of the hardware
parameters that affect transmission are actually changing, since
disabling the transmitter will immediately stops transmission,
whether it is mid-character or not.

POSIX does not define whether "immediately" means mid-character or
at a character boundary, but quality of implementation and real
use (eg, as a serial console) shows that this achieves the best
result, rather than ending up with stuff like the console text
turning into graphics characters by the terminal receiving
garbage.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
