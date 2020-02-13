Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3A215CD33
	for <lists+linux-serial@lfdr.de>; Thu, 13 Feb 2020 22:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgBMVZa (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 13 Feb 2020 16:25:30 -0500
Received: from mail-db8eur05on2071.outbound.protection.outlook.com ([40.107.20.71]:6023
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727754AbgBMVZa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Feb 2020 16:25:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nc7CG7ZrkY59iZsCmGzWQADlxd0jRqZj/vkU1gnJBkTwVXcP40w7wAzjn+ZZa65DFaIiBrxd7sMSOvkchu+V8MtcGKTXsM120Rh4LrmxMS5OG/oBs2rdGnZBhTYCzDCqpSDzBcKA9P/+7NyteYPETOEY4DkQ1gUFMtF/tqzxEtUzOawuvURz5dXudHxf66jf9wF64FPnP4MVvQShL0CO8MtQvTNz1Eb0gG2zDIghVQ3xHKqef9M3ALEOidQqhcZMazTAt8GqphB0UQRGP8EvMDJHkl9MqVKtZn8ZJwU9Yacnuk8QrCMgvaP3sqWjQEGodEAVlnCHu7iXYUrLjQNC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxxWoRx44chqG0YiHPzaigHafOdDOYU7n5YJHTyuiQE=;
 b=a9Hy8d0QbutxQ46YWudMPhTHmPUic1kChflfD9yfpFhm+RZJeDaAgjweyoXKrPUb1pc5Ps2hNLPd6qvskWBSesp8YoYT1yK0b0NWU4Ku/TZbuLHnoVDNMH+iyMQOxoIATHQRTF+u6BdLR9ikXOlt4ZIQjrzqQk9qppMAhcye27VdWuODoq7tfV+ZfTeGZIL1ip338meO37WzXI1/jNupbfPf1CwzFKPIKQurfmvgXxI042u/2bGmoTYqV6S6Uu88YDWfFLmY0OqI4NuZkcirvCxBab4p+LqUuSLudqxC4AE45nMC1sXv4zIPMIFpcqGW8aqmXw7ff/cxeo5GJb9yQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxxWoRx44chqG0YiHPzaigHafOdDOYU7n5YJHTyuiQE=;
 b=NUzPqc77SlVhdHdEjddZm9YYj+tZRroiMNZ+3OlD08KPzN0bNuZp/N9xRfpjw2/fVei4ZsuW1PKWyRMgZuopA0qgWK2GkyGYIXOc59DJ8Rm4TQCPhHTajVSvZniVcDnG6K9aHHrdbqCVGt6TUpUcgnS7Vd2fh1UgwvSbRALGU5o=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6767.eurprd04.prod.outlook.com (20.179.234.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 13 Feb 2020 21:25:14 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23%2]) with mapi id 15.20.2729.025; Thu, 13 Feb 2020
 21:25:14 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@kernel.org>
CC:     Qiang Zhao <qiang.zhao@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] serial: cpm_uart: call cpm_muram_init before registering
 console
Thread-Topic: [PATCH] serial: cpm_uart: call cpm_muram_init before registering
 console
