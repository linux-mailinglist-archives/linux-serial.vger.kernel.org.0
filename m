Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917723BA1F
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2019 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfFJQ47 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Jun 2019 12:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbfFJQ47 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jun 2019 12:56:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 080BC2085A;
        Mon, 10 Jun 2019 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560185818;
        bh=Ku45DsFsSW6Nx4/T3Iaod9jAGJ7GfFk1QsaBQp7GquY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSysJpT+ReitGRznERDODZvymLSPUCPXShKWUjpDXAhp7AJfKaRip+OUGHAhV0KYW
         X9mxI1YJNi7oqEd9y/IH3VhHXCxXz5XpSgif5keZ81Rs60+9nrkm2Hq5sSc59aN/8G
         On66EdAj//oWbh91mdv9MJ3kEFqAX2OzqrFFkEkM=
Date:   Mon, 10 Jun 2019 18:56:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: Fix an invalid comparing statement
Message-ID: <20190610165655.GA397@kroah.com>
References: <1558933288-30023-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558933288-30023-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 27, 2019 at 02:01:27PM +0900, Sugaya Taichi wrote:
> Drop the if-statement which refers to 8th bit field of u8 variable.
> The bit field is no longer used.
> 
> Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  drivers/tty/serial/milbeaut_usio.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
> index 949ab7e..d7207ab 100644
> --- a/drivers/tty/serial/milbeaut_usio.c
> +++ b/drivers/tty/serial/milbeaut_usio.c
> @@ -56,7 +56,6 @@
>  #define MLB_USIO_SSR_FRE		BIT(4)
>  #define MLB_USIO_SSR_PE			BIT(5)
>  #define MLB_USIO_SSR_REC		BIT(7)
> -#define MLB_USIO_SSR_BRK		BIT(8)
>  #define MLB_USIO_FCR_FE1		BIT(0)
>  #define MLB_USIO_FCR_FE2		BIT(1)
>  #define MLB_USIO_FCR_FCL1		BIT(2)
> @@ -180,18 +179,14 @@ static void mlb_usio_rx_chars(struct uart_port *port)
>  		if (status & MLB_USIO_SSR_ORE)
>  			port->icount.overrun++;
>  		status &= port->read_status_mask;
> -		if (status & MLB_USIO_SSR_BRK) {
> -			flag = TTY_BREAK;
> +		if (status & MLB_USIO_SSR_PE) {
> +			flag = TTY_PARITY;
>  			ch = 0;
>  		} else
> -			if (status & MLB_USIO_SSR_PE) {
> -				flag = TTY_PARITY;
> +			if (status & MLB_USIO_SSR_FRE) {
> +				flag = TTY_FRAME;
>  				ch = 0;
> -			} else
> -				if (status & MLB_USIO_SSR_FRE) {
> -					flag = TTY_FRAME;
> -					ch = 0;
> -				}
> +			}
>  		if (flag)
>  			uart_insert_char(port, status, MLB_USIO_SSR_ORE,
>  					 ch, flag);

While the code never actually supported Break, you are explicitly
removing that logic now.  So shouldn't you instead _fix_ break handling?
The code before and after your change does not work any differently, so
this patch isn't really needed at this point.

thanks,

greg k-h
