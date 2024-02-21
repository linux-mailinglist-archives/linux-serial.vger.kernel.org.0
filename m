Return-Path: <linux-serial+bounces-2371-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18B85D9D0
	for <lists+linux-serial@lfdr.de>; Wed, 21 Feb 2024 14:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7EE1C232B4
	for <lists+linux-serial@lfdr.de>; Wed, 21 Feb 2024 13:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ACF77655;
	Wed, 21 Feb 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="tcyr0kRV"
X-Original-To: linux-serial@vger.kernel.org
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9873161
	for <linux-serial@vger.kernel.org>; Wed, 21 Feb 2024 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521762; cv=none; b=JSTeo+HrZrQIdbwfeB+yYIfU6f7ylIazJPBvMLQ8LevBLctyXlImerQWlQ8LfWO6f1x8iWiS+gUtfZjnYL2oRIW6/i/c30mCVOF/OWNI++QxT5ooKOB5XMvv26q351Zo4R8oLlHg48wNS857ktq6MIusyB9bCx0bYr5Bovkg0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521762; c=relaxed/simple;
	bh=CIiz4rZoO8sk2Y7xgiCZtFUEC5rr8VM4HAsayBrF2U4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tRyiB6XoUcwVls3oNNf3C1+fpFOdvcgZMp6VYiryeb8Ypv65QwJ8hasktuDXIc7C7XRPDTe/US+tNTfp1u9YgW1fvl85ea9D8IYGYQCW/VHeYYehPy81EVmN96gYPzoSVE51YslPch5AxBwoGrvNiNzXulZ7NYXV1reKjUdngCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=tcyr0kRV; arc=none smtp.client-ip=116.203.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1708521243;
	bh=CIiz4rZoO8sk2Y7xgiCZtFUEC5rr8VM4HAsayBrF2U4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=tcyr0kRVmED4/5zxR1M20rxljj+iPk6ywrBBqkvoIOaysabdly8SZdf7aUP0CHnww
	 VTuoW12PM8nM5Zf7JZlD4obZNNL8ICrdGA6PWgiy7i6YMcZWbgg9+yn5rMmL3uPGdE
	 tk+sHN47ySHb0JfSL9uxpKhce4sPnV8buu+53FfA2Sw0kMt6zvGO7LGgLjFigvXM2Y
	 /HRsFLdlUs9mahwfebdN51HfojCly6wIk00NdOU95mx+CIHMpnTjM3GbyBN3khPk3V
	 cG9CQAlooLwmfacJnrXpg0zdOlGtz2YDyYijEOphu+7G3rAmQD+Qr3dDoOFhsoXV5c
	 dk8zP9cpCIPEw==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Rickard Andersson <rickaran@axis.com>, "rickard314.andersson@gmail.com"
	<rickard314.andersson@gmail.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-imx@nxp.com"
	<linux-imx@nxp.com>, "martin.fuzzey@flowbird.group"
	<martin.fuzzey@flowbird.group>, "marex@denx.de" <marex@denx.de>,
	"kernel@axis.com" <kernel@axis.com>
