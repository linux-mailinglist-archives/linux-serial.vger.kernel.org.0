Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1A7DA98
	for <lists+linux-serial@lfdr.de>; Thu,  1 Aug 2019 13:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfHALw0 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 1 Aug 2019 07:52:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:5466 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730514AbfHALw0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Aug 2019 07:52:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 04:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,334,1559545200"; 
   d="scan'208";a="191607664"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2019 04:52:24 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ht9d9-0002we-9k; Thu, 01 Aug 2019 14:52:23 +0300
Date:   Thu, 1 Aug 2019 14:52:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Aaron Sierra <asierra@xes-inc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Subject: Re: [PATCH] serial: 8250_exar: Absorb remaining 8250_port INT0
 support
Message-ID: <20190801115223.GR23480@smile.fi.intel.com>
References: <20190731174545.8192-1-asierra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731174545.8192-1-asierra@xes-inc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 31, 2019 at 12:45:45PM -0500, Aaron Sierra wrote:
> Move INT0 clearing out of common, per-port serial8250_do_startup()
> into PCI device probe/resume.
> 
> As described in commit 2c0ac5b48a35 ("serial: exar: Fix stuck MSIs"),
> the purpose of clearing INT0 is to prevent the PCI interrupt line from
> becoming stuck asserted, "which is fatal with edge-triggered MSIs".
> 
> Like the clearing via interrupt handler that moved from common code in
> commit c7e1b4059075 ("tty: serial: exar: Relocate sleep wake-up
> handling"), this clearing at startup can be better handled at the PCI
> device level.
> 

Looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S. When you have a chance to test my series, please, give a tag.

> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
> 
> The embedded patch is written to follow this patch from Andy Shevchenko:
> [PATCH v4 3/3] serial: 8250_exar: Move custom divisor support out from 8250_port
> 
>  drivers/tty/serial/8250/8250_exar.c | 24 ++++++++++++++++--------
>  drivers/tty/serial/8250/8250_port.c |  9 ---------
>  2 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 4f8f45e2fc1d..248be217f528 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -492,6 +492,16 @@ static void pci_xr17v35x_exit(struct pci_dev *pcidev)
>  	port->port.private_data = NULL;
>  }
>  
> +static inline void exar_misc_clear(struct exar8250 *priv)
> +{
> +	/* Clear all PCI interrupts by reading INT0. No effect on IIR */
> +	readb(priv->virt + UART_EXAR_INT0);
> +
> +	/* Clear INT0 for Expansion Interface slave ports, too */
> +	if (priv->board->num_ports > 8)
> +		readb(priv->virt + 0x2000 + UART_EXAR_INT0);
> +}
> +
>  /*
>   * These Exar UARTs have an extra interrupt indicator that could fire for a
>   * few interrupts that are not presented/cleared through IIR.  One of which is
> @@ -503,14 +513,7 @@ static void pci_xr17v35x_exit(struct pci_dev *pcidev)
>   */
>  static irqreturn_t exar_misc_handler(int irq, void *data)
>  {
> -	struct exar8250 *priv = data;
> -
> -	/* Clear all PCI interrupts by reading INT0. No effect on IIR */
> -	readb(priv->virt + UART_EXAR_INT0);
> -
> -	/* Clear INT0 for Expansion Interface slave ports, too */
> -	if (priv->board->num_ports > 8)
> -		readb(priv->virt + 0x2000 + UART_EXAR_INT0);
> +	exar_misc_clear(data);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -563,6 +566,9 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
>  	if (rc)
>  		return rc;
>  
> +	/* Clear interrupts */
> +	exar_misc_clear(priv);
> +
>  	for (i = 0; i < nr_ports && i < maxnr; i++) {
>  		rc = board->setup(priv, pcidev, &uart, i);
>  		if (rc) {
> @@ -622,6 +628,8 @@ static int __maybe_unused exar_resume(struct device *dev)
>  	struct exar8250 *priv = pci_get_drvdata(pcidev);
>  	unsigned int i;
>  
> +	exar_misc_clear(priv);
> +
>  	for (i = 0; i < priv->nr; i++)
>  		if (priv->line[i] >= 0)
>  			serial8250_resume_port(priv->line[i]);
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 995a7e8b7839..706645f89132 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -40,11 +40,6 @@
>  
>  #include "8250.h"
>  
> -/*
> - * These are definitions for the Exar XR17V35X and XR17(C|D)15X
> - */
> -#define UART_EXAR_INT0		0x80
> -
>  /* Nuvoton NPCM timeout register */
>  #define UART_NPCM_TOR          7
>  #define UART_NPCM_TOIE         BIT(7)  /* Timeout Interrupt Enable */
> @@ -2138,8 +2133,6 @@ int serial8250_do_startup(struct uart_port *port)
>  	serial_port_in(port, UART_RX);
>  	serial_port_in(port, UART_IIR);
>  	serial_port_in(port, UART_MSR);
> -	if ((port->type == PORT_XR17V35X) || (port->type == PORT_XR17D15X))
> -		serial_port_in(port, UART_EXAR_INT0);
>  
>  	/*
>  	 * At this point, there's no way the LSR could still be 0xff;
> @@ -2297,8 +2290,6 @@ int serial8250_do_startup(struct uart_port *port)
>  	serial_port_in(port, UART_RX);
>  	serial_port_in(port, UART_IIR);
>  	serial_port_in(port, UART_MSR);
> -	if ((port->type == PORT_XR17V35X) || (port->type == PORT_XR17D15X))
> -		serial_port_in(port, UART_EXAR_INT0);
>  	up->lsr_saved_flags = 0;
>  	up->msr_saved_flags = 0;
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


