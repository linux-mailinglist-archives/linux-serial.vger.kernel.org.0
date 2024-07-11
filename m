Return-Path: <linux-serial+bounces-5002-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D097E92EC4E
	for <lists+linux-serial@lfdr.de>; Thu, 11 Jul 2024 18:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD61B24EBA
	for <lists+linux-serial@lfdr.de>; Thu, 11 Jul 2024 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E45516D313;
	Thu, 11 Jul 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3/bYjJg"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1DE16D307;
	Thu, 11 Jul 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714128; cv=none; b=me14POl0GD7MXlRyFEv/z0pIGVW8C3eNZRqUd0LHR8fe6TLWJC3XbwYRXZRNFYEaV8qCcJifkthQn3hEA/1oJrs0/U0+MX74O5GVqeD8wu3FSjmtW0AaiZsaRCSIyBchb2FnpBPm2FJ+JbKt0C6zdsArwRX6iLUrCGRGZF3DO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714128; c=relaxed/simple;
	bh=dArFzUR62pjSDR9oi4NDee62Jbu4M80ZlukA3ud/HGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuXbTcZGKs1tKqtBICtWGY+sTEF+gds8loJclZXwzLU810DHDbTI5GakT8aXmRI5/9ak7uX3ihiFxx/0YpOr8838TdqH0VagHv3Zl+zcvNU7ygGH0YnSgqHHPqw/3+rumH9sP7ypw7lF1jno1snwUWXiT5cj6g1O6tCRLp9Gmos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3/bYjJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C810CC32786;
	Thu, 11 Jul 2024 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720714127;
	bh=dArFzUR62pjSDR9oi4NDee62Jbu4M80ZlukA3ud/HGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3/bYjJg8XrRRFZG4jagVHinO0jvF/xbwEHRbT+2yY4CWE87TDAJsJPbYz5HNdZOy
	 DS3Rct7Y0KOEvuCpeMMEAFKopRpAqf36oYGIKlLWee+vTXkbPea64LNAa9IPTru1C0
	 jBRNWB0TpyFD5ads4B0ATRVghEhFlZ1n9td1recL8zT7LSFlOpo4Ib+J+beaC9hN1u
	 DRMnZ/0AfwlsA5toyp/BYS52ehT2zLRByxCtWXUST5G08ZABsY5TLsCb9GBAqFKfvR
	 BOD5xnIcKYwcPs1SvVwIEwuwAaop3CR5X5vdUrMrWfHLVep+3s6PuUdACnfbJ41dkp
	 U3u3WD7YCnX4g==
Date: Thu, 11 Jul 2024 17:08:40 +0100
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
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	Jesse Taube <jesse@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Meng Zhang <kevin.z.m@hotmail.com>, Yangyu Chen <cyy@cyyself.name>,
	Conor Dooley <conor.dooley@microchip.com>,
	Matthias Brugger <matthias.bgg@kernel.org>
Subject: Re: [PATCH v4 00/10] riscv: add initial support for SpacemiT K1
Message-ID: <20240711-zeppelin-property-aef2ee5fe999@spud>
References: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yHpvReNwxF6wUK2f"
Content-Disposition: inline
In-Reply-To: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>


--yHpvReNwxF6wUK2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 03:18:43AM +0000, Yixun Lan wrote:
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

This stuff is already too late for 6.11 as I already sent my PRs, so
there's no immediate rush. Is there any progress made on creating the
clock or pinctrl drivers?

Cheers,
Conor.

--yHpvReNwxF6wUK2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpADiAAKCRB4tDGHoIJi
0r+HAP4kQtP7z7FMirQkNnNga/iok/jbgojhmbMGEJinXvYMeQEAlQegTv/hhWUO
JANgyTGsSPtmecPs/EU62TinIgodsgE=
=13ox
-----END PGP SIGNATURE-----

--yHpvReNwxF6wUK2f--

