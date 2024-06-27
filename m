Return-Path: <linux-serial+bounces-4769-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEAC91AB50
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2024 17:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACCB1C20B2D
	for <lists+linux-serial@lfdr.de>; Thu, 27 Jun 2024 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B8198E89;
	Thu, 27 Jun 2024 15:32:25 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D2198A34;
	Thu, 27 Jun 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502345; cv=none; b=ZEEjcAmHnMABNADPLKi7YiszfnQ16jKVJcTLX8FMLSN1FkX3nO5K808M5Nly+yMtxmTHzUdb9sXyXns3tRXdWQdyR9CStCbR/HPvaML0pO01T+SBsGJfqTy/2Q25PndGRLpKskOBgKkGLCMc2p8LMLK7NjzBkJP620nttAu7wLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502345; c=relaxed/simple;
	bh=aVbM1IQMkrPPckh5xWOxqYkHnsmPqgtjycwr/CEZgeY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dXUye54xRAy4Kj5n0+unJ/CBv7N98JNEl6pEFtwq8gj9zENH7poUWIVXfhei3NCHfEQom/quMMuzDp3ARh9KvgDb17Z2XecIjAOXjACoXeLLv3dRpC4LTX9oaPpa4xpHqDkF+uP08nAbXtWodBe6LaEbjEao8B7SIp5kqyfI7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2 00/10] riscv: add initial support for SpacemiT K1
Date: Thu, 27 Jun 2024 15:31:14 +0000
Message-Id: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMKFfWYC/x3MPQqAMAxA4atIZgNtlA5eRRz6EzUIVVoRofTuF
 sdveK9A5iScYeoKJH4kyxkbqO/A7zZujBKagRSNypDBQ6PS6GwWj+FGbe2gmdn5QNCiK/Eq7z+
 cl1o/6qWQ5mAAAAA=
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
 Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4039; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=aVbM1IQMkrPPckh5xWOxqYkHnsmPqgtjycwr/CEZgeY=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmfYXcZao4t4/seNTZQlv12YCD3ueUpvzGIelTI
 x+XqLaMjFiJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZn2F3F8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277UNTD/98/CPAZzXwZUxG50
 N+CfEzPFoSR+6m6Z+zjvH74DWMIFuLEeghYIrET4c3lEE9WtK3QxuZJNh/3Zf9KOgFaRmHRppb/
 tfwgMiOpFJOr8RlwT4FUBRvqsbfQfNq8pHfdkdj+adTpXPBqOo2i8zEW+GxuA13T7XKWLWumM8V
 AJjXlmuOFnlbRRncxhaqXwx0YrDsaLoOKnj9PNYj0wn0fl0Kotx6mqeOXtCiZDiHh56xrW2z5g6
 /Zd8HaIIr6Ir+7niOSRa6PupQmjZ7o2BEv0FMMR7BL3mOL16ELhgFbrp5jeStt7NuE1eN5c6Ixf
 kgGzDV0KGymWAVw4rPp6ix7FHy2LhRD1ku/ijbIy1xsCb3xJcOML9AoWir/AvXWOyfVMUJPc8Yy
 k0JVjw+ex1UCVqaAzgf8ejAVl0d55iT6Xsag1OAnQew5+Wsgm3d121LJoUDdLKuSa7JFj8K0P1+
 RuvdhxoMTMKK+PwTQqNwIiRKCTwtmJB9Ek764dXGc1XJFzdiWX5kNF3VmcLcqtHtbG1y4BlYqFX
 xPvHS7BCo3I7Yt4/SfgTR6BHTpkTsOq7rtcdARSOh08+Yj5Y0GZDpn0HEefur6Bjb85AbYFD+li
 Es2bfCsSg+sz2/klkwIHqYvAHk2EMDoptVQCDlM1Axa0T0Gk+uSRxS7ubmHXHb2TnAaQ==
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
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: Inochi Amaoto <inochiama@outlook.com>
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
      riscv: add SpacemiT SOC family Kconfig support
      riscv: dts: add initial SpacemiT K1 SoC device tree
      riscv: dts: spacemit: add Banana Pi BPI-F3 board device tree
      riscv: defconfig: enable SpacemiT SoC

Yixun Lan (1):
      dt-bindings: serial: 8250: Add SpacemiT K1 uart compatible

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   5 +-
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
 .../devicetree/bindings/riscv/spacemit.yaml        |  24 ++
 Documentation/devicetree/bindings/serial/8250.yaml |   4 +-
 .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/riscv/Kconfig.socs                            |   5 +
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/spacemit/Makefile              |   2 +
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |  19 ++
 arch/riscv/boot/dts/spacemit/k1.dtsi               | 378 +++++++++++++++++++++
 arch/riscv/configs/defconfig                       |   1 +
 12 files changed, 441 insertions(+), 2 deletions(-)
---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240626-k1-01-basic-dt-1aa31eeebcd2

Best regards,
-- 
Yixun Lan <dlan@gentoo.org>


