Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB760311CB
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfEaP5K (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 11:57:10 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33868 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfEaP5K (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 11:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1qsXgMdZdZCVb0zGvBJg48inoUnxWB9wnqlIe6TKCKQ=; b=lMzx7007xbCUygcV/Kwz6yH5h
        pJYhIa7kqEoC8Rw1iqQw3xkJOSwAesHfalzwzBCi8y7A/9zGdvLks6XMBdMoCxpcIZ/MkHZhMWgAB
        JX5K+LbyeV5/uhWl3BShi2oZ/cnTfbzsHols4Q+n0888jF51iq9bCqOif3FboCBteN6zZnZ9ahfzN
        uV84PRibXhMiD7FLhG5VoedR1rTjvueaPF8MSngs1qWniJ+iogk5hfAvaq5Ng7EOXJmoC73nfBq4Z
        HDznL08UeMSuZLvIw1Oj+mgg+Mm1okBQzjokAa89kNYtAMeUYBvob8jPJd+Yo+XGrgNX5fQmdTz4Z
        qydNMxa1A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52758)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hWjtx-0001gZ-3z; Fri, 31 May 2019 16:57:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hWjts-0006T6-L2; Fri, 31 May 2019 16:57:00 +0100
Date:   Fri, 31 May 2019 16:57:00 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] serial: sa1100: add note about modem control signals
Message-ID: <20190531155700.crrawgf3iot2sm2t@shell.armlinux.org.uk>
References: <20190531151032.tfrl7yqph6wsg5pl@pengutronix.de>
 <E1hWjO0-00087g-7y@rmk-PC.armlinux.org.uk>
 <20190531153135.sboekptwx4jxlpeg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531153135.sboekptwx4jxlpeg@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 05:31:35PM +0200, Uwe Kleine-König wrote:
> Hello Russell,
> 
> On Fri, May 31, 2019 at 04:24:04PM +0100, Russell King wrote:
> > As suggested by Uwe, add a note indicating that the modem control
> > signals do not support interrupts, which precludes the driver from
> > using mctrl_gpio_init().
> > 
> > Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> > 
> > Uwe, something like this?
> > 
> >  drivers/tty/serial/sa1100.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> > index a6b4309b62fc..d7dbf0576be8 100644
> > --- a/drivers/tty/serial/sa1100.c
> > +++ b/drivers/tty/serial/sa1100.c
> > @@ -949,6 +949,9 @@ static int sa1100_serial_resume(struct platform_device *dev)
> >  static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
> >  {
> >  	sport->port.dev = &dev->dev;
> > +
> > +	// GPIO driver does not support interrupts for these modem
> > +	// control signals, so the serial driver polls them.
> >  	sport->gpios = mctrl_gpio_init_noauto(sport->port.dev, 0);
> >  	if (IS_ERR(sport->gpios)) {
> >  		int err = PTR_ERR(sport->gpios);
> 
> I would mention that because of this mctrl_gpio_init cannot be used.

Ok.

> (And I would have expected C-like comments).

It seems that Linus has changed his opinion on C99 commenting style,
from "it's not real C" to "I prefer it":

https://lore.kernel.org/patchwork/patch/852060/

Yes, this is mostly about the SPDX commenting style, but Linus seems to
be expressing a general preference towards "//" style comments over
"/* */" comments, especially for new comments.

Specifically see replies #14 and #18, especially #18 where the
discussion moves towards trailing-line comments for structure members.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
