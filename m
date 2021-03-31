Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169DD34E3AE
	for <lists+linux-serial@lfdr.de>; Tue, 30 Mar 2021 10:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhC3I6f (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 30 Mar 2021 04:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhC3I6b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Mar 2021 04:58:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626F3C061762;
        Tue, 30 Mar 2021 01:58:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id g10so5809105plt.8;
        Tue, 30 Mar 2021 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SuS+rvaIUv9IJ+ZscCrtrKCw8bRQ0jb1gAC0r+0KWLM=;
        b=mT48BduQU7uqTb1hauzpYjNyvEmzgo5IsFfTovQ3nmQ17nazjEnMCDANKLbP++3o6g
         lRHhRKWSs90WR2MHWiEUnC9WO/RqQNh/7Oy5/NZkkrBZwGKUicFGy95L1MHTDNpD18CK
         CyQqaNQV8pbSmZN0sCt8yqxt3d7lXN9vt20g9vxOTqoxjlj3eOvlcNV6lmg39wZybhmN
         oOOFXGygtNUcSlc2yqM+1DYlWuIFseyikPBqOAF9DMvOiqYVtkjW0YYrIJwYFBlrRIvL
         2pxLiyVdqDw0Sd3HcG9uNlYJ1n5W9xSYrKEmMsHb27NmcRQVn/JwTbj/D83FajZfnPcB
         8jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SuS+rvaIUv9IJ+ZscCrtrKCw8bRQ0jb1gAC0r+0KWLM=;
        b=WaidRwPeEsC4XtZzRvS94GtMToyccXcGPauNYwIN6CkpiMxO4HACekr5SXYBgiV9+9
         JlJKhaDpkuVZIafVebkitwIa3GcX4kHUs/W4gpryrS/dUb6Evs5878hsYk6pjbdlojnC
         JcynCMCbBTDZwpVid7JuipdQXYdvqboT2gqflYpQsmUYbkycmeWgvmDtS+aHEQIIqcv5
         lFcPWLf2c4WlmF84OAfFl2JGPjsmC/bG2sC3vpkylXLT0i83jXxoqulFEO2I9Hy1WJ3L
         VA/waN1XMWhd/CET0a72EKG+qyApKbY5wJxoXJJRtQ3TCi3M17SRmwk40Op/FUkYsWjx
         eOQg==
X-Gm-Message-State: AOAM533kOxKc3lY+CXYn0OWuY1qsFBlumbfbDGSf6okv7yjWWwysSSfw
        MeXzijKT3qWhKL83vhud9PE=
X-Google-Smtp-Source: ABdhPJyLqM9r2e9gjPnie0Ciq/T/axyEBD9m+ZBld/EMpmunNoq0tkJ+0n0a8LQFo4OyVrVqJ8zYsQ==
X-Received: by 2002:a17:902:6541:b029:e6:27a4:80fb with SMTP id d1-20020a1709026541b02900e627a480fbmr32086393pln.15.1617094710912;
        Tue, 30 Mar 2021 01:58:30 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id y8sm20952642pfp.140.2021.03.30.01.58.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 01:58:30 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh@kernel.org, valentin.caron@foss.st.com,
        Alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, afzal.mohd.ma@gmail.com,
        gregkh@linuxfoundation.org, erwan.leray@foss.st.com,
        erwan.leray@st.com, linux-serial@vger.kernel.org, lkp@intel.com,
        patrice.chotard@foss.st.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v8 0/6] ARM: STM32: add art-pi(stm32h750xbh6) board support
