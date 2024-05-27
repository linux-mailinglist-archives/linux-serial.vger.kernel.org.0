Return-Path: <linux-serial+bounces-4283-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9300B8CF88B
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2024 06:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215341F21F98
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2024 04:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C32184E;
	Mon, 27 May 2024 04:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dWKQEvs+"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C925322E
	for <linux-serial@vger.kernel.org>; Mon, 27 May 2024 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785542; cv=none; b=rReIOLTejshxeip0IOLfRDQynNogyiajQ5lVKCku750JJNQAmiFMqgnCbX0/Gj8f/Yp+zBZzcjSUVLuNahdVQ9fyahHbVBBawsDpvfvLqJfR8YfaDhFCxW+25Z7d8FLsR0hSgea4b9nQ514/jL6PLr0n/Nb5MZ38ON2vmvnGczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785542; c=relaxed/simple;
	bh=AMS5ARv3IfVq3Q8iY1GykVsvHQU5Z7iIP9RDyXjiVic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRiziyQJmXzYP3702uUMhbxyNLaB+Zdfpdc7BES1Eia4eamcxKJicscQcwjzRvKXStmTg1nNHgJXcMj+qvok5StJUhp+3RiJZqZWXPhuIL+luA948RATKoNj9HpbIoik5eXaHzpXKwj+r/UKNAtHuTfSDa8IuJl7LCUGSgTVxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dWKQEvs+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7010a7df499so521216b3a.0
        for <linux-serial@vger.kernel.org>; Sun, 26 May 2024 21:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716785541; x=1717390341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OwVnHZBL6wTRkCGzMu3WG8eEJumBpr030yY2OMz5XY=;
        b=dWKQEvs+MUTWbvLggpmH8Z1VlzQToXz6qDtzRkfM9GD7TN8aA5BcNyYw8jb0JW2+hp
         HZkmCiilUQjK98mkgOmC22CZS//ttmdsGnlmxzHzextBSN7o261fjlen6QgQ+dJ4191F
         KeKpwDSwcNQ1bG4gKwYP0tvvia0mcEwima8BMKeuPIeGNM9pG1TImkbVcMvfRc3HZTB/
         vh+ZYZIhfayqaeXoOiu314yDzDbex13irUdVMsrG3X5DL5Fbc0CbpgrIMrN+ewMB10uO
         4R/WV2IBms1XnS3iP+o5+vhBnanpl/y387LJ/yGE0ZbapvvNFyDayr+RB5I1RIcULxwh
         xr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716785541; x=1717390341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OwVnHZBL6wTRkCGzMu3WG8eEJumBpr030yY2OMz5XY=;
        b=OoC7W8ZQKAwEeBRXxiJwHdUWMnQ3oeZcRC76x3uAzA48VCEG41ESEkRMhaUM1rUQUw
         5CSFvJJ4LUX8fMAExHxwgkho30onRils+Xe0ke2NPGSIJ/nHLumYkYo7y3BFaUmVEAuO
         ERZ4Ck6fCV3tg+UjuYhqFDiUpmyiDBXdcz+EVBO9CxA/pZTBGcHTSStshnby8S6+WEan
         PgDyjbtpJjr92Vz/FYDWZEUVaazr1G1/q171iasOV8zKJgbNYcppjeuNF8rA4726a1mk
         UCooTF1Hf4DF+wDr+hSPq9GyGiCQ2GcncTfhDsD/ETImwcrhgj1kX4DsAgp/FYhN4K1P
         xuTg==
X-Forwarded-Encrypted: i=1; AJvYcCXOWomW8UmkmaIUl6M1PwUYpCo1gWyFtpSR4Q2AJJ5/ozjIZB3VTJ7/bPnipAnHaTuXQg5VNMSvgRGaZmTej8quByX2PfAyccrbXGSO
X-Gm-Message-State: AOJu0Yxc0cIIPPOo8Zk7y4TetQhI/7CihYzs/BVKFFIQ4xgF28P0aWlB
	5ky9gii6cqIncgXy9lHa8jAkBvdg6GgFfRPZXIU7jq5cSOgJ4soRpB5HhnbF34c=
X-Google-Smtp-Source: AGHT+IH1+6Rmi8dE36D+B+xJAB7lUPPIYa2o+TDUzseyC6rijf8D9sllaHoXY4NG8W+kwmTTtncYfQ==
X-Received: by 2002:a05:6a21:191:b0:1a9:d6e2:66e9 with SMTP id adf61e73a8af0-1b212d4aee2mr9906286637.28.1716785540658;
        Sun, 26 May 2024 21:52:20 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f483584be5sm19427935ad.258.2024.05.26.21.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 21:52:20 -0700 (PDT)
