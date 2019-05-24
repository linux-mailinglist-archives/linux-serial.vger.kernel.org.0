Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D329215
	for <lists+linux-serial@lfdr.de>; Fri, 24 May 2019 09:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbfEXHxP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 24 May 2019 03:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbfEXHxO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 May 2019 03:53:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9457E20879;
        Fri, 24 May 2019 07:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558684394;
        bh=bq39WhyJUkIgsQrEq4BkGItbSRm4gFXsWKEMnLvH240=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7fkNsHSUZ1JpCAy8Ijg4EvTqt1EJW1IS8GILRsE8DGAJwzsjrQ8aL0++tiuDyelV
         FwWJJ+uic0PwCeynAbN6IG3FuehXg5S+/TnIViXupcKK9BhCQiinvFNsBwuXsuCoPw
         wAqjuVCXuE9Nds73g+tY4qN15UiceM6SA/b/VhI8=
Date:   Fri, 24 May 2019 09:53:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-serial@vger.kernel.org, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCHv2 1/2] serial: uartps: Move the spinlock after the read
 of the tx empty
Message-ID: <20190524075311.GC13559@kroah.com>
References: <1558436726-32097-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558436726-32097-1-git-send-email-shubhrajyoti.datta@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 21, 2019 at 04:35:26PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Currently we are doing a read of the status register.
> Move the spinlock after that as the reads need not be spinlock
> protected.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> 
>  drivers/tty/serial/xilinx_uartps.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 75e1027..8850790 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -690,8 +690,6 @@ static void cdns_uart_set_termios(struct uart_port *port,
>  	unsigned long flags;
>  	unsigned int ctrl_reg, mode_reg;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> -
>  	/* Wait for the transmit FIFO to empty before making changes */
>  	if (!(readl(port->membase + CDNS_UART_CR) &
>  				CDNS_UART_CR_TX_DIS)) {
> @@ -700,6 +698,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
>  			cpu_relax();
>  		}
>  	}
> +	spin_lock_irqsave(&port->lock, flags);

This is a bigger fix than you imply here, you should not be trying to
sleep with a spinlock held, which is what the current code does, right?

Please update the changelog to show what commit this fixes so it can be
properly backported to the needed stable kernels.

thanks,

greg k-h
