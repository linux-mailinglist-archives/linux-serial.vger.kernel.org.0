Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78631D7BA5
	for <lists+linux-serial@lfdr.de>; Mon, 18 May 2020 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgEROp7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 18 May 2020 10:45:59 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:54401 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgEROp7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 10:45:59 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 6033610351778;
        Mon, 18 May 2020 16:45:56 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 23DD7626CE30;
        Mon, 18 May 2020 16:45:56 +0200 (CEST)
X-Mailbox-Line: From 4f4411895dc52c846f766e7f7207ec412c4811b6 Mon Sep 17 00:00:00 2001
Message-Id: <4f4411895dc52c846f766e7f7207ec412c4811b6.1589811297.git.lukas@wunner.de>
In-Reply-To: <cover.1589811297.git.lukas@wunner.de>
References: <cover.1589811297.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 18 May 2020 16:45:01 +0200
Subject: [PATCH v3 1/2] dt-bindings: serial: Add binding for rs485 bus
 termination GPIO
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit e8759ad17d41 ("serial: uapi: Add support for bus termination")
introduced the ability to enable rs485 bus termination from user space.
So far the feature is only used by a single driver, 8250_exar.c, using a
hardcoded GPIO pin specific to Siemens IOT2040 products.

Provide for a more generic solution by allowing specification of an
rs485 bus termination GPIO pin in the device tree.  An upcoming commit
implements support for this pin for any 8250 driver.  The binding is
used in device trees of the "Revolution Pi" PLCs offered by KUNBUS.

[Heiko Stuebner converted the binding to YAML, hence his Signed-off-by.]

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index d4beaf11222d..a9ad17864889 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -43,3 +43,7 @@ properties:
   rs485-rx-during-tx:
    description: enables the receiving of data even while sending data.
    $ref: /schemas/types.yaml#/definitions/flag
+
+  rs485-term-gpios:
+    description: GPIO pin to enable RS485 bus termination.
+    maxItems: 1
-- 
2.26.2

