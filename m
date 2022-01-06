Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4493548667B
	for <lists+linux-serial@lfdr.de>; Thu,  6 Jan 2022 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiAFPGU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 6 Jan 2022 10:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbiAFPGT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Jan 2022 10:06:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3ACC061245
        for <linux-serial@vger.kernel.org>; Thu,  6 Jan 2022 07:06:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n5ULF-0005ne-Ak; Thu, 06 Jan 2022 16:06:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n5ULE-008nze-90; Thu, 06 Jan 2022 16:06:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n5ULD-0005N5-Ac; Thu, 06 Jan 2022 16:06:11 +0100
Date:   Thu, 6 Jan 2022 16:05:52 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        k.drobinski@camlintechnologies.com,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
Message-ID: <20220106150552.vdt5qabe2xj4kasg@pengutronix.de>
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
 <YdQndwYc9xaauvpS@kroah.com>
 <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
 <YdQxmQ+OMCrabg2u@kroah.com>
 <20220104224900.u3omfbilejx2jawr@pengutronix.de>
 <87tuei4882.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6dzjke5tf4st7pis"
Content-Disposition: inline
In-Reply-To: <87tuei4882.fsf@osv.gnss.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--6dzjke5tf4st7pis
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 05, 2022 at 04:34:21PM +0300, Sergey Organov wrote:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>=20
> > On Tue, Jan 04, 2022 at 12:38:01PM +0100, Greg Kroah-Hartman wrote:
> >> On Tue, Jan 04, 2022 at 12:13:06PM +0100, Tomasz Mo=C5=84 wrote:
> >> > On 04.01.2022 11:54, Greg Kroah-Hartman wrote:
> >> > > Why can't you do this dynamically based on the baud rate so as to =
always
> >> > > work properly for all speeds without increased delays for slower o=
nes?
> >> >=20
> >> > Could you please advise on which baud rates to consider as slow? Doe=
s it
> >> > sound good to have the old trigger level for rates up to and includi=
ng
> >> > 115200 and the new one for faster ones?
> >>=20
> >> You tell me, you are the one seeing this issue and are seeing delays on
> >> slower values with your change.  Do some testing to see where the curve
> >> is.
> >
> > Maybe it's more sensible to make this even more dynamic: e.g. keep it at
> > 1 as default and increase the water level when a certain irq frequency
> > is reached?
>=20
> Too complex, and too many questions, I'm afraid. What is "irq
> frequency", exactly? For this particular driver, or overall system?
> Measured on what time interval? What is the threshold? Do we drop the
> water level back to 1 when "irq frequency" is down again? Will we just
> create re-configure storm at some conditions? Etc.....

It could be as easy as increasing the waterlevel by one if an RX irq
happens with USR1.AGTIM =3D 0 and reset to 1 if USR1.AGTIM =3D 1.

This makes sure that receiving at a low frequency makes the hardware
interrupt the CPU early, and a burst doesn't starve the CPU.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6dzjke5tf4st7pis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHXBUgACgkQwfwUeK3K
7AnOQAgAmLlDOhFPv+SRVO2Gk0eEp3IFn32VSJk8vdV68j1qEnfIiJUqCMWevP7b
DfeqjrNgz80bCozxjriDAw9z5EmWJwakVD3jiTiN02euYVCqARLTaRWbs1LtN6B4
tuQo2vXRyjSE2OYdSk65TVwCXIhg6+AO3i0wlxyyAGlzyoLJBbPg6Q0wp5jF0irt
IrPJZDInm2Pb1mNXJUCphOmpWgWW5sFGFRnXy26FvG24Rsf8CdqgppYdgsey/kW7
uW9XTQXQ4903+6EQrcCNUWmEOQKmdBbcEDcWxKW0qFGK6QNL9VMJ2SMXM7uLpE61
fNnqKyDkBK67zIiIB5URjGZYbeDVLw==
=8Y62
-----END PGP SIGNATURE-----

--6dzjke5tf4st7pis--
