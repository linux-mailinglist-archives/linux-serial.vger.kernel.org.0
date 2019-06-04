Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7133E86
	for <lists+linux-serial@lfdr.de>; Tue,  4 Jun 2019 07:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfFDFoF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 4 Jun 2019 01:44:05 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:36866
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbfFDFoF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jun 2019 01:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bHVQS1E1Gwhwc79P4AKShBjeoI3pfBppXqclmlBL4o=;
 b=IipQZhn6sY0z0WXgIM9UMg7+k3oalTFEFMfagMJylMdHyzi8BJNTxeFQ04EQGu6u45n4MPTDtlZMX9eRd++W3Q6JjWxDGlWpF6yaT/19vIwRLlbnA64G8m8G+riuVXgXCcaSkZLQ03oySs14w43WiSc1z4wozdtdVj52AnFl2v4=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3821.eurprd04.prod.outlook.com (52.134.16.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.21; Tue, 4 Jun 2019 05:44:02 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::4c3e:205:bec9:54ef]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::4c3e:205:bec9:54ef%4]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 05:44:02 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2 1/2] serial: fsl_lpuart: Use dev_info() instead
 of printk()
Thread-Topic: [EXT] [PATCH v2 1/2] serial: fsl_lpuart: Use dev_info() instead
 of printk()
Thread-Index: AQHVGoYMz7ZG+aY7V0Sz/yLg65NOmaaK+4JA
Date:   Tue, 4 Jun 2019 05:44:02 +0000
Message-ID: <VI1PR0402MB3600D80B8FFDC144A1FD5759FF150@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190604033139.25546-1-festevam@gmail.com>
In-Reply-To: <20190604033139.25546-1-festevam@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87976ad3-a45e-423b-376d-08d6e8afa64f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3821;
x-ms-traffictypediagnostic: VI1PR0402MB3821:
x-microsoft-antispam-prvs: <VI1PR0402MB3821D74FC50AA9EDBE5A6643FF150@VI1PR0402MB3821.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(186003)(11346002)(486006)(73956011)(476003)(68736007)(6116002)(110136005)(26005)(3846002)(4326008)(7736002)(9686003)(66066001)(2906002)(446003)(66946007)(99286004)(6246003)(6506007)(8936002)(7696005)(8676002)(81156014)(81166006)(102836004)(76176011)(74316002)(5660300002)(256004)(52536014)(6436002)(55016002)(53936002)(14454004)(2501003)(71200400001)(71190400001)(86362001)(76116006)(66556008)(66446008)(305945005)(316002)(25786009)(229853002)(33656002)(66476007)(64756008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3821;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XsI+/K4jWxJb7YYXYrtdUJen3qRDI17i444nCJWUsAY+pSQrmaH+a6/t0Xk/TF9Sm774gFVdCJBva60PdVHT2IwJ/0A4JhqUtL7PYZWSA/KsESOS/IbzWfzy836QlHnerCTECew6Ee7XSDfydGt5iCyx7FmTDcOPGG2u9QeDOfY76IF9HjeH3YbezLO1viFcWIV+CT7LvsMMYDGVZnFC0hbpiwR8Ov9GyGEL0hHZv0VKo6T8/3hYOlNHucw6CLXNgNnFwGlDLa32URgNB2huyroHrSC3y3TqHM8tEfTTVmJuTzTgP8Vjbd7S3LDUgJ7AFISqI0MFiVDDDe2nQzPfXAjRRaFik3Ek1g9E/RWEhP115z/kLQp5KGM7HRvOEn+blXSTuVvXkDDrpck3psrir7fvzxPqApqJpTblvv4UCuY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87976ad3-a45e-423b-376d-08d6e8afa64f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 05:44:02.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3821
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com> Sent: Tuesday, June 4, 2019 11:32 =
AM
> dev_info() is more appropriate for printing messages inside drivers, so s=
witch
> to dev_info().
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
> ---
> Changes since v1:
> - None
>=20
>  drivers/tty/serial/fsl_lpuart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> ea1c85e3b432..08b52cca650c 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2078,7 +2078,7 @@ lpuart_console_get_options(struct lpuart_port
> *sport, int *baud,
>         baud_raw =3D uartclk / (16 * (sbr + brfa / 32));
>=20
>         if (*baud !=3D baud_raw)
> -               printk(KERN_INFO "Serial: Console lpuart rounded baud
> rate"
> +               dev_info(sport->port.dev, "Serial: Console lpuart rounded
> baud rate"
>                                 "from %d to %d\n", baud_raw,
> *baud);  }
>=20
> @@ -2121,7 +2121,7 @@ lpuart32_console_get_options(struct lpuart_port
> *sport, int *baud,
>         baud_raw =3D uartclk / (16 * sbr);
>=20
>         if (*baud !=3D baud_raw)
> -               printk(KERN_INFO "Serial: Console lpuart rounded baud
> rate"
> +               dev_info(sport->port.dev, "Serial: Console lpuart rounded
> baud rate"
>                                 "from %d to %d\n", baud_raw,
> *baud);  }
>=20
> --
> 2.17.1

