Return-Path: <linux-serial+bounces-679-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461DC80B3F5
	for <lists+linux-serial@lfdr.de>; Sat,  9 Dec 2023 12:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FC61C2091A
	for <lists+linux-serial@lfdr.de>; Sat,  9 Dec 2023 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAE13FEC;
	Sat,  9 Dec 2023 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="ab2hKpIA"
X-Original-To: linux-serial@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6D0E7;
	Sat,  9 Dec 2023 03:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702121091; x=1702725891; i=linosanfilippo@gmx.de;
	bh=85evGRCJ3tCE0nbUckGUxFOChy15m1jRdB9q8Rfhw7U=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ab2hKpIALjqpW1/N6A3JhJrfll/qcmALE0stPvLHiOAt9HnTo6YO22Y2aShbbJ4a
	 Hhjx6MqgwcpYCjaacCNOx0IZtR5Q5gekwsl/wJqfK6OT77Xt0qbfRQfzh8gSDR3+h
	 ArKxyItqZptHfufLmr1gW5gpBG40pOmAO1ZBy+H7aOrMDhgNqttiQ7LBM/iKcZLuj
	 xKOwY5oit7wYKhsaqq60KirKCs1vg54pjeMj/6wL0SBot+NF1wyQx8L7qRaZXMFjc
	 9dsP9mhAvkvkq1/+Y2EI1P+G1ypmZjbOXLJmSse9tIbr4blCVzgCJTxhmIokWQVEu
	 fsNb5gpDWvGCIR9rfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.3.177]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1rd2jw43BC-00inxw; Sat, 09
 Dec 2023 12:24:51 +0100
Message-ID: <f03be8c2-4aef-4949-8797-3998cc7081ec@gmx.de>
Date: Sat, 9 Dec 2023 12:24:48 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Lukas Wunner <lukas@wunner.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "brenda.streiff@ni.com" <brenda.streiff@ni.com>,
 Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
 Tomas Paukrt <tomaspaukrt@email.cz>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
 <ZXG8DI8diij72fBR@smile.fi.intel.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <ZXG8DI8diij72fBR@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BlNMhKf4hOn8nZ5VNdviNti3SIQY3MKvaRGu+LAugRLCx7QQqMT
 FFnqifRU8Kg2D9NDyUAGq5jkD0KCI9PlanSp/Jx0e3SoULmPRa8ER43IqXMCh/zadPNrwwk
 urE6NNOTrdD6s4k61J0eMU+LOtsSwbIAIkzSH9NpAZgY/4wGwDMmziLeI2CpMIc/ik7XQkd
 FEvSd+N9SqtfH6jhI+NPA==
UI-OutboundReport: notjunk:1;M01:P0:v1c/O4aGaHQ=;zEVAzSrV+86469QKPHUQro+41JV
 /qoyx8SjuPwLqfJyP6x90+CMDemY2FAq0ESg+srcF7Dgitf3/dVynlwyT6rU9SYfQfCvMTCd4
 VekXifIwSdvGU8G6mxD2MwpjH6EESwy4KECLfeWy5cRexsnVCfjRtFDHwmwgo7o4v4mLDXz/4
 RbcCmNhHZ42XhYFc+IRHcHlvXisSZHZZ2lwxQqFE439M8/rZs+6s9/ryNNkTDG+z95G89ET5G
 BdSzOAM3vl595lH7FcHhEuhQEZ2T0ziGNzYdx9Iw0RpugAMzTju+zHD+PBSBRX1L0AXUnZCpq
 cHhvT+yThbrL35RGvVQZBVw4rR8xYN0AH1dKSIDBu8QXKne6EBj+vC3G1Q/gWu2odF33rqXmb
 txPsGqS87bVtgmKUtdpsKuv4fQFw1wpEmnaQtb/wdhDLvYvUylplfLgZDHHSZcO/FKwXfzvu0
 6ElximgXokwcd1lqijAWVHosMnSpTl8OJv4P1/rSA+VuvwmyfUL3q/sPrFLZpkZZ/Jr7+o6+d
 +r8GN0pxz8PLAfWlscKq/iC1u4aJnHRH1nGXb/OE0+FN2wmbtUpow/XMFvDWEWquUvu1Cvrgh
 Ln5xPC2UT04sMJFrVmlnpGdbjj2m2J5bpKa5JViOJhSfox4lbdNHUnm1O/hJAvYcFlVSArtF/
 xYXXS/lMFCEAqWF7R8fveABYZOUQpJgJFVnUJbQv+DLGAcU4wFPYRMP0LesLJWCjv5t6ZeO55
 k/gSe3+GWU3VWq6qAKD7ZfjVKtjuVYh5di1y68WmdbxVOL2mZxYs6btYw3hxnp1jlLUogN/yy
 5kbNJVIET6sAkK0nGoFUHgwRm3lH4tWBTrv8rELqqvAfeb8xWDzG2F11Eb1dO8NeaLyelTt9B
 A1nxEtC1yAUSABKG7kMsqRCdE0xt8Wdtvoz/GhYi/ahUU0/YA72+fWXvGIaCO1YY2Y3JoOSHw
 6sfiEovtkyv1dmgC8LUdhGWCjSk=

Hi Andy,

On 07.12.23 13:35, Andy Shevchenko wrote:
> On Wed, Dec 06, 2023 at 04:42:53PM +0100, Lino Sanfilippo wrote:
>> On 27.11.23 13:14, Christoph Niedermaier wrote:
>>> From: Lino Sanfilippo [mailto:LinoSanfilippo@gmx.de]
>>> Sent: Sunday, November 26, 2023 12:40 AM
>
> ...
>
>>> RS-485 (2-wire NO RX_DURING_TX): rs485->flags =3D SER_RS485_ENABLED|SE=
R_RS485_MODE_HALF_DUPLEX
>>> RS-485 (2-wire RX_DURING_TX):    rs485->flags =3D SER_RS485_ENABLED|SE=
R_RS485_MODE_HALF_DUPLEX|SER_RS485_RX_DURING_TX
>>
>> I think we can omit the SER_RS485_MODE_HALF_DUPLEX flag if we assume th=
at
>> a missing SER_RS485_MODE_FULL_DUPLEX means half duplex (i.e. controllin=
g
>> the RTS line).
>
> You should be very careful on these assumptions, i.e. one must to check =
_all_
> existing user space tools (at least that are in use / supplied by main d=
istros)
> on how they behave.
>

Until now the DUPLEX flags do not yet exist, so existing userspace applica=
tions are not
concerned. Christoph suggested to introduce two flags to distinguish betwe=
en
a FULL duplex and a half duplex RS485 mode. My point was that we  do not n=
eed the flag
for half duplex, since this would be the default.

BR,
Lino


