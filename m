Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A0F122D6D
	for <lists+linux-serial@lfdr.de>; Tue, 17 Dec 2019 14:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfLQNvj (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 17 Dec 2019 08:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfLQNvi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Dec 2019 08:51:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA00620716;
        Tue, 17 Dec 2019 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576590698;
        bh=Q7UqnpC27UH1gRfRYAQcz4JNHrgVn2RRkrbH5cdedog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVRVoSAwi3Ql+NgC7/lanHNTLz/qhwc8ijXAzQJzjpl5uwUQgd3dsUcKI9pORF9+n
         R3GYjiGFquoLTUbchwDHt4EmwAripNKl9MfvciqSMb/LwCEppVWRmhDWWyuROO3AQC
         IeYu4LLJjqtHK3o8G5fQ0dWSr72oFeHx6460qq6g=
Date:   Tue, 17 Dec 2019 14:51:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 03/58] serial_core: Un-ifdef sysrq SUPPORT_SYSRQ
Message-ID: <20191217135136.GA3425650@kroah.com>
References: <20191213000657.931618-1-dima@arista.com>
 <20191213000657.931618-4-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213000657.931618-4-dima@arista.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 13, 2019 at 12:06:02AM +0000, Dmitry Safonov wrote:
> The SUPPORT_SYSRQ is messy: every .c source should define it before
> including "serial_core.h" if sysrq is supported or struct uart_port will
> differ in sizes. Also this prevents moving to serial_core.c functions:
> uart_handle_sysrq_char(), uart_prepare_sysrq_char(),
> uart_unlock_and_check_sysrq().
> 
> It doesn't save many bytes in the structure, and a better way to reduce
> it's size would be making rs485 and iso7816 pointers.
> 
> Introduce `has_sysrq` member to be used by serial line drivers further.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/linux/serial_core.h | 77 +++++++++++++++++++++----------------
>  1 file changed, 43 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index bbbe57bf5163..5f761c399282 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -240,14 +240,13 @@ struct uart_port {
>  	resource_size_t		mapsize;
>  	struct device		*dev;			/* parent device */
>  
> -#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
>  	unsigned long		sysrq;			/* sysrq timeout */
>  	unsigned int		sysrq_ch;		/* char for sysrq */
> -#endif
> +	unsigned char		has_sysrq;
>  
>  	unsigned char		hub6;			/* this should be in the 8250 driver */
>  	unsigned char		suspended;
> -	unsigned char		unused[2];

Ugh, the samsung driver was using both of these fields to overload
things for it's own use :(

It's not your fault, I'll go fix up that driver first before applying
this one.

bah, what a horrid hack they did...

greg k-h
