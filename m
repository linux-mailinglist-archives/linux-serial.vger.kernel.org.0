Return-Path: <linux-serial+bounces-2081-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027538495A0
	for <lists+linux-serial@lfdr.de>; Mon,  5 Feb 2024 09:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5026B24161
	for <lists+linux-serial@lfdr.de>; Mon,  5 Feb 2024 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95DD111AE;
	Mon,  5 Feb 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lZIeGFiM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rUa6xTgD"
X-Original-To: linux-serial@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE04811706;
	Mon,  5 Feb 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122836; cv=none; b=D9GFhdXwelfey2UuvzxAx7y/pn8BKQComBDFhsfYzTsIIWenUlcplWrnii9AmCbZwmin16vVChn8O2GvLrVhsTDQ4lBIEBNCoeQXENArVm0AZ9BzgTBbEgs7UQNeOVdf1a3xGorNhOWp/hlvc6cE0wVhswyBEIpbJhAbQsy3MTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122836; c=relaxed/simple;
	bh=KT1fuA8XIq4nEmCmoI5quq3KD/4nVJP7FnXjcu/kpvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uJwLIJYtoZFPW6JxBcHovxr3VD0UtrgE1beCpRCKGiNJK71N14HcBGzP0LrTz0M4+PrNuzXv3IjLXmWVoUuuurdh1P+y6yHsS2tclC93M2IJVFSBLd4FjfOUBlBK08jb2Bp9DPoiRI9RnAuFFMOB69OjV1304SpDySE0p+Ege1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lZIeGFiM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rUa6xTgD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707122833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wFpPSZx8wWDEmYm5qNrc593xG9WuuKadKajRxKukaTA=;
	b=lZIeGFiM+WMQ7vdzk7uwOhmP/2AtEWPBgGrcZQN/HlG8WkuK0ufsH1a0oXTD5/dV4aOI8z
	66WNLp2cHS1OKuRwu73Hx7QKc+hWHHqqzhNLfTDtiBPaDIC+g3vRMdSLbePVGX7f85GCJU
	F8WOmM2sCIRPAoAzsArffMd3zsrDkl+W9dbZA6M4lS7vtKjnFNE/Dve+mQAxpiDGIKUWSu
	4ShoK6+gPCg5vC4ryx39IFedknZ1L/NtodPo3E+55HS1ATvsV6aktjpdPJKNNF689we2l3
	KjYrghb8Q2IAZNdB80Yc7tGgMIirSyQRG9WyFATJVsJ2dZRpB3ibRUyyk3VvAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707122833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wFpPSZx8wWDEmYm5qNrc593xG9WuuKadKajRxKukaTA=;
	b=rUa6xTgD+PCm8udppbCC+3dwx4h16HTMaAmXjclpeXlNN4npD+ERex9Z9thZRi6RaC7ytg
	GvltlAlHqgwXKlCw==
To: Yicong Yang <yangyicong@huawei.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
 yangyicong@hisilicon.com, linuxarm@huawei.com, prime.zeng@hisilicon.com,
 jonathan.cameron@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH] serial: port: Don't suspend if the port is still busy
In-Reply-To: <20240204031957.58176-1-yangyicong@huawei.com>
References: <20240204031957.58176-1-yangyicong@huawei.com>
Date: Mon, 05 Feb 2024 09:53:05 +0106
Message-ID: <878r3zpaba.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-04, Yicong Yang <yangyicong@huawei.com> wrote:
> diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
> index 88975a4df306..60d1eec6b6b7 100644
> --- a/drivers/tty/serial/serial_port.c
> +++ b/drivers/tty/serial/serial_port.c
> @@ -46,8 +46,28 @@ static int serial_port_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int serial_port_runtime_suspend(struct device *dev)
> +{
> +	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
> +	struct uart_port *port;
> +	unsigned long flags;
> +
> +	port = port_dev->port;
> +
> +	if (port->flags & UPF_DEAD)
> +		return 0;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	if (__serial_port_busy(port))
> +		pm_request_resume(dev);
> +	spin_unlock_irqrestore(&port->lock, flags);

Please use the wrapper functions for the uart port lock:

uart_port_lock_irqsave()
uart_port_unlock_irqrestore()

John Ogness

