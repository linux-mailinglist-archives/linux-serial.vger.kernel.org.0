Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED80193464
	for <lists+linux-serial@lfdr.de>; Thu, 26 Mar 2020 00:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCYXOn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 25 Mar 2020 19:14:43 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40188 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbgCYXOm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 19:14:42 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jHFEI-0007ug-Sk; Thu, 26 Mar 2020 00:14:34 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v2 5/7] dt-bindings: serial: Add binding for rs485 receiver enable GPIO
Date:   Thu, 26 Mar 2020 00:14:20 +0100
Message-Id: <20200325231422.1502366-6-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200325231422.1502366-1-heiko@sntech.de>
References: <20200325231422.1502366-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

RS485 has two signals to control transmissions "drivee enable" (RE) and
"receiver enable" (DE). RE is already handled via the uarts RTS signal
while RE signal on most implementations doesn't get handled separately
at all.

As there still will be cases where this is needed though add a gpio
property for declaring this signal pin.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index a9ad17864889..e55730de796d 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -44,6 +44,10 @@ properties:
    description: enables the receiving of data even while sending data.
    $ref: /schemas/types.yaml#/definitions/flag
 
+  rs485-rx-enable-gpios:
+   description: GPIO to handle a separate RS485 receive enable signal
+   $ref: /schemas/types.yaml#/definitions/flag
+
   rs485-term-gpios:
     description: GPIO pin to enable RS485 bus termination.
     maxItems: 1
-- 
2.24.1

