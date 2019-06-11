Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56623C4B5
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391359AbfFKHK1 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 03:10:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33575 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391301AbfFKHK0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 03:10:26 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1haavJ-0003qo-CW; Tue, 11 Jun 2019 09:10:25 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1haavI-0003GJ-FG; Tue, 11 Jun 2019 09:10:24 +0200
Date:   Tue, 11 Jun 2019 09:10:24 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH RFC] serial: imx: fix locking in set_termios()
Message-ID: <20190611071024.xpnxrx7sdys43hnf@pengutronix.de>
References: <1559807977-4598-1-git-send-email-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1559807977-4598-1-git-send-email-sorganov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 06, 2019 at 10:59:37AM +0300, Sergey Organov wrote:
> imx_uart_set_termios() called imx_uart_rts_active(), or
> imx_uart_rts_inactive() before taking port->port.lock.
> 
> As a consequence, sport->port.mctrl that these functions modify
> could have been changed without holding port->port.lock.
> 
> Moved locking of port->port.lock above the calls to fix the issue.

I'm convinced. The issue looks real.

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index dff75dc..cb95ff71 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1550,6 +1550,20 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>  		old_csize = CS8;
>  	}
>  
> +	del_timer_sync(&sport->timer);
> +
> +	/*
> +	 * Ask the core to calculate the divisor for us.
> +	 */
> +	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
> +	quot = uart_get_divisor(port, baud);
> +
> +	/*
> +	 * Take port lock before imx_uart_rts_*() calls, as they change
> +	 * sport->port.mctrl
> +	 */
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +

You can move this block a bit down (and so grab the lock later). The
check for CSIZE doesn't need protection.

Assuming you respin: Several functions are annotated to have to be
called with the lock taken; I would put the comment to imx_uart_rts_* in
the same way, instead of in imx_uart_set_termios.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
