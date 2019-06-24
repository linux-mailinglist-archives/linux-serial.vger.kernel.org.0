Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0AEE507BA
	for <lists+linux-serial@lfdr.de>; Mon, 24 Jun 2019 12:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfFXKJR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 24 Jun 2019 06:09:17 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:35078
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730537AbfFXKIw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Jun 2019 06:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC5/9+zWwYcOKVyS8nZRQnYZ6he33VvqxFcxYvREW20=;
 b=jdUjvlJl2Ex8XA6/Iw2+KcGn4JQi/jZyn24j1VtP4w67ejSbD2/7MTCYlpsf04KtS6CPKSMvZO1G6IXUkB6CPs8Y8/ZEq/lOxdgjQNJ5rwEuU8rfoT6cWlfgMS7rRobnhV3DIy2wzhg2mZkTPYeY6XEEqxpC5eUXBDRvhBZcbqw=
Received: from AM6PR05MB6168.eurprd05.prod.outlook.com (20.178.94.209) by
 AM6PR05MB5442.eurprd05.prod.outlook.com (20.177.118.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 10:08:48 +0000
Received: from AM6PR05MB6168.eurprd05.prod.outlook.com
 ([fe80::5d42:62e2:18eb:c092]) by AM6PR05MB6168.eurprd05.prod.outlook.com
 ([fe80::5d42:62e2:18eb:c092%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 10:08:46 +0000
From:   Michael Shych <michaelsh@mellanox.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Hodaszi, Robert" <Robert.Hodaszi@digi.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: "No irq handler for vector" problem
Thread-Topic: "No irq handler for vector" problem
Thread-Index: AQHVKDldOPMq6dwWv0y/P7fHdq3NuKamVSgAgAAM/4CAAuOxcIAASjoAgAD2MmA=
Date:   Mon, 24 Jun 2019 10:08:45 +0000
Message-ID: <AM6PR05MB6168265CCF44FBCAEBBD4EA8D9E00@AM6PR05MB6168.eurprd05.prod.outlook.com>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com>
 <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de>
 <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com>
 <AM6PR05MB61689A1EE1E6B31682A476FAD9E10@AM6PR05MB6168.eurprd05.prod.outlook.com>
 <alpine.DEB.2.21.1906231955420.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906231955420.32342@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michaelsh@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbb93bd3-a76d-4ba6-c008-08d6f88bf250
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB5442;
x-ms-traffictypediagnostic: AM6PR05MB5442:
x-microsoft-antispam-prvs: <AM6PR05MB54428B6BDC3F18ED991C7BB6D9E00@AM6PR05MB5442.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(13464003)(189003)(199004)(6916009)(8936002)(9686003)(81156014)(6436002)(256004)(186003)(53936002)(26005)(4326008)(14444005)(33656002)(486006)(102836004)(76116006)(6506007)(99286004)(71200400001)(71190400001)(73956011)(2906002)(53546011)(64756008)(66476007)(66556008)(66066001)(229853002)(86362001)(476003)(446003)(7696005)(25786009)(66946007)(76176011)(11346002)(316002)(54906003)(8676002)(7736002)(81166006)(74316002)(6246003)(66446008)(55016002)(3846002)(52536014)(14454004)(6116002)(5660300002)(478600001)(305945005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5442;H:AM6PR05MB6168.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X5i2mPXNy3grGdAwSwoWhKVtA3tJML9alOj94rF2Cfzovx0XCyzrUjGgwJqAOKhgQFG9bUrEjIwQ1LSv2A+cL0nXCt8Q7I5dB3r59UBk1dhAV9W3cdFnBqfm/w9aMCYbtrkBrjSZGvdpXCn4z35XiGEWQxC8COi00Ws6NMaZSiABWLcxmFScoWwKx5l+FrWRBKsLTGzZ5BPnNVu8SFxQDCt956z036/HfjDF9BrNsYG+m6mg5NPR3MyIGwQVHNuTqupagHtt35zQlWEYs5nCDnlWyMvoyJQu4lD+cqLBqG9SOEJD9NwlftZwqsvD0L8yq3MmLF6zDmfIpDAqPsdiScIlzBl0QiMkYScVZJG0oNrqeqyXf5mIVx1L0akQE7KU6DObwlk5vn0le/lTTGLRp8b2yNTTH2nal6TNjvGHYVg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb93bd3-a76d-4ba6-c008-08d6f88bf250
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 10:08:46.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: michaelsh@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5442
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

>=20
> Michael,
>=20
> On Sun, 23 Jun 2019, Michael Shych wrote:
> >
> > > -----Original Message-----
> > > From: Hodaszi, Robert <Robert.Hodaszi@digi.com>
> > > Sent: Friday, June 21, 2019 8:47 PM
> > > To: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Michael Shych <michaelsh@mellanox.com>; x86@kernel.org; Vadim
> > > Pasternak <vadimp@mellanox.com>; Ido Schimmel
> > > <idosch@mellanox.com>; Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org>; linux-serial@vger.kernel.org
> > > Subject: RE: "No irq handler for vector" problem
>=20
> can you please teach your mail client not to copy the full header into th=
e
> reply. That's really not useful on a mailing list.
>=20
> > > On June 21, 2019 19:00:25 Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > Not freeing the vector would just paper over the problem. Can you t=
ry the
> > > > patch below?
> > > >
> >
> > Tried patch on our system. The problem still exist:
> >  [   49.802818] do_IRQ: 0.37 No irq handler for vector
>=20
> Stared some more into the interrupt code. I think Robert was on the right
> track, but I did not see the tree in the forest.
>=20
> The scenario he described can actually happen and yes, we should deactiva=
te
> the interrupt after the synchronize_hardirq() and not before. Tentative f=
ix
> below.
>=20
> Thanks,
>=20
> 	tglx
>=20
> 8<-------------
> --- a/kernel/irq/autoprobe.c
> +++ b/kernel/irq/autoprobe.c
> @@ -90,7 +90,7 @@ unsigned long probe_irq_on(void)
>  			/* It triggered already - consider it spurious. */
>  			if (!(desc->istate & IRQS_WAITING)) {
>  				desc->istate &=3D ~IRQS_AUTODETECT;
> -				irq_shutdown(desc);
> +				irq_shutdown_and_deactivate(desc);
>  			} else
>  				if (i < 32)
>  					mask |=3D 1 << i;
> @@ -127,7 +127,7 @@ unsigned int probe_irq_mask(unsigned lon
>  				mask |=3D 1 << i;
>=20
>  			desc->istate &=3D ~IRQS_AUTODETECT;
> -			irq_shutdown(desc);
> +			irq_shutdown_and_deactivate(desc);
>  		}
>  		raw_spin_unlock_irq(&desc->lock);
>  	}
> @@ -169,7 +169,7 @@ int probe_irq_off(unsigned long val)
>  				nr_of_irqs++;
>  			}
>  			desc->istate &=3D ~IRQS_AUTODETECT;
> -			irq_shutdown(desc);
> +			irq_shutdown_and_deactivate(desc);
>  		}
>  		raw_spin_unlock_irq(&desc->lock);
>  	}
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -314,6 +314,12 @@ void irq_shutdown(struct irq_desc *desc)
>  		}
>  		irq_state_clr_started(desc);
>  	}
> +}
> +
> +
> +void irq_shutdown_and_deactivate(struct irq_desc *desc)
> +{
> +	irq_shutdown(desc);
>  	/*
>  	 * This must be called even if the interrupt was never started up,
>  	 * because the activation can happen before the interrupt is
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -116,7 +116,7 @@ static bool migrate_one_irq(struct irq_d
>  		 */
>  		if (irqd_affinity_is_managed(d)) {
>  			irqd_set_managed_shutdown(d);
> -			irq_shutdown(desc);
> +			irq_shutdown_and_deactivate(desc);
>  			return false;
>  		}
>  		affinity =3D cpu_online_mask;
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -82,6 +82,7 @@ extern int irq_activate_and_startup(stru
>  extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
>=20
>  extern void irq_shutdown(struct irq_desc *desc);
> +extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
>  extern void irq_enable(struct irq_desc *desc);
>  extern void irq_disable(struct irq_desc *desc);
>  extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/random.h>
>  #include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/sched/rt.h>
> @@ -1699,6 +1700,7 @@ static struct irqaction *__free_irq(stru
>  	/* If this was the last handler, shut down the IRQ line: */
>  	if (!desc->action) {
>  		irq_settings_clr_disable_unlazy(desc);
> +		/* Only shutdown. Deactivate after synchronize_irq() */
>  		irq_shutdown(desc);
>  	}
>=20
> @@ -1768,6 +1770,14 @@ static struct irqaction *__free_irq(stru
>  		 * require it to deallocate resources over the slow bus.
>  		 */
>  		chip_bus_lock(desc);
> +		/*
> +		 * There is no interrupt on the fly anymore. Deactivate it
> +		 * completely.
> +		 */
> +		raw_spin_lock_irqsave(&desc->lock, flags);
> +		irq_domain_deactivate_irq(&desc->irq_data);
> +		raw_spin_unlock_irqrestore(&desc->lock, flags);
> +
>  		irq_release_resources(desc);
>  		chip_bus_sync_unlock(desc);
>  		irq_remove_timings(desc);
> @@ -1855,7 +1865,7 @@ static const void *__cleanup_nmi(unsigne
>  	}
>=20
>  	irq_settings_clr_disable_unlazy(desc);
> -	irq_shutdown(desc);
> +	irq_shutdown_and_deactivate(desc);
>=20
>  	irq_release_resources(desc);
>=20
>=20
>=20
>=20

Hi,

It significantly decreased appearance of the problem log (at least in my te=
sts),
But unfortunately, the problem still exists.

Regards,
    Michael.
