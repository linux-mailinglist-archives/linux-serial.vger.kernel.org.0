Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D814D45DAD
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 15:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfFNNOa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Fri, 14 Jun 2019 09:14:30 -0400
Received: from mailout02.agenturserver.de ([185.15.192.33]:49994 "EHLO
        mailout02.agenturserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbfFNNOa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 09:14:30 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jun 2019 09:14:28 EDT
Received: from mail02.agenturserver.de (mail02.internal [172.16.51.35])
        by mailout02.agenturserver.de (Postfix) with ESMTP id 7B9BD12695E;
        Fri, 14 Jun 2019 15:05:53 +0200 (CEST)
Received: from localhost (ac02.internal [172.16.51.82])
        by mail02.agenturserver.de (Postfix) with ESMTP id 6FA0580418;
        Fri, 14 Jun 2019 15:05:53 +0200 (CEST)
X-Spam-Level: 
Received: from mail.agenturserver.de ([172.16.51.35])
        by localhost (ac02.mittwald.de [172.16.51.82]) (amavisd-new, port 10026)
        with ESMTP id 37aakGEqMV_7; Fri, 14 Jun 2019 15:05:53 +0200 (CEST)
Received: from karo-electronics.de (unknown [89.1.81.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lw@karo-electronics.de)
        by mail.agenturserver.de (Postfix) with ESMTPSA;
        Fri, 14 Jun 2019 15:05:52 +0200 (CEST)
Date:   Fri, 14 Jun 2019 15:05:51 +0200
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RFC 5/7] serial: imx: set_termios(): preserve RTS state
Message-ID: <20190614150551.1472b154@karo-electronics.de>
In-Reply-To: <1560514294-29111-6-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
        <1560514294-29111-1-git-send-email-sorganov@gmail.com>
        <1560514294-29111-6-git-send-email-sorganov@gmail.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Fri, 14 Jun 2019 15:11:32 +0300 Sergey Organov wrote:
> imx_set_termios() cleared RTS on every call, now fixed.
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8ee910f..de23068 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1564,6 +1564,13 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>  	spin_lock_irqsave(&sport->port.lock, flags);
>  
> +	/*
> +	 * Read current UCR2 and save it for future use, then clear all the bits
> +	 * except those we will or may need to preserve.
> +	 */
> +	old_ucr2 = imx_uart_readl(sport, UCR2);
> +	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTSC);
> +
>  	ucr2 = UCR2_SRST | UCR2_IRTS;
s/=/|=/


Lothar Waßmann
