Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B7F29214
	for <lists+linux-serial@lfdr.de>; Fri, 24 May 2019 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbfEXHwP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 24 May 2019 03:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbfEXHwP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 May 2019 03:52:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B8B2217F9;
        Fri, 24 May 2019 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558684334;
        bh=cgNe78Opw1PC/TWjq1Qcg/+lEYOE92NeKya+UKvK0Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kV6x6o3eVy7aOtkhb6KZwC1vo+vXibY86uarXACuNFY1ktjmzWB43YbIfySnGoBem
         QV0vYQX4zaXd765MqOXlZEIWl1Hn9XhFM4lDoPV8VPc7LGVFtD2qUlZp8RegU2FEGG
         lGIlW/m2iSqzAww3gfIDitnF9bvlYPsbmlVedQdM=
Date:   Fri, 24 May 2019 09:52:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-serial@vger.kernel.org, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCHv2 2/2] serial: uartps: Add a timeout to the tx empty wait
Message-ID: <20190524075211.GB13559@kroah.com>
References: <1558436618-26194-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558436618-26194-1-git-send-email-shubhrajyoti.datta@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 21, 2019 at 04:33:38PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> In case the cable is not connected then the target gets into
> a infinite wait for tx empty.
> Add a timeout to the tx empty wait.
> 
> Reported-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 8850790..dc86511 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -26,12 +26,14 @@
>  #include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/iopoll.h>
>  
>  #define CDNS_UART_TTY_NAME	"ttyPS"
>  #define CDNS_UART_NAME		"xuartps"
>  #define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
>  #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
>  #define CDNS_UART_REGISTER_SPACE	0x1000
> +#define TX_TIMEOUT		500000
>  
>  /* Rx Trigger level */
>  static int rx_trigger_level = 56;
> @@ -688,14 +690,18 @@ static void cdns_uart_set_termios(struct uart_port *port,
>  	unsigned int cval = 0;
>  	unsigned int baud, minbaud, maxbaud;
>  	unsigned long flags;
> -	unsigned int ctrl_reg, mode_reg;
> +	unsigned int ctrl_reg, mode_reg, val;
> +	int err;
>  
>  	/* Wait for the transmit FIFO to empty before making changes */
>  	if (!(readl(port->membase + CDNS_UART_CR) &
>  				CDNS_UART_CR_TX_DIS)) {
> -		while (!(readl(port->membase + CDNS_UART_SR) &
> -				CDNS_UART_SR_TXEMPTY)) {
> -			cpu_relax();
> +		err = readl_poll_timeout(port->membase + CDNS_UART_SR,
> +					 val, (val & CDNS_UART_SR_TXEMPTY),
> +					 1000, TX_TIMEOUT);
> +		if (err) {
> +			dev_info(port->dev, "timed out waiting for tx empty");
> +			return;

Also, shouldn't this be an error?  Why not tell the caller something
went wrong?

thanks,

greg k-h
