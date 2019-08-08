Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDA4862F8
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 15:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbfHHNVu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 09:21:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:56253 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389742AbfHHNVu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 09:21:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 06:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="193155767"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 Aug 2019 06:20:06 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Aug 2019 16:20:06 +0300
Date:   Thu, 8 Aug 2019 16:20:06 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 5/9] serial: 8250_lpss: switch to use 8250_dwlib
 library
Message-ID: <20190808132006.GD8938@kuha.fi.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
 <20190806094322.64987-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806094322.64987-5-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 06, 2019 at 12:43:18PM +0300, Andy Shevchenko wrote:
> Since we have a common library module for Synopsys DesignWare UART,
> let us use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/tty/serial/8250/8250_lpss.c | 22 +++++++++++++---------
>  drivers/tty/serial/8250/Kconfig     |  1 +
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index d07e431110d9..3bf23770c188 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -14,7 +14,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/dma/dw.h>
>  
> -#include "8250.h"
> +#include "8250_dwlib.h"
>  
>  #define PCI_DEVICE_ID_INTEL_QRK_UARTx	0x0936
>  
> @@ -48,21 +48,25 @@ struct lpss8250_board {
>  };
>  
>  struct lpss8250 {
> -	int line;
> +	struct dw8250_port_data data;
>  	struct lpss8250_board *board;
>  
>  	/* DMA parameters */
> -	struct uart_8250_dma dma;
>  	struct dw_dma_chip dma_chip;
>  	struct dw_dma_slave dma_param;
>  	u8 dma_maxburst;
>  };
>  
> +static inline struct lpss8250 *to_lpss8250(struct dw8250_port_data *data)
> +{
> +	return container_of(data, struct lpss8250, data);
> +}
> +
>  static void byt_set_termios(struct uart_port *p, struct ktermios *termios,
>  			    struct ktermios *old)
>  {
>  	unsigned int baud = tty_termios_baud_rate(termios);
> -	struct lpss8250 *lpss = p->private_data;
> +	struct lpss8250 *lpss = to_lpss8250(p->private_data);
>  	unsigned long fref = lpss->board->freq, fuart = baud * 16;
>  	unsigned long w = BIT(15) - 1;
>  	unsigned long m, n;
> @@ -163,7 +167,7 @@ static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
>  
>  static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>  {
> -	struct uart_8250_dma *dma = &lpss->dma;
> +	struct uart_8250_dma *dma = &lpss->data.dma;
>  	struct dw_dma_chip *chip = &lpss->dma_chip;
>  	struct dw_dma_slave *param = &lpss->dma_param;
>  	struct pci_dev *pdev = to_pci_dev(port->dev);
> @@ -247,7 +251,7 @@ static bool lpss8250_dma_filter(struct dma_chan *chan, void *param)
>  
>  static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port)
>  {
> -	struct uart_8250_dma *dma = &lpss->dma;
> +	struct uart_8250_dma *dma = &lpss->data.dma;
>  	struct dw_dma_slave *rx_param, *tx_param;
>  	struct device *dev = port->port.dev;
>  
> @@ -296,7 +300,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	uart.port.dev = &pdev->dev;
>  	uart.port.irq = pdev->irq;
> -	uart.port.private_data = lpss;
> +	uart.port.private_data = &lpss->data;
>  	uart.port.type = PORT_16550A;
>  	uart.port.iotype = UPIO_MEM;
>  	uart.port.regshift = 2;
> @@ -320,7 +324,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (ret < 0)
>  		goto err_exit;
>  
> -	lpss->line = ret;
> +	lpss->data.line = ret;
>  
>  	pci_set_drvdata(pdev, lpss);
>  	return 0;
> @@ -335,7 +339,7 @@ static void lpss8250_remove(struct pci_dev *pdev)
>  {
>  	struct lpss8250 *lpss = pci_get_drvdata(pdev);
>  
> -	serial8250_unregister_port(lpss->line);
> +	serial8250_unregister_port(lpss->data.line);
>  
>  	if (lpss->board->exit)
>  		lpss->board->exit(lpss);
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 90abf97b378d..ff5d142bbd70 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -444,6 +444,7 @@ config SERIAL_8250_LPSS
>  	default SERIAL_8250
>  	depends on SERIAL_8250 && PCI
>  	depends on X86 || COMPILE_TEST
> +	select SERIAL_8250_DWLIB
>  	select DW_DMAC_CORE if SERIAL_8250_DMA
>  	select DW_DMAC_PCI if (SERIAL_8250_DMA && X86_INTEL_LPSS)
>  	select RATIONAL
> -- 
> 2.20.1

-- 
heikki