Date:   Tue, 30 Mar 2021 16:58:18 +0800
Message-Id: <1617094704-10040-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset intend to add art-pi board support, this board developed
by rt-thread(https://www.rt-thread.org/).

Board resources:
8MiB QSPI flash
16MiB SPI flash
32MiB SDRAM
AP6212 wifi,bt,fm comb

sw context:
- as stm32h750 just has 128k bytes internal flash, so running a fw on
  internal flash to download u-boot/kernel to qspi flash, boot
  u-boot/kernel from qspi flash. this fw is based on rt-thread.
- kernel can be xip on qspi flash or load to sdram
- root filesystem is jffs2(created by buildroot), stored on spi flash

to support the boad, add following changes.
- fix r0-r3, r12 register restore failed after svc call,
- add dts binding
- update yaml doc

---
changes in v8:
- drop '[PATCH v7 3/6] ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to
  support stm32h750' - stm32h743-pinctrl.dtsi file
- move compatible string "st,stm32h743-pinctrl" from stm32h7-pinctrl.dtsi
  to stm32h743.dtsi
- update stm32h743i-{dico/eval}.dtsi to include stm32h7-pinctrl.dtsi
- move file stm32h743.dtsi submit position to [PATCH V8 3/6]
v7 link:
https://lore.kernel.org/lkml/1617071338-9436-1-git-send-email-dillon.minfei@gmail.com/

changes in v7:
- remove changes in
  Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
  Hi Rob Herring
  as you has already ack this patch, please ignore it. thanks
  history link:
  https://lore.kernel.org/lkml/1614758717-18223-4-git-send-email-dillon.minfei@gmail.com/
  https://lore.kernel.org/lkml/20210308195033.GA2855292@robh.at.kernel.org/
- remove "[PATCH v6 8/9] pinctrl: stm32: Add STM32H750 MCU pinctrl support"
  remove "[PATCH v6 5/9] ARM: dts: stm32: add stm32h750-pinctrl.dtsi"
- reference to stm32h743-pinctrl.dtsi in stm32h750i-art-pi.dts
v6 link:
https://lore.kernel.org/lkml/1616757302-7889-1-git-send-email-dillon.minfei@gmail.com/

changes in v6:
- add gpiox{gpio-ranges, ngpios} in stm32h7-pinctrl.dtsi
- add status="disabled" in stm32h743.dtsi 

changes in v5:
- accroding to rob's suggestion, replace false with 'type: object'
  of 'additionalProperties'.
- add Tested-by: Valentin Caron <valentin.caron@foss.st.com>

changes in v4:
- use unevaluatedProperties: false to fix dtbs_check warrnings instead of
  add 'bluetooth' in st,stm32-uart.yaml

changes in v3:
- fix dtbs_check warrning: (8002cbd78fd5 and 4bc21d3dd678)
  >> arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: pin-controller:
     {'type': 'object'} is not allowed for {'#address-cells': [[1]], '#size-cells':
     [[1]], 'ranges': [[0,

  >> arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: 'i2c@40005C00',
     'i2c@58001C00' do not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$',
     '^[^@]+$', 'pinctrl-[0-9]+'
  >> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800:
     'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'

changes in v2:
- reorganize the pinctrl device tree about
  stm32h7-pinctrl/stm32h743/750-pinctrl
  stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi --> stm32h743i-disco.dts
                         |                          |-> stm32h743i-eval.dts
                         |-> stm32h750-pinctrl.dtsi --> stm32h750i-art-pi.dts
  same to the stm32f7/f4's pinctrl style
- fix author name/copyright mistake
- add compatible string st,stm32h750-pinctrl to pinctl-stm32h743.c as they
  have same pin alternate functions, update Kconfig description
- make item in stm32h750i-art-pi.dts sort by letter

*** BLURB HERE ***

dillon min (6):
  Documentation: arm: stm32: Add stm32h750 value line doc
  dt-bindings: arm: stm32: Add compatible strings for ART-PI board
  ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h750
  ARM: dts: stm32: add support for art-pi board based on stm32h750xbh6
  ARM: stm32: Add a new SOC - STM32H750
  dt-bindings: serial: stm32: Use 'type: object' instead of false for
    'additionalProperties'

 Documentation/arm/index.rst                        |   1 +
 Documentation/arm/stm32/stm32h750-overview.rst     |  34 ++
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   4 +
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |   3 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/stm32h7-pinctrl.dtsi             | 341 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           | 306 ------------------
 arch/arm/boot/dts/stm32h743.dtsi                   | 165 +++++++++-
 arch/arm/boot/dts/stm32h743i-disco.dts             |   2 +-
 arch/arm/boot/dts/stm32h743i-eval.dts              |   2 +-
 arch/arm/boot/dts/stm32h750.dtsi                   |   6 +
 arch/arm/boot/dts/stm32h750i-art-pi.dts            | 229 ++++++++++++++
 arch/arm/mach-stm32/board-dt.c                     |   1 +
 13 files changed, 784 insertions(+), 311 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst
 create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/stm32h743-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts

-- 
2.7.4

