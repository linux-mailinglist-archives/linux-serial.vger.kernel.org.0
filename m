Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 107B529466
	for <lists+linux-serial@lfdr.de>; Fri, 24 May 2019 11:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389836AbfEXJT0 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 24 May 2019 05:19:26 -0400
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:50510
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389569AbfEXJT0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 May 2019 05:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1fIuoq37MO2m9JsTOFtvKDXcziY9dB588LvAxIkk88=;
 b=vCmhwJGHSZhP8p0vT0Ghl1IOsU8UKp/BRvp60omrYufVx9k4n9xP+zeT9FwLqLCSR/fUjw/VpnuZzL17iQ6gkonn/QFHywlJ4VKfO16L9C4ZORnLOPP3c2HfK1IBxUyAbWfP2nEjcmwJxFjPXmivHjaxYACEJHwototLoD74VQ4=
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com (10.171.197.142) by
 HE1PR06MB3196.eurprd06.prod.outlook.com (10.171.198.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 24 May 2019 09:19:22 +0000
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::b9fe:93:6eb9:335b]) by HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::b9fe:93:6eb9:335b%6]) with mapi id 15.20.1922.017; Fri, 24 May 2019
 09:19:22 +0000
From:   Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
Subject: [PATCH v4] serial: 8250: Fix TX interrupt handling condition
Thread-Topic: [PATCH v4] serial: 8250: Fix TX interrupt handling condition
Thread-Index: AQHVEhHGiFPVdov7YEyWsL0iBe5iwA==
Date:   Fri, 24 May 2019 09:19:22 +0000
Message-ID: <1558689546-27701-1-git-send-email-ext-kimmo.rautkoski@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0010.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::20)
 To HE1PR06MB3098.eurprd06.prod.outlook.com (2603:10a6:7:23::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ext-kimmo.rautkoski@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.4
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aacf83c-25e8-4178-713f-08d6e028e83b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:HE1PR06MB3196;
x-ms-traffictypediagnostic: HE1PR06MB3196:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <HE1PR06MB3196DADA7927DD65498EEFF4B4020@HE1PR06MB3196.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39850400004)(366004)(136003)(346002)(54534003)(189003)(199004)(36756003)(2906002)(6436002)(6512007)(6486002)(476003)(14454004)(5640700003)(54906003)(26005)(3846002)(6116002)(7736002)(186003)(305945005)(68736007)(99286004)(6916009)(107886003)(66066001)(102836004)(4326008)(386003)(6506007)(2351001)(316002)(73956011)(66946007)(66476007)(66556008)(52116002)(256004)(64756008)(66446008)(486006)(86362001)(5660300002)(478600001)(14444005)(2501003)(50226002)(81166006)(25786009)(71190400001)(71200400001)(8936002)(81156014)(2616005)(1730700003)(53936002)(8676002)(326664003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB3196;H:HE1PR06MB3098.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I/blB/41unW1GUZ7qW7F4qm6Tn50fNiI7nJ6V5rEq7QmxAAiTyDrPOtmKPYliQH8x0BkVzJxzJvM4YB2YQXAcefFMwE1BwMAESaBaqpXb7NAFqNt7FpfTavqY1UxIZLCz0vz84unttyk76+lNo0h5tVeIt7+ewdkTS4z8TycJi1a0CWK0cSBN0vpx7zX+0M4blnSsFw/IC6lxbYoz55xg+X1NFhPVvISQTlO5v0x+8rdP0aA0QU9EWgXgxkvO5bmF5jC8KJNJ2G7/kjPAJaAn/ZDdRd0AIGMilsuxhH1I0sEqT2B3Z4WgXRIokOBTbQlwfG9QkfC+qdhRU7LPKV7U+BYIVmaOFI8zKMyMOHbepz8bEJbwfihGzYrPjo70wUa4ecQ8rQ+xjYYMOt0gd7YrhT3TtiIOieULRhaEw6E6C0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aacf83c-25e8-4178-713f-08d6e028e83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 09:19:22.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3196
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SW50ZXJydXB0IGhhbmRsZXIgY2hlY2tlZCBUSFJFIGJpdCAodHJhbnNtaXR0ZXIgaG9sZGluZyBy
ZWdpc3Rlcg0KZW1wdHkpIGluIExTUiB0byBkZXRlY3QgaWYgVFggZmlmbyBpcyBlbXB0eS4NCklu
IGNhc2Ugd2hlbiB0aGVyZSBpcyBvbmx5IHJlY2VpdmUgaW50ZXJydXB0cyB0aGUgVFggaGFuZGxp
bmcNCmdvdCBjYWxsZWQgYmVjYXVzZSBUSFJFIGJpdCBpbiBMU1IgaXMgc2V0IHdoZW4gdGhlcmUg
aXMgbm8NCnRyYW5zbWlzc2lvbiAoRklGTyBlbXB0eSkuIFRYIGhhbmRsaW5nIGNhdXNlZCBUWCBz
dG9wLCB3aGljaCBpbg0KUlMtNDg1IGhhbGYtZHVwbGV4IG1vZGUgYWN0dWFsbHkgcmVzZXRzIHJl
Y2VpdmVyIEZJRk8uIFRoaXMgaXMgbm90DQpkZXNpcmVkIGR1cmluZyByZWNlcHRpb24gYmVjYXVz
ZSBvZiBwb3NzaWJsZSBkYXRhIGxvc3MuDQoNClRoZSBmaXggaXMgdG8gY2hlY2sgaWYgVEhSSSBp
cyBzZXQgaW4gSUVSIGluIGFkZGl0aW9uIG9mIHRoZSBUWA0KZmlmbyBzdGF0dXMuIFRIUkkgaW4g
SUVSIGlzIHNldCB3aGVuIFRYIGlzIHN0YXJ0ZWQgYW5kIGNsZWFyZWQNCndoZW4gVFggaXMgc3Rv
cHBlZC4NClRoaXMgZW5zdXJlcyB0aGF0IFRYIGhhbmRsaW5nIGlzIG9ubHkgY2FsbGVkIHdoZW4g
dGhlcmUgaXMgcmVhbGx5DQp0cmFuc21pc3Npb24gb24gZ29pbmcgYW5kIGFuIGludGVycnVwdCBm
b3IgVEhSRSBhbmQgbm90IHdoZW4gdGhlcmUNCmFyZSBvbmx5IFJYIGludGVycnVwdHMuDQoNClNp
Z25lZC1vZmYtYnk6IEtpbW1vIFJhdXRrb3NraSA8ZXh0LWtpbW1vLnJhdXRrb3NraUB2YWlzYWxh
LmNvbT4NCi0tLQ0KdjI6IGlpciBjaGVjayBjb25kaXRpb24gZml4ZWQuDQp2MzogSW5zdGVhZCBv
ZiBjaGVja2luZyB0aGUgVEhSSSBpbiBpaXIsIGNoZWNrIGlmIHRyYW5zbWlzc2lvbiBpcw0KICAg
IGFjdGl2ZSBieSBjaGVja2luZyBpZiBUSFJJIGlzIGVuYWJsZWQuDQp2NDogQWRkZWQgdGhpcyBj
aGFuZ2Vsb2cuDQotLS0NCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYyB8IDMg
KystDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYw0KaW5kZXggZDJmMzMxMC4uZmRiNmZkMCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jDQorKysgYi9kcml2
ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYw0KQEAgLTE4NzUsNyArMTg3NSw4IEBAIGlu
dCBzZXJpYWw4MjUwX2hhbmRsZV9pcnEoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgdW5zaWduZWQg
aW50IGlpcikNCiAJCQlzdGF0dXMgPSBzZXJpYWw4MjUwX3J4X2NoYXJzKHVwLCBzdGF0dXMpOw0K
IAl9DQogCXNlcmlhbDgyNTBfbW9kZW1fc3RhdHVzKHVwKTsNCi0JaWYgKCghdXAtPmRtYSB8fCB1
cC0+ZG1hLT50eF9lcnIpICYmIChzdGF0dXMgJiBVQVJUX0xTUl9USFJFKSkNCisJaWYgKCghdXAt
PmRtYSB8fCB1cC0+ZG1hLT50eF9lcnIpICYmIChzdGF0dXMgJiBVQVJUX0xTUl9USFJFKSAmJg0K
KwkJKHVwLT5pZXIgJiBVQVJUX0lFUl9USFJJKSkNCiAJCXNlcmlhbDgyNTBfdHhfY2hhcnModXAp
Ow0KIA0KIAl1YXJ0X3VubG9ja19hbmRfY2hlY2tfc3lzcnEocG9ydCwgZmxhZ3MpOw0KLS0gDQoy
LjEuNA0KDQo=
