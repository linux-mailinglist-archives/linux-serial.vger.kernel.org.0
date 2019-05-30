Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 044F630361
	for <lists+linux-serial@lfdr.de>; Thu, 30 May 2019 22:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfE3Ujg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 May 2019 16:39:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42471 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Ujg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 May 2019 16:39:36 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWRpl-0001fO-K6; Thu, 30 May 2019 22:39:33 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWRpj-0007So-5Q; Thu, 30 May 2019 22:39:31 +0200
Date:   Thu, 30 May 2019 22:39:31 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 2/8] serial: imx: fix breaking RTS/CTS handshake by mctrl
 change
Message-ID: <20190530203931.n6b22ktbzuyg67sd@pengutronix.de>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-3-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190530152950.25377-3-sorganov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On Thu, May 30, 2019 at 06:29:44PM +0300, Sergey Organov wrote:
> imx_set_mctrl() stop fiddling with UCR2_CTSC bit
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index e9e812a..6577552 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -967,9 +967,9 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  		u32 ucr2;
>  
>  		ucr2 = imx_uart_readl(sport, UCR2);
> -		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
> +		ucr2 &= ~UCR2_CTS;
>  		if (mctrl & TIOCM_RTS)
> -			ucr2 |= UCR2_CTS | UCR2_CTSC;
> +			ucr2 |= UCR2_CTS;
>  		imx_uart_writel(sport, ucr2, UCR2);
>  	}

I'm sure this patch is wrong. And your change log fails to point out
what you want to achieve.

Independant of your patch I discussed a problem in imx_uart_set_mctrl()
with Sascha and Russell (both added to Cc:) earlier this week. In the
current implementation there are actually two problems.

Currently imx_uart_set_mctrl does:

	if TIOCM_RTS is set:
		let the receiver control the RTS signal
	else:
		set RTS inactive

The bigger problem is that if the UART is configured not to use
handshaking (CRTSCTS unset) the mode "let the receiver control the RTS
signal" should not be used.

The smaller (and irrelevant for correctness) problem is that setting
UCR2_CTS is a no-op when UCR2_CTSC is also set.

We think the right thing to do is:

	ucr2 = imx_uart_readl(sport, UCR2);
	ucr2 &= ~(UCR2_CTS | UCR2_CTSC);

	if (mctrl & TIOCM_RTS) {
		if (sport->crtscts)
			/* let the receiver control RTS */
			ucr2 |= UCR2_CTSC;
		else
			/* Force RTS active */
			ucr2 |= UCR2_CTS;
	} else {
		/* Force RTS inactive, i.e. CTS=0, CTSC=0 */
	}

	imx_uart_writel(sport, ucr2, UCR2);

but AFAICT this isn't tested yet to an end in the use case that Sascha
currently has and so there isn't a complete patch available yet.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
