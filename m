Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDC425D2A
	for <lists+linux-serial@lfdr.de>; Wed, 22 May 2019 06:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfEVE6W (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 22 May 2019 00:58:22 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:61635
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfEVE6W (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 May 2019 00:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW8pp20GcSZdVC12uxCMElzm0/dEYQmgdPfHJ4YGxnw=;
 b=BI+iLODnR0sYRn7nT50EPLUtyQOPe1ELdgFQz+GUeETGLAY1/qUbCUfWkKuqAy0k3CRT5ImmjfoY0KC4wwpdJ94BXDuC05F/sitGJc4OdneXDrZqAibvP8Y9yTaS5apl5fQmTzv7I8j6GC1qpZlhhi6lvkBee6JFPSRCjWTSKiM=
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com (10.171.197.142) by
 HE1PR06MB4091.eurprd06.prod.outlook.com (20.176.165.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 04:58:15 +0000
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::b9fe:93:6eb9:335b]) by HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::b9fe:93:6eb9:335b%6]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 04:58:15 +0000
From:   Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
To:     Ian Arkver <ian.arkver.dev@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] serial: 8250: Fix TX interrupt handling condition
Thread-Topic: [PATCH] serial: 8250: Fix TX interrupt handling condition
Thread-Index: AQHU/ChxkZH9RbUwgU6kvPIvo3YCo6ZTNLuAgAYiV7CAADGqAIAdMCaw
Date:   Wed, 22 May 2019 04:58:15 +0000
Message-ID: <HE1PR06MB30987759F1E9E72FD0FE5011B4000@HE1PR06MB3098.eurprd06.prod.outlook.com>
References: <1556280367-28685-1-git-send-email-ext-kimmo.rautkoski@vaisala.com>
 <20190429141915.GB12903@kroah.com>
 <HE1PR06MB30986E007789F2DAB69F2E33B4350@HE1PR06MB3098.eurprd06.prod.outlook.com>
 <d4bc7860-c54b-571f-a4f9-1785fade15a1@gmail.com>
