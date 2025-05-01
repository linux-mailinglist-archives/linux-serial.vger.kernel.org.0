Return-Path: <linux-serial+bounces-9194-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B8DAA6163
	for <lists+linux-serial@lfdr.de>; Thu,  1 May 2025 18:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E34E1BC290D
	for <lists+linux-serial@lfdr.de>; Thu,  1 May 2025 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519F20D516;
	Thu,  1 May 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NOv5EZGB"
X-Original-To: linux-serial@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794E1A0728;
	Thu,  1 May 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746116926; cv=none; b=E3AuTLg0E4FiF7Dwd9rLzDN7oA+xlVlSw+cnjyRFZwZztXCJolWJxZQ2Xny4QcC3gEY/baChCQ0QMvnePt7vC4lm6du3cqN9V9zcnG6xVqYvwy4asVZihsDMzsGENaCEmc6v1SJ2p9ijvX+5lniPsFZc2gFyD9rL8XJYW5w3W8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746116926; c=relaxed/simple;
	bh=e6CW+s3dbrHhnVtm1uuMNUyDMchxpflbVQNT59JjAI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CjyE/4sQmrskjwAqbGiHhafSLPs1rTrF0VikdLsfsXTv+CIAMKI+zNQJCaKg3CpW77dDHuo+wdZ9XMyo5rak0QYuuwlG+Q3CC1UJWUvPAVH4R1XPHuYC/uSROqZMHyHABO1E1YsBYVMkG3co4moOR9mwOTpcb11cJ3/wmA1xTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NOv5EZGB; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 541GSOjK209927
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 11:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746116904;
	bh=Yi90HAavV9fZlheZqmgQWMAaYJZdvWL8k9KjGJRKjgk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NOv5EZGB/oyQYn0io7GmGfQ2b1zx/rCYWXSXoeqfsttosonPwiw42Jzo/S9+rPwNk
	 9mPr6tC3xefbt2E/fbdn4auT7/3FtUxru0WsZ1KEa6ysGoPP8N9/koNZBiudz+0Ocf
	 HU87m88UhyJm/7r8NSV1Lgk3bfyUpSBsXSw6NiZk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 541GSOrG013821
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 May 2025 11:28:24 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 May 2025 11:28:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 May 2025 11:28:24 -0500
Received: from [10.250.35.60] ([10.250.35.60])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 541GSNLf089988;
	Thu, 1 May 2025 11:28:23 -0500
Message-ID: <052c2566-d42c-4256-890d-b1cdbc964857@ti.com>
Date: Thu, 1 May 2025 11:28:23 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] serial: 8250: Add PRUSS UART driver
To: Judith Mendez <jm@ti.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>
CC: Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>
References: <20250501003113.1609342-1-jm@ti.com>
 <20250501003113.1609342-3-jm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250501003113.1609342-3-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 4/30/25 7:31 PM, Judith Mendez wrote:
> From: Bin Liu <b-liu@ti.com>
> 
> This adds a new serial 8250 driver that supports the UART in PRUSS
> module.
> 
> The PRUSS has a UART sub-module which is based on the industry standard
> TL16C550 UART controller, which has 16-bytes FIFO and supports 16x and
> 13x over samplings.
> 
> Signed-off-by: Bin Liu <b-liu@ti.com>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   drivers/tty/serial/8250/8250_pruss.c | 213 +++++++++++++++++++++++++++
>   drivers/tty/serial/8250/Kconfig      |  10 ++
>   drivers/tty/serial/8250/Makefile     |   1 +
>   3 files changed, 224 insertions(+)
>   create mode 100644 drivers/tty/serial/8250/8250_pruss.c
> 
> diff --git a/drivers/tty/serial/8250/8250_pruss.c b/drivers/tty/serial/8250/8250_pruss.c
> new file mode 100644
> index 000000000000..2943bf7d6645
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_pruss.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Serial Port driver for PRUSS UART on TI platforms
> + *
> + *  Copyright (C) 2020-2021 by Texas Instruments Incorporated - http://www.ti.com/
> + *  Author: Bin Liu <b-liu@ti.com>
> + */
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_core.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/remoteproc.h>
> +#include "8250.h"
> +
> +#define DEFAULT_CLK_SPEED	192000000
> +
> +/* extra registers */
> +#define PRUSS_UART_PEREMU_MGMT	12
> +#define PRUSS_UART_TX_EN	BIT(14)
> +#define PRUSS_UART_RX_EN	BIT(13)
> +#define PRUSS_UART_FREE_RUN	BIT(0)
> +
> +#define PRUSS_UART_MDR			13
> +#define PRUSS_UART_MDR_OSM_SEL_MASK	BIT(0)
> +#define PRUSS_UART_MDR_16X_MODE		0
> +#define PRUSS_UART_MDR_13X_MODE		1
> +
> +struct pruss8250_info {
> +	int type;

You never use type, why store it here?

> +	int line;
> +};
> +
> +static inline void uart_writel(struct uart_port *p, u32 offset, int value)
> +{
> +	writel(value, p->membase + (offset << p->regshift));
> +}
> +
> +static int pruss8250_startup(struct uart_port *port)
> +{
> +	int ret;
> +
> +	uart_writel(port, PRUSS_UART_PEREMU_MGMT, 0);
> +
> +	ret = serial8250_do_startup(port);
> +	if (!ret)
> +		uart_writel(port, PRUSS_UART_PEREMU_MGMT, PRUSS_UART_TX_EN |
> +							  PRUSS_UART_RX_EN |
> +							  PRUSS_UART_FREE_RUN);
> +	return ret;
> +}
> +
> +static unsigned int pruss8250_get_divisor(struct uart_port *port,
> +					  unsigned int baud,
> +					  unsigned int *frac)
> +{
> +	unsigned int uartclk = port->uartclk;
> +	unsigned int div_13, div_16;
> +	unsigned int abs_d13, abs_d16;
> +	u16 quot;
> +
> +	/* Old custom speed handling */
> +	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
> +		quot = port->custom_divisor & UART_DIV_MAX;
> +		if (port->custom_divisor & (1 << 16))
> +			*frac = PRUSS_UART_MDR_13X_MODE;
> +		else
> +			*frac = PRUSS_UART_MDR_16X_MODE;
> +
> +		return quot;
> +	}
> +
> +	div_13 = DIV_ROUND_CLOSEST(uartclk, 13 * baud);
> +	div_16 = DIV_ROUND_CLOSEST(uartclk, 16 * baud);
> +	div_13 = div_13 ? : 1;
> +	div_16 = div_16 ? : 1;
> +
> +	abs_d13 = abs(baud - uartclk / 13 / div_13);
> +	abs_d16 = abs(baud - uartclk / 16 / div_16);
> +
> +	if (abs_d13 >= abs_d16) {
> +		*frac = PRUSS_UART_MDR_16X_MODE;
> +		quot = div_16;
> +	} else {
> +		*frac = PRUSS_UART_MDR_13X_MODE;
> +		quot = div_13;
> +	}
> +
> +	return quot;
> +}
> +
> +static void pruss8250_set_divisor(struct uart_port *port, unsigned int baud,
> +				  unsigned int quot, unsigned int quot_frac)
> +{
> +	serial8250_do_set_divisor(port, baud, quot);
> +	/*
> +	 * quot_frac holds the MDR over-sampling mode
> +	 * which is set in pruss8250_get_divisor()
> +	 */
> +	quot_frac &= PRUSS_UART_MDR_OSM_SEL_MASK;
> +	serial_port_out(port, PRUSS_UART_MDR, quot_frac);
> +}
> +
> +static int pruss8250_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct uart_8250_port port8250;
> +	struct uart_port *up = &port8250.port;
> +	struct pruss8250_info *info;
> +	struct resource resource;
> +	unsigned int port_type;
> +	struct clk *clk;
> +	int ret;
> +
> +	port_type = (unsigned long)of_device_get_match_data(&pdev->dev);

Will the port type ever not be PORT_16550A?

> +	if (port_type == PORT_UNKNOWN)
> +		return -EINVAL;
> +
> +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	memset(&port8250, 0, sizeof(port8250));
> +
> +	ret = of_address_to_resource(np, 0, &resource);

platform_get_resource()

> +	if (ret) {
> +		dev_err(&pdev->dev, "invalid address\n");
> +		return ret;
> +	}
> +
> +	ret = of_alias_get_id(np, "serial");

