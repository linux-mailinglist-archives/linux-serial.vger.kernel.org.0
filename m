Return-Path: <linux-serial+bounces-3948-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE05F8B9834
	for <lists+linux-serial@lfdr.de>; Thu,  2 May 2024 11:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FA3B215BF
	for <lists+linux-serial@lfdr.de>; Thu,  2 May 2024 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E8C44374;
	Thu,  2 May 2024 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="R5TBtt59"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477B5644E
	for <linux-serial@vger.kernel.org>; Thu,  2 May 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643801; cv=none; b=F8LF+9By8G4nRygCchnNcKXbPxHYCo7vExLOJy1woER9nWG0VEYHZczzUYT/D5YEHnSgGe3cNkfnQi3sMI5fR/ANryVOe/eZ+/EsOzBwunJuOKgAqHmI4KcdnS/91IRm+eM3Sb0TOrYwCzXjsF7PJJp1dthmHb49Fb42NccN9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643801; c=relaxed/simple;
	bh=3l3zV1CvMpPQ6M3agjT4bErcSYjrF9CaWcpEI3wJ9GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCnT6sXfmNbseH34qupx1/olSMDB9eQJUtxfgPbDxm5OzlomozXuRwCxeLEFmqHqFeEHQ/blo4QcM1JqN59kzkICIzZklFxk81jqnROqcy+BaRDs81V9xJHSIw+ZPSXAmImI7rYBnmyz61vYwlCN8qeA7CTtMKDXsuxfEPmdFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=R5TBtt59; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6effe9c852eso6837813b3a.3
        for <linux-serial@vger.kernel.org>; Thu, 02 May 2024 02:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714643800; x=1715248600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sucCdO5kXmwHz0FAAtAAGExlkRhEC3HqOy4Cv/qw8KI=;
        b=R5TBtt59vRw7pDNWPRdtnfrGzClC8OtQpN13oIl6mLbBGMWFqAhCgjMJ77PVbuTvdK
         w76Sq5hiI2T6WsreDf4rWfkHBD5ekHGzRUAuuKldv+z9sSBPcUWUkS6lxI3E11+Kz5gx
         8TPx0FK8znm3jozKmGlvT3OEr40HlR1WZ6nC9NafGgEwr4qvWEQs+Q56/Zi7X7HW4Xp/
         cEhnVJ4XtgJSpYnDJ3aIieLt6bYy+QAlpkvO5opoA/0pS+FqUOJ9XvXpsS898BH0yRsx
         Y3+GCMzFw2feSDRYNRSL6Daa8xbWWBIVz43B3hZs6+vvvWnlLjNFsfP7TGH5Pg/k3+qa
         oWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643800; x=1715248600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sucCdO5kXmwHz0FAAtAAGExlkRhEC3HqOy4Cv/qw8KI=;
        b=wtPIIEr63y2BVj1DSq9Ue6JGl6wseBuP7P4wy0YpUlMxh6XCY3Edidx0T/+rW7OBuY
         BsikdlM79koCurIaXTnS0bEr6g1rvOEej4y5IjAwmfem5pDTiZXhVO/g1ZzyiBTXcwIE
         FK0gSsqMPwwv83lckAFwvbWjrHM6nDKtuv4J3/UQeZU3JUQE4Van57oIowxb3nMla22l
         ACevK5SGfLJiNxxu3BkhlRti9Rajreo8lbgUGC64dYl2ELbcrGZ5x7lzaMgOiA7z9JYO
         zeCC8H1KrzgWCLuRMjQO5Y5uZvTS6Vz5Qy6NLnWM2YsBVZksrYGVNybp7SNhAFKc3cGW
         uz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUISruuewC58AsIjFKDXWVfileu42p32pySwiYAjF5ipGBcPqndeIZi6HgFFYLAWzIxtFkOzzubKH1VIjnqg8DjxO9cx1EjPU5I47HO
X-Gm-Message-State: AOJu0Yz9Ila78LMbrYvIDaNjdA8VWvRcphcXnEH/ToOIOHJhks2VN4V8
	SCIcugEamdjXpRHteHRIHT5lfNQBbn3cLUovBrUM4CX6i19zkSFontZIGS/Mvtw=
X-Google-Smtp-Source: AGHT+IEdqN4j0tZUjqkf7AiQCf6AILBV0FVoUPT7pSiU8sVSt1YtTCq7aHm3fUhXEYUOJZhfGVfIwA==
X-Received: by 2002:a05:6a20:7f86:b0:1a7:5402:8a92 with SMTP id d6-20020a056a207f8600b001a754028a92mr1702915pzj.31.1714643799826;
        Thu, 02 May 2024 02:56:39 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id lf12-20020a170902fb4c00b001eb53dcf458sm864846plb.188.2024.05.02.02.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:56:39 -0700 (PDT)
Date: Thu, 2 May 2024 15:26:26 +0530
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
Subject: Re: [PATCH v5 01/17] arm64: PCI: Migrate ACPI related functions to
 pci-acpi.c
Message-ID: <ZjNjSpJus7EYT6zn@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-2-sunilvl@ventanamicro.com>
 <ZjNbVPYIjINdk4Fn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNbVPYIjINdk4Fn@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:22:28PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 05:47:26PM +0530, Sunil V L wrote:
> > The functions defined in arm64 for ACPI support are required
> > for RISC-V also. To avoid duplication, move these functions
> > to common location.
> 
> ...
> 
> There are -M -C parameters to git format-patch. Use them in the next version of
> the series. (Note, you may add percentage numbers to each of those parameters
> to get prettier result.)
> 
Yeah, I tried different combination of percentage after you told me last
time. I just didn't see any difference in the patch generated. Let me
try again while sending next version. Thanks!


