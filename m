Return-Path: <linux-serial+bounces-2988-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4CF893A48
	for <lists+linux-serial@lfdr.de>; Mon,  1 Apr 2024 12:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F2E1F223C7
	for <lists+linux-serial@lfdr.de>; Mon,  1 Apr 2024 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1991CA94;
	Mon,  1 Apr 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQe1IZ0P"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879D1119F;
	Mon,  1 Apr 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968360; cv=none; b=YoO1yerMMYcbaKg6MDpDd6kbbd91nDsjKk+p+Ozc3fKXK/Jng2O5KYxedMXSpzP0MJmcXRNmRCw0OKF6PHni/kKGzYhZeJoBzKQ12/AKdqOcTTxjai0SnTA5sfXcy6sZS+I0qmJJM78RZEsi0D/FadfYsa21Jz2i40IaAGKtZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968360; c=relaxed/simple;
	bh=1+YXVkWDpfnDUkyfFIwwtuJIeFa+QdWmoa8giba2BLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzRxBA/ofGtsa3297GNkLVs5/VLGj8ZZeum7C4MfTJqNlEcv5Ok2+vEXi0qAZKq/ZYjFZZnjzRq3qvk24wBdiweG+LmUo+nrGuLu6ohh7YC9iZOB5ThoGQOcxV5St/aAIotsObvHJeNwpQXxJIw9kYf5Z9oG6ga3Y5A/1AomcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQe1IZ0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD07C433F1;
	Mon,  1 Apr 2024 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711968359;
	bh=1+YXVkWDpfnDUkyfFIwwtuJIeFa+QdWmoa8giba2BLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQe1IZ0Pc0N4U9C9FfHJXZxrN0K3WmUQFOM9JLj5qzxpsOGP32LUqGIHO/UtVbMA6
	 W+T0dqktkiFd2AjnuDmlhccud5h53EmnYoScLlloZJ4u5A0Dx+BbL2MHynokoBwtfE
	 B3ZNtrHkxmuN3KN6z0ESFKJqMs1zq5osH7DN2IgXSh+EKJmo3DYHve5aHR6fsgwD+M
	 yNq88slX8Gg1I2uutmTbmsMfGdUpRP7SRu475rufrd6O1EvmzPQjL/rWE4DZhli+KU
	 Hl+N/UOoWRP+jiYQ7VwXm/zbY7a071Ef3vGT16zLmt/wQfL7s+/ia/CSYl/mX0K4Yl
	 tCbmRqYiUhDIw==
Date: Mon, 1 Apr 2024 11:45:54 +0100
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for A4
Message-ID: <20240401-tipoff-company-68396618e0aa@spud>
References: <20240401-basic_dt-v3-0-cb29ae1c16da@amlogic.com>
 <20240401-basic_dt-v3-3-cb29ae1c16da@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pr9sKHOsz+G6y9G0"
Content-Disposition: inline
In-Reply-To: <20240401-basic_dt-v3-3-cb29ae1c16da@amlogic.com>


--Pr9sKHOsz+G6y9G0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 06:10:51PM +0800, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>=20
> Amlogic A4 SoCs uses the same UART controller as S4 SoCs and G12A.
> There is no need for an extra compatible line in the driver, but
> add A4 compatible line for documentation.
>=20
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Pr9sKHOsz+G6y9G0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgqQYgAKCRB4tDGHoIJi
0lJtAP9emVjhHRD0uUk/qOkv8tNvKQBjEObm+PXChnwbg2mINAEA5Xe6IFCkPP9y
BuNnPt2S+bduALibxROpFV5QaRImPwo=
=09wH
-----END PGP SIGNATURE-----

--Pr9sKHOsz+G6y9G0--

