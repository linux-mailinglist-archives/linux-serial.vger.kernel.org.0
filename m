Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB7810E106
	for <lists+linux-serial@lfdr.de>; Sun,  1 Dec 2019 09:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfLAIDS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 1 Dec 2019 03:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfLAIDS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 1 Dec 2019 03:03:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6CBC20833;
        Sun,  1 Dec 2019 08:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575187397;
        bh=MlPW5xsoKivfncXytvbaABH9+yPexHTq/zpUsDjycWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrWogk4TVGISA06finE1ARija1hJT117G2eJQrCg9j87YxQd4QN9nBc2lHMcUsoOx
         dCLCU3BY6jTywuraPIOz8xF/Pj6uTTg9/f1i0SM6UKgAAx75Acf/sWCVHB6HVJmfSl
         EY3nlhri269t2fNohwwRcaF/GU/kMQxG/awg7Wyw=
Date:   Sun, 1 Dec 2019 09:03:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hyunki Koo <kkoos00@naver.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kkoos00@gmail.com,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Hyunki Koo <hyunki00.koo@samsung.com>
Subject: Re: [PATCH] tty: serial: samsung: support driver modulization
Message-ID: <20191201080314.GA3716559@kroah.com>
References: <20191201075914.23512-1-kkoos00@naver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201075914.23512-1-kkoos00@naver.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Dec 01, 2019 at 04:59:14PM +0900, Hyunki Koo wrote:
> From: Shinbeom Choi <sbeom.choi@samsung.com>
> 
> This commit enables modulization of samsung uart driver.
> 
> There was no way to make use of this driver in other module,
> because uart functions were static.
> 
> By exporting required functions, user can use this driver
> in other module.
> 
> Signed-off-by: Shinbeom Choi <sbeom.choi@samsung.com>
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
>  drivers/tty/serial/samsung.h     | 32 ++++++++++++
>  drivers/tty/serial/samsung_tty.c | 85 +++++++++++++++-----------------
>  2 files changed, 73 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
> index f93022113f59..25be0962284d 100644
> --- a/drivers/tty/serial/samsung.h
> +++ b/drivers/tty/serial/samsung.h
> @@ -144,4 +144,36 @@ static inline void s3c24xx_clear_bit(struct uart_port *port, int idx,
>  	local_irq_restore(flags);
>  }
>  
> +#if defined(CONFIG_ARCH_EXYNOS)
> +#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
> +	.info = &(struct s3c24xx_uart_info) {			\
> +		.name		= "Samsung Exynos UART",	\
> +		.type		= PORT_S3C6400,			\
> +		.has_divslot	= 1,				\
> +		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
> +		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
> +		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,	\
> +		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,	\
> +		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,	\
> +		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,	\
> +		.def_clk_sel	= S3C2410_UCON_CLKSEL0,		\
> +		.num_clks	= 1,				\
> +		.clksel_mask	= 0,				\
> +		.clksel_shift	= 0,				\
> +	},							\
> +	.def_cfg = &(struct s3c2410_uartcfg) {			\
> +		.ucon		= S5PV210_UCON_DEFAULT,		\
> +		.ufcon		= S5PV210_UFCON_DEFAULT,	\
> +		.has_fracval	= 1,				\
> +	}							\
> +
> +#endif
> +
> +int s3c24xx_serial_get_ports(struct s3c24xx_uart_port **ourport, int index);
> +int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> +				    struct platform_device *platdev);
> +int s3c24xx_serial_unregister_port(struct platform_device *dev);
> +int s3c24xx_serial_suspend(struct device *dev);
> +int s3c24xx_serial_resume(struct device *dev);
> +int s3c24xx_serial_resume_noirq(struct device *dev);
>  #endif
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 83fd51607741..15414ecd9008 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1735,7 +1735,7 @@ static int s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
>   * initialise a single serial port from the platform device given
>   */
>  
> -static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> +int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
>  				    struct platform_device *platdev)
>  {
>  	struct uart_port *port = &ourport->port;
> @@ -1842,12 +1842,24 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
>  	/* reset the fifos (and setup the uart) */
>  	s3c24xx_serial_resetport(port, cfg);
>  
> +	if (!s3c24xx_uart_drv.state) {
> +		ret = uart_register_driver(&s3c24xx_uart_drv);
> +		if (ret < 0) {
> +			dev_err(port->dev, "Failed to register Samsung UART driver\n");
> +			return ret;
> +		}
> +	}
> +
> +	dbg("%s: adding port\n", __func__);
> +	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> +
>  	return 0;
>  
>  err:
>  	port->mapbase = 0;
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(s3c24xx_serial_init_port);

Why are you exporting all of these functions?  What other code uses
them?  Why are you converting them all to global functions I don't see
any other in-kernel callers, so why are those changes needed here?

totally confused,

greg k-h
