Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7211A30E5D
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 14:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEaMuU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 08:50:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57589 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEaMuU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 08:50:20 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWgz9-00020A-Fo; Fri, 31 May 2019 14:50:15 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWgz7-00078v-KN; Fri, 31 May 2019 14:50:13 +0200
Date:   Fri, 31 May 2019 14:50:13 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 1/6] serial: sa1100: add support for mctrl gpios
Message-ID: <20190531125013.3gkexhmbqjpdvrtf@pengutronix.de>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
 <E1hWfTn-0003fP-Rl@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1hWfTn-0003fP-Rl@rmk-PC.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 12:13:47PM +0100, Russell King wrote:
> Add support for the generic mctrl gpio helper.  This will allow us to
> convert several board files to use the gpiod tables to assign GPIOs to
> serial ports, rather than needing to have private function callbacks.
> 
> If the generic mctrl gpio helper fails, ignore the mctrl gpios rather
> than preventing the (possibly console) serial port from being created.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/tty/serial/Kconfig  |  1 +
>  drivers/tty/serial/sa1100.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 72966bc0ac76..f4372ac1a774 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -511,6 +511,7 @@ config SERIAL_SA1100
>  	bool "SA1100 serial port support"
>  	depends on ARCH_SA1100
>  	select SERIAL_CORE
> +	select SERIAL_MCTRL_GPIO if GPIOLIB
>  	help
>  	  If you have a machine based on a SA1100/SA1110 StrongARM(R) CPU you
>  	  can enable its onboard serial port by enabling this option.
> diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> index a399772be3fc..97bdfeccbea9 100644
> --- a/drivers/tty/serial/sa1100.c
> +++ b/drivers/tty/serial/sa1100.c
> @@ -28,6 +28,8 @@
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
>  
> +#include "serial_mctrl_gpio.h"
> +
>  /* We've been assigned a range on the "Low-density serial ports" major */
>  #define SERIAL_SA1100_MAJOR	204
>  #define MINOR_START		5
> @@ -77,6 +79,7 @@ struct sa1100_port {
>  	struct uart_port	port;
>  	struct timer_list	timer;
>  	unsigned int		old_status;
> +	struct mctrl_gpios	*gpios;
>  };
>  
>  /*
> @@ -174,6 +177,8 @@ static void sa1100_enable_ms(struct uart_port *port)
>  		container_of(port, struct sa1100_port, port);
>  
>  	mod_timer(&sport->timer, jiffies);
> +
> +	mctrl_gpio_enable_ms(sport->gpios);
>  }
>  
>  static void
> @@ -322,11 +327,21 @@ static unsigned int sa1100_tx_empty(struct uart_port *port)
>  
>  static unsigned int sa1100_get_mctrl(struct uart_port *port)
>  {
> -	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> +	struct sa1100_port *sport =
> +		container_of(port, struct sa1100_port, port);
> +	int ret = TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> +
> +	mctrl_gpio_get(sport->gpios, &ret);
> +
> +	return ret;
>  }
>  
>  static void sa1100_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
> +	struct sa1100_port *sport =
> +		container_of(port, struct sa1100_port, port);
> +
> +	mctrl_gpio_set(sport->gpios, mctrl);
>  }
>  
>  /*
> @@ -842,6 +857,27 @@ static int sa1100_serial_resume(struct platform_device *dev)
>  	return 0;
>  }
>  
> +static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
> +{
> +	sport->port.dev = &dev->dev;
> +	sport->gpios = mctrl_gpio_init_noauto(sport->port.dev, 0);

the _noauto function was only introduced to ease a transition. I think
the driver would benefit to use mctrl_gpio_init() instead.

Getting rid of mctrl_gpio_init_noauto() was on my todo list for some
time, but it was pushed down too far :-|

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
