Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B629E486
	for <lists+linux-serial@lfdr.de>; Mon, 29 Apr 2019 16:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfD2OTS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 29 Apr 2019 10:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbfD2OTS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Apr 2019 10:19:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0112520673;
        Mon, 29 Apr 2019 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556547557;
        bh=zgnDjgXgwQhfBXfEQ4wZmUL2KxvT1MkJOQtIQPea4iQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wdw08b+JZ0ABU2EvqgOiGNtxVlzQkAF+7RmJNLkFW3Ku1VIZ1htD2UH9X1wqGatge
         Q/nVofDg/Ck0Lcc8vSLJKLLPNv5QWIcwFiXKAsk4KRfFV+sMkPm+QHi+PfeHdsA+UB
         FmIwmzHZZvpw8Jo8bovvxGQhGCgnhJyvAUYhV+C8=
Date:   Mon, 29 Apr 2019 16:19:15 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix TX interrupt handling condition
Message-ID: <20190429141915.GB12903@kroah.com>
References: <1556280367-28685-1-git-send-email-ext-kimmo.rautkoski@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556280367-28685-1-git-send-email-ext-kimmo.rautkoski@vaisala.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 26, 2019 at 12:06:13PM +0000, Rautkoski Kimmo EXT wrote:
> Interrupt handler checked THRE bit (transmitter holding register
> empty) in LSR to detect if TX fifo is empty.
> In case when there is only receive interrupts the TX handling
> got called because THRE bit in LSR is set when there is no
> transmission (FIFO empty). TX handling caused TX stop, which in
> RS-485 half-duplex mode actually resets receiver FIFO. This is not
> desired during reception because of possible data loss.
> 
> The fix is to use IIR instead of LSR to detect the TX fifo status.
> This ensures that TX handling is only called when there is really
> an interrupt for THRE and not when there is only RX interrupts.
> 
> Signed-off-by: Kimmo Rautkoski <ext-kimmo.rautkoski@vaisala.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index d2f3310..91ca0ca 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1875,7 +1875,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  			status = serial8250_rx_chars(up, status);
>  	}
>  	serial8250_modem_status(up);
> -	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE))
> +	if ((!up->dma || up->dma->tx_err) && (iir & UART_IIR_THRI))
>  		serial8250_tx_chars(up);

This feels wrong to me, can someone else test this to verify that it
really does work properly?  I don't have access to any 8250 devices at
the moment :(

thanks,

greg k-h
