Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E5432099
	for <lists+linux-serial@lfdr.de>; Sat,  1 Jun 2019 21:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfFATeq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 1 Jun 2019 15:34:46 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51922 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfFATeq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 1 Jun 2019 15:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nXMDAAk/71y76IUjzGgg91cxztDZ2/8fU4J9FVfrfwI=; b=EnOxl9uQFUms+4MvlqJpKjNyS
        jNUROHZA9qg435BACIr29Y2otnHUKhfSlVlxzYpg0oXY5K8+X2CCwevKdoQg5W86fCNFt0emUcNZw
        0FzTSTOfU6wN6EPC4OXdnKfhljLik5uqgCcIrNxqKlFTUS4+6Mk8zQcfFvMvj+K3msgOdni1flcr6
        VitHPrCNmL7ntlyqaSW6CPPepsLlydyDsmqeUa+sfLm1m1GTv3y2/Jza8y58kGR8WCZcW65aiU1iD
        OsxRMLWRFTu0H6VZTId9Tv0U0y/rWtrCkrwlXVisNO26MNYDN0zufEMAsg+wxWfFgPNMaqhzZoej+
        1ztgqxbVg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:56144)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hX9m4-0000cF-Pt; Sat, 01 Jun 2019 20:34:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hX9m0-0007Vt-Us; Sat, 01 Jun 2019 20:34:36 +0100
Date:   Sat, 1 Jun 2019 20:34:36 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sergey Organov <sorganov@gmail.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/8] serial: imx: fix breaking RTS/CTS handshake by mctrl
 change
Message-ID: <20190601193436.irs6sdknz755uyem@shell.armlinux.org.uk>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-3-sorganov@gmail.com>
 <20190530203931.n6b22ktbzuyg67sd@pengutronix.de>
 <87woi7ur1g.fsf@javad.com>
 <20190531062809.nacg54russc3wvcz@pengutronix.de>
 <20190531135438.bqrpek6niddnrqmo@shell.armlinux.org.uk>
 <87r28ea2qa.fsf@javad.com>
 <20190601161256.4zuhqzrdskjdymu5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190601161256.4zuhqzrdskjdymu5@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Sergey,

I don't get your emails because you bypass Google's servers, meaning
that your emails purportedly from gmail.com come through unsigned with
google's DKIM signature - just like _so_ much spam.

On Sat, Jun 01, 2019 at 06:12:56PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, May 31, 2019 at 09:38:37PM +0300, Sergey Organov wrote:
> > Russell King <rmk@armlinux.org.uk> writes:
> > > If this is not done, data loss will occur: characters will be received
> > > from the FIFO, and the attempt to place them into the kernel buffer
> > > will fail, resulting in the characters being discarded.  This would not
> > > be an effective hardware flow control implementation.
> > 
> > Why? Doesn't kernel stop its receiving machinery anyway when software
> > receive buffers get filled?

It does not.  If the serial port raises a receive interrupt, then the
interrupt gets serviced, which means characters are read from the FIFO
and are attempted to be inserted into the TTY receive buffer.  If the
TTY receive buffer is full, they will be discarded.

This is entirely reasonable: the kernel monitors the level of the TTY
receive buffer, and takes measures to prevent it becoming that full
by using flow control - which, for hardware flow control, means that
the kernel issues set_mctrl() to deassert RTS.

Think about it - if we have a port that does not have hardware assisted
RTS, then how does RTS become inactive - if the kernel stops reading
characters from the FIFO, the hardware FIFO will overflow, and RTS will
remain true.

If we want the kernel to stop reading the FIFO, we would have to add
additional complexity to a lot of serial drivers, and a capability
which tells the kernel that they support this behaviour - why do we
want individual drivers to have to implement this?

History has shown that the more low-level drivers have to implement,
the more bugs we end up with, so keeping the complexity to a minimum
is best - requiring serial drivers deassert RTS when there is hardware
assisted flow control and the kernel wishes to do so is _less_ complex
than having some mechanism to stop reading the FIFO.

> Not all hardware has a FIFO and the necessary mechanisms to
> auto-deassert RTS when it fills. So there must be support in software to
> deassert RTS, too. And even in the presence of a "smart" FIFO, the
> software then usually knows earlier about having to stop the other side
> and this might be the necessary margin that makes them stop before the
> local buffer is over full.

Yes, some sending ports have a deep FIFO and may not support hardware
assisted CTS - which means they could send maybe up to 128 additional
bytes after RTS is deasserted, though 16 is more usual.  At least that
is what I remember of some of the enhanced 8250-based chips.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
