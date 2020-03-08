Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F345B17D4C9
	for <lists+linux-serial@lfdr.de>; Sun,  8 Mar 2020 17:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgCHQct (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 8 Mar 2020 12:32:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgCHQct (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Mar 2020 12:32:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72686B13C;
        Sun,  8 Mar 2020 16:32:47 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Wells=20Lu=20=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC 05/11] dt-bindings: serial: Add Sunplus SP7021 UART
Date:   Sun,  8 Mar 2020 17:32:23 +0100
Message-Id: <20200308163230.4002-6-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200308163230.4002-1-afaerber@suse.de>
References: <20200308163230.4002-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Sunplus Plus1 (aka Pentagram) SP7021 SoC has five UARTs.

Cc: Wells Lu 呂芳騰 <wells.lu@sunplus.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 .../bindings/serial/sunplus,pentagram-uart.yaml    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,pentagram-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/sunplus,pentagram-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,pentagram-uart.yaml
new file mode 100644
index 000000000000..9d1641232a4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sunplus,pentagram-uart.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/sunplus,pentagram-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus Pentagram SoC UART Serial Interface
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+properties:
+  compatible:
+    const: sunplus,sp7021-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+...
-- 
2.16.4

