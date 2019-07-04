Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F075F8AC
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 14:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfGDM7Z (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 08:59:25 -0400
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:54158
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfGDM7Z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 08:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1r7olbOJzI+O0DgZwHCJ/4QMdoDu3qMbhgqioLsJwE=;
 b=cEzQiyJYq9Wczhc7KcJL1og2X2djWeHpou5cAG300IPUJirKrY2Lknt+yaVrCGvLFK2LannttAk7jkqmtw0zbT5dckzZap433mfeGAN5/zZmMzIBCIGpt5fIjYeh65BPX2iWwp3b65wKcPhfiwWC8RiAeGZXaOv4ZOyCX4XIEN0=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB2943.eurprd04.prod.outlook.com (10.175.24.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Thu, 4 Jul 2019 12:59:19 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::cddf:10d0:7cb3:c4cc]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::cddf:10d0:7cb3:c4cc%4]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 12:59:19 +0000
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
Thread-Index: AQHVMlCR4GzB5FciE0WEjqwgXxYLeaa6QCgAgAAHvVCAAAUWAIAAHr4A
Date:   Thu, 4 Jul 2019 12:59:18 +0000
Message-ID: <VI1PR0402MB360031C734CE53F3AF387966FFFA0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190704100021.10859-1-fugang.duan@nxp.com>
 <20190704100021.10859-3-fugang.duan@nxp.com>
 <20190704102234.GA11348@kroah.com>
 <VI1PR0402MB3600709B910F30AB94C6AFEDFFFA0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <20190704110828.GF1404@kroah.com>
In-Reply-To: <20190704110828.GF1404@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a08e410-6746-4226-045b-08d7007f6d59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2943;
x-ms-traffictypediagnostic: VI1PR0402MB2943:
x-microsoft-antispam-prvs: <VI1PR0402MB29433F7F4B9B9C3CF9D4515BFFFA0@VI1PR0402MB2943.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(6246003)(6916009)(66556008)(66476007)(64756008)(53936002)(55016002)(2906002)(6116002)(3846002)(229853002)(4744005)(33656002)(74316002)(7736002)(68736007)(66946007)(305945005)(73956011)(66446008)(76116006)(14454004)(476003)(486006)(102836004)(6506007)(71200400001)(5660300002)(446003)(9686003)(14444005)(256004)(186003)(76176011)(52536014)(11346002)(71190400001)(7696005)(316002)(8936002)(99286004)(86362001)(6436002)(26005)(81156014)(81166006)(25786009)(54906003)(4326008)(478600001)(66066001)(8676002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2943;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2rbeuCZsg0AbpUDUnCQhzIzzOCbeU/DuzWFEjITBdWtizmC/eu4u63A4vZAWKK+DnffNqRAR/JlHQiP9aWgsfQ/IqM6/NYwfSS5W+JyYTrxXsFcUMIkAqw2i37LgdYxrlZB30KXaQnncel4Cg9R6FafyZ0sRCyKLC6WLYK+a0MILMUNyMZj5tZ+VmXlYFzHvMjaa0g1OVmO5+wRzN8wedk6JK04TyU268pNCu9W7Qn5UCJ+DkmCzfRzq1on7Lli37+ArA5sYXnmPy01ldV6j7ZWzV0ChHCe1AdnARz5kiMnbtdjH9L+VGbwbE6ravkMbJrih7no0OPcnFjAu0a21oDXP0qA43e2VrDN8C0N4tEwObdIkZ69qL2vFUwvkpCpDVU8K+y/JkZ+nf4WSSOvAY8JW1T3f8XLZ2LgsqyTPGjQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a08e410-6746-4226-045b-08d7007f6d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 12:59:18.5445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2943
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org> Sent: Thursday, July 4, 2019 7:0=
8 PM
> On Thu, Jul 04, 2019 at 10:55:06AM +0000, Andy Duan wrote:
> > From: Greg KH <gregkh@linuxfoundation.org> Sent: Thursday, July 4,
> > 2019 6:23 PM
> > > On Thu, Jul 04, 2019 at 06:00:21PM +0800, fugang.duan@nxp.com wrote:
> > > > From: Fugang Duan <fugang.duan@nxp.com>
> > > >
> > > > Add the baud clock requirement for imx8qxp.
> > > >
> > > > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > dt stuff needs to cc: the dt maintainers, right?
> >
> > Right, I will resend the binding doc patch and cc the maintainers.
> > And does I need to resend the lpuart driver patch ?
>=20
> Shouldn't the binding doc be 1/2 here anyway?  So please resend the whole
> series.
>=20
> thanks,
>=20
> greg k-h

Okay, I will resend the whole patch, thanks very much!
