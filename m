Return-Path: <linux-serial+bounces-11341-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B77ECC26321
	for <lists+linux-serial@lfdr.de>; Fri, 31 Oct 2025 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB2D404C37
	for <lists+linux-serial@lfdr.de>; Fri, 31 Oct 2025 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C4621ADCB;
	Fri, 31 Oct 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jfpYzVSn"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F51E520A;
	Fri, 31 Oct 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928297; cv=none; b=RRFaGRu35KH9SiU5NykX+Rz67SPvnPojMsK3KSJTMiiHig+P+gt62zToxKBQan2+p5YSnoQb08n7x9snlBHnCGOrFMzlNHP+YBk+4k29mtBMN3bj3JZ0TZAnQd5EatbJSkUC9nhL4WYqNOUVCOjamqsUDzkX4VFUaDVwAa0Z00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928297; c=relaxed/simple;
	bh=zW829c3pZwV8tsnXSpZcuT+PeSyI9qJf7eQP02+ZFXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhRUd00RTyE3igU8RD/Rt3FpxJtIgucxit862ikCD8thYkrZWTQGjU9+MSlyqCrLO+X+9Gq7lDAqqUIzrKJ/5wo6+L+q66QlU5xN9P0qy253A+pX95J7Km7y9YbsFRPLJBgmlZ/ya4RAhHmA3EKHly4tpUE5ZUNQaSxmLmsvMBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jfpYzVSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D00C4CEE7;
	Fri, 31 Oct 2025 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761928296;
	bh=zW829c3pZwV8tsnXSpZcuT+PeSyI9qJf7eQP02+ZFXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfpYzVSnpBx2JIf4UZTkGylOO01LoGMr6kaTAtbxyIQgB6kMrogWmJUEZAQU3xtHT
	 TKh5uHJD2YFuaPRMk74ktnoi6CgWWjaEAe/WJHkrg6YvtmW0XSz4sdEDN2e3vjmPcj
	 KIa2c3vPKJTYTg+Ztr7NhjBRmU4WmJG969TZX0Gg=
Date: Fri, 31 Oct 2025 17:31:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: jirislaby@kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: ma35d1: Fix resource leaks on driver removal
Message-ID: <2025103115-humped-body-d522@gregkh>
References: <20251029080039.1010-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029080039.1010-1-vulab@iscas.ac.cn>

On Wed, Oct 29, 2025 at 04:00:39PM +0800, Haotian Zhang wrote:
> The driver fails to release resources acquired during probe. It calls
> of_clk_get() to obtain the clock reference but never calls clk_put()
> in the remove path, leaking the clock reference count. Similarly, it
> calls ioremap() to map UART registers but never calls iounmap() during
> removal, leaking the I/O memory mapping.
> 
> Switch to devm_clk_get() for automatic clock resource management and
> add iounmap() call in ma35d1serial_remove() to properly release the
> memory mapping.
> 
> Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/tty/serial/ma35d1_serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
> index 285b0fe41a86..37e9f6166290 100644
> --- a/drivers/tty/serial/ma35d1_serial.c
> +++ b/drivers/tty/serial/ma35d1_serial.c
> @@ -711,7 +711,7 @@ static int ma35d1serial_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&up->port.lock);
>  
> -	up->clk = of_clk_get(pdev->dev.of_node, 0);
> +	up->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(up->clk)) {
>  		ret = PTR_ERR(up->clk);
>  		dev_err(&pdev->dev, "failed to get core clk: %d\n", ret);
> @@ -762,6 +762,7 @@ static void ma35d1serial_remove(struct platform_device *dev)
>  
>  	uart_remove_one_port(&ma35d1serial_reg, port);
>  	clk_disable_unprepare(up->clk);
> +	iounmap(up->port.membase);

You are doing two different things in this patch, shouldn't this be 2
different commits?

thanks,

greg k-h

