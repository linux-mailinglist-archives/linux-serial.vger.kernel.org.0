Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DCB2AF74B
	for <lists+linux-serial@lfdr.de>; Wed, 11 Nov 2020 18:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgKKRTy (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 11 Nov 2020 12:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgKKRTy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Nov 2020 12:19:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B978C0613D1
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2020 09:19:54 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kctmi-0008HF-IQ; Wed, 11 Nov 2020 18:19:52 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kctmh-0007QI-4Z; Wed, 11 Nov 2020 18:19:51 +0100
Date:   Wed, 11 Nov 2020 18:19:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH] serial: imx: Remove unused platform data support
Message-ID: <20201111171949.zcbxr6ck7dtz43od@pengutronix.de>
References: <20201110214840.16768-1-festevam@gmail.com>
 <20201111095701.rnsuajzfgkstiwa5@pengutronix.de>
 <CAOMZO5BNdtj15dmJ3xciSrhODs-XYcPOaO2EEUQCxWxBc3bJyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zydaowyeyb7velyn"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BNdtj15dmJ3xciSrhODs-XYcPOaO2EEUQCxWxBc3bJyA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--zydaowyeyb7velyn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 09:36:44AM -0300, Fabio Estevam wrote:
> Hi Uwe,
>=20
> On Wed, Nov 11, 2020 at 6:57 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Is it a problem if you build with SERIAL_IMX=3Dy, COMPILE_TEST=3Dy and
> > ARCH_MXC + CONFIG_OF unset?
>=20
> I tried your suggested combination and it built fine.

fine, then:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zydaowyeyb7velyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+sHTIACgkQwfwUeK3K
7AmWhgf9GbKTjrM/VUJtfC+fHxuQYoTjip59oS61FWVzxdopfZAy86TnfkHt04Vo
K7zN01PQZ1g7LEVgRM4moq00xedKcPyB5mLeIHMCTdR6Er440Uob7tT5Eu9gtTtf
CU2QsJzFjYKU22ZRcsSZGyhYA2Nqn7s/IlGPale47m37bklxd6OkWUIUuIX9uxMg
sjUClxUq3+6erNhihfVduaCJFYUXrhJW9p8SSYpS2r/Xv486nIBiQrQkfOypwKdM
fNUwpcvc3HPVm4J5xgz33IQWRMXbi53cLcyENE2vasnw/TS/RSnpyPeicIkNo+tL
V/ogZCQ6Pf1FFfa/XEB8MUme3VKudw==
=T04A
-----END PGP SIGNATURE-----

--zydaowyeyb7velyn--
