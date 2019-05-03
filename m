Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF99E12D3C
	for <lists+linux-serial@lfdr.de>; Fri,  3 May 2019 14:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfECMKk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 3 May 2019 08:10:40 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:33346
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727240AbfECMKk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 May 2019 08:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bbo6d+wEcpVgkuxEsag1sm8vi6gH/MVjbRnsyfl0sM=;
 b=G2zWelPMn8ps3cB6lqiFZP7wpJtCd8w2gUn9iCWg+tcqYDX7rxYUwXxinZ53NyuguAErXEcZvgxLZCeKEt7HGhhhuMTds55Pis6lIfZRwjoCq4CJSUjiq8sDmGzabklTfhyzL5W147SGQ1+WFQEV0302/vwwdKms84EltS3upOs=
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com (10.171.197.142) by
 HE1PR06MB3932.eurprd06.prod.outlook.com (20.176.165.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Fri, 3 May 2019 12:10:37 +0000
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::1c8a:d311:bbd9:826d]) by HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::1c8a:d311:bbd9:826d%4]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 12:10:37 +0000
From:   Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] serial: 8250: Fix TX interrupt handling condition
Thread-Topic: [PATCH] serial: 8250: Fix TX interrupt handling condition
Thread-Index: AQHU/ChxkZH9RbUwgU6kvPIvo3YCo6ZTNLuAgAYiV7A=
Date:   Fri, 3 May 2019 12:10:36 +0000
Message-ID: <HE1PR06MB30986E007789F2DAB69F2E33B4350@HE1PR06MB3098.eurprd06.prod.outlook.com>
References: <1556280367-28685-1-git-send-email-ext-kimmo.rautkoski@vaisala.com>
 <20190429141915.GB12903@kroah.com>
In-Reply-To: <20190429141915.GB12903@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Enabled=True;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_SiteId=6d7393e0-41f5-4c2e-9b12-4c2be5da5c57;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Owner=ext-kimmo.rautkoski@vaisala.com;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_SetDate=2019-05-03T12:10:35.0762862Z;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Name=Restricted;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Extended_MSFT_Method=Automatic;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Enabled=True;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SiteId=6d7393e0-41f5-4c2e-9b12-4c2be5da5c57;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Owner=ext-kimmo.rautkoski@vaisala.com;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SetDate=2019-05-03T12:10:35.0762862Z;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Name=No Label;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Parent=d5842b46-9b7a-431a-b662-8cc44ff92a4e;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Extended_MSFT_Method=Automatic;
 Sensitivity=Restricted No Label
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ext-kimmo.rautkoski@vaisala.com; 
x-originating-ip: [178.21.198.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08b18964-6253-4325-c4a0-08d6cfc05a05
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:HE1PR06MB3932;
x-ms-traffictypediagnostic: HE1PR06MB3932:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <HE1PR06MB3932B139E94E5D859F1B763EB4350@HE1PR06MB3932.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39850400004)(366004)(376002)(199004)(189003)(13464003)(7696005)(76176011)(53546011)(6506007)(68736007)(4326008)(2351001)(14454004)(2501003)(81166006)(55016002)(102836004)(99286004)(316002)(81156014)(25786009)(33656002)(66066001)(9686003)(26005)(6916009)(6246003)(53936002)(6436002)(74316002)(5640700003)(86362001)(446003)(11346002)(14444005)(478600001)(476003)(186003)(8676002)(7736002)(229853002)(5660300002)(1730700003)(8936002)(305945005)(52536014)(73956011)(66556008)(486006)(66446008)(76116006)(64756008)(66476007)(71190400001)(71200400001)(3846002)(6116002)(2906002)(66946007)(256004)(326664003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB3932;H:HE1PR06MB3098.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qsONqEuPKJoDoQuTSCjzlPeXkgD7Ich95Dd5yYKHlDGs/DKx1GHoV5F6hUONhrd/M8KxNQ/qqBAtYdnE8Fce26f4XhxPMZILnxHxXLAgFmWkKjsGnm6D8eFstV1QykKgSSfqW9Y6Bxv/GkRAfroCoDPQABJtuQMV5bePwDGQk5dnMOhNg5HVZ33tlrMfWKJMkXTrviaWPdn2UxXjysbDuLbuMdM6kx+iE7WIneDoyiRUUIwd/K4cC3UlLb4dDTuDxCgkeW26gprLsE/bLVvYdSyvw1nAV+AhjzM9rQCAKBnko22z9+CMhNXYC2tx4KdH1uWHbWP4wgImX4GiBcMduFZddLj6LkW6JqklqcvMwpdCAztH8RzOj+2xzCEHWp8PKK7eNJa3je8+N3k4U2Zj37PrM9l71e+fCRlTDXEHsac=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b18964-6253-4325-c4a0-08d6cfc05a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 12:10:37.0121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3932
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Monday, 29 April, 2019 17:19
> To: Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
> Cc: linux-serial@vger.kernel.org
> Subject: Re: [PATCH] serial: 8250: Fix TX interrupt handling condition
>=20
> On Fri, Apr 26, 2019 at 12:06:13PM +0000, Rautkoski Kimmo EXT wrote:
> > Interrupt handler checked THRE bit (transmitter holding register
> > empty) in LSR to detect if TX fifo is empty.
> > In case when there is only receive interrupts the TX handling
> > got called because THRE bit in LSR is set when there is no
> > transmission (FIFO empty). TX handling caused TX stop, which in
> > RS-485 half-duplex mode actually resets receiver FIFO. This is not
> > desired during reception because of possible data loss.
> >
> > The fix is to use IIR instead of LSR to detect the TX fifo status.
> > This ensures that TX handling is only called when there is really
> > an interrupt for THRE and not when there is only RX interrupts.
> >
> > Signed-off-by: Kimmo Rautkoski <ext-kimmo.rautkoski@vaisala.com>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> > index d2f3310..91ca0ca 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1875,7 +1875,7 @@ int serial8250_handle_irq(struct uart_port *port,
> unsigned int iir)
> >  			status =3D serial8250_rx_chars(up, status);
> >  	}
> >  	serial8250_modem_status(up);
> > -	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE))
> > +	if ((!up->dma || up->dma->tx_err) && (iir & UART_IIR_THRI))
> >  		serial8250_tx_chars(up);
>=20
> This feels wrong to me, can someone else test this to verify that it
> really does work properly?  I don't have access to any 8250 devices at
> the moment :(
>=20
> thanks,
>=20
> greg k-h

Thanks for checking this. There is indeed a problem with the patch. Interru=
pt ID in Interrupt Identification register is actually 3 bits, so the check=
 should be different: ((iir & UART_IIR_ID) =3D=3D UART_IIR_THRI)

I'll send v2 of the patch soon.

BR,
Kimmo
