Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60152483D1
	for <lists+linux-serial@lfdr.de>; Tue, 18 Aug 2020 13:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHRLbL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 18 Aug 2020 07:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgHRLa6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 07:30:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46ABC20706;
        Tue, 18 Aug 2020 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597750257;
        bh=5TYn0yuZSINSZm4y7PjY+futrVE0KH4lxc5vWIGUn0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMEOoZ8cL4mfjOgtSaKRT86CC+LYDyr1suXSLuOXJQezm7CRHa2kfEhrrs0CR4iMu
         QXf291zph2xqyFCiOyI/hscGC8M9Mhmb7MRcrC72GkxE4BP4GZ1y0Dq5gKZ72FMBif
         0gwsIojSbfIU8KUejzloiR/GYDTJBWoWZLgMEzfw=
Date:   Tue, 18 Aug 2020 13:31:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250: Explicitly show we initialise ISA
 ports only once
Message-ID: <20200818113121.GA314369@kroah.com>
References: <20200731123733.22754-1-andriy.shevchenko@linux.intel.com>
 <20200731123733.22754-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731123733.22754-2-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 31, 2020 at 03:37:33PM +0300, Andy Shevchenko wrote:
> serial8250_isa_init_ports() uses home grown approach to make itself
> a singleton. Instead, explicitly show that we initialise ISA ports
> once by providing a helper function which calls the original function
> via DO_ONCE() macro.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index cae61d1ebec5..9c0d6693f745 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -22,6 +22,7 @@
>  #include <linux/console.h>
>  #include <linux/sysrq.h>
>  #include <linux/delay.h>
> +#include <linux/once.h>
>  #include <linux/platform_device.h>
>  #include <linux/tty.h>
>  #include <linux/ratelimit.h>
> @@ -495,13 +496,8 @@ static inline void serial8250_apply_quirks(struct uart_8250_port *up)
>  static void __init serial8250_isa_init_ports(void)
>  {
>  	struct uart_8250_port *up;
> -	static int first = 1;
>  	int i, irqflag = 0;
>  
> -	if (!first)
> -		return;
> -	first = 0;
> -
>  	if (nr_uarts > UART_NR)
>  		nr_uarts = UART_NR;
>  
> @@ -555,6 +551,11 @@ static void __init serial8250_isa_init_ports(void)
>  	}
>  }
>  
> +static void __init serial8250_isa_init_ports_once(void)
> +{
> +	DO_ONCE(serial8250_isa_init_ports);

DO_ONCE() is there for fast-path code, where the code is then patched
out of the kernel after it is run.  That's not the case here and is not
needed, please just do this "normally".

thanks,

greg k-h
