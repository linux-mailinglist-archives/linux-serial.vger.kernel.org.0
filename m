Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF76231698
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 23:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEaV1G (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 17:27:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46905 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfEaV1G (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 17:27:06 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWp3I-0001Yq-TQ; Fri, 31 May 2019 23:27:04 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWp3G-0006ye-EM; Fri, 31 May 2019 23:27:02 +0200
Date:   Fri, 31 May 2019 23:27:02 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v2] serial: sa1100: add note about modem control signals
Message-ID: <20190531212702.cmqbaqwdybgkb3ug@pengutronix.de>
References: <20190531155700.crrawgf3iot2sm2t@shell.armlinux.org.uk>
 <E1hWjyQ-0008Ni-8V@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1hWjyQ-0008Ni-8V@rmk-PC.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Russell,

On Fri, May 31, 2019 at 05:01:42PM +0100, Russell King wrote:
> As suggested by Uwe, add a note indicating that the modem control
> signals do not support interrupts, which precludes the driver from
> using mctrl_gpio_init().
> 
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/tty/serial/sa1100.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> index 97bdfeccbea9..8e618129e65c 100644
> --- a/drivers/tty/serial/sa1100.c
> +++ b/drivers/tty/serial/sa1100.c
> @@ -860,6 +860,10 @@ static int sa1100_serial_resume(struct platform_device *dev)
>  static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
>  {
>  	sport->port.dev = &dev->dev;
> +
> +	// mctrl_gpio_init() requires that the GPIO driver supports interrupts,
> +	// but we need to support GPIO drivers for hardware that has no such
> +	// interrupts.  Use mctrl_gpio_init_noauto() instead.

I hope it's not an impostor who claimed to be Linus to spread deviance
from K&R :-)

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

If you want to, squash this in the commit that introduced
mctrl_gpio_init_noauto while keeping my Ack on the resulting patch.

Best regards
Uwe

>  	sport->gpios = mctrl_gpio_init_noauto(sport->port.dev, 0);
>  	if (IS_ERR(sport->gpios)) {
>  		int err = PTR_ERR(sport->gpios);
> -- 
> 2.7.4
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
