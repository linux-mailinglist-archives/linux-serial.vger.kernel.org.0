Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132D3232216
	for <lists+linux-serial@lfdr.de>; Wed, 29 Jul 2020 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2QDn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 29 Jul 2020 12:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2QDn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Jul 2020 12:03:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215F8206D8;
        Wed, 29 Jul 2020 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596038622;
        bh=VZUYphEQUTYK+8UogBIYPgtkqViD/D0Xw8dBmHZUB3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H63B0KKsLXRaZEMqJMzY3dz4ZH/fCmTxVfzOf5H0WnP/kkqDO8WFZEFch22BlY253
         2JOo6UlC6YiU79+fj9gs1z0cW6CBjRc1SEipPmRMbC8QyCPeglNLdm2HJ9urPQG1ZI
         4cLj/0a3oNrIMMFnesuG4XvoT7r/466u4S2AnmOI=
Date:   Wed, 29 Jul 2020 18:03:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>,
        "bhuvanchandra.dv@toradex.com" <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH v2] tty: serial: fsl_lpuart.c: prevent a bad shift
 operation
Message-ID: <20200729160333.GA3652767@kroah.com>
References: <20200721174228.misj2mgqzcfz2lsj@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721174228.misj2mgqzcfz2lsj@pesu.pes.edu>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 21, 2020 at 11:12:29PM +0530, B K Karthik wrote:
> prevent a bad shift operation by verifying that
> the argument to fls is non zero.
> 
> Reported-by: "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> ---
> v1 -> v2:
> 	added Reported-by tag
> 
>  drivers/tty/serial/fsl_lpuart.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 7ca642249224..0cc64279cd2d 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1168,7 +1168,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  	 * 10ms at any baud rate.
>  	 */
>  	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
> -	sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
> +	if (sport->rx_dma_rng_buf_len != 0)

How can this variable become 0?

thanks,

greg k-h
