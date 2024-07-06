Return-Path: <linux-serial+bounces-4951-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3826A9292A7
	for <lists+linux-serial@lfdr.de>; Sat,  6 Jul 2024 12:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4291F21F8E
	for <lists+linux-serial@lfdr.de>; Sat,  6 Jul 2024 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279955896;
	Sat,  6 Jul 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFDuRnHJ"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FC487B0;
	Sat,  6 Jul 2024 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720263257; cv=none; b=Yd9LGa1mEQ+pStGPeKEejwUQmqnJqxexPGcicgbPCKScsJdC7fS2BsiX8pmxjoN/YkPM+rJ1e6nOCwyfTvbaWaSdXxP/c1DFYy6DsmCqClHE2Su/Mfc+hxZUJ3ixdS8U61UjYM+hKbkacumISo0cCktbMOd+F/X9/rj/srz4eS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720263257; c=relaxed/simple;
	bh=Ttgueic0OcfhmSuHeW8NTeEojBfeKUJurNp/5wA3sm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4v8EheUT6Q1uNoEQW0vjtkLA+rrdnUgyhTrgeXfjX2cAoX3SndL6A1PMQbTSIRtugM8h/kfyg9PRjUgdZUjKBGXE+QS3FpRQQ5HjqCU7xBCrtRn443tkVZQTUr56C3ltjoqMjvzdmtEskgv6HA3jQqrSrQkAljpqsBY33E9d0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFDuRnHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC8AC2BD10;
	Sat,  6 Jul 2024 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720263256;
	bh=Ttgueic0OcfhmSuHeW8NTeEojBfeKUJurNp/5wA3sm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFDuRnHJFUMEvcoo0y7z2mRgH7o7pSkmt2D6KY0xZTnTBWPuVPmIlSUYtXfvGTquQ
	 7Pps6uBJLlAN+j96Juc26hu+baujQc9CZFNe7XALsKEmur8SU0dJTKOeeOhShl/P7+
	 Uuk88TrxDAN5bT7xKhifI/auM1qANEjUQyHeXuM5khPmGwJ+HNegwzK/bZb2GeWRTK
	 K8mnnEeyTMQeWzmYCnLr1dl035dxdpYdcMKv4jdNRb6OWrCnqHRtwQPstblx7omazZ
	 sEpkwrdqo/nW/C5tE43IVpTgVkqYm9e++v4Ds6GtMEn/1+8CbN/09NeZAzsG/hU95T
	 NMj5RmM9MjlLw==
Date: Sat, 6 Jul 2024 18:40:07 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Inochi Amaoto <inochiama@outlook.com>, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Meng Zhang <zhangmeng.kevin@spacemit.com>
Subject: Re: [PATCH v3 08/11] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <ZokfBzjvwN0IUQIX@xhacker>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-8-12f73b47461e@gentoo.org>
 <Zoanxksn0nio4MPg@xhacker>
 <20240705063839.GA3042186@ofsar>
 <ZojEEAdUwxPJwqIS@xhacker>
 <20240706050556.GA3590714@ofsar>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706050556.GA3590714@ofsar>

