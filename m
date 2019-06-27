Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266AB57B5D
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2019 07:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfF0F0z (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 27 Jun 2019 01:26:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54869 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfF0F0y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jun 2019 01:26:54 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hgMvt-0003hO-KO; Thu, 27 Jun 2019 07:26:53 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hgMvs-0001yt-UK; Thu, 27 Jun 2019 07:26:52 +0200
Date:   Thu, 27 Jun 2019 07:26:52 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 3/7] serial: imx: set_termios(): clarify RTS/CTS bits
 calculation
Message-ID: <20190627052652.ey7cmzkztylfy7k3@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
 <1561558293-7683-4-git-send-email-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561558293-7683-4-git-send-email-sorganov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 26, 2019 at 05:11:29PM +0300, Sergey Organov wrote:
> Avoid repeating the same code for rs485 twice.
> 
> Make it obvious we clear CRTSCTS bit in termios->c_cflag whenever
> sport->have_rtscts is false.
> 
> Make it obvious we clear UCR2_IRTS whenever CRTSCTS is set.
> 
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 87802fd..17e2322 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1567,35 +1567,25 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>  	if ((termios->c_cflag & CSIZE) == CS8)
>  		ucr2 |= UCR2_WS;
>  
> -	if (termios->c_cflag & CRTSCTS) {
> -		if (sport->have_rtscts) {
> -			ucr2 &= ~UCR2_IRTS;
> +	if (!sport->have_rtscts)
> +		termios->c_cflag &= ~CRTSCTS;
>  
> -			if (port->rs485.flags & SER_RS485_ENABLED) {
> -				/*
> -				 * RTS is mandatory for rs485 operation, so keep
> -				 * it under manual control and keep transmitter
> -				 * disabled.
> -				 */
> -				if (port->rs485.flags &
> -				    SER_RS485_RTS_AFTER_SEND)
> -					imx_uart_rts_active(sport, &ucr2);
> -				else
> -					imx_uart_rts_inactive(sport, &ucr2);
> -			} else {
> -				imx_uart_rts_auto(sport, &ucr2);
> -			}
> -		} else {
> -			termios->c_cflag &= ~CRTSCTS;
> -		}
> -	} else if (port->rs485.flags & SER_RS485_ENABLED) {
> -		/* disable transmitter */
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		/*
> +		 * RTS is mandatory for rs485 operation, so keep
> +		 * it under manual control and keep transmitter
> +		 * disabled.
> +		 */
>  		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
>  			imx_uart_rts_active(sport, &ucr2);
>  		else
>  			imx_uart_rts_inactive(sport, &ucr2);
> -	}
>  
> +	} else if (termios->c_cflag & CRTSCTS)
> +		imx_uart_rts_auto(sport, &ucr2);

Here a set of braces is needed even if the body has only a single line.

> +
> +	if (termios->c_cflag & CRTSCTS)
> +		ucr2 &= ~UCR2_IRTS;
>  
>  	if (termios->c_cflag & CSTOPB)
>  		ucr2 |= UCR2_STPB;

Is this patch intended to not change semantic? I wonder if it hides a
fix because if imx_uart_set_termios() was called with termios->c_cflag
& CRTSCTS and !sport->have_rtscts the rs485 block was not reached. Now
it is.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
