Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA457BB5
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2019 08:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfF0GFm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 27 Jun 2019 02:05:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55521 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0GFm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jun 2019 02:05:42 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hgNXQ-0007w2-7l; Thu, 27 Jun 2019 08:05:40 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hgNXN-0003af-LM; Thu, 27 Jun 2019 08:05:37 +0200
Date:   Thu, 27 Jun 2019 08:05:37 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 6/7] serial: imx: set_mctrl(): correctly restore
 autoRTS state
Message-ID: <20190627060537.brmgsmoh3usr4vo6@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
 <1561558293-7683-7-git-send-email-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561558293-7683-7-git-send-email-sorganov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 26, 2019 at 05:11:32PM +0300, Sergey Organov wrote:
> imx_uart_set_mctrl() happened to set UCR2_CTSC bit whenever TIOCM_RTS
> was set, no matter if RTS/CTS handshake is enabled or not. Now fixed by
> turning handshake on only when CRTSCTS bit for the port is set.
> 
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 4867f80..171347d 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -970,10 +970,19 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
>  		u32 ucr2;
>  
> +		/*
> +		 * Turn off autoRTS (UCR2_CTSC) if RTS is lowered and restore
> +		 * autoRTS setting if RTS is raised. Inverted UCR2_IRTS is set
> +		 * if and only if CRTSCTS bit is set for the port, so we use it
> +		 * to get the state to restore to.
> +		 */

The comment is quite complicated. I like the comments of Sascha's patch
that addressed the same issue better.

Are you using UCR2_IRTS as an indicator if CRTSCTS is set? If it's that
what you intend to express in the second sentence that is hard to grasp.
Something like:

	UCR2_IRTS is unset iff the port is configured for CRTSCTS

Also as the value of the CTS bit doesn't matter if CTSC is set, the
order of the checks could be swapped to result in easier code (IMHO at
least) that doesn't need a nested if.

Something like:

	ucr2 = imx_uart_readl(sport, UCR2);
	ucr2 &= ~(UCR2_CTS | UCR2_CTSC);

	/* UCR2_IRTS is unset iff the port is configured for CRTSCTS */
	crtscts = !(ucr2 & UCR2_IRTS);

	if (!(mctrl & TIOCM_RTS)) {
		/* Force RTS inactive, i.e. UCR2_CTS=0 and UCR2_CTSC=0 */
	} else if (crtscts) {
		/* let the receiver control RTS */
		ucr2 |= UCR2_CTSC;
	} else {
		/* Force RTS active */
		ucr2 |= UCR2_CTS;
	}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