In-Reply-To: <d4bc7860-c54b-571f-a4f9-1785fade15a1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Enabled=True;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_SiteId=6d7393e0-41f5-4c2e-9b12-4c2be5da5c57;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Owner=ext-kimmo.rautkoski@vaisala.com;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_SetDate=2019-05-22T04:58:13.6451180Z;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Name=Restricted;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_d5842b46-9b7a-431a-b662-8cc44ff92a4e_Extended_MSFT_Method=Automatic;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Enabled=True;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SiteId=6d7393e0-41f5-4c2e-9b12-4c2be5da5c57;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Owner=ext-kimmo.rautkoski@vaisala.com;
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SetDate=2019-05-22T04:58:13.6451180Z;
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
x-ms-office365-filtering-correlation-id: 2ea01997-e64c-47f3-0182-08d6de721990
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:HE1PR06MB4091;
x-ms-traffictypediagnostic: HE1PR06MB4091:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <HE1PR06MB4091C2ADEEC87724568E9FD6B4000@HE1PR06MB4091.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(136003)(396003)(13464003)(189003)(199004)(8676002)(6506007)(99286004)(305945005)(9686003)(55016002)(6246003)(478600001)(53546011)(66446008)(76116006)(25786009)(14454004)(102836004)(66946007)(73956011)(2906002)(3846002)(6116002)(66476007)(14444005)(64756008)(81166006)(6436002)(81156014)(53936002)(8936002)(33656002)(316002)(229853002)(256004)(66556008)(26005)(68736007)(186003)(71190400001)(476003)(5660300002)(52536014)(86362001)(11346002)(446003)(2501003)(7696005)(66066001)(71200400001)(110136005)(74316002)(4326008)(7736002)(76176011)(486006)(326664003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB4091;H:HE1PR06MB3098.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d885S/sz4ytiY7hiD4NQ2uWOLh2/9ntrfmJLxWnavvZ0VWaHrtQ9k6EEwW2FZa15KrPaBF2QzJXEo0MtD9VrZVvgPo3nIabJcLUkU2iw+T4nOkfYA1rJw9N3WCDRMGQhZ0Faifz0MvMMG0xidPpSEl7Ywqkn9S+WCGOzfn7L3XPTcpeX3aLM5QPrJvujoi0u+QshttiAN5J8fqRiL6SZ3Qw2qwZl4CIDjgAm76yJG4TLuWC2kp524rjJrl5W8y5IO87jE/qELLcZNnzlIobh6rbOaXfadvA7YeggSJAFRhQOaLf596Q3Kbq9XjmXNuo/pLh6a/b4XBr7PdAVaqDJ3Y0c2D15I5fQecI2OFZ2KZj8yIX8Bm0Hz9yJHv0oglf6omD32txc/dPzTeu8sd3KuWnj/pPx/S3lKqPU/ANkpqM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea01997-e64c-47f3-0182-08d6de721990
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 04:58:15.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB4091
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIEFya3ZlciA8
aWFuLmFya3Zlci5kZXZAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIDAzIE1heSwgMjAxOSAx
Nzo1Nw0KPiBUbzogUmF1dGtvc2tpIEtpbW1vIEVYVCA8ZXh0LWtpbW1vLnJhdXRrb3NraUB2YWlz
YWxhLmNvbT47DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQo+IENjOiBsaW51eC1zZXJp
YWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNlcmlhbDogODI1MDog
Rml4IFRYIGludGVycnVwdCBoYW5kbGluZyBjb25kaXRpb24NCj4gDQo+IEhpLg0KPiANCj4gT24g
MDMvMDUvMjAxOSAxMzoxMCwgUmF1dGtvc2tpIEtpbW1vIEVYVCB3cm90ZToNCj4gPg0KPiA+DQo+
ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPj4gU2VudDogTW9u
ZGF5LCAyOSBBcHJpbCwgMjAxOSAxNzoxOQ0KPiA+PiBUbzogUmF1dGtvc2tpIEtpbW1vIEVYVCA8
ZXh0LWtpbW1vLnJhdXRrb3NraUB2YWlzYWxhLmNvbT4NCj4gPj4gQ2M6IGxpbnV4LXNlcmlhbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc2VyaWFsOiA4MjUwOiBG
aXggVFggaW50ZXJydXB0IGhhbmRsaW5nIGNvbmRpdGlvbg0KPiA+Pg0KPiA+PiBPbiBGcmksIEFw
ciAyNiwgMjAxOSBhdCAxMjowNjoxM1BNICswMDAwLCBSYXV0a29za2kgS2ltbW8gRVhUIHdyb3Rl
Og0KPiA+Pj4gSW50ZXJydXB0IGhhbmRsZXIgY2hlY2tlZCBUSFJFIGJpdCAodHJhbnNtaXR0ZXIg
aG9sZGluZyByZWdpc3Rlcg0KPiA+Pj4gZW1wdHkpIGluIExTUiB0byBkZXRlY3QgaWYgVFggZmlm
byBpcyBlbXB0eS4NCj4gPj4+IEluIGNhc2Ugd2hlbiB0aGVyZSBpcyBvbmx5IHJlY2VpdmUgaW50
ZXJydXB0cyB0aGUgVFggaGFuZGxpbmcNCj4gPj4+IGdvdCBjYWxsZWQgYmVjYXVzZSBUSFJFIGJp
dCBpbiBMU1IgaXMgc2V0IHdoZW4gdGhlcmUgaXMgbm8NCj4gPj4+IHRyYW5zbWlzc2lvbiAoRklG
TyBlbXB0eSkuIFRYIGhhbmRsaW5nIGNhdXNlZCBUWCBzdG9wLCB3aGljaCBpbg0KPiA+Pj4gUlMt
NDg1IGhhbGYtZHVwbGV4IG1vZGUgYWN0dWFsbHkgcmVzZXRzIHJlY2VpdmVyIEZJRk8uIFRoaXMg
aXMgbm90DQo+ID4+PiBkZXNpcmVkIGR1cmluZyByZWNlcHRpb24gYmVjYXVzZSBvZiBwb3NzaWJs
ZSBkYXRhIGxvc3MuDQo+ID4+Pg0KPiA+Pj4gVGhlIGZpeCBpcyB0byB1c2UgSUlSIGluc3RlYWQg
b2YgTFNSIHRvIGRldGVjdCB0aGUgVFggZmlmbyBzdGF0dXMuDQo+ID4+PiBUaGlzIGVuc3VyZXMg
dGhhdCBUWCBoYW5kbGluZyBpcyBvbmx5IGNhbGxlZCB3aGVuIHRoZXJlIGlzIHJlYWxseQ0KPiA+
Pj4gYW4gaW50ZXJydXB0IGZvciBUSFJFIGFuZCBub3Qgd2hlbiB0aGVyZSBpcyBvbmx5IFJYIGlu
dGVycnVwdHMuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogS2ltbW8gUmF1dGtvc2tpIDxl
eHQta2ltbW8ucmF1dGtvc2tpQHZhaXNhbGEuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgIGRyaXZl
cnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jIHwgMiArLQ0KPiA+Pj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMNCj4gPj4gYi9kcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYw0KPiA+Pj4gaW5kZXggZDJmMzMxMC4uOTFjYTBj
YSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5j
DQo+ID4+PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYw0KPiA+Pj4g
QEAgLTE4NzUsNyArMTg3NSw3IEBAIGludCBzZXJpYWw4MjUwX2hhbmRsZV9pcnEoc3RydWN0IHVh
cnRfcG9ydA0KPiAqcG9ydCwNCj4gPj4gdW5zaWduZWQgaW50IGlpcikNCj4gPj4+ICAgCQkJc3Rh
dHVzID0gc2VyaWFsODI1MF9yeF9jaGFycyh1cCwgc3RhdHVzKTsNCj4gPj4+ICAgCX0NCj4gPj4+
ICAgCXNlcmlhbDgyNTBfbW9kZW1fc3RhdHVzKHVwKTsNCj4gPj4+IC0JaWYgKCghdXAtPmRtYSB8
fCB1cC0+ZG1hLT50eF9lcnIpICYmIChzdGF0dXMgJiBVQVJUX0xTUl9USFJFKSkNCj4gPj4+ICsJ
aWYgKCghdXAtPmRtYSB8fCB1cC0+ZG1hLT50eF9lcnIpICYmIChpaXIgJiBVQVJUX0lJUl9USFJJ
KSkNCj4gPj4+ICAgCQlzZXJpYWw4MjUwX3R4X2NoYXJzKHVwKTsNCj4gPj4NCj4gPj4gVGhpcyBm
ZWVscyB3cm9uZyB0byBtZSwgY2FuIHNvbWVvbmUgZWxzZSB0ZXN0IHRoaXMgdG8gdmVyaWZ5IHRo
YXQgaXQNCj4gPj4gcmVhbGx5IGRvZXMgd29yayBwcm9wZXJseT8gIEkgZG9uJ3QgaGF2ZSBhY2Nl
c3MgdG8gYW55IDgyNTAgZGV2aWNlcyBhdA0KPiA+PiB0aGUgbW9tZW50IDooDQo+ID4+DQo+ID4+
IHRoYW5rcywNCj4gPj4NCj4gPj4gZ3JlZyBrLWgNCj4gPg0KPiA+IFRoYW5rcyBmb3IgY2hlY2tp
bmcgdGhpcy4gVGhlcmUgaXMgaW5kZWVkIGEgcHJvYmxlbSB3aXRoIHRoZSBwYXRjaC4NCj4gSW50
ZXJydXB0IElEIGluIEludGVycnVwdCBJZGVudGlmaWNhdGlvbiByZWdpc3RlciBpcyBhY3R1YWxs
eSAzIGJpdHMsIHNvIHRoZSBjaGVjaw0KPiBzaG91bGQgYmUgZGlmZmVyZW50OiAoKGlpciAmIFVB
UlRfSUlSX0lEKSA9PSBVQVJUX0lJUl9USFJJKQ0KPiA+DQo+ID4gSSdsbCBzZW5kIHYyIG9mIHRo
ZSBwYXRjaCBzb29uLg0KPiANCj4gUmF0aGVyIHRoYW4gc3dpdGNoaW5nIHRvIHRoZSBJSVIgd2hp
Y2ggY2FuIGhhdmUgb3RoZXIgbWVhbmluZ3MgZm9yDQo+IGRldmljZXMgd2l0aCBGSUZPcyAoZWcu
IEZJRk8gc3BhY2UgYXZhaWwpLCBvciBtYXkgYmUgZmxha3kgKHNlZQ0KPiBVQVJUX0JVR19USFJF
KSwgY291bGQgeW91IGNvbnRpbnVlIHRvIHVzZSB0aGUgTFNSIFRIUkUgYml0IGJ1dCBhbHNvDQo+
IGNoZWNrIGZvciB1cC0+aWVyICYgVUFSVF9JRVJfVEhSSS4gVGhpcyBpcyBzZXQgaW4gX19zdGFy
dF90eCBhbmQgY2xlYXJlZA0KPiBpbiBfX2RvX3N0b3BfdHguDQo+IA0KPiBJdCdzIHJlYWxseSBq
dXN0IGRvaW5nIGluIHNvZnR3YXJlIHdoYXQgdGhlIElJUiBoYXJkd2FyZSBzaG91bGQgaW4NCj4g
dGhlb3J5IGJlIGRvaW5nIGZvciBhIHJlZ3VsYXIgODI1MC4NCj4gDQoNClRoaXMgd291bGQgd29y
ayB0b28sIEkgaGF2ZSB0ZXN0ZWQgaXQgb24gbXkgc2V0dXAuIE1heWJlIHRoaXMgaXMgYSBiZXR0
ZXIgDQphcHByb2FjaCBpbiB0aGUgc2Vuc2UgdGhhdCBpdCBkb2VzIG5vdCBicmVhayBpbXBsZW1l
bnRhdGlvbnMgd2l0aCBidWdneSANCjgyNTAuIFRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgdGhpcyBv
dXQuIEknbGwgcHJlcGFyZSB2MyBwYXRjaCB3aXRoIHRoaXMgY2hhbmdlLg0KDQpCUiwNCktpbW1v
DQoNCg0KPiBEaXNjbGFpbWVyOiBJIGRvbid0IGhhdmUgYW55IHN1Y2ggZGV2aWNlcyBlaXRoZXIu
DQo+IA0KPiBSZWdhcmRzLA0KPiBJYW4NCj4gDQo+ID4NCj4gPiBCUiwNCj4gPiBLaW1tbw0KPiA+
DQo=
