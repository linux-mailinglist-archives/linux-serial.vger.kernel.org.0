Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAEDD30F63
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEaN5C (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 09:57:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50943 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEaN5B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 09:57:01 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWi1j-00089c-6Y; Fri, 31 May 2019 15:56:59 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWi1i-0000pa-6S; Fri, 31 May 2019 15:56:58 +0200
Date:   Fri, 31 May 2019 15:56:58 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 1/6] serial: sa1100: add support for mctrl gpios
Message-ID: <20190531135658.jo4kas3ozj7gpmmc@pengutronix.de>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
 <E1hWfTn-0003fP-Rl@rmk-PC.armlinux.org.uk>
 <20190531125013.3gkexhmbqjpdvrtf@pengutronix.de>
 <20190531132340.bco6xpyl3aatbryl@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531132340.bco6xpyl3aatbryl@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 02:23:40PM +0100, Russell King - ARM Linux admin wrote:
> On Fri, May 31, 2019 at 02:50:13PM +0200, Uwe Kleine-König wrote:
> > On Fri, May 31, 2019 at 12:13:47PM +0100, Russell King wrote:
> > > +static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
> > > +{
> > > +	sport->port.dev = &dev->dev;
> > > +	sport->gpios = mctrl_gpio_init_noauto(sport->port.dev, 0);
> > 
> > the _noauto function was only introduced to ease a transition. I think
> > the driver would benefit to use mctrl_gpio_init() instead.
> 
> In what way would the driver benefit?  mctrl_gpio_init() requires that
> there are IRQs for each input GPIO.  This is not the case with most
> SA11x0 platforms, where the GPIO controls are implemented using simple
> latches, hence that interface is entirely unsuitable.

Ah, but then you can only use the outputs reliably here as an edge on
(say) CTS stays unnoticed with both mctrl_gpio_init() and
mctrl_gpio_init_noauto().

Unless I miss something (which is quite possible given that it's quite
some time ago I looked into mctrl_gpio) with mctrl_gpio_init_noauto()
having a CTS-gpio is just ignored unless the modem ctrl lines are
explicitely requestet while with mctrl_gpio_init() it results in an
error. Isn't the error the better alternative?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
