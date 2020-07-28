Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668D6230BA7
	for <lists+linux-serial@lfdr.de>; Tue, 28 Jul 2020 15:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgG1Nmd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 28 Jul 2020 09:42:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41270 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730069AbgG1Nmc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jul 2020 09:42:32 -0400
X-UUID: e62af6ad064248819b3fe334897bfaa1-20200728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6JOhCoUtOoNK1a+Sr6LjVOqd6OgdvIqN6AmXnjDucFc=;
        b=rxQEckFH80TeE2YS03v4P8u6yiFggfT8kJ3ytlZX1mt/L87bC5LijC38lI+ko8mi2Dk/S6ywbcN3JS373vsX2onxHjxs8gB+m03uP9cVxTdVylm18XK9ZzAGiUMy1NwMnKhEGl+m2h7/h4QpMultraqAR8e2Nrd6q+QBKTQoJLA=;
X-UUID: e62af6ad064248819b3fe334897bfaa1-20200728
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2074433596; Tue, 28 Jul 2020 21:42:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Jul 2020 21:42:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jul 2020 21:42:25 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>
Subject: [PATCH v2 2/3] dt-bindings: serial: Add compatible for Mediatek MT8192
Date:   Tue, 28 Jul 2020 21:41:48 +0800
Message-ID: <20200728134149.19758-3-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200728134149.19758-1-seiya.wang@mediatek.com>
References: <20200728134149.19758-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

VGhpcyBjb21taXQgYWRkcyBkdC1iaW5kaW5nIGRvY3VtZW50YXRpb24gb2YgdWFydCBmb3IgTWVk
aWF0ZWsgTVQ4MTkyIFNvQw0KUGxhdGZvcm0uDQoNCkNoYW5nZS1JZDogSTIxODlkNTc3NTUxMDc1
NDVkN2I4MmQ0N2Y0OWM1MTBiOWJjNzJmYTUNCkFja2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogU2VpeWEgV2FuZyA8c2VpeWEud2FuZ0BtZWRpYXRl
ay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL210
ay11YXJ0LnR4dCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9tdGstdWFy
dC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL210ay11YXJ0
LnR4dA0KaW5kZXggM2EzYjU3MDc5ZjBkLi42NDdiNWFlZTg2ZjMgMTAwNjQ0DQotLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL210ay11YXJ0LnR4dA0KKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9tdGstdWFydC50eHQNCkBA
IC0xOSw2ICsxOSw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogICAqICJtZWRpYXRlayxtdDgx
MzUtdWFydCIgZm9yIE1UODEzNSBjb21wYXRpYmxlIFVBUlRTDQogICAqICJtZWRpYXRlayxtdDgx
NzMtdWFydCIgZm9yIE1UODE3MyBjb21wYXRpYmxlIFVBUlRTDQogICAqICJtZWRpYXRlayxtdDgx
ODMtdWFydCIsICJtZWRpYXRlayxtdDY1NzctdWFydCIgZm9yIE1UODE4MyBjb21wYXRpYmxlIFVB
UlRTDQorICAqICJtZWRpYXRlayxtdDgxOTItdWFydCIsICJtZWRpYXRlayxtdDY1NzctdWFydCIg
Zm9yIE1UODE5MiBjb21wYXRpYmxlIFVBUlRTDQogICAqICJtZWRpYXRlayxtdDg1MTYtdWFydCIg
Zm9yIE1UODUxNiBjb21wYXRpYmxlIFVBUlRTDQogICAqICJtZWRpYXRlayxtdDY1NzctdWFydCIg
Zm9yIE1UNjU3NyBhbmQgYWxsIG9mIHRoZSBhYm92ZQ0KIA0KLS0gDQoyLjE0LjENCg==

