Return-Path: <linux-serial+bounces-6208-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F57C97B4FF
	for <lists+linux-serial@lfdr.de>; Tue, 17 Sep 2024 23:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D03B223CE
	for <lists+linux-serial@lfdr.de>; Tue, 17 Sep 2024 21:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A2B18BC12;
	Tue, 17 Sep 2024 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsbDwsQM"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8D17A591;
	Tue, 17 Sep 2024 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726607282; cv=none; b=Ej9L496Q1YJQvmL2PORmDorKLW8IJBl1k9SbzRE/fSZgDslf62iMtKktoaRXI94x8kycToOR4rG6Rzh2P+BAyNLI8iXu7vQKRB0Y7TYxyiVCuLZAMmyDJhKm8AI+hLfewVf4g2lUjY16hibz3jFe1LULTCJ4dPE9VihATyQbK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726607282; c=relaxed/simple;
	bh=Xw3qFVde4mW/vVW5R3FHyrkUkN6HRIPohqAfP8ki1cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpm86PngAXCsRvCTexiLdvOakvuHASqkzb0hdL1skBcejwsaKLpP+UxMtP5tEol0pksW4cu9HbFi84ZhsjGe0jV12g8m7WeWsrb3OzlIpS4Lbrl9fMSamKq2qurFbAWJuTgHKJMkG6gf3XEkB9Kwvvaoui17QvxZ6IXW2QKY0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsbDwsQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7AFC4CEC5;
	Tue, 17 Sep 2024 21:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726607282;
	bh=Xw3qFVde4mW/vVW5R3FHyrkUkN6HRIPohqAfP8ki1cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsbDwsQMzYP89sJ1xwuAWKIoRn8xBwDKXeZc2aPQxof68aoPY2YRumZdSdWdEc+Ho
	 bENcFwj9e2++zZDEjW5+MefLdrq9A7siRX0dYBhKXcollwOX8h6rvTqCIXASx6zlsT
	 eCQ3DnxsA7D4JgP+zlUg/XWpEUZE5HuM3eHqwTIE18TbkNf/zdkqH0lyNQ8JS7MGIV
	 EgDUjZhWlOBVSDbinAUrSP8yB/jDA1sZsLgrJiZ9hgOf0Uzueilgi8rybxwdvawVL1
	 3wNiEVxcHWM7tZ2bhrPRO9GHpav6z2H5S8wcRzE9aDScHsr16Jy/xFTrrl3bulziAm
	 K4nxuAfu/2ZlQ==
Date: Tue, 17 Sep 2024 22:08:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
	aou@eecs.berkeley.edu, cyy@cyyself.name, daniel.lezcano@linaro.org,
	tglx@linutronix.de, samuel.holland@sifive.com, anup@brainfault.org,
	Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
	lkundrak@v3.sk, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, jesse@rivosinc.com,
	jszhang@kernel.org, inochiama@outlook.com, uwu@icenowy.me,
	zhangmeng.kevin@spacemit.com, kevin.z.m@hotmail.com,
	Conor Dooley <conor.dooley@microchip.com>, matthias.bgg@kernel.org
Subject: Re: [PATCH v5 00/10] riscv: add initial support for SpacemiT K1
Message-ID: <20240917-spoilage-nimble-a8303fd04482@squawk>
References: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
 <mhng-5bc45db9-5deb-4db6-8733-561768b2968c@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v4bulkuQot7/4uA1"
Content-Disposition: inline
In-Reply-To: <mhng-5bc45db9-5deb-4db6-8733-561768b2968c@palmer-ri-x1c9>


--v4bulkuQot7/4uA1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 06:04:29AM -0700, Palmer Dabbelt wrote:
> On Mon, 29 Jul 2024 17:28:03 PDT (-0700), dlan@gentoo.org wrote:
> > SpacemiT K1 is an ideal chip for some new extension such as RISC-V Vect=
or
> > 1.0 and Zicond evaluation now. Add initial support for it to allow more
> > people to participate in building drivers to mainline for it.
> >=20
> > This kernel has been tested upon Banana Pi BPI-F3 board on vendor U-Boot
> > bootflow generated by Armbian SDK[1] and patched OpenSBI[2] to enable
> > Zicboz, which does not in the vendor dts on its U-Boot. Then successful=
ly
> > booted to busybox on initrd with this log[3].
> >=20
> > As previous discussion in patch v1[4], maintainer expect more basic dri=
vers
> > ready before really merging it, which would be fine. For other follow-u=
p patches,
> > that are clk, pinctrl/gpio, reset.. My current goal would target at a h=
eadless
> > system including SD card, emmc, and ethernet.
>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> if you guys want to take this through some SOC tree.  I'm not really sure
> what the bar is for SOC support to get merged, but I'd be happy to just s=
ee
> this booting at all -- we've got a bunch of them floating around and the
> vendor kernels are pretty crusty, so anything's an improvement on my end.

I've asked for clock and ideally pinctrl support before merging it. We
had a conversation about the usefulness etc of some of the initial
devicetrees merged for some platforms a few months back, that lead to me
not merging the k230 support I had queued up. I know this isn't exactly
a "fair" barrier to entry, as it is likely that platforms supported by
hobbyists are going to be more affected than companies that usually come
with that basic level, but have to draw a line somewhere.
Both clock and pinctrl are currently in progress for the k1, hopefully
wont take too much longer before this is mergeable.

In other news, nobody has really made an "official" statement about who
is going to maintain this particular platform. People have expressed
interest (including the submitter of the series, IIRC) but there's no
MAINTAINERS entry added here AFAICT. I used to have an entry that
covered arch/riscv/boot/dts/*, with exclusions for sunxi and renesas,
but with Drew taking on thead and sophgo being the res=E3=81=BDonsibility of
Chen Wang and Inochi, I no longer have that wildcard.

I'm happy to apply patches for the platform if noone else is interested
in that side of things, provided there are willing reviewers, but I
would much rather that someone else took up the responsibility of
applying patches and sending PRs - and of course I am happy to help
whoever that is with the process.

Cheers,
Conor.

--v4bulkuQot7/4uA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZunvrwAKCRB4tDGHoIJi
0vJfAQCKzg29et4gyyvvDvcq+H0Lr+9pUp0MuhQz0BQ1+12qRAD/ZabDnCrlmXdm
mcstHKWqUcb70WAc/TNCUbS+pCiwsgo=
=JYI3
-----END PGP SIGNATURE-----

--v4bulkuQot7/4uA1--

