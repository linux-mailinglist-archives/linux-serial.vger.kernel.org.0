Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 135C430393
	for <lists+linux-serial@lfdr.de>; Thu, 30 May 2019 22:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfE3UxR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 May 2019 16:53:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34761 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3UxR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 May 2019 16:53:17 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWS30-00030k-Nk; Thu, 30 May 2019 22:53:14 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWS2z-0007ou-RF; Thu, 30 May 2019 22:53:13 +0200
Date:   Thu, 30 May 2019 22:53:13 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/8] serial: imx: fix DTR inversion
Message-ID: <20190530205313.uwue3q2t5tp2vwz6@pengutronix.de>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-2-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190530152950.25377-2-sorganov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 30, 2019 at 06:29:43PM +0300, Sergey Organov wrote:
> imx_set_mctrl() had TIOCM_DTR meaning inverted
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index dff75dc..e9e812a 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -974,7 +974,7 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  	}
>  
>  	ucr3 = imx_uart_readl(sport, UCR3) & ~UCR3_DSR;
> -	if (!(mctrl & TIOCM_DTR))
> +	if (mctrl & TIOCM_DTR)
>  		ucr3 |= UCR3_DSR;
>  	imx_uart_writel(sport, ucr3, UCR3);

I'm not sure this is right and your commit log is too short to convince
me otherwise.

In the past I had several customers that used handshaking on an imx UART
so I'd be surprised if such a bug would have stayed unnoticed until now.

The i.MX25 Reference manual states:

	This bit [UCR3_DSR] used by software to control the DSR/DTR output pin
	for the modem interface. In DCE mode it applies to DSR and in DTE mode
	it applies to DTR.

		0 DSR/ DTR pin is logic zero
		1 DSR/ DTR pin is logic one


Semantically if TIOCM_DTR is set in .set_mctrl, the DTR output should
become active (i.e. low). Without testing I'm not sure if "active"
corresponds to "logic one" which would make your patch correct.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
