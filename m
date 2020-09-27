Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2E27A0CC
	for <lists+linux-serial@lfdr.de>; Sun, 27 Sep 2020 14:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgI0MQq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 27 Sep 2020 08:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgI0MQq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Sep 2020 08:16:46 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FFB23718;
        Sun, 27 Sep 2020 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601209006;
        bh=pcY7ffGH6/XQibD7s4qp+XLjL/keifcPMq/Qb6HxOBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYPi7+5vTXXrQJ4/NtfJR5/XpBML5EVeEN6kg6T6whB8882VMJ7qTZxug/CBCUNXa
         6pj8Qzx/lDnjou+kw3aITTw9bmBPqWgNFXU+74IKSaw5HzvByArsRZ60j3KRB7qEFm
         OaDfffgnQGO3r+RysAWNxoAahsbCQLYIGoJIz6uw=
Date:   Sun, 27 Sep 2020 14:16:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     drolevar@gmail.com
Cc:     linux-serial@vger.kernel.org, Andrij Abyzov <aabyzov@slb.com>
Subject: Re: [PATCH 1/1] serial: 8250: Fix TX interrupt handling condition in
 8250_fsl.c
Message-ID: <20200927121656.GC164938@kroah.com>
References: <20200921084313.1536884-1-aabyzov@slb.com>
 <20200921084313.1536884-2-aabyzov@slb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921084313.1536884-2-aabyzov@slb.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 21, 2020 at 10:43:13AM +0200, drolevar@gmail.com wrote:
> From: Andrij Abyzov <aabyzov@slb.com>
> 
> This is a port of the commit
> db1b5bc047b3cadaedab3826bba82c3d9e023c4b ("Fix TX interrupt handling condition")
> to the FSL-specifific interrupt handling routine.

See the kernel documentation file "submitting patches" for how to
reference commits within changelogs.  This paragraph should look
something like:

	This is the port of the commit db1b5bc047b3 ("serial: 8250: Fix TX
	interrupt handling condition") to the 8250_fsl irq handling logic.

Right?

> Interrupt handler checked THRE bit (transmitter holding register
> empty) in LSR to detect if TX fifo is empty.
> In case when there is only receive interrupts the TX handling
> got called because THRE bit in LSR is set when there is no
> transmission (FIFO empty). TX handling caused TX stop, which in
> RS-485 half-duplex mode actually resets receiver FIFO. This is not
> desired during reception because of possible data loss.
> 
> The fix is to check if THRI is set in IER in addition of the TX
> fifo status. THRI in IER is set when TX is started and cleared
> when TX is stopped.
> This ensures that TX handling is only called when there is really
> transmission on going and an interrupt for THRE and not when there
> are only RX interrupts.
> 
> Signed-off-by: Andrij Abyzov <aabyzov@slb.com>
> ---
>  drivers/tty/serial/8250/8250_fsl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
> index 0d0c80905c58..ceac6cfce4c7 100644
> --- a/drivers/tty/serial/8250/8250_fsl.c
> +++ b/drivers/tty/serial/8250/8250_fsl.c
> @@ -71,7 +71,7 @@ int fsl8250_handle_irq(struct uart_port *port)
>  
>  	serial8250_modem_status(up);
>  
> -	if (lsr & UART_LSR_THRE)
> +	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
>  		serial8250_tx_chars(up);

Does this fix up a bug that has always been there, or was caused by a
specific kernel change?  If a specific one, please list that on the
Fixes: line.

Can you fix this up and resend?

thanks,

greg k-h
