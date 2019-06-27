Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 968A057BB7
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2019 08:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfF0GIj (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 27 Jun 2019 02:08:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52329 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0GIj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jun 2019 02:08:39 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hgNaI-0008C4-FZ; Thu, 27 Jun 2019 08:08:38 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hgNaI-0003bZ-35; Thu, 27 Jun 2019 08:08:38 +0200
Date:   Thu, 27 Jun 2019 08:08:38 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 7/7] serial: imx: get rid of imx_uart_rts_auto()
Message-ID: <20190627060838.ls5ghzngkoiczqex@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
 <1561558293-7683-8-git-send-email-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561558293-7683-8-git-send-email-sorganov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 26, 2019 at 05:11:33PM +0300, Sergey Organov wrote:
> Called in only one place, for RS232, it only obscures things, as it
> doesn't go well with 2 similar named functions,
> imx_uart_rts_inactive() and imx_uart_rts_active(), that both are
> RS485-specific.
> 
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 171347d..a5e80a0 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -402,13 +402,6 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
>  	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
>  }
>  
> -/* called with port.lock taken and irqs caller dependent */
> -static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
> -{
> -	if (*ucr2 & UCR2_CTS)
> -		*ucr2 |= UCR2_CTSC;
> -}
> -
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_start_rx(struct uart_port *port)
>  {
> @@ -1598,8 +1591,10 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>  		else
>  			imx_uart_rts_inactive(sport, &ucr2);
>  
> -	} else if (termios->c_cflag & CRTSCTS)
> -		imx_uart_rts_auto(sport, &ucr2);
> +	} else if (termios->c_cflag & CRTSCTS) {
> +		if (ucr2 & UCR2_CTS)
> +			ucr2 |= UCR2_CTSC;
> +	}

At least before it was (somewhat) clear that this is about RTS and it
is about something automatic. So I don't like the patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
