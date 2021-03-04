Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF232C33C
	for <lists+linux-serial@lfdr.de>; Thu,  4 Mar 2021 01:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbhCDAAB (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 3 Mar 2021 19:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835986AbhCCIDc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Mar 2021 03:03:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5749DC0617AA
        for <linux-serial@vger.kernel.org>; Tue,  2 Mar 2021 23:44:43 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lHMBU-0002s8-Rd; Wed, 03 Mar 2021 08:44:40 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lHMBQ-0006Qi-JT; Wed, 03 Mar 2021 08:44:36 +0100
Date:   Wed, 3 Mar 2021 08:44:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jiri Slaby <jslaby@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 40/44] tty: hvc, drop unneeded forward declarations
Message-ID: <20210303074436.keguljsgyvan6d5g@pengutronix.de>
References: <20210302062214.29627-1-jslaby@suse.cz>
 <20210302062214.29627-40-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="prjodd2hjuh6jp2h"
Content-Disposition: inline
In-Reply-To: <20210302062214.29627-40-jslaby@suse.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--prjodd2hjuh6jp2h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jiri,

On Tue, Mar 02, 2021 at 07:22:10AM +0100, Jiri Slaby wrote:
> Forward declarations make the code larger and rewrites harder. Harder as
> they are often omitted from global changes. Remove forward declarations
> which are not really needed, i.e. the definition of the function is
> before its first use.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  drivers/tty/hvc/hvcs.c | 25 -------------------------

note this conflicts with commit 386a966f5ce71a0364b158c5d0a6971f4e418ea8
that currently sits in the powerpc tree. I think it's easy to resolve.

Other than that:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

>  1 file changed, 25 deletions(-)
>=20
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index c90848919644..0b89d878a108 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -290,36 +290,11 @@ static LIST_HEAD(hvcs_structs);
>  static DEFINE_SPINLOCK(hvcs_structs_lock);
>  static DEFINE_MUTEX(hvcs_init_mutex);
> =20
> -static void hvcs_unthrottle(struct tty_struct *tty);
> -static void hvcs_throttle(struct tty_struct *tty);
> -static irqreturn_t hvcs_handle_interrupt(int irq, void *dev_instance);
> -
> -static int hvcs_write(struct tty_struct *tty,
> -		const unsigned char *buf, int count);
> -static int hvcs_write_room(struct tty_struct *tty);
> -static int hvcs_chars_in_buffer(struct tty_struct *tty);
> -
> -static int hvcs_has_pi(struct hvcs_struct *hvcsd);
> -static void hvcs_set_pi(struct hvcs_partner_info *pi,
> -		struct hvcs_struct *hvcsd);
>  static int hvcs_get_pi(struct hvcs_struct *hvcsd);
>  static int hvcs_rescan_devices_list(void);
> =20
> -static int hvcs_partner_connect(struct hvcs_struct *hvcsd);
>  static void hvcs_partner_free(struct hvcs_struct *hvcsd);
> =20
> -static int hvcs_enable_device(struct hvcs_struct *hvcsd,
> -		uint32_t unit_address, unsigned int irq, struct vio_dev *dev);
> -
> -static int hvcs_open(struct tty_struct *tty, struct file *filp);
> -static void hvcs_close(struct tty_struct *tty, struct file *filp);
> -static void hvcs_hangup(struct tty_struct * tty);
> -
> -static int hvcs_probe(struct vio_dev *dev,
> -		const struct vio_device_id *id);
> -static int hvcs_remove(struct vio_dev *dev);
> -static int __init hvcs_module_init(void);
> -static void __exit hvcs_module_exit(void);
>  static int hvcs_initialize(void);
> =20
>  #define HVCS_SCHED_READ	0x00000001
> --=20
> 2.30.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--prjodd2hjuh6jp2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmA/PmEACgkQwfwUeK3K
7Ak/+QgAoaMQF3clqadoCfC+pLPxWDoOB9ZNxnHO1dNcFLtQHZEAJNwMZw9h/mxr
DY6thVwediWE2JI/e/c2XaF78mUy9KrMtd8TwTjKHCMhOzAlF9fRNra9eTLP+gBJ
QOJOIQntpeiolTtZTuy4bphiJe09YuuEZSr4zx0HgaECI811eyG+qLZWmPKeK2Jl
EYoZtx1uoKnlwrZOqbhkopk2U9st6Kt/oxzEjBF3NcMXDKjCfFvz9eCaklbwctPq
2e8MFy7Jg2dq2hrNIHBxRIAOu7H7Ba7oPMFnlJkoLdGdg3jyqMjjpQccJjZaSI+j
d6/csnS/+InQyjvZWcGPMCrZSCxvjg==
=/Ai0
-----END PGP SIGNATURE-----

--prjodd2hjuh6jp2h--
