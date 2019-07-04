Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC15F6DC
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 12:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfGDKzK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 06:55:10 -0400
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:64823
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727512AbfGDKzK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 06:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOKS9j2X/aScvt3b9uNbwp4eey5mu4eY6JWW/gLup6k=;
 b=QLVH+x6Gym9S/ssB9ou6YaXokAq6zQDq1xE/RcwxKE4wEFXKw/+/VOghqqcamEBuvxTzJ0dn/j3lZ1bI5dTahR2sCHo6nRcuuypNI8sSr8pUJcJJmY+keRnTlDaHPgeSMCBRqrCxwbdF3kCQxJ0aHVVGo0LgQpTkvRY4YKGgylQ=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3438.eurprd04.prod.outlook.com (52.134.3.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 10:55:06 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::cddf:10d0:7cb3:c4cc]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::cddf:10d0:7cb3:c4cc%4]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 10:55:06 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [EXT] Re: [PATCH tty/serial 2/2] dt-bindings: serial: lpuart: add
 the clock requirement for imx8qxp
Thread-Topic: [EXT] Re: [PATCH tty/serial 2/2] dt-bindings: serial: lpuart:
 add the clock requirement for imx8qxp
Thread-Index: AQHVMlCR4GzB5FciE0WEjqwgXxYLeaa6QCgAgAAHvVA=
Date:   Thu, 4 Jul 2019 10:55:06 +0000
Message-ID: <VI1PR0402MB3600709B910F30AB94C6AFEDFFFA0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190704100021.10859-1-fugang.duan@nxp.com>
 <20190704100021.10859-3-fugang.duan@nxp.com>
 <20190704102234.GA11348@kroah.com>
In-Reply-To: <20190704102234.GA11348@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1baaa9fa-3ade-4f4c-a9c5-08d7006e133e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3438;
x-ms-traffictypediagnostic: VI1PR0402MB3438:
x-microsoft-antispam-prvs: <VI1PR0402MB34385BB1364F719537DD8763FFFA0@VI1PR0402MB3438.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(305945005)(4326008)(14454004)(25786009)(66066001)(81156014)(4744005)(26005)(5660300002)(74316002)(6246003)(53936002)(81166006)(8936002)(7736002)(99286004)(6436002)(6506007)(9686003)(76176011)(55016002)(73956011)(6916009)(7696005)(33656002)(186003)(52536014)(229853002)(68736007)(102836004)(76116006)(66556008)(66446008)(66946007)(8676002)(64756008)(66476007)(2906002)(71200400001)(6116002)(3846002)(11346002)(486006)(86362001)(446003)(476003)(256004)(71190400001)(14444005)(54906003)(316002)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3438;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MUib9gJDjYUAtrrz7R0hwVpHziEVnrmObd9T/q8ZJNJpsg1zJcrVbbc2GlERRKyLd3UEzRv3DAwHBlZ+asm0o06E5Rp6hGlEeqTM1TQ3fvPHJ27EQNEQWnDV4VSwm4wjId1kK4vqqAisBMwthzwFN8WFqC1n3Kp+ncCfP0Be7Nt3ou1MxRr5PE5Tf7RFSWOJaKmdRYOTKePaGOPBBjfs+t/4CXq778yJ2uZGB+cag2/zYWKVzRSG5F80hgHyCs8ywcK4T/P6PNy6G0+h0ufygaQclyngjnq4Xg0ltDEzJ6D89x7GQSU90gERNava4jH0HG0LvnaBrjJCpIcpIL1i2jbg6DqqV35+e/wTgHqjxTBbtyIfFGJGBVnBuIJEnTae39WSqDBhR6eX0oTEo2g1xV+tyhXgZLJAopy8z3JUcsU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baaa9fa-3ade-4f4c-a9c5-08d7006e133e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 10:55:06.5001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3438
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org> Sent: Thursday, July 4, 2019 6:2=
3 PM
> On Thu, Jul 04, 2019 at 06:00:21PM +0800, fugang.duan@nxp.com wrote:
> > From: Fugang Duan <fugang.duan@nxp.com>
> >
> > Add the baud clock requirement for imx8qxp.
> >
> > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> dt stuff needs to cc: the dt maintainers, right?

Right, I will resend the binding doc patch and cc the maintainers.
And does I need to resend the lpuart driver patch ?

Thanks!
