Return-Path: <linux-serial+bounces-3179-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD56898332
	for <lists+linux-serial@lfdr.de>; Thu,  4 Apr 2024 10:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F161C21FAF
	for <lists+linux-serial@lfdr.de>; Thu,  4 Apr 2024 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5665FBBA;
	Thu,  4 Apr 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VGw7IpEx"
X-Original-To: linux-serial@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4611E86F;
	Thu,  4 Apr 2024 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219693; cv=none; b=J3JpLmlS9nDraqlBK7Yd4MFml/f/q8fOEf//zQgEX86ji6Gj0bkA7cdonCwU6Dehy7WVADPpKKbkQDj5wJHzqfbPE6mr+R4PyBN+Pf6jqzDsnfZTr3wdvZcLzbZf8K/mqBvY4OMLTfYFrJpxrPKBc7cdGfDRsvo0S1esCGc8rbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219693; c=relaxed/simple;
	bh=C5a9aG3Qw2Bw6k8igkXBLSfg5iCmR4TbbWe7aLkG3MU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0VvR70JntN6yZ4B8nGPMOWlYK/NJ7IWeiSWCQU/bSehW5T+641MWEubHYhpG33Hcv9Gv/iNl0SDQDqTLDiZSf45aKYv2wGUxzOmopS5NX77JFKFAO+sf+7eXICNRusTQ2ECjWWLW3hhmJekYL2GBGfEe/oLNUlOsjA27KZRnns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VGw7IpEx; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D678560010;
	Thu,  4 Apr 2024 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712219687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7oqIdUtVHuAqA326fh1aqDMQzLhpDYB2v27wCCOmDc=;
	b=VGw7IpExoX/8amBz6m8hIsK1TQiWwvogDSuLsrCe18UFehMdj7j/jHR7QLIX6oLyBaEudH
	7TrYpZxFzWatZ1bwNKw+3VnJ0wywWER4UlRR1SJmsau1TlAv1WSCukTWoaaADn+SqOanQX
	tJVYuT65vuWiIlVsILuitgmDjMMGM7E8KAEyQwna2xma6dK2kYMN8Es95EOcpk92Fit5sA
	XBLQKqqlhHzKXMDxYbxPk9XRWbugRfnp1DMKNEEOMWvYK0dmsgDVmkuZFIl6SLRYCgkfwd
	AbDzihXEicQwyqKNxSwoWrypk/dmBAhKRMXbVsufyEq/xggKBPm5BlYo0xItwA==
Date: Thu, 4 Apr 2024 10:34:46 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, christophercordahi@nanometrics.ca
Subject: Re: [PATCH 1/1] serial: 8250_of: Add clock_notifier
Message-ID: <20240404103446.2fd953a1@bootlin.com>
In-Reply-To: <20240404074450.42708-1-bastien.curutchet@bootlin.com>
References: <20240404074450.42708-1-bastien.curutchet@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Bastien,

On Thu,  4 Apr 2024 09:44:50 +0200
Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:

> The UART's input clock rate can change at runtime but this is not
> handled by the driver.
> 
> Add a clock_notifier callback that updates the divisors when the input
> clock is updated. The serial8250_update_uartclk() is used to do so.
> PRE_RATE_CHANGE and ABORT_RATE_CHANGE notifications are ignored, only
> the POST_RATE_CHANGE is used.
> 
> Reorder the #include to match alphabetic order.
> 
> It has been tested on a DAVINCI/OMAP-L138 processor.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
...
> +static int of_platform_serial_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
> +					      void *data)
> +{
> +	struct of_serial_info *info = clk_nb_to_info(nb);
> +	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
> +	struct clk_notifier_data *ndata = data;
> +
> +	if (IS_ERR(info->clk))
> +		return NOTIFY_DONE;

The info->clk pointer cannot contain an error code.
Can you double check that and remove the test if it is not needed?

Best regards,
Hervé

