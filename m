Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF6242963
	for <lists+linux-serial@lfdr.de>; Wed, 12 Aug 2020 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgHLMd5 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 12 Aug 2020 08:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHLMd4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 08:33:56 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824DCC06174A
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 05:33:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so1996481ljo.12
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aQwP/0l0m5s+Hp6E9P2OaxabPF+ONqwtg5F3idJNxeo=;
        b=E1Oyp1cDKNXa/qL202tPvk+586jn7dzdRSDowWFBi3ibjreBcyongiJbYLzZBNs6Hb
         SFS3+XBKWcjS61acKhdJbl8jzFYrrFWYhFIraeQqVwPb8oUHSuh95BulF1qr12dxVbzt
         T9g/bX5P68NjhX8eRtvn2abSXpl3pyPCHNZrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aQwP/0l0m5s+Hp6E9P2OaxabPF+ONqwtg5F3idJNxeo=;
        b=B+k/afnkrB+QfVerwhwgYTgZ6FEDQmDKzKgUreUTdEhE9jgbcWHxKIHOZVN3M61JkJ
         4eiW4pnNsZaR2BSPhSJbHjgeNb9XbMqmI/tcDCDhgK811NhocLMcNJ8iajBQUMSLgZg/
         qy4hdEfbwzWFZG4Mc95zVkMkR1NyfoIuxp9XeIFAiLOrayvvyUq7LoejtYKdWmSbZ/32
         YaQ4ONlJLmwt3uFS/ixQL/1ndiQw1XBwx9NqTX4vMZCu22ohbUuD6MPTOzzatV5EqK01
         KevAArA7BjVc1o60/3INLCn1CcUYNew6adZ5g6zpZyL3u4ah2R55nE3F0G1g2p5dHCWA
         Kecw==
X-Gm-Message-State: AOAM530D+L0PXnZyAPw4Rj6gBHapMfqnpJzx0M5HP//gUiF9ZpmHb9GM
        MnME/O9xtQebmMK52ss8wMQEvA==
X-Google-Smtp-Source: ABdhPJzDLRNV6Ipk/5lW5Sc5MeOljidE0sbnR7D6ZFavmHh+RRkNYPs6cq5l1Du/GfScLPHm/VvzXQ==
X-Received: by 2002:a2e:302:: with SMTP id 2mr4821823ljd.156.1597235635003;
        Wed, 12 Aug 2020 05:33:55 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id r19sm414364ljc.59.2020.08.12.05.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 05:33:54 -0700 (PDT)
Date:   Wed, 12 Aug 2020 14:33:46 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: [PATCH v10 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20200812143324.2394375-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patchset introduces support for LiteX SoC Controller
and LiteUART - serial device from LiteX SoC builder
(https://github.com/enjoy-digital/litex).

In the following patchset I will add
a new mor1kx-based (OpenRISC) platform that
uses this device.

Later I plan to extend this platform by
adding support for more devices from LiteX suite.

Changes in v10:
    - added casting to avoid sparse warnings in the SoC Controller's driver

Changes in v9:
    - fixed the `reg` node notation in the DT example
    - added exporting of the `litex_set_reg`/`litex_get_reg` symbols

Changes in v8:
    - fixed help messages in LiteUART's KConfig
    - removed dependency between LiteUART and LiteX SoC drivers
    - removed `litex_check_accessors()` helper function
    - added crashing (BUG) on the failed LiteX CSR access test

Changes in v7:
    - added missing include directive in UART's driver

Changes in v6:
    - changed accessors in SoC Controller's driver
    - reworked UART driver

Changes in v5:
    - added Reviewed-by tag
    - removed custom accessors from SoC Controller's driver
    - fixed error checking in SoC Controller's driver

Changes in v4:
    - fixed copyright headers
    - fixed SoC Controller's yaml 
    - simplified SoC Controller's driver

Changes in v3:
    - added Acked-by and Reviewed-by tags
    - introduced LiteX SoC Controller driver
    - removed endianness detection (handled now by LiteX SoC Controller driver)
    - modified litex.h header
    - DTS aliases for LiteUART made optional
    - renamed SERIAL_LITEUART_NR_PORTS to SERIAL_LITEUART_MAX_PORTS
    - changed PORT_LITEUART from 122 to 123

Changes in v2:
    - binding description rewritten to a yaml schema file
    - added litex.h header with common register access functions

Filip Kokosinski (3):
  dt-bindings: vendor: add vendor prefix for LiteX
  dt-bindings: serial: document LiteUART bindings
  drivers/tty/serial: add LiteUART driver

Pawel Czarnecki (2):
  dt-bindings: soc: document LiteX SoC Controller bindings
  drivers/soc/litex: add LiteX SoC Controller driver

 .../bindings/serial/litex,liteuart.yaml       |  38 ++
 .../soc/litex/litex,soc-controller.yaml       |  39 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   9 +
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/litex/Kconfig                     |  15 +
 drivers/soc/litex/Makefile                    |   3 +
 drivers/soc/litex/litex_soc_ctrl.c            | 194 +++++++++
 drivers/tty/serial/Kconfig                    |  32 ++
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 402 ++++++++++++++++++
 include/linux/litex.h                         |  24 ++
 13 files changed, 761 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h

-- 
2.25.1

