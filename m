Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA03E2B0DA
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 11:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfE0JFH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 05:05:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34618 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726071AbfE0JFH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 05:05:07 -0400
X-UUID: 9b45fc4f1566450c808686863345d682-20190527
X-UUID: 9b45fc4f1566450c808686863345d682-20190527
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2099036367; Mon, 27 May 2019 17:05:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 27 May 2019 17:04:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 27 May 2019 17:04:59 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, <eddie.huang@mediatek.com>
Subject: [PATCH v11 0/6] Add basic node support for Mediatek MT8183 SoC
Date:   Mon, 27 May 2019 17:04:41 +0800
Message-ID: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A3A3979E730E1DEDDFD1A2DDEE29397448A5ACC75A9DFEC103545943F1E524CC2000:8
X-MTK:  N
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

MT8183 is a SoC based on 64bit ARMv8 architecture.
It contains 4 CA53 and 4 CA73 cores.
MT8183 share many HW IP with MT65xx series.
This patchset was tested on MT8183 evaluation board and use correct clock to shell.

Based on v5.2-rc1

Change in v11:
New add spi node, efuse node, pinctrl node, auxadc node, and capacity-dmips-mhz field

Change in v10:
Add the L2 cache node to prevent warning on unable to detect cache
hierarchy.

Change in v9:
Remove pio node since binding is not documented yet

Change in v8:
1. Fix interrupt-parent of pio node
2. Remove pinfunc.h and spi node patches

Change in v7:
1. Place all the MMIO peripherals under one or more simple-bus nodes
2. Make the pinfunc.h and spi node into seperate patch
3. Modify SPIs pamerater from 4 back to 3
   and remove patch "support 4 interrupt parameters for sysirq"
4. Rename intpol-controller to interrupt-controller
5. Rename pinctrl@1000b000 to pinctrl@10005000

Change in v6:
1. Remove power and iommu nodes
2. Fix dtb build warning
3. Fix pinctrl binding doc
4. Fix '_' in node names

Change in v5:
1. Collect all device tree nodes to the last patch
2. Add PMU
3. Add Signed-off-by
4. Remove clock driver code and binding doc
5. Add pinctrl, iommu, spi, and pwrap nodes

Change in v4:
1. Correct syntax error in dtsi
2. Add MT8183 clock support

Change in v3:
1. Fill out GICC, GICH, GICV regions
2. Update Copyright to 2018

Change in v2:
1. Split dt-bindings into different patches
2. Correct bindings for supported SoCs (mtk-uart.txt)

Ben Ho (1):
  arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
    Makefile

Erin Lo (1):
  arm64: dts: mt8183: add spi node

Hsin-Yi, Wang (1):
  arm64: dts: mt8183: add capacity-dmips-mhz

Michael Mei (1):
  arm64: dts: mt8183: add efuse and Mediatek Chip id node to read

Zhiyong Tao (2):
  arm64: dts: mt8183: add pinctrl device node
  arm64: dts: mt8183: Add auxadc device node

 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 140 ++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 447 ++++++++++++++++++++
 3 files changed, 588 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi

--
1.8.1.1.dirty