Subject: RE: [PATCH v3] tty: serial: imx: Fix broken RS485
Thread-Topic: [PATCH v3] tty: serial: imx: Fix broken RS485
Thread-Index: AQHaZLyX00YXFUb0zUaBIWsbLR08rrEUxAYw
Date: Wed, 21 Feb 2024 13:14:00 +0000
Message-ID: <188a1900e8db435c840ae72478d4d5ac@dh-electronics.com>
References: <20240221115304.509811-1-rickaran@axis.com>
In-Reply-To: <20240221115304.509811-1-rickaran@axis.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogUmlja2FyZCBBbmRlcnNzb24gPHJpY2thcmFuQGF4aXMuY29tPg0KU2VudDogV2VkbmVz
ZGF5LCBGZWJydWFyeSAyMSwgMjAyNCAxMjo1MyBQTQ0KPiANCj4gRnJvbTogUmlja2FyZCB4IEFu
ZGVyc3NvbiA8cmlja2FyYW5AYXhpcy5jb20+DQo+IA0KPiBXaGVuIGFib3V0IHRvIHRyYW5zbWl0
IHRoZSBmdW5jdGlvbiBpbXhfdWFydF9zdGFydF90eCBpcyBjYWxsZWQgYW5kIGluDQo+IHNvbWUg
UlM0ODUgY29uZmlndXJhdGlvbnMgdGhpcyBmdW5jdGlvbiB3aWxsIGNhbGwgaW14X3VhcnRfc3Rv
cF9yeC4gVGhlDQo+IHByb2JsZW0gaXMgdGhhdCBpbXhfdWFydF9zdG9wX3J4IHdpbGwgZW5hYmxl
IGxvb3BiYWNrIGluIG9yZGVyIHRvDQo+IHJlbGVhc2UgdGhlIFJTNDg1IGJ1cywgYnV0IHdoZW4g
bG9vcGJhY2sgaXMgZW5hYmxlZCB0cmFuc21pdHRlZCBkYXRhDQo+IHdpbGwganVzdCBiZSBsb29w
ZWQgdG8gUlguDQo+IA0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBhYm92ZSBwcm9ibGVtIGJ5IG5v
dCBlbmFibGluZyBsb29wYmFjayB3aGVuIGFib3V0DQo+IHRvIHRyYW5zbWl0Lg0KPiANCj4gVGhp
cyBkcml2ZXIgbm93IHdvcmtzIHdlbGwgd2hlbiB1c2VkIGZvciBSUzQ4NSBoYWxmIGR1cGxleCBt
YXN0ZXINCj4gY29uZmlndXJhdGlvbnMuDQo+IA0KPiBGaXhlczogNzlkMDIyNGY2YmYyICgidHR5
OiBzZXJpYWw6IGlteDogSGFuZGxlIFJTNDg1IERFIHNpZ25hbCBhY3RpdmUgaGlnaCIpDQo+IFNp
Z25lZC1vZmYtYnk6IFJpY2thcmQgeCBBbmRlcnNzb24gPHJpY2thcmFuQGF4aXMuY29tPg0KPiAt
LS0NCj4gVjIgLT4gVjM6IEFkZGVkIHdyYXBwZXIgZnVuY3Rpb24NCj4gVjEgLT4gVjI6IEFkZGVk
IGZpeGVzIHRhZw0KPiAgZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIHwgMjIgKysrKysrKysrKysr
KysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIGIvZHJp
dmVycy90dHkvc2VyaWFsL2lteC5jDQo+IGluZGV4IDRhYTcyZDVhZWFmYi4uZTE0ODEzMjUwNjE2
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCj4gKysrIGIvZHJpdmVy
cy90dHkvc2VyaWFsL2lteC5jDQo+IEBAIC00NjIsOCArNDYyLDcgQEAgc3RhdGljIHZvaWQgaW14
X3VhcnRfc3RvcF90eChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KPiAgICAgICAgIH0NCj4gIH0N
Cj4gDQo+IC0vKiBjYWxsZWQgd2l0aCBwb3J0LmxvY2sgdGFrZW4gYW5kIGlycXMgb2ZmICovDQo+
IC1zdGF0aWMgdm9pZCBpbXhfdWFydF9zdG9wX3J4KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpDQo+
ICtzdGF0aWMgdm9pZCBpbXhfdWFydF9zdG9wX3J4X3dpdGhfbG9vcGJhY2tfY3RybChzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LCBib29sIGxvb3BiYWNrKQ0KPiAgew0KPiAgICAgICAgIHN0cnVjdCBp
bXhfcG9ydCAqc3BvcnQgPSAoc3RydWN0IGlteF9wb3J0ICopcG9ydDsNCj4gICAgICAgICB1MzIg
dWNyMSwgdWNyMiwgdWNyNCwgdXRzOw0KPiBAQCAtNDg1LDcgKzQ4NCw3IEBAIHN0YXRpYyB2b2lk
IGlteF91YXJ0X3N0b3Bfcngoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCj4gICAgICAgICAvKiBT
ZWUgU0VSX1JTNDg1X0VOQUJMRUQvVVRTX0xPT1AgY29tbWVudCBpbiBpbXhfdWFydF9wcm9iZSgp
ICovDQo+ICAgICAgICAgaWYgKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQg
JiYNCj4gICAgICAgICAgICAgcG9ydC0+cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NF
TkQgJiYNCj4gLSAgICAgICAgICAgc3BvcnQtPmhhdmVfcnRzY3RzICYmICFzcG9ydC0+aGF2ZV9y
dHNncGlvKSB7DQo+ICsgICAgICAgICAgIHNwb3J0LT5oYXZlX3J0c2N0cyAmJiAhc3BvcnQtPmhh
dmVfcnRzZ3BpbyAmJiBsb29wYmFjaykgew0KPiAgICAgICAgICAgICAgICAgdXRzID0gaW14X3Vh
cnRfcmVhZGwoc3BvcnQsIGlteF91YXJ0X3V0c19yZWcoc3BvcnQpKTsNCj4gICAgICAgICAgICAg
ICAgIHV0cyB8PSBVVFNfTE9PUDsNCj4gICAgICAgICAgICAgICAgIGlteF91YXJ0X3dyaXRlbChz
cG9ydCwgdXRzLCBpbXhfdWFydF91dHNfcmVnKHNwb3J0KSk7DQo+IEBAIC00OTcsNiArNDk2LDE2
IEBAIHN0YXRpYyB2b2lkIGlteF91YXJ0X3N0b3Bfcngoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkN
Cj4gICAgICAgICBpbXhfdWFydF93cml0ZWwoc3BvcnQsIHVjcjIsIFVDUjIpOw0KPiAgfQ0KPiAN
Cj4gKy8qIGNhbGxlZCB3aXRoIHBvcnQubG9jayB0YWtlbiBhbmQgaXJxcyBvZmYgKi8NCj4gK3N0
YXRpYyB2b2lkIGlteF91YXJ0X3N0b3Bfcngoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCj4gK3sN
Cj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIFN0b3AgUlggYW5kIGVuYWJsZSBsb29wYmFjayBp
biBvcmRlciB0byBtYWtlIHN1cmUgUlM0ODUgYnVzDQo+ICsgICAgICAgICogaXMgbm90IGJsb2Nr
ZWQuIFNlIGNvbW1lbnQgaW4gaW14X3VhcnRfcHJvYmUoKS4NCj4gKyAgICAgICAgKi8NCj4gKyAg
ICAgICBpbXhfdWFydF9zdG9wX3J4X3dpdGhfbG9vcGJhY2tfY3RybChwb3J0LCB0cnVlKTsNCj4g
K30NCj4gKw0KPiAgLyogY2FsbGVkIHdpdGggcG9ydC5sb2NrIHRha2VuIGFuZCBpcnFzIG9mZiAq
Lw0KPiAgc3RhdGljIHZvaWQgaW14X3VhcnRfZW5hYmxlX21zKHN0cnVjdCB1YXJ0X3BvcnQgKnBv
cnQpDQo+ICB7DQo+IEBAIC02ODIsOSArNjkxLDE0IEBAIHN0YXRpYyB2b2lkIGlteF91YXJ0X3N0
YXJ0X3R4KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW14X3VhcnRfcnRzX2luYWN0aXZlKHNwb3J0LCAmdWNyMik7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGlteF91YXJ0X3dyaXRlbChzcG9ydCwgdWNyMiwgVUNSMik7DQo+IA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
KiBTaW5jZSB3ZSBhcmUgYWJvdXQgdG8gdHJhbnNtaXQgd2UgY2FuIG5vdCBzdG9wIFJYDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAqIHdpdGggbG9vcGJhY2sgZW5hYmxlZCBiZWNhdXNlIHRo
YXQgd2lsbCBtYWtlIG91cg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgKiB0cmFuc21pdHRl
ZCBkYXRhIGJlaW5nIGp1c3QgbG9vcGVkIHRvIFJYLg0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCEocG9ydC0+cnM0ODUuZmxhZ3Mg
JiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKSAmJg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIXBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvKQ0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlteF91YXJ0X3N0b3BfcngocG9ydCk7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW14X3VhcnRfc3RvcF9yeF93aXRoX2xvb3BiYWNrX2N0cmwocG9ydCwg
ZmFsc2UpOw0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgc3BvcnQtPnR4X3N0YXRlID0g
V0FJVF9BRlRFUl9SVFM7DQo+IA0KDQpUZXN0ZWQtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8
Y25pZWRlcm1haWVyQGRoLWVsZWN0cm9uaWNzLmNvbT4NCg0KVGVzdGVkIG9uIGEgREhDT00gaS5N
WDZVTEwgU29NLg0KDQpSZWdhcmRzDQpDaHJpc3RvcGgNCg==

