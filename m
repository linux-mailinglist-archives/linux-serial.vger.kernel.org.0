Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E97D459E72
	for <lists+linux-serial@lfdr.de>; Tue, 23 Nov 2021 09:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhKWIqg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 23 Nov 2021 03:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhKWIqe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 03:46:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DF1C061574
        for <linux-serial@vger.kernel.org>; Tue, 23 Nov 2021 00:43:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpROf-0007sO-28; Tue, 23 Nov 2021 09:43:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpROe-000aYX-SB; Tue, 23 Nov 2021 09:43:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpROd-0001qe-Us; Tue, 23 Nov 2021 09:43:23 +0100
Date:   Tue, 23 Nov 2021 09:43:21 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] tty: serial: imx: disable UCR4_OREN in .stop_rx()
Message-ID: <20211123084321.gpblxmqddn3kl44y@pengutronix.de>
References: <20211123070437.20153-1-sherry.sun@nxp.com>
 <20211123075122.2cwhrdwrsyjgebnk@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="htaspexec67klvnz"
Content-Disposition: inline
In-Reply-To: <20211123075122.2cwhrdwrsyjgebnk@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--htaspexec67klvnz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

On Tue, Nov 23, 2021 at 08:51:22AM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Nov 23, 2021 at 03:04:37PM +0800, Sherry Sun wrote:
> > From: Fugang Duan <fugang.duan@nxp.com>
> >=20
> > Disable UCR4_OREN bit in .stop_rx() to avoid endless
> > interrupt happen while tty port is closing.
> >=20
> > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/tty/serial/imx.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index fb75e3e0d828..9ecaf051249d 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -486,18 +486,21 @@ static void imx_uart_stop_tx(struct uart_port *po=
rt)
> >  static void imx_uart_stop_rx(struct uart_port *port)
> >  {
> >  	struct imx_port *sport =3D (struct imx_port *)port;
> > -	u32 ucr1, ucr2;
> > +	u32 ucr1, ucr2, ucr4;
> > =20
> >  	ucr1 =3D imx_uart_readl(sport, UCR1);
> >  	ucr2 =3D imx_uart_readl(sport, UCR2);
> > +	ucr4 =3D imx_uart_readl(sport, UCR4);
> > =20
> >  	if (sport->dma_is_enabled) {
> >  		ucr1 &=3D ~(UCR1_RXDMAEN | UCR1_ATDMAEN);
> >  	} else {
> >  		ucr1 &=3D ~UCR1_RRDYEN;
> >  		ucr2 &=3D ~UCR2_ATEN;
> > +		ucr4 &=3D ~UCR4_OREN;
> >  	}
> >  	imx_uart_writel(sport, ucr1, UCR1);
> > +	imx_uart_writel(sport, ucr4, UCR4);
>=20
> I don't understand this yet, but I guess this is just a matter of
> improving the commit log. How does the endless irq happen?
>=20
> ... some time later after thinking and reading the driver source ...
>=20
> Hmm, when the OR event is triggered the handler does
>=20
> 	imx_uart_writel(sport, USR2_ORE, USR2);
>=20
> and so clears the event. I would expect that this should be good enough
> to prevent an irq storm even if the receiver is disabled. Doesn't acking
> work with the receiver disabled?

One thing I forgot to mention:

If imx_uart_stop_rx() now clears UCR4_OREN, clearing in
imx_uart_shutdown() should probably be dropped.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--htaspexec67klvnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGcqaYACgkQwfwUeK3K
7AnyRggAjPVE2oGVO6+Mju+sJmNwGsiBt73Tr9kixCSfdP+z/9Pmt1NLaOgNCCwT
pqAHQP0GSiEfBosUIKpNCHVUn5uXkCnlXc7ri0KBGInCn5IJjHS9t5pjZtgKKqLL
uR8ml+YQcLwRlJhbMadOaoQjWEJ23vHRp9MGty8ok6yYwFSG+uwyXKy+6C0XHB2Q
setR+jgLKl8YFFVOYIyX3f9/AEXkDBwA/PexuAP+/J9sU0kbRoofEIQyCD7dlcTZ
E5oul6qH2/g+uMEoa86ed9J6w4KyjuGug+Ev4QwiOO3H0ytBkNGPZmeUCEG0kPW8
moDXyWwUONZNqgfzfwDPcwkZnvVClA==
=+YlV
-----END PGP SIGNATURE-----

--htaspexec67klvnz--
