Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38C412DBD
	for <lists+linux-serial@lfdr.de>; Fri,  3 May 2019 14:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfECMhK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 3 May 2019 08:37:10 -0400
Received: from mail-eopbgr10063.outbound.protection.outlook.com ([40.107.1.63]:17223
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726897AbfECMhK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 May 2019 08:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Coj7fqoqhOfjcA9yQGAoSd8x9kZqJkbF0Kl0wbrtYIw=;
 b=YbCsfbFf6JJE7IAfwxGLXlcHRggU2eyWxyGXz606xnyxUW7a8GVjTcYI1++8cB/llOGCOfGUykb1brEbO89LtYRzQuV1juoGtLrBJZTm/zqa1Kj0wXQS8Kzc0CIz5XpmkGqDs1+dta1zIyDbCkKyRIGRhhF/7zWmdvX3FjnwKXg=
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com (10.171.197.142) by
 HE1PR06MB4124.eurprd06.prod.outlook.com (20.176.166.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Fri, 3 May 2019 12:37:06 +0000
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::1c8a:d311:bbd9:826d]) by HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::1c8a:d311:bbd9:826d%4]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 12:37:06 +0000
From:   Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
Subject: [PATCH v2] serial: 8250: Fix TX interrupt handling condition
Thread-Topic: [PATCH v2] serial: 8250: Fix TX interrupt handling condition
Thread-Index: AQHVAazqy5l9LCGaZ0OdQQg/4ETxnA==
Date:   Fri, 3 May 2019 12:37:06 +0000
Message-ID: <1556886994-107634-1-git-send-email-ext-kimmo.rautkoski@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0244.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::20) To HE1PR06MB3098.eurprd06.prod.outlook.com
 (2603:10a6:7:23::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ext-kimmo.rautkoski@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.4
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06bc86d0-7b07-4412-6f73-08d6cfc40d43
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:HE1PR06MB4124;
x-ms-traffictypediagnostic: HE1PR06MB4124:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <HE1PR06MB4124752BA4AD33511D9DC7B8B4350@HE1PR06MB4124.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39850400004)(396003)(366004)(376002)(199004)(189003)(486006)(2616005)(476003)(2501003)(99286004)(54906003)(6436002)(2351001)(186003)(316002)(8936002)(26005)(64756008)(386003)(66556008)(102836004)(6506007)(66946007)(66446008)(66476007)(68736007)(73956011)(50226002)(71200400001)(71190400001)(14444005)(256004)(2906002)(305945005)(6916009)(86362001)(52116002)(6116002)(478600001)(14454004)(7736002)(8676002)(1730700003)(81156014)(81166006)(36756003)(5640700003)(5660300002)(107886003)(3846002)(6512007)(25786009)(6486002)(53936002)(4326008)(66066001)(326664003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB4124;H:HE1PR06MB3098.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NxQwc6ZKQnLocFf1/wAnciefOo5wawgfeCQj+Fey5ar5+5GEjllm6gng8VpSUtOJEKgU88t1mQTD4dAkumwR+CM7SHrN9jlThBhuy0k6qMgiFUgpRJ0stuhOt3gGpDKQA0gxxmHDzAxNWCz5Rw3XYPWNjp+qpuNoyZNmU9NV+Sck0QWZLbvhl4aKRmmlp1QiaCymoVp6tGzd1DHndSp/788Dq9TiG85l7b4m39RJIASW3XrAnZl+AKGEghQbAghfN1HTaq75TieZ3CuRIqEUl44E9BzQ8oepB0tXRl5ZAYkS3olL0x4gziK+65jajQMUJwn5t2nLCIqRbNtvugUdkowCH9KRU+FBp12MhbqWm8+9qBtmkt/WTkZdG2U43es8k7SDZ+Ml2N2FIcbpJjNBkvK0+6Y85Oiv0/QdXUzZdLs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bc86d0-7b07-4412-6f73-08d6cfc40d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 12:37:06.6689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB4124
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
ZSBvZiBwb3NzaWJsZSBkYXRhIGxvc3MuDQoNClRoZSBmaXggaXMgdG8gdXNlIElJUiBpbnN0ZWFk
IG9mIExTUiB0byBkZXRlY3QgdGhlIFRYIGZpZm8gc3RhdHVzLg0KVGhpcyBlbnN1cmVzIHRoYXQg
VFggaGFuZGxpbmcgaXMgb25seSBjYWxsZWQgd2hlbiB0aGVyZSBpcyByZWFsbHkNCmFuIGludGVy
cnVwdCBmb3IgVEhSRSBhbmQgbm90IHdoZW4gdGhlcmUgaXMgb25seSBSWCBpbnRlcnJ1cHRzLg0K
DQpTaWduZWQtb2ZmLWJ5OiBLaW1tbyBSYXV0a29za2kgPGV4dC1raW1tby5yYXV0a29za2lAdmFp
c2FsYS5jb20+DQotLS0NCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYyB8IDIg
Ky0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jIGIvZHJpdmVycy90
dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMNCmluZGV4IGQyZjMzMTAuLjk4OWRiYWMgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYw0KKysrIGIvZHJpdmVy
cy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMNCkBAIC0xODc1LDcgKzE4NzUsNyBAQCBpbnQg
c2VyaWFsODI1MF9oYW5kbGVfaXJxKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHVuc2lnbmVkIGlu
dCBpaXIpDQogCQkJc3RhdHVzID0gc2VyaWFsODI1MF9yeF9jaGFycyh1cCwgc3RhdHVzKTsNCiAJ
fQ0KIAlzZXJpYWw4MjUwX21vZGVtX3N0YXR1cyh1cCk7DQotCWlmICgoIXVwLT5kbWEgfHwgdXAt
PmRtYS0+dHhfZXJyKSAmJiAoc3RhdHVzICYgVUFSVF9MU1JfVEhSRSkpDQorCWlmICgoIXVwLT5k
bWEgfHwgdXAtPmRtYS0+dHhfZXJyKSAmJiAoKGlpciAmIFVBUlRfSUlSX0lEKSA9PSBVQVJUX0lJ
Ul9USFJJKSkNCiAJCXNlcmlhbDgyNTBfdHhfY2hhcnModXApOw0KIA0KIAl1YXJ0X3VubG9ja19h
bmRfY2hlY2tfc3lzcnEocG9ydCwgZmxhZ3MpOw0KLS0gDQoyLjEuNA0KDQo=
