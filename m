Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3AC2B35D6
	for <lists+linux-serial@lfdr.de>; Sun, 15 Nov 2020 16:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKOPjj (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 15 Nov 2020 10:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbgKOPjj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 15 Nov 2020 10:39:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFA7C0613D1
        for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2020 07:39:39 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1keK7s-0003Yn-VT; Sun, 15 Nov 2020 16:39:36 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1keK7r-0001Rs-Cb; Sun, 15 Nov 2020 16:39:35 +0100
Date:   Sun, 15 Nov 2020 16:39:34 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, fugang.duan@nxp.com
Subject: Re: [PATCH] serial: imx: Remove unused .id_table support
Message-ID: <20201115153934.ywc5ld224zs6uifl@pengutronix.de>
References: <20201115110341.22761-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gdxxzssnm4fyv7cl"
Content-Disposition: inline
In-Reply-To: <20201115110341.22761-1-festevam@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--gdxxzssnm4fyv7cl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Nov 15, 2020 at 08:03:41AM -0300, Fabio Estevam wrote:
> Since 5.10-rc1 i.MX is a devicetree-only platform and the existing
> .id_table support in this driver was only useful for old non-devicetree
> platforms.
>=20
> Get rid of the .id_table since it is no longer used.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gdxxzssnm4fyv7cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+xS7MACgkQwfwUeK3K
7Ak8Cgf/Sg2PbPBnnCqhydXsPPhnAsBfDR6Yypo9LmxDoFePLMfvNdeDZM8+DIzn
ToYFZ7FC4TRQe5CDxstM3YKMTN9tCrt6APgibssf7+87nkA5shz02ujD5hyWBl7O
AbFywNGp3TVm++P2A4FDRAdJIMaeLFUjQAzxZFpGbjBCrBDxm65djMLyJAp6X5Qc
EesBgEJWoOxRfsFBbTzUGvW8jmGIuM0KXZcHB1sk5bxUccKi3g4IlR8uwBsyxQlu
JvfgL0DKKsRCj9vmuQqDRDfn3UubeEDGSFhBlqjx1Ova/BBmyd9FnU9TX2B46ngW
ezaTXa5V9PMyKg2TWJcenjx6e0OjRg==
=RpJm
-----END PGP SIGNATURE-----

--gdxxzssnm4fyv7cl--
