Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6208630B
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbfHHNYd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 09:24:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:28833 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733046AbfHHNYd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 09:24:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 06:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="193156178"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 Aug 2019 06:24:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Aug 2019 16:24:30 +0300
Date:   Thu, 8 Aug 2019 16:24:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 7/9] serial: 8250_lpss: register DMA IRQ and pool with
 instance ID
Message-ID: <20190808132430.GF8938@kuha.fi.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
 <20190806094322.64987-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806094322.64987-7-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 06, 2019 at 12:43:20PM +0300, Andy Shevchenko wrote:
> It is really useful not only for debugging to have an DMA IRQ line and
> pool being mapped to the corresponding IP by using its instance ID.
> 
> Provide PCI device and function as instance ID for Intel Quark UART DMA.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/tty/serial/8250/8250_lpss.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 0c6aa990db3d..2bb30e688433 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -170,6 +170,7 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>  
>  	chip->pdata = &qrk_serial_dma_pdata;
>  	chip->dev = &pdev->dev;
> +	chip->id = pdev->devfn;
>  	chip->irq = pci_irq_vector(pdev, 0);
>  	chip->regs = pci_ioremap_bar(pdev, 1);
>  	if (!chip->regs)
> -- 
> 2.20.1

-- 
heikki
