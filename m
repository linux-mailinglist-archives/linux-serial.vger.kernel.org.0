Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36957303D1
	for <lists+linux-serial@lfdr.de>; Thu, 30 May 2019 23:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfE3VI1 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 May 2019 17:08:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54971 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3VI1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 May 2019 17:08:27 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWSHh-0004ZT-J0; Thu, 30 May 2019 23:08:25 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWSHg-0000BA-Vz; Thu, 30 May 2019 23:08:24 +0200
Date:   Thu, 30 May 2019 23:08:24 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 3/8] serial: imx: preserve RTS state over termios change
Message-ID: <20190530210824.rf2aaxumcc3cnc5c@pengutronix.de>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-4-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190530152950.25377-4-sorganov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 30, 2019 at 06:29:45PM +0300, Sergey Organov wrote:
> imx_set_mctrl() cleared RTS on every call


> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 6577552..13face9 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1648,7 +1648,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>  	/* then, disable everything */
>  	imx_uart_writel(sport, old_ucr2 & ~(UCR2_TXEN | UCR2_RXEN | UCR2_ATEN), UCR2);
> -	old_ucr2 &= (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN);
>  
>  	/* custom-baudrate handling */
>  	div = sport->port.uartclk / (baud * 16);
> @@ -1686,7 +1685,8 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>  	imx_uart_writel(sport, old_ucr1, UCR1);
>  
> -	/* set the parity, stop bits and data size */
> +	/* Set parity, stop bits, data size, etc. Keep bits we don't compute. */
> +	old_ucr2 &= (UCR2_CTS | UCR2_TXEN | UCR2_RXEN | UCR2_ATEN);

I wonder if that fixes a certain usecase and breaks another.

If I change the baud rate of the UART the sequence I actually want to
have is:

	clear RTS (to not encourage the other side to send data)
	disable receiver
	reconfigure requested settings
	reenable receiver
	(maybe) reactivate RTS to signal being ready again

So I think your approach is too simple.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
