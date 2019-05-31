Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2067730EC7
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfEaNXv (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 09:23:51 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60254 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaNXv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 09:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R+/naJ1UQoGyodf+msmj2cXK4danC8BGGNx/taTC64M=; b=1tC05U25KWZMAO6FBiCQIF95t
        Bsj0t4VqFdqU8FGJLW8miG147uRy5mZPCJJz9irSWowrQjOdTGtUKux6rV9919Lk5hL2KHgynj7q1
        Gh3Qevfrfh0eTuti5hHamJstJfhMy7/8YH3e2h12I+tTCcHkkRJxztAxn/lFnTrcxNAvbbdYK18yo
        GFzDTanCozbM564kNbmcFr/lADcwMVSJhmS6MdJ2FvnJVXaGo8SlWL/AdiFVs6/Tf56ELPWWz9+OQ
        b1stbeefWRwqQhiM32TVLw0/X+WB5wMODYP0zRZZzWJDeo/EMGU3TiGL/FETaTgufhvccpRYwPA9q
        wOPFoVOSg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38402)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hWhVb-0000yu-0V; Fri, 31 May 2019 14:23:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hWhVU-0006NF-7L; Fri, 31 May 2019 14:23:40 +0100
Date:   Fri, 31 May 2019 14:23:40 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 1/6] serial: sa1100: add support for mctrl gpios
Message-ID: <20190531132340.bco6xpyl3aatbryl@shell.armlinux.org.uk>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
 <E1hWfTn-0003fP-Rl@rmk-PC.armlinux.org.uk>
 <20190531125013.3gkexhmbqjpdvrtf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531125013.3gkexhmbqjpdvrtf@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 02:50:13PM +0200, Uwe Kleine-König wrote:
> On Fri, May 31, 2019 at 12:13:47PM +0100, Russell King wrote:
> > Add support for the generic mctrl gpio helper.  This will allow us to
> > convert several board files to use the gpiod tables to assign GPIOs to
> > serial ports, rather than needing to have private function callbacks.
> > 
> > If the generic mctrl gpio helper fails, ignore the mctrl gpios rather
> > than preventing the (possibly console) serial port from being created.
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/tty/serial/Kconfig  |  1 +
> >  drivers/tty/serial/sa1100.c | 42 ++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 39 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 72966bc0ac76..f4372ac1a774 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -511,6 +511,7 @@ config SERIAL_SA1100
> >  	bool "SA1100 serial port support"
> >  	depends on ARCH_SA1100
> >  	select SERIAL_CORE
> > +	select SERIAL_MCTRL_GPIO if GPIOLIB
> >  	help
> >  	  If you have a machine based on a SA1100/SA1110 StrongARM(R) CPU you
> >  	  can enable its onboard serial port by enabling this option.
> > diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> > index a399772be3fc..97bdfeccbea9 100644
> > --- a/drivers/tty/serial/sa1100.c
> > +++ b/drivers/tty/serial/sa1100.c
> > @@ -28,6 +28,8 @@
> >  #include <mach/hardware.h>
> >  #include <mach/irqs.h>
> >  
> > +#include "serial_mctrl_gpio.h"
> > +
> >  /* We've been assigned a range on the "Low-density serial ports" major */
> >  #define SERIAL_SA1100_MAJOR	204
> >  #define MINOR_START		5
> > @@ -77,6 +79,7 @@ struct sa1100_port {
> >  	struct uart_port	port;
> >  	struct timer_list	timer;
> >  	unsigned int		old_status;
> > +	struct mctrl_gpios	*gpios;
> >  };
> >  
> >  /*
> > @@ -174,6 +177,8 @@ static void sa1100_enable_ms(struct uart_port *port)
> >  		container_of(port, struct sa1100_port, port);
> >  
> >  	mod_timer(&sport->timer, jiffies);
> > +
> > +	mctrl_gpio_enable_ms(sport->gpios);
> >  }
> >  
> >  static void
> > @@ -322,11 +327,21 @@ static unsigned int sa1100_tx_empty(struct uart_port *port)
> >  
> >  static unsigned int sa1100_get_mctrl(struct uart_port *port)
> >  {
> > -	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> > +	struct sa1100_port *sport =
> > +		container_of(port, struct sa1100_port, port);
> > +	int ret = TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> > +
> > +	mctrl_gpio_get(sport->gpios, &ret);
> > +
> > +	return ret;
> >  }
> >  
> >  static void sa1100_set_mctrl(struct uart_port *port, unsigned int mctrl)
> >  {
> > +	struct sa1100_port *sport =
> > +		container_of(port, struct sa1100_port, port);
> > +
> > +	mctrl_gpio_set(sport->gpios, mctrl);
> >  }
> >  
> >  /*
> > @@ -842,6 +857,27 @@ static int sa1100_serial_resume(struct platform_device *dev)
> >  	return 0;
> >  }
> >  
> > +static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
> > +{
> > +	sport->port.dev = &dev->dev;
> > +	sport->gpios = mctrl_gpio_init_noauto(sport->port.dev, 0);
> 
> the _noauto function was only introduced to ease a transition. I think
> the driver would benefit to use mctrl_gpio_init() instead.

In what way would the driver benefit?  mctrl_gpio_init() requires that
there are IRQs for each input GPIO.  This is not the case with most
SA11x0 platforms, where the GPIO controls are implemented using simple
latches, hence that interface is entirely unsuitable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
