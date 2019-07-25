Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A1374B05
	for <lists+linux-serial@lfdr.de>; Thu, 25 Jul 2019 12:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfGYKCc (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 25 Jul 2019 06:02:32 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49327 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727336AbfGYKCc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jul 2019 06:02:32 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6FF5E2207F;
        Thu, 25 Jul 2019 06:02:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 25 Jul 2019 06:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=79MNnWJBCKmXg4fbmhNSUXOBuM7
        +0XuWuu9CQMTun5g=; b=QDSa0X/zhmG9pXU8hjCThnNuEc1GfmFhSBY0hkRlVnS
        Z0XoLLuyp60K+KEZT/5wlT1l3EYXYiMRMWSPr40vxvYQzVP8nW54C2OW0a0/ELJm
        qBtAJE1qL1tYg84LAYn7ibyxvfIwh2FsQ5W+4cgDbnruL4dZxIZgSWnZegB9GOTz
        ngxDhwdMkXLll5vkVznXrUZVcy31FNrwwmF5ZX1gLhND4Yw40p6KTi9u0ekA1m7h
        lAcTK7fr4a5wbzMmoa9DHQVyRh6V0y4UBlpYAlpMJ7mGzESl5x+6eEJflTJj1pzS
        BNvTcRXDaBoM6sW8qew5HCHZJc4SQVHdrW9iXM6blZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=79MNnW
        JBCKmXg4fbmhNSUXOBuM7+0XuWuu9CQMTun5g=; b=dIJRKWTlL3hR27T3sTTjbJ
        dWS/jqA4nfoBQA+OTtqrnNQjULOcahAZIL7QJ6QIbEyq+J8r25J7So/xn1d/TlgL
        HGy3Cin2L6r8Tfkd81Yd1xslINOWtVMMZdgUJjfKgik/IVjhFD8bitgb0RHNu7Ds
        5v73SFkhOfypmxXwyh8E1HgxuPq8bYsHT2Yfm+jii/jCnmjRaS/MfecUkDprGJMH
        Z+5mlPZtj98x8BLWUHi8Hmm4P/MG+BKzRwDveA9Vmhbu69h5QbrINsTTQIa3NUqH
        1j9hex2pTkdPv64RSv5shzJsfA1YbBa/pyuv3mN7oiahqsZ3aBFfcptb4Vgzce6Q
        ==
X-ME-Sender: <xms:Nn45XVrtwCgW1U8gPOtg5UP3p2ofliJ3GOf-9lOnOb0NigoIJzHlUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkedvgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Nn45Xb7ggCvnEFJK2gnTFJEc-OaSSuzOIrs7fBhlURqWLYzdlrRUbQ>
    <xmx:Nn45XdNRnQTUeQsbDvayPQjE3C3lwngxPPfmhzUUYvJIaF0vejO1bQ>
    <xmx:Nn45XVNyAsYe-4EGMFkbW_vRsrLf4mmu8WoapU48-Heoe0Uq0jj4Sw>
    <xmx:N345XW2c8CkiKJ-dSReLZXiKXZ-gw46MiRyIp8HijyR4m6vQgDXgQw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 95285380085;
        Thu, 25 Jul 2019 06:02:30 -0400 (EDT)
Date:   Thu, 25 Jul 2019 12:02:29 +0200
From:   Greg KH <greg@kroah.com>
To:     Robert Middleton <robert.middleton@rm5248.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_exar: Clear buffer before shutdown
Message-ID: <20190725100229.GB20445@kroah.com>
References: <20190723143632.22427-1-robert.middleton@rm5248.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723143632.22427-1-robert.middleton@rm5248.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 23, 2019 at 10:36:32AM -0400, Robert Middleton wrote:
> When closing and shutting down the exar serial port, if the chip
> has not finished sending all of the data in its buffer, the
> remaining bytes will be lost.  Hold off on the shutdown until the
> bytes have all been sent.
> 
> Signed-off-by: Robert Middleton <robert.middleton@rm5248.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index edd6dfe055bf..f58eeb670b15 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -19,6 +19,7 @@
>  #include <linux/string.h>
>  #include <linux/tty.h>
>  #include <linux/8250_pci.h>
> +#include <linux/delay.h>
>  
>  #include <asm/byteorder.h>
>  
> @@ -457,6 +458,26 @@ static irqreturn_t exar_misc_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static void
> +exar_shutdown(struct uart_port *port)
> +{
> +	unsigned char lsr;
> +	bool tx_complete = 0;
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	struct circ_buf *xmit = &port->state->xmit;
> +
> +	do {
> +		lsr = serial_in(up, UART_LSR);
> +		if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
> +			tx_complete = 1;
> +		else
> +			tx_complete = 0;
> +		msleep(1);
> +	} while (!uart_circ_empty(xmit) && !tx_complete);

What if the hardware is locked up?  Will this sit and spin forever?
Shouldn't you also have a timeout for the flush?

thanks,

greg k-h
