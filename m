Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603BDDA508
	for <lists+linux-serial@lfdr.de>; Thu, 17 Oct 2019 07:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389546AbfJQFOA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 17 Oct 2019 01:14:00 -0400
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:46066
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728999AbfJQFN7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Oct 2019 01:13:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKuPFODObnLkUbSs6ZS6cFrtgKV+xoE+H1uU8rvu40JV41a++q//JXKo0Y0wEQSemEMn6GOed9LJu1PBpNUERwIHxnF2wDZ42mvzlHZB2YTVMTxJUVFTDUaBpzoZ2/gw1LWA1Fhfj22XwNai6KQEV2WgJCd98Hpk4M1bVcfO0zwD6X+HMb0FpM0Uh5XMU26MXr8m7T7VfBoKC6J3y2Z+NJrBxLEgdpDcJJm+PkHM1kNH32AEZkUDl51PpczESbrNQ4BLhe0HQ7GS6/lFweMpwqw85DMu0AUixNKe+7JCsi/UnD5v52GD5whdukFW7Ipj82oZdp4jZeGXZdoj6LgZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5GVpY5hlzHefCyhS54246YeFT+/LlW1YBdCV0qt5Ks=;
 b=HI5kzhdyKQRQ5B4C4RayvJQd9b1vum0wAKJe3Tj2PS/QxdKOistwagFKwQGk13TmVQmwzLHFMW2ytjEiWv2EZlARn074M+ATQD6fPfaa1SKpI3WMi876ejIWOMq1JeDerKHB+eM4c9asFfIo6gxCleRBbAWWW41nylpX9csSt8ezenwjXII45kGNnj52i3Q6/3z7c8naKgyGAQFmY54HEnkQhtzYox/pgkdIjl6+8ypNWcCdytM6I5VTU/r8auQOTO46/8d8IUeg5PBTwXw1VKzd0Fg++w8cfTf3V3ACYcSlj26QDgMC7JardNif8vjq+3ArYT8RFJAF/VI9stVRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5GVpY5hlzHefCyhS54246YeFT+/LlW1YBdCV0qt5Ks=;
 b=cVP2w1Vpw1WNTyTRujhJzREWwJvF4VZaiFXEsFkuB0MA9l8QGaObZWEUO+2QoJdbLummWulT3GLReKSbYiUqs7xnSWAR//73Pvlk0BQOnidcRvketAXAYlAFPgJIdwhiqcdNU+5PpUUBf7UjOTqR3S8QEXOvi/eHUt+ID584g7M=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB2878.eurprd04.prod.outlook.com (10.175.23.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 05:13:55 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::5dd6:297c:51e5:2b52]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::5dd6:297c:51e5:2b52%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 05:13:55 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        dl-linux-imx <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: RE: [EXT] [PATCH v1 2/3] tty: serial: lpuart: Use defines that
 correspond to correct register
Thread-Topic: [EXT] [PATCH v1 2/3] tty: serial: lpuart: Use defines that
 correspond to correct register
Thread-Index: AQHVhDUKwO+6auP4F0GizDSFST7wu6deSsrQ
Date:   Thu, 17 Oct 2019 05:13:55 +0000
Message-ID: <VI1PR0402MB360094FDEBF58A36A8049122FF6D0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20191016151845.15859-1-philippe.schenker@toradex.com>
 <20191016151845.15859-2-philippe.schenker@toradex.com>
In-Reply-To: <20191016151845.15859-2-philippe.schenker@toradex.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6d3bfe7-69ce-479a-ed62-08d752c0cf12
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0402MB2878:|VI1PR0402MB2878:|VI1PR0402MB2878:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB287858F4835C20E304CDB46EFF6D0@VI1PR0402MB2878.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(66066001)(71200400001)(71190400001)(4326008)(476003)(102836004)(6506007)(26005)(186003)(86362001)(11346002)(256004)(52536014)(14454004)(446003)(478600001)(25786009)(6246003)(486006)(33656002)(2501003)(74316002)(81156014)(305945005)(229853002)(66446008)(66476007)(66556008)(4744005)(7736002)(3846002)(76176011)(8936002)(9686003)(6116002)(2906002)(66946007)(6436002)(7696005)(54906003)(55016002)(110136005)(81166006)(8676002)(76116006)(99286004)(5660300002)(64756008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2878;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UXtFR1iC72MrdAGSnjd50PtFt5saLyylXfixFcrzA5W9dP6FjgFT9BNWKvp2sCLKMRr7FtFHd179KzhRGmISOjmcVDDIKN1xOUNqwf/s2PA20h9wYHR8mAl2car9hmxm68GRj+3m7XvkAwx9maxgmuGF+WoF3GP4mSumxFlebYo9x3sESwiv06bchov3eS+1r68B6z9f1C2eNTL/XotS8gfFBdwqjo21BMqCoqJH+Gr+Kc8uZddFPWjfJStkqiTeL9LBhXPTOZTjoK+A4RkJIkl0ZmhSrNK8h9rYFK+uq6Oq4hOhQ6MgRN4dFE50RI+QSwZmip8FvWrO/BQqQwU7cswvYae4tyqL47a7kQCMkjHr1QdRXj9y73fUEmbkKRpPOJzLIaUvniqYemwzrdUOEF7aaaNJq+fas3ArFqWdtKM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d3bfe7-69ce-479a-ed62-08d752c0cf12
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 05:13:55.5298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wl6M1tY+h6Gpe3J/OW5sg/PaR+vWvZCV4CoFy/GXh/4tNN4YqK6O6GBV7G5gimM3RPBLuJpa29ztppSXVMZpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2878
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com> Sent: Wednesday, Oc=
tober 16, 2019 11:19 PM
> Use UARTMODIR defines instead of UARTMODEM as it is a 32-bit function
>=20
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>

> ---
>=20
>  drivers/tty/serial/fsl_lpuart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> f3271857621c..346b4a070ce9 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1879,10 +1879,10 @@ lpuart32_set_termios(struct uart_port *port,
> struct ktermios *termios,
>         }
>=20
>         if (termios->c_cflag & CRTSCTS) {
> -               modem |=3D UARTMODEM_RXRTSE |
> UARTMODEM_TXCTSE;
> +               modem |=3D (UARTMODIR_RXRTSE |
> UARTMODIR_TXCTSE);
>         } else {
>                 termios->c_cflag &=3D ~CRTSCTS;
> -               modem &=3D ~(UARTMODEM_RXRTSE |
> UARTMODEM_TXCTSE);
> +               modem &=3D ~(UARTMODIR_RXRTSE |
> UARTMODIR_TXCTSE);
>         }
>=20
>         if (termios->c_cflag & CSTOPB)
> --
> 2.23.0

