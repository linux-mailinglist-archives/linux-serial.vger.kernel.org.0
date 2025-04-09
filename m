Return-Path: <linux-serial+bounces-8805-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24EAA824FF
	for <lists+linux-serial@lfdr.de>; Wed,  9 Apr 2025 14:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEB3172F03
	for <lists+linux-serial@lfdr.de>; Wed,  9 Apr 2025 12:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15DC25DCE9;
	Wed,  9 Apr 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1gEqkhQ"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6FE2561CC
	for <linux-serial@vger.kernel.org>; Wed,  9 Apr 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202204; cv=none; b=Hd5vwP3YwWEytI5gk8YmLtgLxW3AV826jvkbaMywgYwwIvmeJ7IdhVoXvn0eyMVaTVr0uFWHpwCuRGBhViBhlHu7OSNN3t4wYj8ekzNiTWsxveX6aHchAI6psctUuiLWHk1cmSCsLob4sIGbWwLC9oG66pUioPn4+g+mObYymhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202204; c=relaxed/simple;
	bh=pCcQnsh8CRxpv5xHp1wrSTOStnKxLEg4YyQW1LbBAlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtIgHnVj2UvN9r8mKy41stuTJBMbWMy3Ms1tZrN+KCmdjE5iHrdVqQchUkPY/RlB3EDfvALbE786FJf6w/3di3VHAd7hDleGw7Ph0QeuN7HF+XQE8LiWuikKaQBI60b+2OSc/za0dFSJFecCWeRdNqjerDNZZDMTqrBbQk5+pH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n1gEqkhQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f0c8448f99so9804970a12.1
        for <linux-serial@vger.kernel.org>; Wed, 09 Apr 2025 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744202201; x=1744807001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QH7veB4JfW1Wles/JBHNgdIkw9ORpNInhsceujqVsTs=;
        b=n1gEqkhQi7XM/04q79n2aM4jKTrzu0XaHTUaarT8ZZArWln5aOd8F1PXqVIei/hYbW
         mB23eTe7Q4+n0HRC7lTKikJR3x8XghGcTsgjqRKRNXTWRb8ob5nf3tIfcpsUFJ4HLal1
         fZ6WMeCsgJePHnRQugr26IrBYBUJ4V5K5vqVYw2JYQ7bvy4V5kw8nj4J/87kFY4eMzlE
         BYRFXiNgLUhvhUt145i+bqsDvfa0ky27fEW9xQ7oQfZA7pRQGXvRk6+qjaHmZNbT/byv
         tJuzpEKVZnVdze88aOKSVLj2pmMz/aemn02hw8C/2mtd7muUSnGMNyY5zh4V1kD9CHLh
         QcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744202201; x=1744807001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QH7veB4JfW1Wles/JBHNgdIkw9ORpNInhsceujqVsTs=;
        b=EJnEiM3vSYD3wNJBIFhdxe99sgH8LBFK3PPl6C+fFLlYJYEsbjh0aCuPEOmXttztqw
         yJlZWpCJSHuuAlt78NwXea06egFmB93GogeKeOL6qZ2KpqZAzszkdw0KzY+sM6p0VtVE
         j165stE060s7BFJzgdd/wpaUFiGOC8yalu6nCGwnrq4pkr31SvwWpp2STuztZzNgDBEu
         jjQRhbRjK7xDo8WYYTm0xpjSfwSTdxwnanJf35SyUk0DxaJARL7o4h+FnIS8LBwOcFc/
         vxXxku+vmuBCPwFBB0Iwp8KxmkoOAe2Skp1fKol7t14q+icJkjfCSZ00h4q8Yfu5XTtt
         IAPA==
X-Forwarded-Encrypted: i=1; AJvYcCWKN3neTc2AY1e5d9MqkKtxKi3IFdx/bu6lX/eTCbXazndrB4tSBvA6u/CnTT0L7G5zYMakQD9X2Pv7bxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzomqAPhEoqpx7amD+k4mAsUcAaYBehrV1QjFwtUZjSkeuTCsrX
	9AxHiKT3AgOTWQ3vvujdJCHCAnmxaJ2aSTvS2GzFHRBxDypxmmC5S38mgJFu+Y0=
