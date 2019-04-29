Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7FDBF0
	for <lists+linux-serial@lfdr.de>; Mon, 29 Apr 2019 08:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfD2G1i (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 29 Apr 2019 02:27:38 -0400
Received: from forward100j.mail.yandex.net ([5.45.198.240]:38231 "EHLO
        forward100j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbfD2G1i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Apr 2019 02:27:38 -0400
Received: from mxback13g.mail.yandex.net (mxback13g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:92])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 4E33150E0329;
        Mon, 29 Apr 2019 09:27:34 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback13g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 23BJMQk6qv-RX84bIS9;
        Mon, 29 Apr 2019 09:27:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=procenne.com; s=mail; t=1556519254;
        bh=G7kbMtwK+Rycl7qNllmoEUAZ6sb8au0IzgNke+4cxMg=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-ID;
        b=RZ3MivT3JdtF9K70gkQP2SDGLBq2D6K1VS0wG9wTf1EEBU7D9VTxowIHry+SyHgLQ
         bppX785QIe0SdE/LJC0Vps1ZaqimgocphubbN6bwe/B+uj2ZZTnqHmQxVhv5od0bsD
         LG1JGQg7N9EUVH0F0cbTAqYQe838yGAMm9vb3miI=
Authentication-Results: mxback13g.mail.yandex.net; dkim=pass header.i=@procenne.com
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id LVUtH5KVuF-RW6aasTH;
        Mon, 29 Apr 2019 09:27:32 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Fatih =?utf-8?B?QcWfxLFjxLE=?= <fatih.asici@procenne.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        fatih.asici@gmail.com
Subject: Re: [PATCH] serdev: add method to set stop bits
Date:   Mon, 29 Apr 2019 09:27:26 +0300
Message-ID: <5406741.ymGCjNrDGl@fatih-x542urr>
Organization: Procenne
In-Reply-To: <CAL_JsqLgURV2uHMG-q904Z+hWsP0qskPKCf4MQQBOGTGUjqfcw@mail.gmail.com>
References: <20190412064737.30424-1-fatih.asici@procenne.com> <CAL_JsqLgURV2uHMG-q904Z+hWsP0qskPKCf4MQQBOGTGUjqfcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart34591477.v2HXjLMM9y"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--nextPart34591477.v2HXjLMM9y
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On 26 Nisan 2019 Cuma 17:00:02 +03 Rob Herring wrote:
> On Fri, Apr 12, 2019 at 1:55 AM Fatih A=C5=9F=C4=B1c=C4=B1 <fatih.asici@p=
rocenne.com>=20
wrote:
> > Adds serdev_device_set_stop_bits() which takes an int argument with
> > a value of 1 or 2.
>=20
> Do you have a user? We normally like to have one before adding
> functions to the kernel.

We are developing a smartcard interface [1] driver for use in our embedded=
=20
project. The driver is not suitable for general use. It is just written to=
=20
support certain cards that we will use in the project. It is unlikely to be=
=20
mainlined; but I thought adding this function to mainline might prevent=20
possible duplicate work in the future since it is related to one of the com=
mon=20
serial port parameters (data/parity/stop bits).

> > An implementation for ttyport is also added.
> >=20
> > Signed-off-by: Fatih A=C5=9F=C4=B1c=C4=B1 <fatih.asici@procenne.com>
> > ---
> >=20
> >  drivers/tty/serdev/core.c           | 11 +++++++++++
> >  drivers/tty/serdev/serdev-ttyport.c | 22 ++++++++++++++++++++++
> >  include/linux/serdev.h              |  3 +++
> >  3 files changed, 36 insertions(+)
> >=20
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index a0ac16ee6575..1ca1c067e10f 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -371,6 +371,17 @@ int serdev_device_set_parity(struct serdev_device
> > *serdev,>=20
> >  }
> >  EXPORT_SYMBOL_GPL(serdev_device_set_parity);
> >=20
> > +int serdev_device_set_stop_bits(struct serdev_device *serdev, int
> > stop_bits) +{
> > +       struct serdev_controller *ctrl =3D serdev->ctrl;
> > +
> > +       if (!ctrl || !ctrl->ops->set_stop_bits)
> > +               return -ENOTSUPP;
> > +
> > +       return ctrl->ops->set_stop_bits(ctrl, stop_bits);
> > +}
> > +EXPORT_SYMBOL_GPL(serdev_device_set_stop_bits);
> > +
> >=20
> >  void serdev_device_wait_until_sent(struct serdev_device *serdev, long
> >  timeout) {
> > =20
> >         struct serdev_controller *ctrl =3D serdev->ctrl;
> >=20
> > diff --git a/drivers/tty/serdev/serdev-ttyport.c
> > b/drivers/tty/serdev/serdev-ttyport.c index d1cdd2ab8b4c..820c632e77cc
> > 100644
> > --- a/drivers/tty/serdev/serdev-ttyport.c
> > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > @@ -217,6 +217,27 @@ static int ttyport_set_parity(struct
> > serdev_controller *ctrl,>=20
> >         return 0;
> > =20
> >  }
> >=20
> > +static int ttyport_set_stop_bits(struct serdev_controller *ctrl, int
> > stop_bits) +{
> > +       struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> > +       struct tty_struct *tty =3D serport->tty;
> > +       struct ktermios ktermios =3D tty->termios;
> > +
> > +       if (stop_bits =3D=3D 1)
> > +               ktermios.c_cflag &=3D ~CSTOPB;
> > +       else if (stop_bits =3D=3D 2)
> > +               ktermios.c_cflag |=3D CSTOPB;
> > +       else
> > +               return -EINVAL;
> > +
> > +       tty_set_termios(tty, &ktermios);
> > +
> > +       if ((tty->termios.c_cflag & CSTOPB) !=3D (ktermios.c_cflag &
> > CSTOPB))
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +
> >=20
> >  static void ttyport_wait_until_sent(struct serdev_controller *ctrl, lo=
ng
> >  timeout) {
> > =20
> >         struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> >=20
> > @@ -255,6 +276,7 @@ static const struct serdev_controller_ops ctrl_ops =
=3D {
> >=20
> >         .close =3D ttyport_close,
> >         .set_flow_control =3D ttyport_set_flow_control,
> >         .set_parity =3D ttyport_set_parity,
> >=20
> > +       .set_stop_bits =3D ttyport_set_stop_bits,
> >=20
> >         .set_baudrate =3D ttyport_set_baudrate,
> >         .wait_until_sent =3D ttyport_wait_until_sent,
> >         .get_tiocm =3D ttyport_get_tiocm,
> >=20
> > diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> > index 070bf4e92df7..ec8bb6b4ac39 100644
> > --- a/include/linux/serdev.h
> > +++ b/include/linux/serdev.h
> > @@ -95,6 +95,7 @@ struct serdev_controller_ops {
> >=20
> >         void (*close)(struct serdev_controller *);
> >         void (*set_flow_control)(struct serdev_controller *, bool);
> >         int (*set_parity)(struct serdev_controller *, enum serdev_parit=
y);
> >=20
> > +       int (*set_stop_bits)(struct serdev_controller *, int);
> >=20
> >         unsigned int (*set_baudrate)(struct serdev_controller *, unsign=
ed
> >         int);
> >         void (*wait_until_sent)(struct serdev_controller *, long);
> >         int (*get_tiocm)(struct serdev_controller *);
> >=20
> > @@ -311,6 +312,8 @@ static inline int serdev_device_set_rts(struct
> > serdev_device *serdev, bool enabl>=20
> >  int serdev_device_set_parity(struct serdev_device *serdev,
> > =20
> >                              enum serdev_parity parity);
> >=20
> > +int serdev_device_set_stop_bits(struct serdev_device *serdev, int
> > stop_bits);
> You need an empty function for when serdev config is disabled.

I will add it.

Regards,
=46atih

[1] Datasheet: https://www.st.com/resource/en/datasheet/st8034hn.pdf


--nextPart34591477.v2HXjLMM9y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEl9F08CEOU/H0jn92gJ5Mw4HO4KgFAlzGmU4ACgkQgJ5Mw4HO
4KjDHgf/fnpSDsLh6Z3ZJxKx5kQgr0LIoJD5FelvNjbP5UlxPC7JG9/rFH00y9Io
wf7j1TBTe26hpMFVIraiercrgOhmrsK2nYQkP/vclsOlYJRLdQzN7YCjBvOLYind
0McnLVAQKG/Un+vsPANEJ/bqcfpbD1dKYsWppDEx2/20FljyfqWolXkpj9BHkGF6
pa+XCF3b4nd0RFCo0NV/AHZR/66gJuixK4haWMW0OtYveEuTuYPeLiDoaYNvhLhg
9dOecnldeu0gKTL2VkvHVqvesGQrRBpDzVOURnBbEXHjqKiPox5N4vfPOrQtosC0
e3isd6NiRV4Iw1lT1KFForklOPVw2A==
=BGwr
-----END PGP SIGNATURE-----

--nextPart34591477.v2HXjLMM9y--



