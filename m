Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8274FBF8
	for <lists+linux-serial@lfdr.de>; Sun, 23 Jun 2019 15:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfFWN5I (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 23 Jun 2019 09:57:08 -0400
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:39780
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726429AbfFWN5I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 23 Jun 2019 09:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMa8M4A2gzXWaa/1oGV915/whUdJE2ZuR3e90f0C8Tw=;
 b=gaTfnBNZJRBFPJXhOFDHlaQC8e1pJusSyHHVVs++MD+DSL8UM4yyP2zT0MVrRqisRylyvkqRF5BygIeT8gcPNSX6VI5I9P18YFO73hN5kp8oJX3dJIDDN9RdzXdxyZJhhkP1fddfy22z0m56+Pm2R2lmQuVL1SCky47laML5Hjg=
Received: from AM6PR05MB6168.eurprd05.prod.outlook.com (20.178.94.209) by
 AM6PR05MB5601.eurprd05.prod.outlook.com (20.177.188.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Sun, 23 Jun 2019 13:57:01 +0000
Received: from AM6PR05MB6168.eurprd05.prod.outlook.com
 ([fe80::5d42:62e2:18eb:c092]) by AM6PR05MB6168.eurprd05.prod.outlook.com
 ([fe80::5d42:62e2:18eb:c092%6]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 13:57:01 +0000
From:   Michael Shych <michaelsh@mellanox.com>
To:     "Hodaszi, Robert" <Robert.Hodaszi@digi.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: "No irq handler for vector" problem
Thread-Topic: "No irq handler for vector" problem
Thread-Index: AQHVKDldOPMq6dwWv0y/P7fHdq3NuKamVSgAgAAM/4CAAuOxcA==
Date:   Sun, 23 Jun 2019 13:57:01 +0000
Message-ID: <AM6PR05MB61689A1EE1E6B31682A476FAD9E10@AM6PR05MB6168.eurprd05.prod.outlook.com>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com>
 <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de>
 <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com>
In-Reply-To: <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michaelsh@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a118942e-3611-4ff3-caf5-08d6f7e2aabc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB5601;
x-ms-traffictypediagnostic: AM6PR05MB5601:
x-microsoft-antispam-prvs: <AM6PR05MB5601073B59E18324EA61D919D9E10@AM6PR05MB5601.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(366004)(376002)(39860400002)(396003)(136003)(13464003)(199004)(189003)(7696005)(54906003)(26005)(6436002)(8676002)(305945005)(229853002)(486006)(52536014)(8936002)(81166006)(5660300002)(11346002)(3846002)(102836004)(110136005)(6116002)(14454004)(68736007)(4326008)(81156014)(446003)(86362001)(2906002)(55016002)(6246003)(73956011)(9686003)(64756008)(316002)(256004)(186003)(66556008)(478600001)(66476007)(66446008)(74316002)(76176011)(53546011)(53936002)(476003)(71190400001)(66066001)(6506007)(25786009)(7736002)(76116006)(14444005)(71200400001)(66946007)(99286004)(33656002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5601;H:AM6PR05MB6168.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oBmOu0USfNps3Wb5VRezGaOphQLXVhwy1JObsmsIImgB6wYp84gqCe5OhlIThXNwBif2YOIGtf3HCGsnCyqoA1X02M1UJAAe36HxxigyL9Us4IS7VF+Ltl9Z83z89b2uiBfdyCVOF7QJVd0X3/d9efzdAWARVOjgiZPBO+/PbL2eSS4rMF9z6skoQdCe7hgFwgajznjKYS24Qq18bNb+h5zaexBzbYB/sjbh+vi/4jEt7LDBFgTSlJip1wnOwFObUZNc3EobsYbROX75RKLI5DsQ9aRycyNzYTB6551fvKyM9qUn0Co5jYfiJYsL8MRiYG6eFQdC8vZwC+cn1VGgr9rj9Od/ee7ytE1ZvYkwz1jMe1huPZ3RmFe+yBkFsUux2wunnwR02cf6AO/J6S4qx/JmcEXyi3QbP838+ZC0ZRo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a118942e-3611-4ff3-caf5-08d6f7e2aabc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 13:57:01.7683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: michaelsh@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5601
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Hodaszi, Robert <Robert.Hodaszi@digi.com>
> Sent: Friday, June 21, 2019 8:47 PM
> To: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michael Shych <michaelsh@mellanox.com>; x86@kernel.org; Vadim
> Pasternak <vadimp@mellanox.com>; Ido Schimmel
> <idosch@mellanox.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; linux-serial@vger.kernel.org
> Subject: RE: "No irq handler for vector" problem
>=20
>=20
> On June 21, 2019 19:00:25 Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> > On Fri, 21 Jun 2019, Hodaszi, Robert wrote:
> >>
> >>
> >> Also, it seems, if I'm running the serial port opening-closing process
> >> on the same core as the interrupt is assigned to, I'm not getting the
> >> error message. If I'm running it on a different core, most of the time=
,
> >> I'm getting the error message.
> >
> > ...
> >
> >> Unfortunately, I'm stuck at this point a bit. Don't really know, what
> >> would be the proper solution (how could I avoid free'ing up a pending
> >> IRQ's vector), also I'm not knowing the x86 part of the kernel very we=
ll
> >> yet.
> >
> > Not freeing the vector would just paper over the problem. Can you try t=
he
> > patch below?
> >
> > Thanks,
> >
> > tglx
> >
> > 8<------------------
> > diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_a=
pic.c
> > index 53aa234a6803..189db40b0524 100644
> > --- a/arch/x86/kernel/apic/io_apic.c
> > +++ b/arch/x86/kernel/apic/io_apic.c
> > @@ -3003,8 +3003,8 @@ void mp_irqdomain_deactivate(struct irq_domain
> *domain,
> >      struct irq_data *irq_data)
> > {
> >  /* It won't be called for IRQ with multiple IOAPIC pins associated */
> > - ioapic_mask_entry(mp_irqdomain_ioapic_idx(domain),
> > -  (int)irq_data->hwirq);
> > + clear_IO_APIC_pin(mp_irqdomain_ioapic_idx(domain),
> > +  (unsigned int)irq_data->hwirq);
> > }
> >
> > int mp_irqdomain_ioapic_idx(struct irq_domain *domain)
>=20
Hi,

Tried patch on our system. The problem still exist:
 [   49.802818] do_IRQ: 0.37 No irq handler for vector

Michael.

> I can try it on Monday. Thanks!
>=20
> Robert