X-Gm-Gg: ASbGncviTfMO/QlBmfzEEVqw8RrKIIgmQTkT+/wdHak09//7WZKwS0+qrIYkxTz0lPo
	5af3FtSbHe0O6Gwx+ffDOoh2cQraSKYqgw00a76Nxw6lObxZNYCmoCKFRLxaz3f+q/WMt8iAmo5
	6cW9g0Y+JMpN/Mzey2O+Aj4EdslgJ45WLT538kfBPoR9rReeKCUQURnystNHmhw47UF4jxADgXi
	Vny9PxjiYt2X/uNAKQAM4qE97JQhViSP57p3wRtmTrLce3w8WDPlLcd4UQowW5UW4J2m46GdQjJ
	mbu0LXEeVf5R/3w4BYPQ3N81h8Y7/VVF0IVj1biT4WeUwRABdKE=
X-Google-Smtp-Source: AGHT+IElIPi4StbNu1fXcOUzTMwgB5987RBpnEzg2VNy/DLgYGEJx5pDeTwmq7vbIqpvHrwBZzfZ+w==
X-Received: by 2002:a17:907:1c1a:b0:ac3:9587:f2ac with SMTP id a640c23a62f3a-aca9d644d3bmr191195666b.33.1744202201219;
        Wed, 09 Apr 2025 05:36:41 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:9738:960c:8c08:7b2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3167sm90726666b.21.2025.04.09.05.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:36:40 -0700 (PDT)
Date: Wed, 9 Apr 2025 14:36:35 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Sam Day <me@samcday.com>,
	Chandana Kishori Chiluveru <cchiluve@qti.qualcomm.com>
Subject: Re: [PATCH] serial: msm: Configure correct working mode before
 starting earlycon
Message-ID: <Z_Zp0yCXrYM9zG83@linaro.org>
References: <20250408-msm-serial-earlycon-v1-1-429080127530@linaro.org>
 <058f8b9c-55db-4735-bf61-b1e0f3d05953@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <058f8b9c-55db-4735-bf61-b1e0f3d05953@quicinc.com>

On Wed, Apr 09, 2025 at 03:30:02PM +0530, Mukesh Kumar Savaliya wrote:
> On 4/8/2025 10:52 PM, Stephan Gerhold wrote:
> > The MSM UART DM controller supports different working modes, e.g. DMA or
> > the "single-character mode", where all reads/writes operate on a single
> > character rather than 4 chars (32-bit) at once. When using earlycon,
> > __msm_console_write() always writes 4 characters at a time, but we don't
> > know which mode the bootloader was using and we don't set the mode either.
> > 
> Looks surprising. I haven't seen pre-kernel UART console ever works in DMA
> mode. It was always fixed to work in FIFO/PIO mode. From what i know.

I'm sure you're right, since it doesn't really make sense to implement
DMA mode for the UART console in earlier firmware or the bootloader.

DMA is just the side note here though. As I wrote in the patch
description, the real problem this patch fixes is the "single-character
mode". This is still FIFO/PIO mode, except that the register will
take/return just a single character rather than 4 chars at once.

This mode is used by firmware on some platforms and I'm planning to make
use of this mode in U-Boot to fix some edge cases. It's much more simple
to implement reliably for something minimal like U-Boot. With that
change in U-Boot, I get the garbled output shown below in the earlycon
serial console. This patch fixes it.

> > This causes garbled output if the bootloader was using the single-character
> > mode, because only every 4th character appears in the serial console, e.g.
> > 
> >    "[ 00oni pi  000xf0[ 00i s 5rm9(l)l s 1  1 SPMTA 7:C 5[ 00A ade k d[
> >     00ano:ameoi .Q1B[ 00ac _idaM00080oo'"
> > 
> > If the bootloader was using the DMA ("DM") mode, output would likely fail
> > entirely. Later, when the full serial driver probes, the port is
> > re-initialized and output works as expected.
> > 
> AFAIR, console UART was always configured in FIFO/PIO mode. For non Console
> application e.g. Bluetooth it works in DMA mode.

I think console UART in msm_serial does use DMA at least for receiving
at the moment, since we don't differentiate between "console" or
"non-console" use case in the upstream driver (as far as I can tell).
My patch doesn't change anything about this though, it just ensures the
UART controller is in the expected mode before starting earlycon.

Thanks,
Stephan

