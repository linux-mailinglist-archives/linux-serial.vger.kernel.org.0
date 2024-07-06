Return-Path: <linux-serial+bounces-4952-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0009293F8
	for <lists+linux-serial@lfdr.de>; Sat,  6 Jul 2024 16:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C382F1F227EC
	for <lists+linux-serial@lfdr.de>; Sat,  6 Jul 2024 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA0D12F5B1;
	Sat,  6 Jul 2024 14:05:30 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52473131E38;
	Sat,  6 Jul 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720274730; cv=none; b=FyWJOVzsQGcOTE5CrB/x6MycQMrY4mphh9f1JSb2zPpQjSe5hbvkh5EmqrQeXzP8MY8uql1YJ3dzb6vZ8DEYJdeV54xvB6ThPRWUdUYvaetXOHFT7v3adoqVws8HoIrknCuRZEHr9tV3n0+0WfQpSLaxD748SMm2zjbCleSGMr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720274730; c=relaxed/simple;
	bh=MSc8OTMQZrHOQM8n4bGSW9rNoDlLTQ/CsDbfWASvVmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8RUJQx5NKx+OnlkSBjwvuxSPyaa7ck1TpxDd5jTAcU9F+bevXloSWfCw93ZItp3xTOupMoakuT2tsBEnOJCVivIw6BaPPRLIuKWMCgFB3yw0g5CITAxG8AXFj3O+YgkBaavRIykpr8EAD+JjdVQcJgPz02Tgm9QGhGDZZ/CEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Sat, 6 Jul 2024 14:05:24 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] serial: 8250: don't lost port's default capabilities
Message-ID: <20240706140524.GYA4122589.dlan.gentoo>
References: <20240706082928.2238-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706082928.2238-1-jszhang@kernel.org>

Hi

On 16:29 Sat 06 Jul     , Jisheng Zhang wrote:
> Commit b0b8c84cf58d ("serial: of_serial: Handle auto-flow-control
> property") added support for fifo-size and hw-flow-control properties
> to avoid adding new types to 8250.c for UARTs that are compatible with
> the standard types but that have different size fifo or support 16750
> compatible auto flow control. We avoided many new 8250 port types with
> this nice feature, but there's a problem, if the code detects fifo-size
> or auto-flow-control property, up->capabilities will be set
> accordingly, then serial8250_set_defaults() will ignore the default
> port's capabilities:

> 
> |if (!up->capabilities)
> |	up->capabilities = uart_config[type].flags;
> 
so the previous old logic is trying to override the config of 'type' uart,
while this patch try to extend capabilities with default config of 'type' uart as base

I tend to agree this is right direction (but wasn't 100% sure..)

btw, Jisheng, can you also check serial8250_do_startup()? which has similar logic

> If the port's default capabilities contains other bits such as
> UART_CAP_SLEEP, UART_CAP_EFR and so on, they are lost.
> 
> Fixes: b0b8c84cf58d ("serial: of_serial: Handle auto-flow-control property")

I believe the commit just reveal the problem, make it more visible, but not the root cause,
'git blame' lead to b6830f6df8914f ("serial: 8250: Split base port operations from universal driver")
as the original commit introduce this logic which seems exist long time ago..


> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 893bc493f662..e20614241229 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3245,8 +3245,7 @@ void serial8250_set_defaults(struct uart_8250_port *up)
>  			up->port.fifosize = uart_config[type].fifo_size;
>  		if (!up->tx_loadsz)
>  			up->tx_loadsz = uart_config[type].tx_loadsz;
> -		if (!up->capabilities)
> -			up->capabilities = uart_config[type].flags;
> +		up->capabilities |= uart_config[type].flags;
>  	}
>  
>  	set_io_from_upio(port);
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

