Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C041EE22B
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jun 2020 12:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgFDKNI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jun 2020 06:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgFDKNI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jun 2020 06:13:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83617C03E97D
        for <linux-serial@vger.kernel.org>; Thu,  4 Jun 2020 03:13:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n24so6508557lji.10
        for <linux-serial@vger.kernel.org>; Thu, 04 Jun 2020 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZZVPaeD6pafUVZlGgrGYpBNjojdk0ld5/Ukhpgln068=;
        b=Lg19XjiaIStU/45Aokk3jdAKSEAxz1u/TC55Qx/tOh05DuScCZwfQf29WiE0m3mq/d
         RqXdntbuLjFZhfOVgw2FM8KIv74eVobECT3sGQpxnyKhAEl1QPv9sT7hFZwjpnGKRlf5
         6cTVPy+Tv9TCR0tPhYrgU70y0gSm7XDYwEOiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZZVPaeD6pafUVZlGgrGYpBNjojdk0ld5/Ukhpgln068=;
        b=t6FgTRB5gdTFpdM7NK1ft6BI2U94tq55Iyy+cmQcusDt99mCUNdoEVCt4aRjdMHyI6
         IJrueUDWfrh6Z+ei6HkjWJzit72CPPfK8s7s6HKyX6tPuGKBa2ogKJnQUFU35XsGD75S
         dRCfHzbKbTT8TtwJ87h7VHmN4s1beS3mXDOlkriQZwULauiqrVxMzN/WI3c8EPeETOIw
         XOhghDCGKRxKQBgTTOinYo7iYpQC2SuWBGf3RI3yQo0k9epu0DQHkRKvXOdwfzjldWbb
         qDBjLYF7hZVjC456AejUqCAAjZVWOk5PilRl2pgvdgfFfmMlWg+H105YsEiqrofT1GdB
         i3aw==
X-Gm-Message-State: AOAM533sbiVKSGudq3OLvZ5TBtPoK6HcImXZE/5DqOFkgs0fn/zta/Sf
        SLfFTBBt8diddbANzWnuAN8Tqw==
X-Google-Smtp-Source: ABdhPJyoMv/UljqcbfMr3TmJJ2V+jZ4DDPzKGoMgnLz3G6jRojSqBemSop3+XUqhZR3Q9hTTOY5jIg==
X-Received: by 2002:a2e:b6c5:: with SMTP id m5mr1698155ljo.94.1591265585804;
        Thu, 04 Jun 2020 03:13:05 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id w144sm1363270lff.67.2020.06.04.03.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 03:13:05 -0700 (PDT)
Date:   Thu, 4 Jun 2020 12:12:42 +0200
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
Subject: [PATCH v7 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20200604121142.2964437-0-mholenko@antmicro.com>
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
 drivers/soc/litex/litex_soc_ctrl.c            | 197 +++++++++
 drivers/tty/serial/Kconfig                    |  31 ++
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 405 ++++++++++++++++++
 include/linux/litex.h                         |  45 ++
 13 files changed, 787 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h

-- 
2.25.1