Thread-Index: AQHV4mLcwlaGVGakwUiwrPknOrcTP6gZozHw
Date:   Thu, 13 Feb 2020 21:25:13 +0000
Message-ID: <VE1PR04MB668747A445A3882DCDAE60358F1A0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20200213114342.21712-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20200213114342.21712-1-linux@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43304c2f-83a4-40e5-cb37-08d7b0cb36dd
x-ms-traffictypediagnostic: VE1PR04MB6767:|VE1PR04MB6767:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB67670C4500771158D683CA088F1A0@VE1PR04MB6767.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:156;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(189003)(199004)(9686003)(71200400001)(55016002)(8936002)(110136005)(478600001)(8676002)(66476007)(66556008)(64756008)(2906002)(54906003)(66446008)(66946007)(76116006)(33656002)(5660300002)(81156014)(81166006)(7696005)(26005)(186003)(86362001)(4326008)(52536014)(6506007)(316002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6767;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LN1JDcIYObKkD6Js+Jb1ZA8EDHXFCuB3F4b+L3LCbTMOs/FDm7dClDko96tAoVog9EYIkAasUp/QrjNQh4rRllpcuLJj3SOv0bPP0nUeHcfSjp0PDpMZoGX2G8FJ/Kq7t7XU+oT/sUwD5rCbdLnIW6/scDml4nNtLsbt+C5Yy+dhMSpRkoO5wj9BarFmtJcESCC8eFuQ23vigu0hovc8mn18w2bNDCEkC6Dlps5itwDSZY+xc1s9+IwI58A7FAkO9UmfQXnk+km5qVnuux/bw7u6zE0BHawt5SvM5N7iyW+bTODKyY5Ce3NodpTYVIP4t241CMojooTkVr6ZtkRWBR794/1WDayYQFLe5Ued9gTiQwXOpOUnvjCWOalT3iEQz7W/vB8Yz5kzEx2IwQIDEVMUXmCyBNP253an0qbjBIEdJbbWji5Ur0vn2TCwpJL2
x-ms-exchange-antispam-messagedata: qla6gQ7Lp/TH+/6d8UXku6wCTZegVbiwkmbS9B4fNpFrT6WV0UJsw7uvvAgOfv4hcKOLMLA1N3WeBMmg9UVjXT9UVTVndrdgUPraT5H8CFkXLfBQhyo7xv24aoKowey9Tgiux+yos9jioBbzRcvMRQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43304c2f-83a4-40e5-cb37-08d7b0cb36dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 21:25:13.9970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgS7X0PFVHkhyxXMwR1gWUJryMXACQmXBTzu/a5i8D7Ds5rlAgurI3TfPzlJydhOsrYbvo0L4MtvFHEAg6AFhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6767
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Thursday, February 13, 2020 5:44 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby
> <jslaby@suse.com>; Timur Tabi <timur@kernel.org>; Leo Li
> <leoyang.li@nxp.com>; Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>; linuxppc-dev@lists.ozlabs.org; Scott
> Wood <oss@buserror.net>; Christophe Leroy <christophe.leroy@c-s.fr>;
> linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] serial: cpm_uart: call cpm_muram_init before registering
> console
>=20
> Christophe reports that powerpc 8xx silently fails to 5.6-rc1. It turns o=
ut I was
> wrong about nobody relying on the lazy initialization of the cpm/qe muram=
 in
> commit b6231ea2b3c6 (soc: fsl: qe: drop broken lazy call of
> cpm_muram_init()).
>=20
> Rather than reinstating the somewhat dubious lazy call (initializing a cu=
rrently
> held spinlock, and implicitly doing a GFP_KERNEL under that spinlock), ma=
ke
> sure that cpm_muram_init() is called early enough - I thought the calls f=
rom
> the subsys_initcalls were good enough, but when used by console drivers,
> that's obviously not the case. cpm_muram_init() is safe to call twice (th=
ere's
> an early return if it is already initialized), so keep the call from cpm_=
init() - in
> case SERIAL_CPM_CONSOLE=3Dn.
>=20
> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: b6231ea2b3c6 (soc: fsl: qe: drop broken lazy call of cpm_muram_ini=
t())
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>=20
> Christophe, can I get you to add a formal Tested-by?
>=20
> I'm not sure which tree this should go through.
>=20
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> index 19d5a4cf29a6..d4b81b06e0cb 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> @@ -1373,6 +1373,7 @@ static struct console cpm_scc_uart_console =3D {
>=20
>  static int __init cpm_uart_console_init(void)  {
> +	cpm_muram_init();
>  	register_console(&cpm_scc_uart_console);
>  	return 0;
>  }
> --
> 2.23.0

