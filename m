Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C40F4B6ED
	for <lists+linux-serial@lfdr.de>; Wed, 19 Jun 2019 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfFSLU6 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 19 Jun 2019 07:20:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:16932 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfFSLU6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Jun 2019 07:20:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 04:20:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="160347079"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jun 2019 04:20:53 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hdYe4-0004ST-QK; Wed, 19 Jun 2019 14:20:52 +0300
Date:   Wed, 19 Jun 2019 14:20:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Oliver Barta <o.barta89@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH] Revert "serial: 8250: Don't service RX FIFO if
 interrupts are disabled"
Message-ID: <20190619112052.GD9224@smile.fi.intel.com>
References: <20190619081639.325-1-o.barta89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619081639.325-1-o.barta89@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 19, 2019 at 10:16:39AM +0200, Oliver Barta wrote:
> This reverts commit 2e9fe539108320820016f78ca7704a7342788380.
> 
> Reading LSR unconditionally but processing the error flags only if
> UART_IIR_RDI bit was set before in IIR may lead to a loss of transmission
> error information on UARTs where the transmission error flags are cleared
> by a read of LSR. Information are lost in case an error is detected right
> before the read of LSR while processing e.g. an UART_IIR_THRI interrupt.
> 

Perhaps Fixes tag?

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Oliver Barta <o.barta89@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index d2f3310abe54..682300713be4 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1869,8 +1869,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  
>  	status = serial_port_in(port, UART_LSR);
>  
> -	if (status & (UART_LSR_DR | UART_LSR_BI) &&
> -	    iir & UART_IIR_RDI) {
> +	if (status & (UART_LSR_DR | UART_LSR_BI)) {
>  		if (!up->dma || handle_rx_dma(up, iir))
>  			status = serial8250_rx_chars(up, status);
>  	}
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


