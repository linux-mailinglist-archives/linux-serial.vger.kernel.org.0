Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80728D9160
	for <lists+linux-serial@lfdr.de>; Wed, 16 Oct 2019 14:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393270AbfJPMsd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 16 Oct 2019 08:48:33 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56930 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390608AbfJPMsc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Oct 2019 08:48:32 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DF2B21A0542;
        Wed, 16 Oct 2019 14:48:28 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D0CBE1A001A;
        Wed, 16 Oct 2019 14:48:28 +0200 (CEST)
Received: from fsr-ub1664-026.ea.freescale.net (fsr-ub1664-026.ea.freescale.net [10.171.81.59])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 24F1D205D2;
        Wed, 16 Oct 2019 14:48:28 +0200 (CEST)
From:   Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com
Cc:     jslaby@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 0/5] Add initial support for S32V234-EVB
Date:   Wed, 16 Oct 2019 15:48:22 +0300
Message-Id: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

NXP's S32V234[1] ("Treerunner") vision microprocessors are targeted for
high-performance, computationally intensive vision and sensor fusion
applications that require automotive safety levels. They include leading
edge Camera Vision modules like APEX-2, ISP and GPU. The S32V234-EVB and
S32V234-SBC boards are available for customer evaluation.

The following patch series introduces minimal enablement support for the
NXP S32V234-EVB2[2] board, which leverages most of the SoC capabilities.
Up to v2, this series also included the fsl_linflexuart driver, which has
been included in Linux 5.4-rc1[3].

In the future, we aim to submit multiple drivers upstream, which can be
found in the kernel of our Auto Linux BSP[4] ("ALB"), starting with basic
pinmuxing, clock and uSDHC drivers.

For validation, you can use the U-Boot bootloader in the ALB[5], which we
build and test with our patched version of the Linaro GCC 6.3.1 2017.05
toolchain for ARM 64-bit, with sources available on [6].

Changes in v7:
* Rebase the patch 'serial: fsl_linflexuart: Be consistent with the name'
  on the tty-next branch in Greg's tty git tree.

Changes in v6:
* In the patch 'serial: fsl_linflexuart: Be consistent with the name',
  avoid updating the definition of PORT_LINFLEXUART; that was an
  independent fix which has been submitted and accepted[9] separately;
* Avoid using 'base64' as 'Content-Transfer-Encoding'.

Changes in v5:
* Remove the patch 'dt-bindings: serial: Document Freescale LINFlexD UART'
  following its acceptance in Linux 5.4-rc1[8];
* Rebase the other patches on v5.4-rc1.

Changes in v4:
* Remove the patch 'serial: fsl_linflexuart: Update compatible string'
  following its acceptance[7];
* Rebase the patch 'serial: fsl_linflexuart: Be consistent with the name'
  on the tty-next branch in Greg's tty git tree.

Changes in v3:
* Remove the patch 'tty: serial: Add linflexuart driver for S32V234'
  following its acceptance[3];
* Replace 'Freescale' with 'NXP' in the ARCH_S32 config definition and the
  'model' property from the device tree;
* Remove the 'fsl-' prefixes from the dtsi and dts file names;
* Move the 'model' property from (fsl-)s32v234.dtsi to s32v234-evb.dts;
* Add newlines between the cpu nodes in s32v234.dtsi;
* Make use of GIC_SPI, GIC_PPI, GIC_CPU_MASK_SIMPLE and IRQ_TYPE_* in the
  'interrupts' tuples;
* Move the 'timer' and 'interrupt-controller' nodes before 'soc' in
  s32v234.dtsi;
* Be consistent with the 'LINFlexD' spelling in documentation, strings and
  comments; add new patch 'serial: fsl_linflexuart: Be consistent with the
  name' to update the LINFlexD driver as well;
* Remove from fsl,s32-linflexuart.txt a statement regarding the limitation
  to UART mode;
* Make the compatible string SoC specific ("fsl,s32v234-linflexuart"); add
  new patch 'serial: fsl_linflexuart: Update compatible string' to update
  the LINFlexD driver as well;
* In the LINFlexD binding documentation, insert a space between label and
  node name and remove the 'status' property.

Changes in v2:
* Update the entry in fsl.yaml to apply to all S32V234 based boards;
* Add chosen node to dts, with a 'stdout-path' property for earlycon;
* Remove linflex_verify_port(), because it was only called from
  uart_set_info(), which was going to always fail at the "baud_base < 9600"
  check, as we are not using uartclk from uart_port yet;
* Fix compatible string used in OF_EARLYCON_DECLARE.

[1] https://www.nxp.com/products/processors-and-microcontrollers/arm-based-processors-and-mcus/s32-automotive-platform/vision-processor-for-front-and-surround-view-camera-machine-learning-and-sensor-fusion:S32V234
[2] https://www.nxp.com/support/developer-resources/evaluation-and-development-boards/ultra-reliable-dev-platforms/s32v-mpus-platforms/s32v-vision-and-sensor-fusion-evaluation-system:S32V234EVB
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09864c1cdf5c537bd01bff45181406e422ea988c
[4] https://source.codeaurora.org/external/autobsps32/linux/
[5] https://source.codeaurora.org/external/autobsps32/u-boot/
[6] https://source.codeaurora.org/external/s32ds/compiler/gcc/
[7] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2bd3661ea0eb2056852cbc58c5d96bb4df2f164f
[8] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e16feab6cce2b91d2996d4bc4eff01ece577c4a
[9] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9050079719021776e48437827eb9d5986b6e45d4

Eddy Petrișor (1):
  dt-bindings: arm: fsl: Add the S32V234-EVB board

Mihaela Martinas (2):
  arm64: Introduce config for S32
  arm64: defconfig: Enable configs for S32V234

Stefan-Gabriel Mirea (1):
  serial: fsl_linflexuart: Be consistent with the name

Stoica Cosmin-Stefan (1):
  arm64: dts: fsl: Add device tree for S32V234-EVB

 .../admin-guide/kernel-parameters.txt         |   2 +-
 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 arch/arm64/boot/dts/freescale/s32v234-evb.dts |  25 ++++
 arch/arm64/boot/dts/freescale/s32v234.dtsi    | 139 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   3 +
 drivers/tty/serial/Kconfig                    |   8 +-
 drivers/tty/serial/fsl_linflexuart.c          |   4 +-
 include/uapi/linux/serial_core.h              |   2 +-
 10 files changed, 188 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/s32v234-evb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32v234.dtsi

-- 
2.22.0

