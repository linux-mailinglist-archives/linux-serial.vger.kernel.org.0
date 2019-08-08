Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80185D4C
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfHHIvp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 04:51:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36631 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHIvp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 04:51:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so333155wrt.3
        for <linux-serial@vger.kernel.org>; Thu, 08 Aug 2019 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vifwZCE4bnskih8jmiWXXxluQMEl4VWESPVBYYZw1Fc=;
        b=OFvZDM2GMu+vNEzqszF7ge0Swd1VEF//llkq14iazVY4eYdAX7SfvBw71e1ROskeQs
         eTdH3onFMmimiTDbMHf9wtIEsKETqkpp9/znyHWDzs4GlVAbIKA4jTEuba2fzW4QST1U
         lC/c7vcgt016PN9/xE2xfZFIbHDkJTzNiXKECIoIYkZu8EE6PnEc7MjW4/qi4JsSqy8R
         tgs4Fojid604Eo4/9TjdzfeFrnVyBUwCZalwvqCe/36SLypMwp2C4Qi75ZuL0y2vWqG5
         SAkAo9ITL5rrygXMNmYZbRWkvOECmyI/ILT6X84dtMcZffLwNvZs0Dga6Pw11fLaKwqR
         fPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vifwZCE4bnskih8jmiWXXxluQMEl4VWESPVBYYZw1Fc=;
        b=I5FL3Z8GDbnmDvnd5OvEdZ+YCofxWnGiBna4yulSF16H+Nn5WE1Op1FaIO04JsJkRb
         26BU4m6zsHea2kg3NfUqIJJLke6yfU+gxxEiIumNkgmSY8pvAH6RJyDG8YGBD3WpzVVZ
         ihJ3ZGuby7DjUfzNK71j0SxwymqdqYDdRq/evUNSwbF7YKu6/JArGBj3S5NTFNlAO8mi
         zGijENkJ3GGtG2u2q7X0O+JZYrkyq9nRq3FWy4xdHHpV89BRIBC6DB7+4HBZpj6e5KgQ
         QTlNCADAM4HIhdEqrcHlBTHoDlISIAf4p1KSGZi5SX4k5fmPWFUK4dkjqyLqU+0TcRN7
         kBtw==
X-Gm-Message-State: APjAAAWmlO+7jzZWFRv2jYyz7aipgPTXfP9+nnoVaA37N67Dy1RpBMFJ
        NI7NKvzSjTKjb2tJYNNnrRUKcA==
X-Google-Smtp-Source: APXvYqwYEgl9MohCcq4LViUU9lWOpsLOwFkb7HqqBUCOa+plL4VwngfAF9IVJpka4nRbg/TwRZbMuQ==
X-Received: by 2002:adf:f088:: with SMTP id n8mr15584283wro.58.1565254301982;
        Thu, 08 Aug 2019 01:51:41 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i66sm3360031wmi.11.2019.08.08.01.51.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 01:51:41 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        jassisinghbrar@gmail.com, kishon@ti.com, p.zabel@pengutronix.de
Subject: [PATCH 0/9] dt-bindings: first tentative of conversion to yaml format
Date:   Thu,  8 Aug 2019 10:51:30 +0200
Message-Id: <20190808085139.21438-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a first tentative to convert some of the simplest Amlogic
dt-bindings to the yaml format.

All have been tested using :
$ make ARCH=arm64 dtbs_check

Issues with the amlogic arm64 DTs has already been identified thanks
to the validation scripts. The DT fixes will be pushed once these yaml
bindings are acked.

Changes since rfc v2:
- Collected Rob's, Martin's, Philipp's and Guenter's tags
- Removed mhu maxItems: 3 to leave only minItems
- Fixed flash@0 in spifc example

Changes since rfc v1:
- Fixed bindings according to Rob's comments
- Added commit log
- renamed yaml files using amlogic prefix

Neil Armstrong (9):
  dt-bindings: mailbox: meson-mhu: convert to yaml
  dt-bindings: rng: amlogic,meson-rng: convert to yaml
  dt-bindings: spi: meson: convert to yaml
  dt-bindings: reset: amlogic,meson-reset: convert to yaml
  dt-bindings: arm: amlogic: amlogic,meson-gx-ao-secure: convert to yaml
  dt-bindings: phy: meson-g12a-usb2-phy: convert to yaml
  dt-bindings: phy: meson-g12a-usb3-pcie-phy: convert to yaml
  dt-bindings: serial: meson-uart: convert to yaml
  dt-bindings: watchdog: meson-gxbb-wdt: convert to yaml

 .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 -------
 .../amlogic/amlogic,meson-gx-ao-secure.yaml   | 52 +++++++++++++
 .../mailbox/amlogic,meson-gxbb-mhu.yaml       | 52 +++++++++++++
 .../devicetree/bindings/mailbox/meson-mhu.txt | 34 ---------
 .../phy/amlogic,meson-g12a-usb2-phy.yaml      | 63 ++++++++++++++++
 .../phy/amlogic,meson-g12a-usb3-pcie-phy.yaml | 57 +++++++++++++++
 .../bindings/phy/meson-g12a-usb2-phy.txt      | 22 ------
 .../bindings/phy/meson-g12a-usb3-pcie-phy.txt | 22 ------
 .../bindings/reset/amlogic,meson-reset.txt    | 19 -----
 .../bindings/reset/amlogic,meson-reset.yaml   | 37 ++++++++++
 .../bindings/rng/amlogic,meson-rng.txt        | 21 ------
 .../bindings/rng/amlogic,meson-rng.yaml       | 37 ++++++++++
 .../bindings/serial/amlogic,meson-uart.txt    | 38 ----------
 .../bindings/serial/amlogic,meson-uart.yaml   | 73 +++++++++++++++++++
 .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 67 +++++++++++++++++
 .../bindings/spi/amlogic,meson6-spifc.yaml    | 53 ++++++++++++++
 .../devicetree/bindings/spi/spi-meson.txt     | 55 --------------
 .../watchdog/amlogic,meson-gxbb-wdt.yaml      | 37 ++++++++++
 .../bindings/watchdog/meson-gxbb-wdt.txt      | 16 ----
 19 files changed, 528 insertions(+), 255 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/meson-mhu.txt
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-g12a-usb2-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-g12a-usb3-pcie-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/amlogic,meson-rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt

-- 
2.22.0

