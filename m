Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABFE3115B
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfEaPbk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 11:31:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35081 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfEaPbj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 11:31:39 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWjVJ-0000o1-9k; Fri, 31 May 2019 17:31:37 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWjVI-0004Dn-0H; Fri, 31 May 2019 17:31:36 +0200
Date:   Fri, 31 May 2019 17:31:35 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] serial: sa1100: add note about modem control signals
Message-ID: <20190531153135.sboekptwx4jxlpeg@pengutronix.de>
References: <20190531151032.tfrl7yqph6wsg5pl@pengutronix.de>
 <E1hWjO0-00087g-7y@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1hWjO0-00087g-7y@rmk-PC.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Russell,

On Fri, May 31, 2019 at 04:24:04PM +0100, Russell King wrote:
> As suggested by Uwe, add a note indicating that the modem control
> signals do not support interrupts, which precludes the driver from
> using mctrl_gpio_init().
> 
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> 
> Uwe, something like this?
> 
>  drivers/tty/serial/sa1100.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> index a6b4309b62fc..d7dbf0576be8 100644
> --- a/drivers/tty/serial/sa1100.c
> +++ b/drivers/tty/serial/sa1100.c
> @@ -949,6 +949,9 @@ static int sa1100_serial_resume(struct platform_device *dev)
>  static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
>  {
>  	sport->port.dev = &dev->dev;
> +
> +	// GPIO driver does not support interrupts for these modem
> +	// control signals, so the serial driver polls them.
>  	sport->gpios = mctrl_gpio_init_noauto(sport->port.dev, 0);
>  	if (IS_ERR(sport->gpios)) {
>  		int err = PTR_ERR(sport->gpios);

I would mention that because of this mctrl_gpio_init cannot be used.
(And I would have expected C-like comments).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
