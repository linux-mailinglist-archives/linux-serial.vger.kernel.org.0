Return-Path: <linux-serial+bounces-10192-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCB4B02997
	for <lists+linux-serial@lfdr.de>; Sat, 12 Jul 2025 08:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58477B164B
	for <lists+linux-serial@lfdr.de>; Sat, 12 Jul 2025 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B842A87;
	Sat, 12 Jul 2025 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a2SaZx/q"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20258C11;
	Sat, 12 Jul 2025 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752302867; cv=none; b=S+8Z4FbILgbwUzl2OxRgs1uc4s7zPbyMh/cJuBL2acDboYnWrCmSTTWypl2gN9q4KvRYM1u8fZFGvhLi/oqDLbUn0wZS7CY18p3Fu0TgboFvIY8mvjKJ8QlKJFLgEBxzTsfV8JqAqk666yK3BoDmxzgCEKzXXkTvAUZ8qtiMJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752302867; c=relaxed/simple;
	bh=1fRTenjyUuEj5+LdfZV0G/3BEZBYDJpLugg5BCBP1GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZGTcVjqhXt1xArtvBogDTse+IIP/S/z8uJFS5/KYEl2Fg7rrddNNK8g5/kDFIcQ0vUc7xT0oSTn049H5QBdAc5ptpyyFl57hFyuNU2Olh3jO5F3Z2v3Hb0hwUP/O7pr0py9tiY0aXyO4S6/dYYq9fzJ/yRLRVxxEEQNK9DAMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a2SaZx/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6733C4CEEF;
	Sat, 12 Jul 2025 06:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752302866;
	bh=1fRTenjyUuEj5+LdfZV0G/3BEZBYDJpLugg5BCBP1GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2SaZx/qpQZaUVL8y6/fEGLeqaqwQMi6Q9yHKabigGn0EtWUb2P2LO4OKLvqKGnpX
	 CSJyj6ln5gnyYY9UQuHWuPiB70SAS/2buOvfUXhEwpCp1nPoOJQMLcADIQSTzvhpAU
	 bkfybmjeg7afBMSNymbPF/e6jbKSKlqgxKtVUb9k=
Date: Sat, 12 Jul 2025 08:47:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Jason Smith <jason.smith@emerson.com>,
	Gratian Crisan <gratian.crisan@emerson.com>
Subject: Re: [PATCH] serial: 8250_ni: Fix build warning
Message-ID: <2025071206-grip-overblown-bf53@gregkh>
References: <20250710223838.2657261-1-chaitanya.vadrevu@emerson.com>
 <2025071102-zombie-disbelief-4c38@gregkh>
 <991f5fe9-b810-4aef-825c-d0b532584730@emerson.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <991f5fe9-b810-4aef-825c-d0b532584730@emerson.com>

