Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35930F79
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 16:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfEaOBd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 10:01:33 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60708 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEaOBd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 10:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gwiVuzFV6bQvlyPXmdEGdPq+Cy17hU8CYkt3Fw8v/lU=; b=lcPC/c3qpa4vkVD3PvIN0ICGd
        0zoixj25uxmyrPC1Gl7gwqwTnH6jZaINctHr7f5EijX5pDknWZP6zUFb2gEvXbD9QQrYgydwfY6Sv
        5MQXJtQCEc1sNkIluhHPJ2YGMK75RfPb7BRy2d5ig5+iwtW0LxtnP6yqh+d7DXzJELG+kxT+grrvB
        R9BBnisnkcsa7ILE9alXYIYhhRpOK6oqTJW5iIehQRjLG/7v5iVG/Ori9lflWJTHLrO0VvwxbBYM4
        VXEkVwSZOlsqgBv8em/B2/mCJBPqpy5foQ28445i0ge0zgUsqpt6kItLt8thiAb5gtuAh5JlKGeQP
        avpaTKeSw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:56106)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hWi66-0001AF-6m; Fri, 31 May 2019 15:01:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hWi64-0006Oj-3h; Fri, 31 May 2019 15:01:28 +0100
Date:   Fri, 31 May 2019 15:01:28 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 1/6] serial: sa1100: add support for mctrl gpios
Message-ID: <20190531140127.yp2o7effrsxencyb@shell.armlinux.org.uk>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
 <E1hWfTn-0003fP-Rl@rmk-PC.armlinux.org.uk>
 <20190531125013.3gkexhmbqjpdvrtf@pengutronix.de>
 <20190531132340.bco6xpyl3aatbryl@shell.armlinux.org.uk>
 <20190531135658.jo4kas3ozj7gpmmc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531135658.jo4kas3ozj7gpmmc@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 03:56:58PM +0200, Uwe Kleine-König wrote:
> On Fri, May 31, 2019 at 02:23:40PM +0100, Russell King - ARM Linux admin wrote:
> > On Fri, May 31, 2019 at 02:50:13PM +0200, Uwe Kleine-König wrote:
> > > On Fri, May 31, 2019 at 12:13:47PM +0100, Russell King wrote:
> > > > +static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
> > > > +{
> > > > +	sport->port.dev = &dev->dev;
> > > > +	sport->gpios = mctrl_gpio_init_noauto(sport->port.dev, 0);
> > > 
> > > the _noauto function was only introduced to ease a transition. I think
> > > the driver would benefit to use mctrl_gpio_init() instead.
> > 
> > In what way would the driver benefit?  mctrl_gpio_init() requires that
> > there are IRQs for each input GPIO.  This is not the case with most
> > SA11x0 platforms, where the GPIO controls are implemented using simple
> > latches, hence that interface is entirely unsuitable.
> 
> Ah, but then you can only use the outputs reliably here as an edge on
> (say) CTS stays unnoticed with both mctrl_gpio_init() and
> mctrl_gpio_init_noauto().

Right that is a risk with a polled approach, but that is the approach
that the SA1100 serial driver has taken ever since it was written
almost twenty years ago, and no one has raised any concerns about
that until now.

> Unless I miss something (which is quite possible given that it's quite
> some time ago I looked into mctrl_gpio) with mctrl_gpio_init_noauto()
> having a CTS-gpio is just ignored unless the modem ctrl lines are
> explicitely requestet while with mctrl_gpio_init() it results in an
> error. Isn't the error the better alternative?

Unless the serial driver polls the modem control line status, which
the SA1100 driver continues to do in exactly the same way after this
conversion.

Do you suggest that we just regress the driver by ripping out this
support that no one has had any problems with, and that is known to
work sufficiently in its day, just because we now don't like it?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
