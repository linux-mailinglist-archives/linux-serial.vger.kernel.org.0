Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377F58631E
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 15:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbfHHN2i (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 09:28:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:42864 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733036AbfHHN2i (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 09:28:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 06:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="193156134"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 Aug 2019 06:23:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Aug 2019 16:23:52 +0300
Date:   Thu, 8 Aug 2019 16:23:52 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 6/9] serial: 8250_lpss: add fractional divisor support
Message-ID: <20190808132352.GE8938@kuha.fi.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
 <20190806094322.64987-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806094322.64987-6-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 06, 2019 at 12:43:19PM +0300, Andy Shevchenko wrote:
> For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> valid divisor latch fraction register.
> 
> Now the preparation is done, it's easy to add the feature support.
> This patch firstly tries to get the fractional divisor width during
> probe, then setups specific get_divisor() and set_divisor() hook.
> 
> Among other changes the FIFO size is now retrieved from the hardware.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/tty/serial/8250/8250_lpss.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 3bf23770c188..0c6aa990db3d 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -113,7 +113,6 @@ static unsigned int byt_get_mctrl(struct uart_port *port)
>  static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
>  {
>  	struct dw_dma_slave *param = &lpss->dma_param;
> -	struct uart_8250_port *up = up_to_u8250p(port);
>  	struct pci_dev *pdev = to_pci_dev(port->dev);
>  	unsigned int dma_devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), 0);
>  	struct pci_dev *dma_dev = pci_get_slot(pdev->bus, dma_devfn);
> @@ -139,10 +138,6 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
>  	param->m_master = 0;
>  	param->p_master = 1;
>  
> -	/* TODO: Detect FIFO size automaticaly for DesignWare 8250 */
> -	port->fifosize = 64;
> -	up->tx_loadsz = 64;
> -
>  	lpss->dma_maxburst = 16;
>  
>  	port->set_termios = byt_set_termios;
> @@ -316,6 +311,8 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (ret)
>  		return ret;
>  
> +	dw8250_setup_port(&uart.port);
> +
>  	ret = lpss8250_dma_setup(lpss, &uart);
>  	if (ret)
>  		goto err_exit;
> -- 
> 2.20.1

-- 
heikki
