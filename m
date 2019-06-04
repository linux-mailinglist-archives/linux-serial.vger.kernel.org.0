Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E77C33E81
	for <lists+linux-serial@lfdr.de>; Tue,  4 Jun 2019 07:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfFDFmH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 4 Jun 2019 01:42:07 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:44686
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbfFDFmG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jun 2019 01:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+uKlA597p8dHYpm/bbkkkTjLi3nUsdeyY5q1Xw0Lw8=;
 b=PotM1JbQqKsz3kGpXTeLdtGrhcVzRUvBhqd+3wcqVcRo19cARxnvoeCskwxj79+57Plp4aGSWuERoFhu8TOr2/D5e4tEvRlrAVMx9uPAGbxnu5vIGUZXPmbiQZHRbPb2WCz/UvHMqhd5jAdLPfabbGvP4M1uJNMwAgNosTkT0rM=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3664.eurprd04.prod.outlook.com (52.134.15.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Tue, 4 Jun 2019 05:42:02 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::4c3e:205:bec9:54ef]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::4c3e:205:bec9:54ef%4]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 05:42:02 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2 2/2] serial: imx: Use dev_info() instead of
 pr_info()
Thread-Topic: [EXT] [PATCH v2 2/2] serial: imx: Use dev_info() instead of
 pr_info()
Thread-Index: AQHVGoYOJ/ISPyvJlkuEZ+1/Wt4ey6aK+y9g
Date:   Tue, 4 Jun 2019 05:42:02 +0000
Message-ID: <VI1PR0402MB3600C770CEA827A2C5CBD500FF150@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190604033139.25546-1-festevam@gmail.com>
 <20190604033139.25546-2-festevam@gmail.com>
In-Reply-To: <20190604033139.25546-2-festevam@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c704793-bc54-4493-0911-08d6e8af5ebb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3664;
x-ms-traffictypediagnostic: VI1PR0402MB3664:
x-microsoft-antispam-prvs: <VI1PR0402MB366448D886D9423580913626FF150@VI1PR0402MB3664.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(14454004)(86362001)(99286004)(76176011)(66066001)(7696005)(9686003)(229853002)(74316002)(68736007)(6436002)(55016002)(110136005)(14444005)(256004)(8936002)(305945005)(76116006)(66946007)(81156014)(73956011)(8676002)(81166006)(6246003)(446003)(66476007)(64756008)(66446008)(4326008)(7736002)(25786009)(71200400001)(2501003)(71190400001)(53936002)(66556008)(476003)(2906002)(186003)(316002)(486006)(478600001)(6506007)(26005)(11346002)(102836004)(5660300002)(6116002)(4744005)(3846002)(33656002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3664;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f2esqUjG9HNQCe1acsyFo1wawwc9g673vRQsrYoIjmUCG3BPosrlOv25mIb6sxXgv6lv9KZaLWpLLzcWoEa3ZPCSRwm8rq7sKwK0sI84RpWHU3F6EFYQ5LChZOZaIK7M/Wp2rjy6qUqyFfC6K5Sh4LEXuoRyMEg67yg3SROYOdegByjHwx2aWbGtIJ6n6Jlkh9V1NmcEpWITpXuKIAu/sHRQlBJXCnp53DODtpDLJwAHzKmM1tAvn26AX1/PI+SXl0jdj7tfcTDMSwwO+MoyLmT6xE4MWYJJ887n0cQMWGmUVBdnYpFxCazupOjN71eMPYGPhJaXyF76RhGUJpTLCpIL76AApCQf6lB/LkLipSevj9Dc5ixq6f1RCx7lMlPOT4X3j38nyK86a46vLikBSPkibkPOArBgCL8XeK7V6j8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c704793-bc54-4493-0911-08d6e8af5ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 05:42:02.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3664
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
> - Fix typo in Subject
>=20
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> 8b752e895053..d8eadab02446 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2015,7 +2015,7 @@ imx_uart_console_get_options(struct imx_port
> *sport, int *baud,
>                 }
>=20
>                 if (*baud !=3D baud_raw)
> -                       pr_info("Console IMX rounded baud rate
> from %d to %d\n",
> +                       dev_info(sport->port.dev, "Console IMX
> rounded
> + baud rate from %d to %d\n",
>                                 baud_raw, *baud);
>         }
>  }
> --
> 2.17.1

