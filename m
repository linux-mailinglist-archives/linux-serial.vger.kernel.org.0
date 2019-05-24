Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE1A29322
	for <lists+linux-serial@lfdr.de>; Fri, 24 May 2019 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbfEXIcB (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 24 May 2019 04:32:01 -0400
Received: from mail-eopbgr00040.outbound.protection.outlook.com ([40.107.0.40]:27872
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389615AbfEXIcB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 May 2019 04:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5ouZHqRtz775poGXiiafeLxFu3pxRYxbSYAMpSto6Q=;
 b=nfYkbBvTgCM6aMxARZ13liyJnRWY8l7sNkSNkPNxoR2XJFFyrbqntKHRrIV3ffTIXr186pY3Pvp5sjFc5EDV6c57LjqT3ay1joyheN4VPJBMLnL8pWKx3EYe4UTWpWQ2e/AnDQbXMb/k9FLrVCoY/UHfbEcKebgpA+6b4S8fiDc=
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com (10.171.197.142) by
 HE1PR06MB4060.eurprd06.prod.outlook.com (20.176.165.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Fri, 24 May 2019 08:31:55 +0000
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::b9fe:93:6eb9:335b]) by HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::b9fe:93:6eb9:335b%6]) with mapi id 15.20.1922.017; Fri, 24 May 2019
 08:31:55 +0000
From:   Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH v3] serial: 8250: Fix TX interrupt handling condition
Thread-Topic: [PATCH v3] serial: 8250: Fix TX interrupt handling condition
Thread-Index: AQHVEfyQRiqKWGJ2tUyxjQvDcsJqTqZ56J0AgAAJLsA=
Date:   Fri, 24 May 2019 08:31:55 +0000
Message-ID: <HE1PR06MB3098F094B58FBF2614BF65EFB4020@HE1PR06MB3098.eurprd06.prod.outlook.com>
References: <1558680424-57578-1-git-send-email-ext-kimmo.rautkoski@vaisala.com>
 <20190524075712.GC31438@kroah.com>
In-Reply-To: <20190524075712.GC31438@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Enabled=True;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_SiteId=6d7393e0-41f5-4c2e-9b12-4c2be5da5c57;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Owner=ext-kimmo.rautkoski@vaisala.com;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_SetDate=2019-05-24T08:31:53.4463707Z;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Name=Restricted;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Extended_MSFT_Method=Automatic;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Enabled=True;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SiteId=6d7393e0-41f5-4c2e-9b12-4c2be5da5c57;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Owner=ext-kimmo.rautkoski@vaisala.com;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SetDate=2019-05-24T08:31:53.4463707Z;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Name=No Label;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Parent=d5842b46-9b7a-431a-b662-8cc44ff92a4e;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Extended_MSFT_Method=Automatic;
 Sensitivity=Restricted No Label
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ext-kimmo.rautkoski@vaisala.com; 
x-originating-ip: [87.100.166.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bc996eb-2f78-4726-6be8-08d6e022479a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:HE1PR06MB4060;
x-ms-traffictypediagnostic: HE1PR06MB4060:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <HE1PR06MB40608764655D411082B2CCB9B4020@HE1PR06MB4060.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(366004)(346002)(376002)(136003)(51914003)(199004)(189003)(13464003)(54534003)(81166006)(6916009)(81156014)(8936002)(2501003)(66446008)(64756008)(478600001)(316002)(256004)(53936002)(99286004)(14454004)(26005)(5640700003)(86362001)(9686003)(305945005)(25786009)(71200400001)(71190400001)(3846002)(6116002)(55016002)(6436002)(14444005)(7736002)(76176011)(2351001)(5660300002)(1730700003)(229853002)(68736007)(8676002)(186003)(2906002)(6246003)(66066001)(4326008)(7696005)(6506007)(53546011)(66556008)(76116006)(66476007)(486006)(33656002)(52536014)(73956011)(11346002)(476003)(66946007)(446003)(74316002)(102836004)(326664003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB4060;H:HE1PR06MB3098.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QTHbYdZRRBnM1u+D+CPUbQs4Wo9/wslhD/G4K6sAcsONUeARPsYrAfyNmWnkUny8zOI+EfQ6G+nkr82duxWlX+SaKGuIQLaQWh5a5Ui3M4cnc5IN55ezNavWb3dRsixU0gKNTdb9akC3KwTCd533DaCVdEK2uN3ccU36XtkxSHQJ6etUliJ50n6gD7Uz5+3SxqqQOma8NER+cntnWPIVJ+aAoy2jSX1fZ0z27q84N3Y938DznkpJhvCeNUE2ZJdBuDqca85aFaFKX6ZTGbV5VKWrirUxOy52I6TBUzgnMvcwE1yGh9+WxcoSDRA28TOutKnfOhMfu6eijMd6b2CWF2sXKD0S03oI5xONwvtslzMt2s4ZQJ5IQwYftJhJL82cea0yjUtr5y6ZZzk9C7XZf1V0VU9GS2XxsqCzPVz1Hs4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc996eb-2f78-4726-6be8-08d6e022479a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 08:31:55.3116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ext-kimmo.rautkoski@vaisala.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB4060
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Friday, 24 May, 2019 10:57
> To: Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
> Cc: linux-serial@vger.kernel.org
> Subject: Re: [PATCH v3] serial: 8250: Fix TX interrupt handling condition
>=20
> On Fri, May 24, 2019 at 06:47:33AM +0000, Rautkoski Kimmo EXT wrote:
> > Interrupt handler checked THRE bit (transmitter holding register
> > empty) in LSR to detect if TX fifo is empty.
> > In case when there is only receive interrupts the TX handling
> > got called because THRE bit in LSR is set when there is no
> > transmission (FIFO empty). TX handling caused TX stop, which in
> > RS-485 half-duplex mode actually resets receiver FIFO. This is not
> > desired during reception because of possible data loss.
> >
> > The fix is to check if THRI is set in IER in addition of the TX
> > fifo status. THRI in IER is set when TX is started and cleared
> > when TX is stopped.
> > This ensures that TX handling is only called when there is really
> > transmission on going and an interrupt for THRE and not when there
> > are only RX interrupts.
> >
> > Signed-off-by: Kimmo Rautkoski <ext-kimmo.rautkoski@vaisala.com>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
>=20
> What changed from all of the previous versions of this patch?  That
> needs to go below the --- line.
>=20
> Please fix up and resend a v4.
>=20
> thanks,
>=20
> greg k-h

Thanks for the reminder.

I'll post v4 with changelog soon.

BR,
Kimmo