On Sat, Jul 06, 2024 at 05:05:56AM +0000, Yixun Lan wrote:
> 
> On 12:12 Sat 06 Jul     , Jisheng Zhang wrote:
> > On Fri, Jul 05, 2024 at 06:38:39AM +0000, Yixun Lan wrote:
> > > 
> > > On 21:46 Thu 04 Jul     , Jisheng Zhang wrote:
> > > > On Wed, Jul 03, 2024 at 02:55:11PM +0000, Yixun Lan wrote:
> > > > > From: Yangyu Chen <cyy@cyyself.name>
> > > > > 
> > > > > Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> > > > > 
> > > > > Key features:
> > > > > - 4 cores per cluster, 2 clusters on chip
> > > > > - UART IP is Intel XScale UART
> > > > > 
> > > > > Some key considerations:
> > > > > - ISA string is inferred from vendor documentation[2]
> > > > > - Cluster topology is inferred from datasheet[1] and L2 in vendor dts[3]
> > > > > - No coherent DMA on this board
> > > > >     Inferred by taking vendor ethernet and MMC drivers to the mainline
> > > > >     kernel. Without dma-noncoherent in soc node, the driver fails.
> > > > > - No cache nodes now
> > > > >     The parameters from vendor dts are likely to be wrong. It has 512
> > > > >     sets for a 32KiB L1 Cache. In this case, each set is 64B in size.
> > > > >     When the size of the cache line is 64B, it is a directly mapped
> > > > >     cache rather than a set-associative cache, the latter is commonly
> > > > >     used. Thus, I didn't use the parameters from vendor dts.
> > > > > 
> > > > > Currently only support booting into console with only uart, other
> > > > > features will be added soon later.
> > > > > 
> > > > > Link: https://docs.banana-pi.org/en/BPI-F3/SpacemiT_K1_datasheet [1]
> > > > > Link: https://developer.spacemit.com/#/documentation?token=BWbGwbx7liGW21kq9lucSA6Vnpb [2]
> > > > > Link: https://gitee.com/bianbu-linux/linux-6.1/blob/bl-v1.0.y/arch/riscv/boot/dts/spacemit/k1-x.dtsi [3]
> > > > > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > > > > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > > > > ---
> > > > >  arch/riscv/boot/dts/spacemit/k1.dtsi | 376 +++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 376 insertions(+)
> > > > > 
> > > > > diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > > > > new file mode 100644
> > > > > index 0000000000000..a076e35855a2e
> > > > > --- /dev/null
> > > > > +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > > > > @@ -0,0 +1,376 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > > > > +/*
> > > > > + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> > > > > + */
> > > > > +
> > > > > +/dts-v1/;
> > > > > +/ {
> > > > > +	#address-cells = <2>;
> > > > > +	#size-cells = <2>;
> > > > > +	model = "SpacemiT K1";
> > > > > +	compatible = "spacemit,k1";
> > > > > +
> > > > > +
...
> > > > > +	soc {
> > > > > +		compatible = "simple-bus";
> > > > > +		interrupt-parent = <&plic>;
> > > > > +		#address-cells = <2>;
> > > > > +		#size-cells = <2>;
> > > > > +		dma-noncoherent;
> > > > > +		ranges;
> > > > > +
> > > > > +		uart0: serial@d4017000 {
> > > > > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > > > 
> > > > no, this is not a correct hw modeling. The doc on spacemit says
> > > > all the uart support 64 bytes FIFO, declaring xscale only makes
> > > > use of 32 bytes FIFO.
> > > yes, I also noticed it's 64 bytes FIFO
> > > 
> > > > 
> > > > IIRC, 8250_pxa is a xscale uart with 64 bytes FIFO, so this should be
> > > > "mrvl,pxa-uart" or "mrvl,mmp-uart"
> > > 
> > > 
> > > for mrvl,pxa-uart, I think you imply to use drivers/tty/serial/8250/8250_pxa.c,
> > > which turn out doesn't work on k1 SoC, for the record, we need to adjust
> > 
> > Really? I just tried "mrvl,pxa-uart" with rc6, it works perfectly, and the FIFO
> > in the driver logic is 64bytes now. Am I misssing something or you never tried it?
> > 
> Ok, I realised it's the clock issue
> 
> still, I'm not fully convinced about using "mrvl,pxa-uart",
> e.g this driver hardcoded tz_loadsz to 32, not sure if K1 suffer same problem
> 5208e7ced520 ("serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level")

I believe the problem commit 5208e7ced520 tries to solve is: the
mmp|pxa-uart only support threshold up to 32Bytes, tz_loadsz will be
fifo size by default, this will cause probleme with 64Bytes FIFO.

> 
> also, what's the preference when choosing driver between 8250_pxa.c vs 8250_of.c?

Good question. I have no preference. But there are two problems with
8250_of, I have sent out patches[1][2] to address them.

After these two patches, both the earlycon and uart FIFO logic work too
with below dts properties:
		uart0: serial@d4017000 {
			compatible = "mrvl,mmp-uart";
			...
                        reg-shift = <2>;
                        reg-io-width = <4>;
                        tx-threshold = <32>;
                        fifo-size = <64>;
                        no-loopback-test;
			...
		}

Link: https://lore.kernel.org/linux-riscv/20240706082928.2238-1-jszhang@kernel.org/ [1]
Link: https://lore.kernel.org/linux-riscv/20240706101856.3077-1-jszhang@kernel.org/ [2]

> it occur to me that 8250_pxa.c is more specially tailored for pxa hardware, while
> 8250_of.c is more generic.. besides, should we consider one more step if we want to

there's a work around for Erratum #74 in 8250_pxa, while I believe the
Errata doesn't exisit in K1, so from this PoV it seems 8250_of is
better, no?

> support DMA mode in the future (vendor uart driver has DMA support)?

Adding dma engine support to 8250_of is doable.

> 
> 
> > >  drivers/tty/serial/8250/Kconfig to enable the driver for ARCH_SPACEMIT,
> > >  and change uart compatible to "spacemit,k1-uart", "mrvl,pxa-uart"
> > > 
> > > for mrvl,mmp-uart, I see two choices, one using 8250_pxa.c which has same result
> > > as mrvl,pxa-uart, another choice would using the driver of 8250_of.c 
> > > and it work as same as "intel,xscale-uart", I don't see any difference..
> > > 
> > > P.S: there is possibly a side problem that "mrvl,mmp-uart" from 8250_of.c doesn't 
> > > really compatile with "mrvl,mmp-uart" from 8250_pxa.c, but I think it's another story
> 
> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55

