Return-Path: <linux-serial+bounces-4027-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0468BAE4E
	for <lists+linux-serial@lfdr.de>; Fri,  3 May 2024 15:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117B71C2183F
	for <lists+linux-serial@lfdr.de>; Fri,  3 May 2024 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B1B154444;
	Fri,  3 May 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JfmkKyfa"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0A154430
	for <linux-serial@vger.kernel.org>; Fri,  3 May 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744792; cv=none; b=LPubeoD6rwmjjk9tYTV/oy1ZurIGZRMln26lCCOG21Vz82ZM2/Ji7onBcOpwtXiF00IiUYbq8ACUIgQugjIQKZI8MYG86wWIRVaZoHQnfciDT30l/zmXU0tJbd7INzSd9dro7H+0u3s7dReAqXRrBpvylCwfnP0ubDy8Jz4scMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744792; c=relaxed/simple;
	bh=9XTu69i9//N23QjLUaRVeITayCFaVH/ZcxE8frlF8/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLeJN6QYBVCZ+5chP+Oz62A09nsAJalPdOp2jmL1SyKohwmWVrm7YjA8C5GK1eXt6uKWISb1tNS19CQsuwFeE9MkuwpRijup5BTr0i7zc8RxrOqERJfTOa+MQEtv205EWpcHvaahu2E/5jad0lau1t4A/sKJlbtDk6M4T+B7KK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JfmkKyfa; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de5a7b18acdso9077871276.3
        for <linux-serial@vger.kernel.org>; Fri, 03 May 2024 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714744789; x=1715349589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ChPcRq4NfZHnrwL48HNhQ7iFI35ROHq79DvxMeghd44=;
        b=JfmkKyfaJuYg5mwrmJMxqu7Eel+9ThNcdFDiYO9YqQ1kJBCkO3H/xMSHQSw6Wb9+Kg
         05UzQEys4dw00NIr/Mlwr65do+t23F6VYKLzsFS/JuEn1Nq19druVREWyfQp09GPIMMA
         9dU72hsdHzPZ+f02XFa0eSpBl8ubhCKk1gkfpXSjDeNsCYk/KzF6XmXKe4OlTCOEPTOa
         KKV4x6P8fJc/wYycb4EPANAjPXBDu0IsZQYPmZ25cc/Z3uHhYS4ZxjgqtdCA4FgiUNu3
         zmHbsv8vlZpOJ3WKrevk4/I56d3Xh3d7+zW2uVzY0KymQ8aXGh4i3907OzcyHwNGrNSW
         VvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744789; x=1715349589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChPcRq4NfZHnrwL48HNhQ7iFI35ROHq79DvxMeghd44=;
        b=rJux/mDMtM7mh1bW2XQMzte3dhILGapibcFcDVh+8HbnQTv7iMECDdRJkKRkWKQcga
         yjVSJ3bxxxD92oV5ZYLLafVdcFlgIM5PZS3MOohIwWi2QPYNshOZLrnv9ZDjxFv+jIIj
         P/aC1yqS9Z0OMtSBCUPfahrBauxfbWZ7tPiw1J5lDwSf7nqWCM8RzhA3BlaaDjIMEkYA
         p0QTV/RAaBG/dApjJ14Q4oxY1eEOogJKVWbNYPlrySWojwv9ehLr3eMNcT91yFN3gSBg
         TZyeT7DZly7+9Un2MX0JBWd8Kc8ywUBUPEW4S8HXOVDUUYOhyI/Mb7jkda717+NAeSMo
         6tDA==
X-Forwarded-Encrypted: i=1; AJvYcCUyxnQKLrZb7J9q8+0gTCl2rdHI829hJTsgF+tmxXgTCvtwKDJcf8/IShvGmdJUDHKoz6etVJ3Grs4NSvGLsUoHNyhbZ0vU6lhIam29
X-Gm-Message-State: AOJu0Yxa9BBHJLVmj7slInv2aQ8KZ42aZbvV1G+QMKtY/8+59T+0zxtP
	qoBnP0HRugeFlVAA852LFHvYab7d320NyUUCJre+ddYSnLE/KDzyf+0X478Goy4=
X-Google-Smtp-Source: AGHT+IFctvodowwbTmaaEDSmGBZj/O9adwDNYje40Gk9jTBEJueLXsMCVV/UKXpClCHAizcOHif2cQ==
X-Received: by 2002:a05:6902:246:b0:de5:e046:6ac with SMTP id k6-20020a056902024600b00de5e04606acmr2994231ybs.5.1714744789552;
        Fri, 03 May 2024 06:59:49 -0700 (PDT)
Received: from sunil-laptop ([106.51.191.139])
        by smtp.gmail.com with ESMTPSA id l14-20020a25bf8e000000b00de51b87bfefsm627782ybk.18.2024.05.03.06.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:59:48 -0700 (PDT)
Date: Fri, 3 May 2024 19:29:35 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 17/17] serial: 8250: Add 8250_acpi driver
Message-ID: <ZjTtx88zk4GvCImk@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-18-sunilvl@ventanamicro.com>
 <ZjNaR-YtVTm4pbP7@smile.fi.intel.com>
 <ZjNh0Llcx+0VHevy@sunil-laptop>
 <ZjNmdfR2J6hNnYle@smile.fi.intel.com>
 <ZjN3GQI3gegYOIgS@sunil-laptop>
 <ZjOy2G0qN5G076i0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjOy2G0qN5G076i0@smile.fi.intel.com>

On Thu, May 02, 2024 at 06:35:52PM +0300, Andy Shevchenko wrote:
> On Thu, May 02, 2024 at 04:50:57PM +0530, Sunil V L wrote:
> > On Thu, May 02, 2024 at 01:09:57PM +0300, Andy Shevchenko wrote:
> > > On Thu, May 02, 2024 at 03:20:08PM +0530, Sunil V L wrote:
> > > > On Thu, May 02, 2024 at 12:17:59PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > This driver is not a duplicate of 8250_pnp. It just relies on UART
> > > > enumerated as platform device instead of using PNP interfaces.
> > > > Isn't it better and simple to have an option to enumerate as platform
> > > > device instead of PNP? 
> > > 
> > > Ah, then extract platform driver first from 8250_core.c.
> > > 
> > Let me know if I understand your suggestion correctly. Do you mean call
> > something like serial8250_acpi_init() from serial8250_init() and
> > register the driver directly in serial8250_acpi_init()?
> 
> Extract the code to be 8250_platform.c and update that file.
> I have locally the extraction of RSA code, I will see if I can help you
> with the rest.
> 
Thanks!. That will be helpful. TBH, I don't understand what to do for
extracting the platform driver code. There are already several vendor
specific UART drivers (ex: 8250_fsl.c) which are enumerated as platform
devices. 8250_core.c looks cleanly supporting such drivers which can
register themselves with the core. For generic UART, DT has 8250_of.c
and ACPI has 8250_pnp.c. But 8250_pnp.c comes with baggage of PNP
contract. So, the driver in this patch is similar to vendor specific
drivers to support generic uart devices which are enumerated as platform
device. I can rename 8250_acpi.c to 8250_platform.c if that is better.

Could you please help with a patch even if not compiled so that I can
understand your suggestion better? 

Thanks for your help!
Sunil

