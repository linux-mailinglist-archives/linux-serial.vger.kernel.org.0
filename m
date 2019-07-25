Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 039A674B01
	for <lists+linux-serial@lfdr.de>; Thu, 25 Jul 2019 12:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfGYKBi (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 25 Jul 2019 06:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfGYKBi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jul 2019 06:01:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C32BA218D3;
        Thu, 25 Jul 2019 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564048897;
        bh=ShdPEC6xTkiuBHmGB2uT3zgwgaLI0C3Qbx5tcZE4W3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zrPdZf13pK5+2i4LN9eq6Ny5WYenEzik1iibzsSp2CcuMriLkxBUvEST6OkVnYcPu
         of2Lqm9SJFXebW5mRsO8dVQLiQ45sy+w7jlGeqZXBo521syfmc7Eq97P3UKaHDQy7N
         Mz2XXoAeUAFATQUCzoH/OaKRUd4uAsG+ME7tYBk0=
Date:   Thu, 25 Jul 2019 12:01:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Robert Middleton <robert.middleton@rm5248.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Issue with XR17V35X
Message-ID: <20190725100134.GA20445@kroah.com>
References: <CAKpcJVav5-_VdakmPYatZ5iZa38=_wN-gd4yhsx0Pfo+zR+2-Q@mail.gmail.com>
 <CAKpcJVb+59BEb6++O=h0_t0z8hDs+zSwHO5-TNDZgrX-YX2SUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKpcJVb+59BEb6++O=h0_t0z8hDs+zSwHO5-TNDZgrX-YX2SUg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 28, 2019 at 10:33:39AM -0400, Robert Middleton wrote:
> Hi,
> 
> I have fixed the problem for my use-case with the following patch to
> not clear the FIFOs if there is still data to be transmitted:
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index d2f3310abe54..569a76d1b00a 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2441,7 +2441,10 @@ void serial8250_do_shutdown(struct uart_port *port)
>       */
>      serial_port_out(port, UART_LCR,
>              serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
> -    serial8250_clear_fifos(up);
> +    if (serial_in(up, UART_LSR) & UART_LSR_TEMT){
> +        /* Check if transmitter is empty before clearing FIFOs */
> +        serial8250_clear_fifos(up);
> +    }
> 
>  #ifdef CONFIG_SERIAL_8250_RSA
>      /*
> 
> I'm not sure if this is correct/the best way to do it, since I am not
> sure if this is common to all drivers under 8250 or only for the Exar
> chip.  I can also provide a proper patch via e-mail if that makes
> sense.

A proper patch makes the most sense please.

thanks,

greg k-h
