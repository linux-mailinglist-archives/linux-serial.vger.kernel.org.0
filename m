Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD0970A99
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 22:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfGVUYJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 16:24:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50671 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfGVUYJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 16:24:09 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hpeqt-0006Ge-S5; Mon, 22 Jul 2019 22:24:07 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hpeqs-0007Px-Ss; Mon, 22 Jul 2019 22:24:06 +0200
Date:   Mon, 22 Jul 2019 22:24:06 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v6 2/3] serial: imx: set_mctrl(): correctly restore
 autoRTS state
Message-ID: <20190722202406.hr74mg64sxoovah7@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563823331-5629-1-git-send-email-sorganov@gmail.com>
 <1563823331-5629-3-git-send-email-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1563823331-5629-3-git-send-email-sorganov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 22, 2019 at 10:22:10PM +0300, Sergey Organov wrote:
> imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
> was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
> turning handshake on only when CRTSCTS bit for the port is set.
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 32f36d8..059ba35 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -974,10 +974,22 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
>  		u32 ucr2;
>  
> +		/*
> +		 * Turn off autoRTS if RTS is lowered and restore autoRTS
> +		 * setting if RTS is raised.

"lower" and "raising" are misleading here. I recommend sticking to
"active" and "inactive".

> +		 */
>  		ucr2 = imx_uart_readl(sport, UCR2);
>  		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
> -		if (mctrl & TIOCM_RTS)
> -			ucr2 |= UCR2_CTS | UCR2_CTSC;
> +		if (mctrl & TIOCM_RTS) {
> +			ucr2 |= UCR2_CTS;
> +			/*
> +			 * UCR2_IRTS is unset if and only if the port is
> +			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
> +			 * to get the state to restore to.
> +			 */
> +			if (!(ucr2 & UCR2_IRTS))
> +				ucr2 |= UCR2_CTSC;
> +		}

If you teach imx_uart_rts_auto about IRTS this function could be reused
here I think.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
