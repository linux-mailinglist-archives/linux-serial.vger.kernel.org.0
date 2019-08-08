Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877A9862DB
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 15:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbfHHNSm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 09:18:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:51167 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfHHNSm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 09:18:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 06:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="193155564"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 Aug 2019 06:18:39 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Aug 2019 16:18:38 +0300
Date:   Thu, 8 Aug 2019 16:18:38 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 3/9] serial: 8250_dw: split Synopsys DesignWare 8250
 common functions
Message-ID: <20190808131838.GB8938@kuha.fi.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
 <20190806094322.64987-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806094322.64987-3-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 06, 2019 at 12:43:16PM +0300, Andy Shevchenko wrote:
> We would like to use same functions in the couple of drivers for
> Synopsys DesignWare 8250 UART. Split them from 8250_dw into new brand
> library module which users will select explicitly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/tty/serial/8250/8250_dwlib.c | 126 +++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_dwlib.h |  19 ++++
>  drivers/tty/serial/8250/Kconfig      |   3 +
>  drivers/tty/serial/8250/Makefile     |   1 +
>  4 files changed, 149 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_dwlib.c
>  create mode 100644 drivers/tty/serial/8250/8250_dwlib.h
> 
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> new file mode 100644
> index 000000000000..6d6a78eead3e
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Synopsys DesignWare 8250 library. */
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/serial_8250.h>
> +#include <linux/serial_core.h>
> +
> +#include "8250_dwlib.h"
> +
> +/* Offsets for the DesignWare specific registers */
> +#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
> +#define DW_UART_CPR	0xf4 /* Component Parameter Register */
> +#define DW_UART_UCV	0xf8 /* UART Component Version */
> +
> +/* Component Parameter Register bits */
> +#define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
> +#define DW_UART_CPR_AFCE_MODE		(1 << 4)
> +#define DW_UART_CPR_THRE_MODE		(1 << 5)
> +#define DW_UART_CPR_SIR_MODE		(1 << 6)
> +#define DW_UART_CPR_SIR_LP_MODE		(1 << 7)
> +#define DW_UART_CPR_ADDITIONAL_FEATURES	(1 << 8)
> +#define DW_UART_CPR_FIFO_ACCESS		(1 << 9)
> +#define DW_UART_CPR_FIFO_STAT		(1 << 10)
> +#define DW_UART_CPR_SHADOW		(1 << 11)
> +#define DW_UART_CPR_ENCODED_PARMS	(1 << 12)
> +#define DW_UART_CPR_DMA_EXTRA		(1 << 13)
> +#define DW_UART_CPR_FIFO_MODE		(0xff << 16)
> +
> +/* Helper for FIFO size calculation */
> +#define DW_UART_CPR_FIFO_SIZE(a)	(((a >> 16) & 0xff) * 16)
> +
> +static inline u32 dw8250_readl_ext(struct uart_port *p, int offset)
> +{
> +	if (p->iotype == UPIO_MEM32BE)
> +		return ioread32be(p->membase + offset);
> +	return readl(p->membase + offset);
> +}
> +
> +static inline void dw8250_writel_ext(struct uart_port *p, int offset, u32 reg)
> +{
> +	if (p->iotype == UPIO_MEM32BE)
> +		iowrite32be(reg, p->membase + offset);
> +	else
> +		writel(reg, p->membase + offset);
> +}
> +
> +/*
> + * divisor = div(I) + div(F)
> + * "I" means integer, "F" means fractional
> + * quot = div(I) = clk / (16 * baud)
> + * frac = div(F) * 2^dlf_size
> + *
> + * let rem = clk % (16 * baud)
> + * we have: div(F) * (16 * baud) = rem
> + * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16 * baud)
> + */
> +static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
> +				       unsigned int *frac)
> +{
> +	unsigned int quot, rem, base_baud = baud * 16;
> +	struct dw8250_port_data *d = p->private_data;
> +
> +	quot = p->uartclk / base_baud;
> +	rem = p->uartclk % base_baud;
> +	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, base_baud);
> +
> +	return quot;
> +}
> +
> +static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
> +			       unsigned int quot, unsigned int quot_frac)
> +{
> +	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
> +	serial8250_do_set_divisor(p, baud, quot, quot_frac);
> +}
> +
> +void dw8250_setup_port(struct uart_port *p)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +	u32 reg;
> +
> +	/*
> +	 * If the Component Version Register returns zero, we know that
> +	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
> +	 */
> +	reg = dw8250_readl_ext(p, DW_UART_UCV);
> +	if (!reg)
> +		return;
> +
> +	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
> +		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
> +
> +	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
> +	reg = dw8250_readl_ext(p, DW_UART_DLF);
> +	dw8250_writel_ext(p, DW_UART_DLF, 0);
> +
> +	if (reg) {
> +		struct dw8250_port_data *d = p->private_data;
> +
> +		d->dlf_size = fls(reg);
> +		p->get_divisor = dw8250_get_divisor;
> +		p->set_divisor = dw8250_set_divisor;
> +	}
> +
> +	reg = dw8250_readl_ext(p, DW_UART_CPR);
> +	if (!reg)
> +		return;
> +
> +	/* Select the type based on FIFO */
> +	if (reg & DW_UART_CPR_FIFO_MODE) {
> +		p->type = PORT_16550A;
> +		p->flags |= UPF_FIXED_TYPE;
> +		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
> +		up->capabilities = UART_CAP_FIFO;
> +	}
> +
> +	if (reg & DW_UART_CPR_AFCE_MODE)
> +		up->capabilities |= UART_CAP_AFE;
> +
> +	if (reg & DW_UART_CPR_SIR_MODE)
> +		up->capabilities |= UART_CAP_IRDA;
> +}
> +EXPORT_SYMBOL_GPL(dw8250_setup_port);
> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
> new file mode 100644
> index 000000000000..87a4db2a8aba
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_dwlib.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Synopsys DesignWare 8250 library header file. */
> +
> +#include <linux/types.h>
> +
> +#include "8250.h"
> +
> +struct dw8250_port_data {
> +	/* Port properties */
> +	int			line;
> +
> +	/* DMA operations */
> +	struct uart_8250_dma	dma;
> +
> +	/* Hardware configuration */
> +	u8			dlf_size;
> +};
> +
> +void dw8250_setup_port(struct uart_port *p);
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 509f6a3bb9ff..d628258fb4cf 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -314,6 +314,9 @@ config SERIAL_8250_RSA
>  
>  	  If you don't have such card, or if unsure, say N.
>  
> +config SERIAL_8250_DWLIB
> +	bool
> +
>  config SERIAL_8250_ACORN
>  	tristate "Acorn expansion card serial port support"
>  	depends on ARCH_ACORN && SERIAL_8250
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index 18751bc63a84..9b451d81588b 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
>  8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
>  8250_base-y				:= 8250_port.o
>  8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
> +8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
>  8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
>  obj-$(CONFIG_SERIAL_8250_GSC)		+= 8250_gsc.o
>  obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
> -- 
> 2.20.1

-- 
heikki
