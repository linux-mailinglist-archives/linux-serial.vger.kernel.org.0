Return-Path: <linux-serial+bounces-7225-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654649F2483
	for <lists+linux-serial@lfdr.de>; Sun, 15 Dec 2024 16:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8843D164A69
	for <lists+linux-serial@lfdr.de>; Sun, 15 Dec 2024 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A618A92C;
	Sun, 15 Dec 2024 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1IHChds"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8518039;
	Sun, 15 Dec 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734275064; cv=none; b=BmXBke4F+L4oNthPygufWRZEDTY6qA/jh0S9tm3LP3JJhqYiGNa5/pgHJ1ulLwaiQ5rgbpRA+zVeMLjij1dZdGTNdfqMl4LmKbKbzeKlitUNaX0CyYw+aYq0/fMwyW2Nk+XGh7nSOXF6trJ+zZR8EqmwEwq0TTG5ZYeEpsn+5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734275064; c=relaxed/simple;
	bh=B21t/+Jd24OqV24lEe0unWNkkQaLiMeKbtQvE7t0xgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtHT2k4Jp9F6gLlXtQgt2Yw2zC9vf/tFhLreX4Lp67Iov5DEsIaEZKhgRuXanIiZIpA8ypa+EcdHNS5qKcBuMywt3nb/uasLJ9ne+tBlIQLoMDDiC7+OtuEbaeiO47sLIbQtNtsCksqOLgIzxYqveTMGVyBV3TPJYasESP/CvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1IHChds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAEBC4CECE;
	Sun, 15 Dec 2024 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734275063;
	bh=B21t/+Jd24OqV24lEe0unWNkkQaLiMeKbtQvE7t0xgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1IHChdsmyUj2rHC1Sxe+lq/YC7/Qi1Clc8g+kIeAWhfWK70K3cbx6He8drDOw3Zo
	 FXYA+wLl38BI05tCza8iFiwJNCE9ag4IHxrpcfQQTvwFiMq8m5Xuo2CV3HNyHeytS1
	 zuzHzM05a+zK39w6VaesXQ9NbQo85ig8e75blj1lpMa34unnuo8JGd2kp1nv686B23
	 u0mGOVd9+f18d6BGYau4wZwpj9GpdBzHB7VmDZ1rGdDsL93omoIKhdH7PoMB9isdgF
	 G7N4AkSurDNP3/1kUgFFYjLDFnAXu4lU+cfu09LxKYWZwlZJwqt76hxCw3vqdjN6cF
	 8t9cZMAxXlWZQ==
Date: Sun, 15 Dec 2024 15:04:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, cyy@cyyself.name,
	daniel.lezcano@linaro.org, tglx@linutronix.de,
	samuel.holland@sifive.com, anup@brainfault.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org, lkundrak@v3.sk,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jesse Taube <mr.bossman075@gmail.com>,
	inochiama@outlook.com, zhangmeng.kevin@spacemit.com,
	jszhang@kernel.org, matthias.bgg@kernel.org, kevin.z.m@hotmail.com
Subject: Re: [PATCH v5 00/10] riscv: add initial support for SpacemiT K1
Message-ID: <20241215-reward-nutlike-23f481fb1b75@spud>
References: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
 <173395638199.1729195.1529576042123666894.git-patchwork-notify@kernel.org>
 <20241212101901-GYA2292414@gentoo>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/kpettwmxOSIqaPM"
Content-Disposition: inline
In-Reply-To: <20241212101901-GYA2292414@gentoo>


--/kpettwmxOSIqaPM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 06:19:01PM +0800, Yixun Lan wrote:
> Hi Conor:
>=20
> On 22:33 Wed 11 Dec     , patchwork-bot+linux-riscv@kernel.org wrote:
> > Hello:
> >=20
> > This series was applied to riscv/linux.git (fixes)
> > by Conor Dooley <conor.dooley@microchip.com>:
> >=20
> > On Tue, 30 Jul 2024 00:28:03 +0000 you wrote:
> > > SpacemiT K1 is an ideal chip for some new extension such as RISC-V Ve=
ctor
> > > 1.0 and Zicond evaluation now. Add initial support for it to allow mo=
re
> > > people to participate in building drivers to mainline for it.
> > >=20
> > > This kernel has been tested upon Banana Pi BPI-F3 board on vendor U-B=
oot
> > > bootflow generated by Armbian SDK[1] and patched OpenSBI[2] to enable
> > > Zicboz, which does not in the vendor dts on its U-Boot. Then successf=
ully
> > > booted to busybox on initrd with this log[3].
> > >=20
> > > [...]
> >=20
> > Here is the summary with links:
> >   - [v5,01/10] dt-bindings: vendor-prefixes: add spacemit
> >     https://git.kernel.org/riscv/c/7cf3e9bfc63d
> If I understand correctly, only patch [01/10] of this series was accepted
> to 6.13-rc1
>=20
> for the rest of patches, they would be expected to go through SpacemiT's
> SoC tree? which should I take care of them.. so if no objection, I'd like=
 to
> queue them at branch k1/dt-for-next [1] first, we might rebase or revert =
if
> something happens before merging (since the clock driver is still under r=
eview)
>=20
> Let me know what you think..

Sure. I had grabbed the first patch because a couple trees needed the
vendor prefix for peripheral drivers. How is the clock driver getting
on? Do you think it is close to being merged?

--/kpettwmxOSIqaPM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ17v8AAKCRB4tDGHoIJi
0iAdAP9HD4/Y0RNI7dVATy3fSwrhtkjS3S73FSLgbFoXrRzX3AEA13XuZem7fa3p
+XtYsKHNn/iYUJB1jXAY5GCnofTroAc=
=0rg/
-----END PGP SIGNATURE-----

--/kpettwmxOSIqaPM--

