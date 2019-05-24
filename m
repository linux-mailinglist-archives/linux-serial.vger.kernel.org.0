Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E712913A
	for <lists+linux-serial@lfdr.de>; Fri, 24 May 2019 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbfEXGrk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 24 May 2019 02:47:40 -0400
Received: from mail-eopbgr50051.outbound.protection.outlook.com ([40.107.5.51]:62147
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388600AbfEXGrk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 May 2019 02:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEt5ks0+HxA3V94/irp9sP1wpVP7Y39Re1HV1fxXd/U=;
 b=tDJk8bCNdS0hrgoZFQqKk02Sn+CtYCPSEn/6Fn1uzGiDoQNNwA/eG7OlGbI/edWeNNFxTzcSUwA7wYzcu2fDtrFZwdjXCOOz0Hzw2QvTnEnUscxr5KgRWa0j8icuzpxZcn4+bJcgUed7G3RZDv3BWBxD7ZsAVyl0FF0PSuGH/fQ=
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com (10.171.197.142) by
 HE1PR06MB3018.eurprd06.prod.outlook.com (10.171.197.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Fri, 24 May 2019 06:47:34 +0000
Received: from HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::b9fe:93:6eb9:335b]) by HE1PR06MB3098.eurprd06.prod.outlook.com
 ([fe80::b9fe:93:6eb9:335b%6]) with mapi id 15.20.1922.017; Fri, 24 May 2019
 06:47:34 +0000
From:   Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
Subject: [PATCH v3] serial: 8250: Fix TX interrupt handling condition
Thread-Topic: [PATCH v3] serial: 8250: Fix TX interrupt handling condition
Thread-Index: AQHVEfyQRiqKWGJ2tUyxjQvDcsJqTg==
Date:   Fri, 24 May 2019 06:47:33 +0000
Message-ID: <1558680424-57578-1-git-send-email-ext-kimmo.rautkoski@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0011.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::21) To HE1PR06MB3098.eurprd06.prod.outlook.com
 (2603:10a6:7:23::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ext-kimmo.rautkoski@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.4
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c261adb-2984-44dc-99ad-08d6e013b33e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:HE1PR06MB3018;
x-ms-traffictypediagnostic: HE1PR06MB3018:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <HE1PR06MB30187AD606D8DFDDD0E4C525B4020@HE1PR06MB3018.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(39850400004)(136003)(199004)(189003)(14454004)(8676002)(36756003)(316002)(81166006)(81156014)(5660300002)(66066001)(3846002)(6116002)(54906003)(26005)(478600001)(1730700003)(66556008)(486006)(2501003)(476003)(2616005)(64756008)(68736007)(66446008)(53936002)(8936002)(107886003)(66476007)(2351001)(86362001)(66946007)(73956011)(305945005)(25786009)(52116002)(6486002)(7736002)(71200400001)(71190400001)(4326008)(2906002)(102836004)(5640700003)(99286004)(6436002)(50226002)(6916009)(386003)(6506007)(256004)(14444005)(6512007)(186003)(326664003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB3018;H:HE1PR06MB3098.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BIS48MtM1P/+h6IUSL18ic4yF9FCFm4Wn7WjgrzpsSQWZ2fPLp+fyfSe4o0JtZGPpWQJNxb65XYhBItunTZAYrfxx8Ve0JCAKE13v6f60bx2Nd5pElXxUpvvLi899zLLC8P0lwtJbu1597ospNDEDsa2F1rb1CpEF8KWZYndRNG2lQMeY8UauT6bd5ZcMC8dKsOChM3+X1zkiwj1/VpWw+o5Qs1TmuwXRrEK3KOfE/ZhyE4XfJeAk85B0saf30EzoCotMtGSmOOn7PUc/pLxfUuEf9eu79cB0JC+bqlgFe0bD0ZSwbnMVSdZAIkA4cWsTvOndacQZvNGJmCPCeMbwGodlsed9JFv33sNiAbV89biSnS12CaB9AllD+NRM2Lxz3TkNn7AkLvwyiJOW5b/IWESULp41yjmNf+v9GTPCmo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c261adb-2984-44dc-99ad-08d6e013b33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 06:47:33.9886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3018
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
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jIHwgMyArKy0N
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYyBiL2RyaXZlcnMvdHR5
L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jDQppbmRleCBkMmYzMzEwLi5mZGI2ZmQwIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMNCisrKyBiL2RyaXZlcnMv
dHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jDQpAQCAtMTg3NSw3ICsxODc1LDggQEAgaW50IHNl
cmlhbDgyNTBfaGFuZGxlX2lycShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCB1bnNpZ25lZCBpbnQg
aWlyKQ0KIAkJCXN0YXR1cyA9IHNlcmlhbDgyNTBfcnhfY2hhcnModXAsIHN0YXR1cyk7DQogCX0N
CiAJc2VyaWFsODI1MF9tb2RlbV9zdGF0dXModXApOw0KLQlpZiAoKCF1cC0+ZG1hIHx8IHVwLT5k
bWEtPnR4X2VycikgJiYgKHN0YXR1cyAmIFVBUlRfTFNSX1RIUkUpKQ0KKwlpZiAoKCF1cC0+ZG1h
IHx8IHVwLT5kbWEtPnR4X2VycikgJiYgKHN0YXR1cyAmIFVBUlRfTFNSX1RIUkUpICYmDQorCQko
dXAtPmllciAmIFVBUlRfSUVSX1RIUkkpKQ0KIAkJc2VyaWFsODI1MF90eF9jaGFycyh1cCk7DQog
DQogCXVhcnRfdW5sb2NrX2FuZF9jaGVja19zeXNycShwb3J0LCBmbGFncyk7DQotLSANCjIuMS40
DQoNCg==