Date: Mon, 27 May 2024 10:22:08 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
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
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 14/17] irqchip/riscv-imsic: Add ACPI support
Message-ID: <ZlQReOytuJcMsXUW@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-15-sunilvl@ventanamicro.com>
 <871q5sfatm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q5sfatm.ffs@tglx>

On Fri, May 24, 2024 at 12:00:21AM +0200, Thomas Gleixner wrote:
> On Wed, May 01 2024 at 17:47, Sunil V L wrote:
> 
> > RISC-V IMSIC interrupt controller provides IPI and MSI support.
> > Currently, DT based drivers setup the IPI feature early during boot but
> > defer setting up the MSI functionality. However, in ACPI systems, ACPI,
> > both IPI and MSI features need to be initialized early itself.
> 
> Why?
> 
Sorry, commit message got truncated by mistake. Basically, in ACPI PCI
scan happens very early and there is no concept of msi-parent/dependency
on MSI controller like in DT. It just assumes MSI is setup already. Due
to this, we need to setup MSI controller early as well.

> > +
> > +#ifdef CONFIG_ACPI
> > +
> > +static struct fwnode_handle *imsic_acpi_fwnode;
> > +
> > +struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
> 
> Why is this function global? It's only used in the very same file and
> under the same CONFIG_ACPI #ifdef, no?
> 
For platform devices using MSIs, we need a way to determine the MSI
domain. This function is exported so that platform device like
APLIC/IOMMU can find the MSI irqdomain.

For PCI, pci_msi_register_fwnode_provider() is registered by the MSI
driver for this purpose.

Let me know if this can be made better.

> > +{
> > +	return imsic_acpi_fwnode;
> > +}
> > +
> > +static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
> > +					const unsigned long end)
> > +{
> > +	struct acpi_madt_imsic *imsic = (struct acpi_madt_imsic *)header;
> > +	int rc;
> > +
> > +	imsic_acpi_fwnode = irq_domain_alloc_named_fwnode("imsic");
> > +	if (!imsic_acpi_fwnode) {
> > +		pr_err("unable to allocate IMSIC FW node\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Setup IMSIC state */
> > +	rc = imsic_setup_state(imsic_acpi_fwnode, (void *)imsic);
> 
> Pointless (void *) cast.
> 
Okay.

> > +	if (rc) {
> > +		pr_err("%pfwP: failed to setup state (error %d)\n", imsic_acpi_fwnode, rc);
> > +		return rc;
> > +	}
> > +
> > +	/* Do early setup of IMSIC state and IPIs */
> > +	rc = imsic_early_probe(imsic_acpi_fwnode);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = imsic_platform_acpi_probe(imsic_acpi_fwnode);
> > +
> > +#ifdef CONFIG_PCI
> > +	if (!rc)
> > +		pci_msi_register_fwnode_provider(&imsic_acpi_get_fwnode);
> > +#endif
> > +
> > +	return rc;
> 
> Any error return in this function leaks the firmware node and probably
> some more stuff.
>
Yeah, fwnode needs free up and need to update the code a bit. Thanks!
 
> > +}
> > +
> > +IRQCHIP_ACPI_DECLARE(riscv_imsic, ACPI_MADT_TYPE_IMSIC, NULL,
> > +		     1, imsic_early_acpi_init);
> > +#endif
> 
> ...
> 
> > -	/* Find number of interrupt identities */
> > -	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
> > -				  &global->nr_ids);
> > -	if (rc) {
> > -		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
> > -		return rc;
> > +		/* Find number of guest interrupt identities */
> > +		rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
> > +					  &global->nr_guest_ids);
> > +		if (rc)
> > +			global->nr_guest_ids = global->nr_ids;
> > +	} else {
> > +		global->guest_index_bits = imsic->guest_index_bits;
> > +		global->hart_index_bits = imsic->hart_index_bits;
> > +		global->group_index_bits = imsic->group_index_bits;
> > +		global->group_index_shift = imsic->group_index_shift;
> > +		global->nr_ids = imsic->num_ids;
> > +		global->nr_guest_ids = imsic->num_guest_ids;
> >  	}
> 
> Seriously?
> 
> Why can't you just split out the existing DT code into a separate
> function in an initial patch which avoulds all of this unreviewable
> churn of making the DT stuff indented ?
> 
Sure, makes sense. let me create separate patch first as you suggested.

> > +#ifdef CONFIG_ACPI
> > +int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
> > +struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
> > +#else
> > +static inline struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> 
> Oh well.
> 
I guess this is related to your prior comment about the need to make
this public function. Let me know if I am missing something.

Thanks!
Sunil

