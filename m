Return-Path: <linux-serial+bounces-5100-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D403594022C
	for <lists+linux-serial@lfdr.de>; Tue, 30 Jul 2024 02:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EF6B21634
	for <lists+linux-serial@lfdr.de>; Tue, 30 Jul 2024 00:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8910E3;
	Tue, 30 Jul 2024 00:28:53 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380021361;
	Tue, 30 Jul 2024 00:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299333; cv=none; b=LXsBoA9M0LQPmX8zpm2/VojDMFBfUvK2e7NntfsJHPg69iqsOb7VBO0iyY0b3HHNAxY+jeJ09f16JGrMQd4cByXoz6VD1cg+x6qmFEKM2sKGS3FJH7jwaVFj1azK1wdOx4kGTmk/pzFvum3eLmasjYIdcJ/c3dIoSQeAQqqQH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299333; c=relaxed/simple;
	bh=V4T8fd0d2+h0+Ln8i2kGkme2tTA/eQW/YrvMlVwVBNw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TwzOhlOp6HUxTRbG/xnmXY6XvNwKzyaDWlmk6RGk4UkOOsJmzwgWwNDAsWz5DOLH98Jz7cNUl0y3VWsiy0JKG9CjAweWnikUgpcBti4l3ytl1IefAmUyM2qge3aSrLB2VNGt9hRSrjxwJKWVK7lpBeayDkHG0z2vKs8c6jyUVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v5 00/10] riscv: add initial support for SpacemiT K1
Date: Tue, 30 Jul 2024 00:28:03 +0000
Message-Id: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJQzqGYC/2XMSwrCMBSF4a1Ixl7JO+jIfYiDJL1tg9BIUoJSu
 nfTgvjo8Bz4/olkTAEzOe0mkrCEHOJQh9rviO/t0CGEpm7CKZdUcw03BpSBszl4aEZg1gqGiM4
 3nFR0T9iGxxq8XOvuQx5jeq79wpf3nTL/qcKBgvdUe6OUaqk5dziMMR5i6sjSKuLjDRUbL6pnv
 DXCSSM1w42X3/648bJ6i8o5hUpb2/74eZ5fYBp4GS0BAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Yangyu Chen <cyy@cyyself.name>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Jesse Taube <jesse@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, 
 Meng Zhang <kevin.z.m@hotmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Matthias Brugger <matthias.bgg@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4015; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=V4T8fd0d2+h0+Ln8i2kGkme2tTA/eQW/YrvMlVwVBNw=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmqDOaQ0GI2eOl57347SCIy4BFS/AKSz2EiNH9+
 Hev8/juaJuJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZqgzml8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277c50D/42G0a9O66gMEGAcM
 WOw+H3lRyEXfImWH31qsng7fdSgHbn4y9VgbF/gJQtuyNzHM8vFkWb4CzZQ1bYrmVI9fPJRoF6u
 ziSWrpmQIK8724b9Tmkg6I0N83rY5p0uS8YqT2jAzFaTy8cF1GwN0aEJ6w8yKi9S2+Cs0GXKKIa
 /gw4vvNaeKK0jQjaBj09zNvx/qOAiQqzzPZXpzgryReaBh8t+fyeITItgdqIVPNvCQHZ36XeNZd
 loAs/ifHifi7k5seVfatnxLltcglNQclyLKaldxVqwKLVSv4qIPkgTzT4zBShl28Hn2B7kzzhyq
 Pig0Tb1kNZUd7hwOb1bcYAhV9BP7PxOGGjHvGLxtScHbyA41D7aophhs64zaFiHYow9wZmh+TyB
 1mOYJnrveID98HncHvFCQLHJOdaxrOuq+MhSNGu1kBiTlFNT3AGheFXheKyfArOWbvOP4KNyYlX
 ICaaX7VtxqjJnLFEa3YyZxfJPr42m4UF3JBoQvzOKJOYyXkAmTqG9B1AwuAdErxwod7j4S8W7ZC
 Ys1ff+dtEDOvQqmCfcDY04x/X3R3y1Wo50lNeoiYJ2vfytNq75cdJZs1PUIzup8/L9SS4wXK0lq
 Rv0P9UeesI6Nse9BenhJ0LnRCo5Vsqrul40JUvgLxUxTDzk2OBuS+AjwUNL9T1vjjJjg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

