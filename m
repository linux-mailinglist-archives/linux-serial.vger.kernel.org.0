Return-Path: <linux-serial+bounces-4963-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F150E92AE89
	for <lists+linux-serial@lfdr.de>; Tue,  9 Jul 2024 05:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8E81F22B97
	for <lists+linux-serial@lfdr.de>; Tue,  9 Jul 2024 03:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593C8433BE;
	Tue,  9 Jul 2024 03:19:39 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770FC3214;
	Tue,  9 Jul 2024 03:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495179; cv=none; b=cUIViu+nRs295lcnnIFcl/Sg6yzZWuQgTUaTpdqWv2Oa+yFE4J/hWYd+mlRVbxmZI1oIluQnoYCpaQUMVcjz2VjNDrHph4R/4dTJI0onHKlxLso86L0ekluRcCERt2RVc/fJQQhDzv1NK451Wb27t1PZ93WbHP+h/0Jd2I0UTsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495179; c=relaxed/simple;
	bh=1SdTmeilqjiG7jpnm9+ZW5h/p8HcQo7QMrkh1sNGG88=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VwxnooNqN5WUCzmqc2VGpVu1KipPjI2Q71lPsVJPkjyQVN+yu2qDFLiEP++dybkkL+3WcHK6tyPYyd7REG01l3eYquAI+F7O5s38ac+QjwUPEysaMTPZlQI3h8DOQOB1PHOwhh7ChgrHkAJ3Q22SMx+zVJxU672kZp2CqgV48UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v4 00/10] riscv: add initial support for SpacemiT K1
Date: Tue, 09 Jul 2024 03:18:43 +0000
Message-Id: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABOsjGYC/2XMSwrCMBSF4a2UO/ZKXk3AkfsQB2l62wahkSQEp
 XTvpgURdXgO/N8CiaKnBKdmgUjFJx/mOtShATfZeST0fd0gmFBMC403joxjZ5N32Gfk1kpORJ3
 rBdToHmnwjx28XOuefMohPne/iO19U+aXKgIZOse0M23bDsycR5pzCMcQR9isIj+9YfKvl7XnY
 jCyU0ZpTl/9uq4v5mU/fO0AAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
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
 Meng Zhang <kevin.z.m@hotmail.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>, Conor Dooley <conor.dooley@microchip.com>, 
 Matthias Brugger <matthias.bgg@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4804; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=1SdTmeilqjiG7jpnm9+ZW5h/p8HcQo7QMrkh1sNGG88=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmjKwbIJafHAqwMsLyc2V+MIIXf4+E9UmMfC3lR
 JnzpNZNKseJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoysG18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277TDYD/9qTw/C2ltVXIRNhv
 Zqp3aW/KSv8QRlrbmf5NAtqnLENgOQ1Ckx94bdhXnfGQCNkTI3vSOw6RcnJlsXwp3pIRuMb10v1
 3ITzsi1OZAEi7ydZU2xi6AioLp0Mq/xWfaBrYxYwpyJDBqyTmTI5vOnJBL4EMakqZUIv5I7ntdp
 snkZwgtKwTGwJ6XFC0WSKK1mpKM8jXisJ1VQUrZ1IEg8sX+5BG/Jct1dxgrxyLOC51HC8arHLc2
 Y9JKATGoz/bRVZsnAkuHwSmq39tScVPunP10VzobRwkRyEp2vmnBC0DEEtZIe0Mu/i6BAckLi6a
 MznA+oJPzveLoI03Py+z4sVEjmQlamfvjws/BK+NTIqHTL6rTN5aRu65ENf9xE2tbYA5XNrHPZb
 b4+8VMXGqGEeqk30Vu2XTDvm7d5Jrb7rukEVTF+eGNOkei+TIYUq0nWRsZax04Xa+t3ke/+FlDQ
 MyAqlG2XKqMH/jWFHijVbkm6N+DeDHbefmKWTaPU719x0aPg0yDycw+1QQJfVAVaGjlDCscEO1d
 2So/6XNt/BXK41NOV1zEN1it2ybB7IFDh2OU5DuO8pFyrpbsIepVOU441nl/Pl2KRZHKIaCOD+N
 rHxfZ+HQv/NDe9OCuZkTgy9cojTpWvElRcWd4uedfs8TjCIBDl7gRDESpc8rDra/lJQg==
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
Link:https://lore.kernel.org/linux-riscv/20240706082928.2238-1-jszhang@kernel.org/ [5]

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Conor Dooley <conor@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
To: Samuel Holland <samuel.holland@sifive.com>
To: Anup Patel <anup@brainfault.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: Jesse Taube <jesse@rivosinc.com>
Cc: Jisheng Zhang <jszhang@kernel.org>
Cc: Inochi Amaoto <inochiama@outlook.com>
Cc: Icenowy Zheng <uwu@icenowy.me>
Cc: Meng Zhang <zhangmeng.kevin@spacemit.com>
Cc: Meng Zhang <kevin.z.m@hotmail.com>

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
base-commit: 256abd8e550ce977b728be79a74e1729438b4948
change-id: 20240626-k1-01-basic-dt-1aa31eeebcd2

Best regards,
-- 
Yixun Lan <dlan@gentoo.org>