Can you make use of the uart_read_port_properties() helper here?

Andrew

> +	if (ret > 0)
> +		up->line = ret;
> +
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		if (PTR_ERR(clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		up->uartclk = DEFAULT_CLK_SPEED;
> +	} else {
> +		up->uartclk = clk_get_rate(clk);
> +		devm_clk_put(&pdev->dev, clk);
> +	}
> +
> +	up->dev = &pdev->dev;
> +	up->mapbase = resource.start;
> +	up->mapsize = resource_size(&resource);
> +	up->type = port_type;
> +	up->iotype = UPIO_MEM;
> +	up->regshift = 2;
> +	up->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
> +		    UPF_FIXED_TYPE | UPF_IOREMAP;
> +	up->irqflags |= IRQF_SHARED;
> +	up->startup = pruss8250_startup;
> +	up->rs485_config = serial8250_em485_config;
> +	up->get_divisor = pruss8250_get_divisor;
> +	up->set_divisor = pruss8250_set_divisor;
> +
> +	ret = of_irq_get(np, 0);
> +	if (ret < 0) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "missing irq\n");
> +		return ret;
> +	}
> +
> +	up->irq = ret;
> +	spin_lock_init(&port8250.port.lock);
> +	port8250.capabilities = UART_CAP_FIFO | UART_CAP_AFE;
> +
> +	ret = serial8250_register_8250_port(&port8250);
> +	if (ret < 0)
> +		goto err_dispose;
> +
> +	info->type = port_type;
> +	info->line = ret;
> +	platform_set_drvdata(pdev, info);
> +
> +	return 0;
> +
> +err_dispose:
> +	irq_dispose_mapping(port8250.port.irq);
> +	return ret;
> +}
> +
> +static void pruss8250_remove(struct platform_device *pdev)
> +{
> +	struct pruss8250_info *info = platform_get_drvdata(pdev);
> +
> +	serial8250_unregister_port(info->line);
> +}
> +
> +static const struct of_device_id pruss8250_table[] = {
> +	{ .compatible = "ti,pruss-uart", .data = (void *)PORT_16550A, },
> +	{ /* end of list */ },
> +};
> +MODULE_DEVICE_TABLE(of, pruss8250_table);
> +
> +static struct platform_driver pruss8250_driver = {
> +	.driver = {
> +		.name = "pruss8250",
> +		.of_match_table = pruss8250_table,
> +	},
> +	.probe = pruss8250_probe,
> +	.remove = pruss8250_remove,
> +};
> +
> +module_platform_driver(pruss8250_driver);
> +
> +MODULE_AUTHOR("Bin Liu <b-liu@ti.com");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Serial Port driver for PRUSS UART on TI platforms");
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index f64ef0819cd4..cd4346609c55 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -582,6 +582,16 @@ config SERIAL_8250_NI
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called 8250_ni.
>   
> +config SERIAL_8250_PRUSS
> +	tristate "TI PRU-ICSS UART support"
> +	depends on SERIAL_8250
> +	depends on PRU_REMOTEPROC && TI_PRUSS_INTC
> +	help
> +	  This driver is to support the UART module in PRU-ICSS which is
> +	  available in some TI platforms.
> +	  Say 'Y' here if you wish to use PRU-ICSS UART.
> +	  Otherwise, say 'N'.
> +
>   config SERIAL_OF_PLATFORM
>   	tristate "Devicetree based probing for 8250 ports"
>   	depends on SERIAL_8250 && OF
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index b04eeda03b23..3132b4f40a34 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_SERIAL_8250_PARISC)	+= 8250_parisc.o
>   obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
>   obj-$(CONFIG_SERIAL_8250_PCI1XXXX)	+= 8250_pci1xxxx.o
>   obj-$(CONFIG_SERIAL_8250_PERICOM)	+= 8250_pericom.o
> +obj-$(CONFIG_SERIAL_8250_PRUSS)		+= 8250_pruss.o
>   obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
>   obj-$(CONFIG_SERIAL_8250_RT288X)	+= 8250_rt288x.o
>   obj-$(CONFIG_SERIAL_8250_CS)		+= serial_cs.o