SpacemiT K1 is an ideal chip for some new extension such as RISC-V Vector
1.0 and Zicond evaluation now. Add initial support for it to allow more
people to participate in building drivers to mainline for it.

This kernel has been tested upon Banana Pi BPI-F3 board on vendor U-Boot
bootflow generated by Armbian SDK[1] and patched OpenSBI[2] to enable
Zicboz, which does not in the vendor dts on its U-Boot. Then successfully
booted to busybox on initrd with this log[3].

As previous discussion in patch v1[4], maintainer expect more basic drivers
ready before really merging it, which would be fine. For other follow-up patches, 
that are clk, pinctrl/gpio, reset.. My current goal would target at a headless
system including SD card, emmc, and ethernet.

In this series, the uart node has no 'fifo-size', 'tx-threshold' property populated,
will add them once this patch is resolved, see thread [5]

P.S: talked to Yangyu, I will help and take care of this patch series, thanks

---
Changes in v5:
- fix cache-sets in dts
- collect Rob's Ack
- rebase to 6.11-rc1
- Link to v4: https://lore.kernel.org/r/20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org

Changes in v4:
 - add i/d-cache, l2-cache info
 - squash uart1 dts node
 - update tags
 - Link to v3: https://lore.kernel.org/r/20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org

Changes in v3:
 - fix dt_binding_check error
 - fix plic compatible
 - fix uart node name
 - add uart1 dts node
 - collect tags
 - Link to v2: https://lore.kernel.org/r/20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org

Changes in v2:
 - fix timebase-frequency according to current setting
 - add other uart dt nodes, fix input frequency
 - introduce new uart compatible for K1 SoC
 - add 'k1' prefix to bananapi-f3.dts
 - fix k1-clint compatible
 - fix some typos
 - Link to v1: https://lore.kernel.org/r/tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com

Link: https://github.com/BPI-SINOVOIP/armbian-build/tree/v24.04.30 [1]
Link: https://gist.github.com/cyyself/a07096e6e99c949ed13f8fa16d884402 [2]
Link: https://gist.github.com/cyyself/a2201c01f5c8955a119641f97b7d0280 [3]
Link: https://lore.kernel.org/r/20240618-hardwood-footrest-ab5ec5bce3cf@wendy [4]
Link: https://lore.kernel.org/linux-riscv/20240706082928.2238-1-jszhang@kernel.org/ [5]

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yixun Lan <dlan@gentoo.org>

---
Yangyu Chen (9):
      dt-bindings: vendor-prefixes: add spacemit
      dt-bindings: riscv: Add SpacemiT X60 compatibles
      dt-bindings: riscv: add SpacemiT K1 bindings
      dt-bindings: timer: Add SpacemiT K1 CLINT
      dt-bindings: interrupt-controller: Add SpacemiT K1 PLIC
      riscv: add SpacemiT SoC family Kconfig support
      riscv: dts: add initial SpacemiT K1 SoC device tree
      riscv: dts: spacemit: add Banana Pi BPI-F3 board device tree
      riscv: defconfig: enable SpacemiT SoC

Yixun Lan (1):
      dt-bindings: serial: 8250: Add SpacemiT K1 uart compatible

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   1 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
 .../devicetree/bindings/riscv/spacemit.yaml        |  28 ++
 Documentation/devicetree/bindings/serial/8250.yaml |   4 +-
 .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/riscv/Kconfig.socs                            |   5 +
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/spacemit/Makefile              |   2 +
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |  19 +
 arch/riscv/boot/dts/spacemit/k1.dtsi               | 459 +++++++++++++++++++++
 arch/riscv/configs/defconfig                       |   1 +
 12 files changed, 523 insertions(+), 1 deletion(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240626-k1-01-basic-dt-1aa31eeebcd2

Best regards,
-- 
Yixun Lan <dlan@gentoo.org>


