Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910304CB0E
	for <lists+linux-serial@lfdr.de>; Thu, 20 Jun 2019 11:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfFTJhq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Jun 2019 05:37:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54007 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfFTJhp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jun 2019 05:37:45 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hdtVm-0000y0-PQ; Thu, 20 Jun 2019 11:37:42 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hdtVl-0006tP-6J; Thu, 20 Jun 2019 11:37:41 +0200
Date:   Thu, 20 Jun 2019 11:37:41 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RFC 4/7] serial: imx: set_termios(): do not enable
 autoRTS if RTS is unset
Message-ID: <20190620093741.7wom6a475be2byob@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1560514294-29111-1-git-send-email-sorganov@gmail.com>
 <1560514294-29111-5-git-send-email-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560514294-29111-5-git-send-email-sorganov@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:26:57 up 33 days, 15:45, 91 users,  load average: 0.07, 0.10,
 0.12
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sergey,

On Fri, Jun 14, 2019 at 03:11:31PM +0300, Sergey Organov wrote:
> set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS (=TIOCM_RTS) is
> cleared. Added corresponding check in imx_uart_rts_auto() to fix this.
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 17e2322..8ee910f 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
>  /* called with port.lock taken and irqs caller dependent */
>  static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
>  {
> -	*ucr2 |= UCR2_CTSC;
> +	if (*ucr2 & UCR2_CTS)
> +		*ucr2 |= UCR2_CTSC;
>  }

*ucr2 is set like this in imx_uart_set_termios():

	ucr2 = UCR2_SRST | UCR2_IRTS;
	if ((termios->c_cflag & CSIZE) == CS8)
		ucr2 |= UCR2_WS;
	...
	imx_uart_rts_auto(sport, &ucr2);

So the UCR2_CTS bit is never set, hence UCR2_CTSC will never be set.
You meant to pass in the actual register value of the UCR2 register.

This is shifted around a bit in the following patches, as an end result
we have:

	old_ucr2 = imx_uart_readl(sport, UCR2);
	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTSC);
	...
	if (ucr2 & UCR2_CTS)
		ucr2 |= UCR2_CTSC;

Again the test can never be true, it should probably be if (old_ucr2 &
UCR2_CTS).

With this issue and the one Lothar has found fixed this series works for
me.

With these issues fixed I'd be happy to test this series and apply it in
favour of my patch.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