On Fri, Jul 11, 2025 at 02:27:48PM -0500, Chaitanya Vadrevu wrote:
> > > Allocate memory on heap instead of stack to fix following warning that
> > > clang version 20.1.2 produces on W=1 build.
> > > 
> > > drivers/tty/serial/8250/8250_ni.c:277:12: warning: stack frame size (1072) exceeds limit (1024) in 'ni16550_probe' [-Wframe-larger-than]
> > >   277 | static int ni16550_probe(struct platform_device *pdev)
> > >       |            ^
> > >   1 warning generated.
> > > 
> > > Also, reorder variable declarations to follow reverse Christmas tree
> > > style.
> > 
> > When you say "also", that's usually a hint this should be a separate
> > patch :(
> 
> Sure, I'll split this and send a v2.
> 
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202507030557.vIewJJQO-lkp@intel.com/
> > > Cc: Jason Smith <jason.smith@emerson.com>
> > > Cc: Gratian Crisan <gratian.crisan@emerson.com>
> > > Signed-off-by: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_ni.c | 56 +++++++++++++++++--------------
> > >  1 file changed, 30 insertions(+), 26 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
> > > index b0e44fb00b3a4..cb5b42b3609c9 100644
> > > --- a/drivers/tty/serial/8250/8250_ni.c
> > > +++ b/drivers/tty/serial/8250/8250_ni.c
> > > @@ -275,76 +275,80 @@ static void ni16550_set_mctrl(struct uart_port *port, unsigned int mctrl)
> > >  
> > >  static int ni16550_probe(struct platform_device *pdev)
> > >  {
> > > +	struct uart_8250_port *uart __free(kfree) = NULL;
> > >  	const struct ni16550_device_info *info;
> > >  	struct device *dev = &pdev->dev;
> > > -	struct uart_8250_port uart = {};
> > >  	unsigned int txfifosz, rxfifosz;
> > > -	unsigned int prescaler;
> > >  	struct ni16550_data *data;
> > > +	unsigned int prescaler;
> > >  	const char *portmode;
> > >  	bool rs232_property;
> > >  	int ret;
> > >  
> > > +	uart = kzalloc(sizeof(*uart), GFP_KERNEL);
> > > +	if (!uart)
> > > +		return -ENOMEM;
> > > +
> > >  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > >  	if (!data)
> > >  		return -ENOMEM;
> > >  
> > > -	spin_lock_init(&uart.port.lock);
> > > +	spin_lock_init(&uart->port.lock);
> > >  
> > > -	ret = ni16550_get_regs(pdev, &uart.port);
> > > +	ret = ni16550_get_regs(pdev, &uart->port);
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > >  	/* early setup so that serial_in()/serial_out() work */
> > > -	serial8250_set_defaults(&uart);
> > > +	serial8250_set_defaults(uart);
> > >  
> > >  	info = device_get_match_data(dev);
> > >  
> > > -	uart.port.dev		= dev;
> > > -	uart.port.flags		= UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
> > > -	uart.port.startup	= ni16550_port_startup;
> > > -	uart.port.shutdown	= ni16550_port_shutdown;
> > > +	uart->port.dev		= dev;
> > > +	uart->port.flags	= UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
> > > +	uart->port.startup	= ni16550_port_startup;
> > > +	uart->port.shutdown	= ni16550_port_shutdown;
> > >  
> > >  	/*
> > >  	 * Hardware instantiation of FIFO sizes are held in registers.
> > >  	 */
> > > -	txfifosz = ni16550_read_fifo_size(&uart, NI16550_TFS_OFFSET);
> > > -	rxfifosz = ni16550_read_fifo_size(&uart, NI16550_RFS_OFFSET);
> > > +	txfifosz = ni16550_read_fifo_size(uart, NI16550_TFS_OFFSET);
> > > +	rxfifosz = ni16550_read_fifo_size(uart, NI16550_RFS_OFFSET);
> > >  
> > >  	dev_dbg(dev, "NI 16550 has TX FIFO size %u, RX FIFO size %u\n",
> > >  		txfifosz, rxfifosz);
> > >  
> > > -	uart.port.type		= PORT_16550A;
> > > -	uart.port.fifosize	= txfifosz;
> > > -	uart.tx_loadsz		= txfifosz;
> > > -	uart.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
> > > -	uart.capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
> > > +	uart->port.type		= PORT_16550A;
> > > +	uart->port.fifosize	= txfifosz;
> > > +	uart->tx_loadsz		= txfifosz;
> > > +	uart->fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
> > > +	uart->capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
> > >  
> > >  	/*
> > >  	 * Declaration of the base clock frequency can come from one of:
> > >  	 * - static declaration in this driver (for older ACPI IDs)
> > >  	 * - a "clock-frequency" ACPI
> > >  	 */
> > > -	uart.port.uartclk = info->uartclk;
> > > +	uart->port.uartclk = info->uartclk;
> > >  
> > > -	ret = uart_read_port_properties(&uart.port);
> > > +	ret = uart_read_port_properties(&uart->port);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	if (!uart.port.uartclk) {
> > > +	if (!uart->port.uartclk) {
> > >  		data->clk = devm_clk_get_enabled(dev, NULL);
> > >  		if (!IS_ERR(data->clk))
> > > -			uart.port.uartclk = clk_get_rate(data->clk);
> > > +			uart->port.uartclk = clk_get_rate(data->clk);
> > >  	}
> > >  
> > > -	if (!uart.port.uartclk)
> > > +	if (!uart->port.uartclk)
> > >  		return dev_err_probe(dev, -ENODEV, "unable to determine clock frequency!\n");
> > >  
> > >  	prescaler = info->prescaler;
> > >  	device_property_read_u32(dev, "clock-prescaler", &prescaler);
> > >  	if (prescaler) {
> > > -		uart.port.set_mctrl = ni16550_set_mctrl;
> > > -		ni16550_config_prescaler(&uart, (u8)prescaler);
> > > +		uart->port.set_mctrl = ni16550_set_mctrl;
> > > +		ni16550_config_prescaler(uart, (u8)prescaler);
> > >  	}
> > >  
> > >  	/*
> > > @@ -362,7 +366,7 @@ static int ni16550_probe(struct platform_device *pdev)
> > >  		dev_dbg(dev, "port is in %s mode (via device property)\n",
> > >  			rs232_property ? "RS-232" : "RS-485");
> > >  	} else if (info->flags & NI_HAS_PMR) {
> > > -		rs232_property = is_pmr_rs232_mode(&uart);
> > > +		rs232_property = is_pmr_rs232_mode(uart);
> > >  
> > >  		dev_dbg(dev, "port is in %s mode (via PMR)\n",
> > >  			rs232_property ? "RS-232" : "RS-485");
> > > @@ -377,10 +381,10 @@ static int ni16550_probe(struct platform_device *pdev)
> > >  		 * Neither the 'transceiver' property nor the PMR indicate
> > >  		 * that this is an RS-232 port, so it must be an RS-485 one.
> > >  		 */
> > > -		ni16550_rs485_setup(&uart.port);
> > > +		ni16550_rs485_setup(&uart->port);
> > >  	}
> > >  
> > > -	ret = serial8250_register_8250_port(&uart);
> > > +	ret = serial8250_register_8250_port(uart);
> > 
> > So uart is freed after this and that's ok?  Are you sure?
> 
> Before this patch, uart was defined on stack where it would also be
> freed at the end of the function.
> I see similar pattern being used in other 8250 drivers where they also
> define uart_8250_port on stack. So, I don't believe this is an issue.

Ah, you are right, sorry, I always get that one wrong.  I'll just take
this as-is, no need to redo it.

Also, if other drivers put this on the stack, they should get the same
fixup as well.

thanks,

greg k-h

