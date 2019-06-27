Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF7157BD0
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2019 08:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfF0GQK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 27 Jun 2019 02:16:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56861 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0GQK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jun 2019 02:16:10 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hgNhY-0000Yp-N8; Thu, 27 Jun 2019 08:16:08 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hgNhX-0003qa-Jk; Thu, 27 Jun 2019 08:16:07 +0200
Date:   Thu, 27 Jun 2019 08:16:07 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 1/2] serial: imx: remove duplicate handling of CTS change
Message-ID: <20190627061607.4ehhr6jj6vkfjorl@pengutronix.de>
References: <20190626101557.26299-1-s.hauer@pengutronix.de>
 <20190626101557.26299-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626101557.26299-2-s.hauer@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 26, 2019 at 12:15:56PM +0200, Sascha Hauer wrote:
> We have an interrupt for the CTS input (RTS in FSL speech). Its handler
> calls uart_handle_cts_change(), so we shouldn't do this in
> imx_uart_mctrl_check() again.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/tty/serial/imx.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index a5e80a028e83..0419a084c0ed 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -805,12 +805,8 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport);
>  static unsigned int imx_uart_get_hwmctrl(struct imx_port *sport)
>  {
>  	unsigned int tmp = TIOCM_DSR;
> -	unsigned usr1 = imx_uart_readl(sport, USR1);
>  	unsigned usr2 = imx_uart_readl(sport, USR2);
>  
> -	if (usr1 & USR1_RTSS)
> -		tmp |= TIOCM_CTS;
> -
>  	/* in DCE mode DCDIN is always 0 */
>  	if (!(usr2 & USR2_DCDIN))
>  		tmp |= TIOCM_CAR;

Is this hunk supposed to be included in this patch? I think it's wrong.

> @@ -843,8 +839,6 @@ static void imx_uart_mctrl_check(struct imx_port *sport)
>  		sport->port.icount.dsr++;
>  	if (changed & TIOCM_CAR)
>  		uart_handle_dcd_change(&sport->port, status & TIOCM_CAR);
> -	if (changed & TIOCM_CTS)
> -		uart_handle_cts_change(&sport->port, status & TIOCM_CTS);

This doesn't hurt, does it? Also imx_uart_mctrl_check is called from
imx_uart_timeout which is supposed to catch missed interrupts and in
this case uart_handle_cts_change() must be called.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
