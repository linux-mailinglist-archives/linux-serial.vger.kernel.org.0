Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14EA34534
	for <lists+linux-serial@lfdr.de>; Tue,  4 Jun 2019 13:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFDLQM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 4 Jun 2019 07:16:12 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38040 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFDLQM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jun 2019 07:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wnIWM1sutZPHP5l1xG0B5EZ8RdjswMiBjWZmLmapwzs=; b=g645oWxA7WoMXJOZWqq4PNrSj
        LqQ/7oxcWul9/UOJpiqiWEft+ac5lyzwr6P9aB/WVKj74xvOLUE8Nx/H4ZfT5LC8Zre2y2bLYq2c5
        3CIKHQDFRUe1nJISyS3+XgO7/bykhCUsQz4GXOLVoAK4bRJ7UCbTzbarpMnqsGkXuPJbYq6yTtLzS
        K551QN5CGADIpxcju76NnsVaAFaNIidN3zPKhMAaJpn2CPRhO20sQISl++Gw8iKPdw5q/eRRqnNBb
        Cdsdvh0zf5LjTa0TG8RQoLbDERwBKQedazTEA99h3e6JgV3OSOyA3uSXNHgL/HS+x8oS7jGSQBoDI
        iqcRjub/A==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:56180)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hY7QG-0000na-CG; Tue, 04 Jun 2019 12:16:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hY7QD-0001St-IE; Tue, 04 Jun 2019 12:16:05 +0100
Date:   Tue, 4 Jun 2019 12:16:05 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v2] serial: sa1100: add note about modem control signals
Message-ID: <20190604111605.thwhicndrqmy7rlx@shell.armlinux.org.uk>
References: <20190531155700.crrawgf3iot2sm2t@shell.armlinux.org.uk>
 <E1hWjyQ-0008Ni-8V@rmk-PC.armlinux.org.uk>
 <20190531212702.cmqbaqwdybgkb3ug@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531212702.cmqbaqwdybgkb3ug@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 11:27:02PM +0200, Uwe Kleine-König wrote:
> Hello Russell,
> 
> On Fri, May 31, 2019 at 05:01:42PM +0100, Russell King wrote:
> > As suggested by Uwe, add a note indicating that the modem control
> > signals do not support interrupts, which precludes the driver from
> > using mctrl_gpio_init().
> > 
> > Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/tty/serial/sa1100.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> > index 97bdfeccbea9..8e618129e65c 100644
> > --- a/drivers/tty/serial/sa1100.c
> > +++ b/drivers/tty/serial/sa1100.c
> > @@ -860,6 +860,10 @@ static int sa1100_serial_resume(struct platform_device *dev)
> >  static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
> >  {
> >  	sport->port.dev = &dev->dev;
> > +
> > +	// mctrl_gpio_init() requires that the GPIO driver supports interrupts,
> > +	// but we need to support GPIO drivers for hardware that has no such
> > +	// interrupts.  Use mctrl_gpio_init_noauto() instead.
> 
> I hope it's not an impostor who claimed to be Linus to spread deviance
> from K&R :-)
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> If you want to, squash this in the commit that introduced
> mctrl_gpio_init_noauto while keeping my Ack on the resulting patch.

I'd prefer to keep it separate to avoid invalidating the acks that I
already have on the first patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
