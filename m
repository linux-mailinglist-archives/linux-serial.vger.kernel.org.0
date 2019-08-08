Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212E0862E2
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbfHHNTC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 09:19:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:2131 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbfHHNTC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 09:19:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 06:19:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="193155596"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 Aug 2019 06:18:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Aug 2019 16:18:58 +0300
Date:   Thu, 8 Aug 2019 16:18:58 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 4/9] serial: 8250_dw: switch to use 8250_dwlib library
Message-ID: <20190808131858.GC8938@kuha.fi.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
 <20190806094322.64987-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806094322.64987-4-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 06, 2019 at 12:43:17PM +0300, Andy Shevchenko wrote:
> Since we have a common library module for Synopsys DesignWare UART,
> let us use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/tty/serial/8250/8250_dw.c | 162 +++++-------------------------
>  drivers/tty/serial/8250/Kconfig   |   1 +
>  2 files changed, 28 insertions(+), 135 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 010d0a292e73..1c72fdc2dd37 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -27,66 +27,36 @@
>  
>  #include <asm/byteorder.h>
>  
> -#include "8250.h"
> +#include "8250_dwlib.h"
>  
>  /* Offsets for the DesignWare specific registers */
>  #define DW_UART_USR	0x1f /* UART Status Register */
> -#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
> -#define DW_UART_CPR	0xf4 /* Component Parameter Register */
> -#define DW_UART_UCV	0xf8 /* UART Component Version */
> -
> -/* Component Parameter Register bits */
> -#define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
> -#define DW_UART_CPR_AFCE_MODE		(1 << 4)
> -#define DW_UART_CPR_THRE_MODE		(1 << 5)
> -#define DW_UART_CPR_SIR_MODE		(1 << 6)
> -#define DW_UART_CPR_SIR_LP_MODE		(1 << 7)
> -#define DW_UART_CPR_ADDITIONAL_FEATURES	(1 << 8)
> -#define DW_UART_CPR_FIFO_ACCESS		(1 << 9)
> -#define DW_UART_CPR_FIFO_STAT		(1 << 10)
> -#define DW_UART_CPR_SHADOW		(1 << 11)
> -#define DW_UART_CPR_ENCODED_PARMS	(1 << 12)
> -#define DW_UART_CPR_DMA_EXTRA		(1 << 13)
> -#define DW_UART_CPR_FIFO_MODE		(0xff << 16)
> -/* Helper for fifo size calculation */
> -#define DW_UART_CPR_FIFO_SIZE(a)	(((a >> 16) & 0xff) * 16)
>  
>  /* DesignWare specific register fields */
>  #define DW_UART_MCR_SIRE		BIT(6)
>  
>  struct dw8250_data {
> +	struct dw8250_port_data	data;
> +
>  	u8			usr_reg;
> -	u8			dlf_size;
> -	int			line;
>  	int			msr_mask_on;
>  	int			msr_mask_off;
>  	struct clk		*clk;
>  	struct clk		*pclk;
>  	struct reset_control	*rst;
> -	struct uart_8250_dma	dma;
>  
>  	unsigned int		skip_autocfg:1;
>  	unsigned int		uart_16550_compatible:1;
>  };
>  
> -static inline u32 dw8250_readl_ext(struct uart_port *p, int offset)
> +static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
>  {
> -	if (p->iotype == UPIO_MEM32BE)
> -		return ioread32be(p->membase + offset);
> -	return readl(p->membase + offset);
> -}
> -
> -static inline void dw8250_writel_ext(struct uart_port *p, int offset, u32 reg)
> -{
> -	if (p->iotype == UPIO_MEM32BE)
> -		iowrite32be(reg, p->membase + offset);
> -	else
> -		writel(reg, p->membase + offset);
> +	return container_of(data, struct dw8250_data, data);
>  }
>  
>  static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
>  {
> -	struct dw8250_data *d = p->private_data;
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  
>  	/* Override any modem control signals if needed */
>  	if (offset == UART_MSR) {
> @@ -160,7 +130,7 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
>  
>  static void dw8250_serial_out38x(struct uart_port *p, int offset, int value)
>  {
> -	struct dw8250_data *d = p->private_data;
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  
>  	/* Allow the TX to drain before we reconfigure */
>  	if (offset == UART_LCR)
> @@ -175,7 +145,7 @@ static void dw8250_serial_out38x(struct uart_port *p, int offset, int value)
>  
>  static void dw8250_serial_out(struct uart_port *p, int offset, int value)
>  {
> -	struct dw8250_data *d = p->private_data;
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  
>  	writeb(value, p->membase + (offset << p->regshift));
>  
> @@ -202,7 +172,7 @@ static unsigned int dw8250_serial_inq(struct uart_port *p, int offset)
>  
>  static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
>  {
> -	struct dw8250_data *d = p->private_data;
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  
>  	value &= 0xff;
>  	__raw_writeq(value, p->membase + (offset << p->regshift));
> @@ -216,7 +186,7 @@ static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
>  
>  static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
>  {
> -	struct dw8250_data *d = p->private_data;
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  
>  	writel(value, p->membase + (offset << p->regshift));
>  
> @@ -233,7 +203,7 @@ static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
>  
>  static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
>  {
> -	struct dw8250_data *d = p->private_data;
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  
>  	iowrite32be(value, p->membase + (offset << p->regshift));
>  
> @@ -252,7 +222,7 @@ static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
>  static int dw8250_handle_irq(struct uart_port *p)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(p);
> -	struct dw8250_data *d = p->private_data;
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  	unsigned int iir = p->serial_in(p, UART_IIR);
>  	unsigned int status;
>  	unsigned long flags;
> @@ -306,7 +276,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>  			       struct ktermios *old)
>  {
>  	unsigned int baud = tty_termios_baud_rate(termios);
> -	struct dw8250_data *d = p->private_data;
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  	long rate;
>  	int ret;
>  
> @@ -368,37 +338,6 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
>  	return param == chan->device->dev;
>  }
>  
> -/*
> - * divisor = div(I) + div(F)
> - * "I" means integer, "F" means fractional
> - * quot = div(I) = clk / (16 * baud)
> - * frac = div(F) * 2^dlf_size
> - *
> - * let rem = clk % (16 * baud)
> - * we have: div(F) * (16 * baud) = rem
> - * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16 * baud)
> - */
> -static unsigned int dw8250_get_divisor(struct uart_port *p,
> -				       unsigned int baud,
> -				       unsigned int *frac)
> -{
> -	unsigned int quot, rem, base_baud = baud * 16;
> -	struct dw8250_data *d = p->private_data;
> -
> -	quot = p->uartclk / base_baud;
> -	rem = p->uartclk % base_baud;
> -	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, base_baud);
> -
> -	return quot;
> -}
> -
> -static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
> -			       unsigned int quot, unsigned int quot_frac)
> -{
> -	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
> -	serial8250_do_set_divisor(p, baud, quot, quot_frac);
> -}
> -
>  static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  {
>  	if (p->dev->of_node) {
> @@ -437,59 +376,12 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  	/* Platforms with iDMA 64-bit */
>  	if (platform_get_resource_byname(to_platform_device(p->dev),
>  					 IORESOURCE_MEM, "lpss_priv")) {
> -		data->dma.rx_param = p->dev->parent;
> -		data->dma.tx_param = p->dev->parent;
> -		data->dma.fn = dw8250_idma_filter;
> +		data->data.dma.rx_param = p->dev->parent;
> +		data->data.dma.tx_param = p->dev->parent;
> +		data->data.dma.fn = dw8250_idma_filter;
>  	}
>  }
>  
> -static void dw8250_setup_port(struct uart_port *p)
> -{
> -	struct uart_8250_port *up = up_to_u8250p(p);
> -	u32 reg;
> -
> -	/*
> -	 * If the Component Version Register returns zero, we know that
> -	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
> -	 */
> -	reg = dw8250_readl_ext(p, DW_UART_UCV);
> -	if (!reg)
> -		return;
> -
> -	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
> -		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
> -
> -	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
> -	reg = dw8250_readl_ext(p, DW_UART_DLF);
> -	dw8250_writel_ext(p, DW_UART_DLF, 0);
> -
> -	if (reg) {
> -		struct dw8250_data *d = p->private_data;
> -
> -		d->dlf_size = fls(reg);
> -		p->get_divisor = dw8250_get_divisor;
> -		p->set_divisor = dw8250_set_divisor;
> -	}
> -
> -	reg = dw8250_readl_ext(p, DW_UART_CPR);
> -	if (!reg)
> -		return;
> -
> -	/* Select the type based on fifo */
> -	if (reg & DW_UART_CPR_FIFO_MODE) {
> -		p->type = PORT_16550A;
> -		p->flags |= UPF_FIXED_TYPE;
> -		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
> -		up->capabilities = UART_CAP_FIFO;
> -	}
> -
> -	if (reg & DW_UART_CPR_AFCE_MODE)
> -		up->capabilities |= UART_CAP_AFE;
> -
> -	if (reg & DW_UART_CPR_SIR_MODE)
> -		up->capabilities |= UART_CAP_IRDA;
> -}
> -
>  static int dw8250_probe(struct platform_device *pdev)
>  {
>  	struct uart_8250_port uart = {}, *up = &uart;
> @@ -534,9 +426,9 @@ static int dw8250_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	data->dma.fn = dw8250_fallback_dma_filter;
> +	data->data.dma.fn = dw8250_fallback_dma_filter;
>  	data->usr_reg = DW_UART_USR;
> -	p->private_data = data;
> +	p->private_data = &data->data;
>  
>  	data->uart_16550_compatible = device_property_read_bool(dev,
>  						"snps,uart-16550-compatible");
> @@ -632,14 +524,14 @@ static int dw8250_probe(struct platform_device *pdev)
>  
>  	/* If we have a valid fifosize, try hooking up DMA */
>  	if (p->fifosize) {
> -		data->dma.rxconf.src_maxburst = p->fifosize / 4;
> -		data->dma.txconf.dst_maxburst = p->fifosize / 4;
> -		up->dma = &data->dma;
> +		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
> +		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
> +		up->dma = &data->data.dma;
>  	}
>  
> -	data->line = serial8250_register_8250_port(up);
> -	if (data->line < 0) {
> -		err = data->line;
> +	data->data.line = serial8250_register_8250_port(up);
> +	if (data->data.line < 0) {
> +		err = data->data.line;
>  		goto err_reset;
>  	}
>  
> @@ -671,7 +563,7 @@ static int dw8250_remove(struct platform_device *pdev)
>  
>  	pm_runtime_get_sync(dev);
>  
> -	serial8250_unregister_port(data->line);
> +	serial8250_unregister_port(data->data.line);
>  
>  	reset_control_assert(data->rst);
>  
> @@ -692,7 +584,7 @@ static int dw8250_suspend(struct device *dev)
>  {
>  	struct dw8250_data *data = dev_get_drvdata(dev);
>  
> -	serial8250_suspend_port(data->line);
> +	serial8250_suspend_port(data->data.line);
>  
>  	return 0;
>  }
> @@ -701,7 +593,7 @@ static int dw8250_resume(struct device *dev)
>  {
>  	struct dw8250_data *data = dev_get_drvdata(dev);
>  
> -	serial8250_resume_port(data->line);
> +	serial8250_resume_port(data->data.line);
>  
>  	return 0;
>  }
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index d628258fb4cf..90abf97b378d 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -357,6 +357,7 @@ config SERIAL_8250_FSL
>  config SERIAL_8250_DW
>  	tristate "Support for Synopsys DesignWare 8250 quirks"
>  	depends on SERIAL_8250
> +	select SERIAL_8250_DWLIB
>  	help
>  	  Selecting this option will enable handling of the extra features
>  	  present in the Synopsys DesignWare APB UART.
> -- 
> 2.20.1

-- 
heikki
