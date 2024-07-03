Return-Path: <linux-serial+bounces-4877-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC2C9263F6
	for <lists+linux-serial@lfdr.de>; Wed,  3 Jul 2024 16:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D611B21886
	for <lists+linux-serial@lfdr.de>; Wed,  3 Jul 2024 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C3F17B401;
	Wed,  3 Jul 2024 14:56:39 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB91EB48;
	Wed,  3 Jul 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018599; cv=none; b=aPjCj+Tctg18C8AqtlCVWzRuCwf1ryKfyDxmFMyYf8ixOQPyOm5YHuo17+ziofQCkF8mn9n9500kChMBkUToyPI9alUitJgWKJdI2pVAQ7zcusMXqQ/k/wGlAP6oAxEc/tyRzB+P/gr3tJzRgSBD/TjFdHNSVMmS/e76tLdPCNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018599; c=relaxed/simple;
	bh=NwPx3nsi9Frt9F3UqrolqP4cPwi7Q+jktVDtLsEkNUs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SyCZL8pGGf6+nW/ofq49b54SkQ+trhRyPjfsNjts647hCyQl9E9JQHw5+HXBPEKUid/OAFTtHqeP1BlEDCNyYxlMrKkIV8SrUmH4v51IhuJKC5jalQ1cmCI6TyO6b2dYL92VOK2JJa5cM8JBWQUq+8GO6TUK61knZ6Tr7QazfLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v3 00/11] riscv: add initial support for SpacemiT K1
Date: Wed, 03 Jul 2024 14:55:03 +0000
Message-Id: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEdmhWYC/13MQQrDIBCF4auEWXeKmmqgq96jZGHMxAyFWFSkJ
 Xj32kA3Xf4P3rdDosiU4NrtEKlw4rC16E8duNVunpDn1qCEugijDD4kComTTexwziit7SURTW5
 W0E7PSAu/DvA+tl455RDfh1/Ud/1Rwz9VFAp0Thg3aK0XMdw8bTmEc4gexlrrB0Oo7vutAAAA
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
 Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4318; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=NwPx3nsi9Frt9F3UqrolqP4cPwi7Q+jktVDtLsEkNUs=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmhWZ0HOav0H0NHzSndaIJgQRth3C/Xo4ktKzdn
 3fML2AcfpiJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoVmdF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277ZvAD/9q3jxF1uPzaRjIT2
 uJ72pkyE2r8LAfLjsTAbPexyz/OQZfWG0ITZJSDtukOJVOwyH+924ozLF+7zCXmzmExJGMJ51CX
 7viL8GXJRxZWMWMIBam/ZcE98zrLmlu6gzT7i8zuR5s/OmuVImdoqePXSNg+IH8QiV8lGlGVOQQ
 FjNg/qRjhxEXiIWMoE3oXw6FXl1ZbcmVtqbhKIL9rByoT0Zmx00rbCDzEjdDi8xqCsTaJ9ftc2X
 BgQEpQUAOP7UlRp9ExUvEP5CfMxHoquTVc00BEdfqVWjCqMkqxqTcRGWqHcO43BJx56uZZDO696
 +DExF//8oV2OMM4bwACUAqcVEd/LIAv2Fq2Bgi0nS8+20m+BDqDELItTa3OyxrTUqe+ZsWOzlkY
 t/bmwRleCkugSWFWXe7G0ddY/cn7IPFYP+RbShSbrIGU3BJAF+DqIaqp6Lu1PM6OTVbS+zYCPz9
 x5BxzkH45c+HQ63mXYEPkrWsFNZK0VhtnbIQsQ5QsMbFNsSF1d/unhfohlv1NgkiC4d4DC3QjKN
 bMiEdPcgid02XHxJ+rjxK30LkheQVZZ25GvarL6932RXv+gzu7Kxd01vt49NeSkTfaGl8psrofK
 /VEucX+AlmM7AYmDhoOAV96vi/5eR8Rge+3gLaaaalDW4FG4lkLpmB/nlEdwikTBg4WQ==
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

P.S: talked to Yangyu, I will help and take care of this patch series, thanks
---
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
Cc: Inochi Amaoto <inochiama@outlook.com>
Cc: Icenowy Zheng <uwu@icenowy.me>
Cc: Meng Zhang <zhangmeng.kevin@spacemit.com>

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

Yixun Lan (2):
      dt-bindings: serial: 8250: Add SpacemiT K1 uart compatible
      riscv: dts: spacemit: add uart1 node for K1 SoC

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
 arch/riscv/boot/dts/spacemit/k1.dtsi               | 386 +++++++++++++++++++++
 arch/riscv/configs/defconfig                       |   1 +
 12 files changed, 450 insertions(+), 1 deletion(-)
---
base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
change-id: 20240626-k1-01-basic-dt-1aa31eeebcd2

Best regards,
-- 
Yixun Lan <dlan@gentoo.org>


