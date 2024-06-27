Return-Path: <linux-serial+bounces-4780-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8696591AB9B
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2024 17:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317D01F212C5
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2024 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8858B1991A4;
	Thu, 27 Jun 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVx9fyYP"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605021990C8;
	Thu, 27 Jun 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502787; cv=none; b=EOtAnlsmNuWiEXNu6T7H2uYr+lMOSOvny14wAX+5qtotn5NPlNOW6LWmfBS7HdEXBmYNkgkgFemqA3E/vfGbvEzV98DyRunb1kpFbKJFhpR+V5kRlsWtzwxKbe8Q6TsPVV71xKcc77phX3+j1clhKP8ju/vrJgnuxBK/BhecZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502787; c=relaxed/simple;
	bh=Ywx8pgA49G69DV3dqyJz6NtRDDw0b8MnCogTK2pHYOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr0PXOtSOVtCkGFfSoL2Fi6LzeRotaUBOdBaePmPvMPzB0sdx6DPFIE4UTvwwjQMRN2BjYIDbVV81TIAGhKA8YCJJ+nglQog792u3iCx2i6tL7DNm+SgiF2xxK8R546KA26fcRlqxRjOJ6/xDWWY+IdobU4xutWrrC077tfXEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVx9fyYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35CDC2BBFC;
	Thu, 27 Jun 2024 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719502786;
	bh=Ywx8pgA49G69DV3dqyJz6NtRDDw0b8MnCogTK2pHYOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QVx9fyYPbM6G44pHTfQyI5umZjBKQU707w9S1MdX8L73Q8lJcDUB1/l7i7JuigntQ
	 V7AaHYrk0TscJQninZ6TloyAmYwVdEvIt9YlnucjFmmUzlc4+lpLR/HhfLB5iuOz85
	 KjqjRq1+ZXxJChF3GSoqahnjhGHlmooNhyFc7e4vVS2Ph7/lnmEOgc0FgIRmJwZX05
	 cliOI60EaO8105GJDjWgR8wMDycYwiYVNhp+jwhJO288xuQGHFjSfiDLhNxy29B4yL
	 Pp1k+Djq+JO81hntJo13fZkPMk/h1h2zUDZSiM59jOWC3cBZPxAdBI2YN+QGodHD+C
	 CWcs7RXdZ0ghA==
Date: Thu, 27 Jun 2024 16:39:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH v2 00/10] riscv: add initial support for SpacemiT K1
Message-ID: <20240627-flinch-rented-1f2a2e5d73ca@spud>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B/g3FF/HUcTA5w9b"
Content-Disposition: inline
In-Reply-To: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>


--B/g3FF/HUcTA5w9b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 03:31:14PM +0000, Yixun Lan wrote:
> SpacemiT K1 is an ideal chip for some new extension such as RISC-V Vector
> 1.0 and Zicond evaluation now. Add initial support for it to allow more
> people to participate in building drivers to mainline for it.
>=20
> This kernel has been tested upon Banana Pi BPI-F3 board on vendor U-Boot
> bootflow generated by Armbian SDK[1] and patched OpenSBI[2] to enable
> Zicboz, which does not in the vendor dts on its U-Boot. Then successfully
> booted to busybox on initrd with this log[3].
>=20
> As previous discussion in patch v1[4], maintainer expect more basic drive=
rs
> ready before really merging it, which would be fine. For other follow-up =
patches,=20
> that are clk, pinctrl/gpio, reset.. My current goal would target at a hea=
dless
> system including SD card, emmc, and ethernet.
>=20
> P.S: talked to Yangyu, I will help and take care of this patch series, th=
anks
> ---
> Changes in v2:
>  - fix timebase-frequency according to current setting
>  - add other uart dt nodes, fix input frequency
>  - introduce new uart compatible for K1 SoC
>  - add 'k1' prefix to bananapi-f3.dts
>  - fix k1-clint compatible
>  - fix some typos
>  - Link to v1: https://lore.kernel.org/r/tencent_BC64B7B1876F5D10479BD191=
12F73F262505@qq.com

I will take a closer look at this series later, but there's a few
patches here missing Acks that I gave alongside some nitpick remarks.
Could you look at v1 again and add those to whatever other comments I
leave when I take a closer look?

Thanks,
Conor.

--B/g3FF/HUcTA5w9b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn2HvAAKCRB4tDGHoIJi
0tlKAP9lICc0h2PXA8woQQ1/YJesp1lYcTXaG9wmSbBAioDPdwEAjAML4ZKw+0ho
TiRw0/v5b6+QjdIR1CH3r6zIy7etrg8=
=/Fdc
-----END PGP SIGNATURE-----

--B/g3FF/HUcTA5w9b--

