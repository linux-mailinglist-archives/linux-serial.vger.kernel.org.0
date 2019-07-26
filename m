Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA02764F6
	for <lists+linux-serial@lfdr.de>; Fri, 26 Jul 2019 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfGZL6i (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 26 Jul 2019 07:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfGZL6i (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jul 2019 07:58:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D278D218DA;
        Fri, 26 Jul 2019 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564142317;
        bh=fVn4+kswuU6S8WBTywNSNm5DjkloXeamWKxd5Wvh4S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4+wAWzBDNWtzYtPcPXx8zZUyckB70TkfacEXGhL++X9MaHmYJDpNGVdHzqJXIL9j
         GaTbvqc9O8bONAyUIgkc+Ciqpzzk5kTz9aKZmwScULFTPQqQiU/LJLSm98CGu4wAvv
         O+3xdtTZVrcW68tHAdkiorfCsUwwQD+NHanl5MP4=
Date:   Fri, 26 Jul 2019 13:58:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Morris Ku <saumah@gmail.com>
Cc:     linux-serial@vger.kernel.org, morris_ku@sunix.com,
        kai.heng.feng@canonical.com, tiffany.wang@canonical.com,
        kent.lin@canonical.com, debbie_liu@sunix.com
Subject: Re: [PATCH] Add driver for SUNIX serial board
Message-ID: <20190726115834.GB18727@kroah.com>
References: <20190726103242.6233-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726103242.6233-1-saumah@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 26, 2019 at 06:32:42PM +0800, Morris Ku wrote:
> This patch add support for SUNIX serial board.

Again, I asked for a lot of documentation as to why this can not be a
small patch to the 8250 pci code and why it needs to be a separate
driver.

Please provide that.

Also please properly version your patches, saying what changed from
previous ones.  THe kernel documentation says how to do this correctly.

> 
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  serial/Kconfig      |  11 ++
>  serial/Makefile     |   2 +-
>  serial/sunix_uart.c | 357 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 369 insertions(+), 1 deletion(-)
>  create mode 100644 serial/sunix_uart.c
> 
> diff --git a/serial/Kconfig b/serial/Kconfig
> index 0d31251..f9ae108 100644
> --- a/serial/Kconfig
> +++ b/serial/Kconfig
> @@ -1618,6 +1618,17 @@ config SERIAL_MILBEAUT_USIO_PORTS
>  	depends on SERIAL_MILBEAUT_USIO
>  	default "4"
>  
> +config SERIAL_SUNIX
> +	tristate "SUNIX pci serial port support"
> +	depends on SERIAL_8250
> +	select SERIAL_CORE
> +	help
> +	  Say Y here if you have a SUNIX serial card.
> +	  If unsure, say N.
> +
> +	  This driver can also be built as a module. The module will be called
> +	  sunix_pci_serial. If you want to do that, say M here.
> +
>  config SERIAL_MILBEAUT_USIO_CONSOLE
>  	bool "Support for console on MILBEAUT USIO/UART serial port"
>  	depends on SERIAL_MILBEAUT_USIO=y
> diff --git a/serial/Makefile b/serial/Makefile
> index 58d5317..cecccc6 100644
> --- a/serial/Makefile
> +++ b/serial/Makefile
> @@ -94,7 +94,7 @@ obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
>  obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
>  obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
>  obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
> -
> +obj-$(CONFIG_SERIAL_SUNIX)	+= sunix_uart.o
>  
>  # GPIOLIB helpers for modem control lines
>  obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
> diff --git a/serial/sunix_uart.c b/serial/sunix_uart.c
> new file mode 100644
> index 0000000..d227d7a
> --- /dev/null
> +++ b/serial/sunix_uart.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *	Driver for SUNIX PCI serial board
> + *	Based on drivers/tty/serial/8250/8250_pci.c
> + *	by Linus Torvalds, Theodore Ts'o.
> + *
> + *	This program is free software; you can redistribute it and/or modify
> + *	it under the terms of the GNU General Public License as published by
> + *	the Free Software Foundation; either version 2 of the License.

This sentence does not make any sense.  Please just remove it entirely
as the SPDX notifier should say what you mean here, right?

thanks,

greg k-h
