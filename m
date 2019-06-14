Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C8456B5
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbfFNHsW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 03:48:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40897 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFNHsW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 03:48:22 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hbgwe-00041Y-Hd; Fri, 14 Jun 2019 09:48:20 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hbgwc-0006jw-0h; Fri, 14 Jun 2019 09:48:18 +0200
Date:   Fri, 14 Jun 2019 09:48:17 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] serial: imx: fix RTS/CTS setting
Message-ID: <20190614074817.vmvhvbms32i6jfqo@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614072801.3187-1-s.hauer@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[expanded Cc: a bit]

Hello Sascha,

On Fri, Jun 14, 2019 at 09:28:01AM +0200, Sascha Hauer wrote:
> The correct setting of the RTS pin depends on the CRTSCTS termios setting:
> 
> - When CRTSCTS is disabled then RTS shall be controlled by the TIOCM_RTS
>   flag.
> - When CRTSCTS is enabled the expected behaviour of the RTS pin is:
>   - When TIOCM_RTS is set then let the receiver control RTS.
>   - When the TIOCM_RTS flag is cleared then RTS shall be deasserted (to let
>     the upper layers throttle the transfer even when the FIFO in the UART has
>     enough space).
> 
> This patch fixes this behaviour. Previously the RTS pin has always been
> controlled by the receiver once the TIOCM_RTS flag was set and the CRTSCTS
> setting hasn't been taken into account.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/tty/serial/imx.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8b752e895053..0eddca6455ad 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -216,6 +216,7 @@ struct imx_port {
>  	unsigned int		dma_is_enabled:1;
>  	unsigned int		dma_is_rxing:1;
>  	unsigned int		dma_is_txing:1;
> +	unsigned int		crtscts:1;
>  	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
>  	struct scatterlist	rx_sgl, tx_sgl[2];
>  	void			*rx_buf;
> @@ -967,9 +968,18 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  		u32 ucr2;
>  
>  		ucr2 = imx_uart_readl(sport, UCR2);
> +
>  		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
> -		if (mctrl & TIOCM_RTS)
> -			ucr2 |= UCR2_CTS | UCR2_CTSC;
> +
> +		if (mctrl & TIOCM_RTS) {
> +			if (sport->crtscts)
> +				/* let the receiver control RTS */
> +				ucr2 |= UCR2_CTSC;
> +			else
> +				/* Force RTS active */
> +				ucr2 |= UCR2_CTS;
> +		}
> +

Other drivers check for

	port->status & UPSTAT_AUTORTS

instead of CRTSCTS. I didn't manage to grasp all the details from the
quick look I took, but maybe you should better do the same?

>  		imx_uart_writel(sport, ucr2, UCR2);
>  	}
>  
> @@ -1554,6 +1564,11 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>  	else
>  		ucr2 = UCR2_SRST | UCR2_IRTS;
>  
> +	if (termios->c_cflag & CRTSCTS)
> +		sport->crtscts = true;
> +	else
> +		sport->crtscts = false;
> +
>  	if (termios->c_cflag & CRTSCTS) {

I'd put setting sport->crtscts in the following if block, maybe even in
the if (sport->have_rtscts) part that starts below here?

>  		if (sport->have_rtscts) {
>  			ucr2 &= ~UCR2_IRTS;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
