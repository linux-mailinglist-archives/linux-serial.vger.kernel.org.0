Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071241B1272
	for <lists+linux-serial@lfdr.de>; Mon, 20 Apr 2020 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDTRCZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 20 Apr 2020 13:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRCY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Apr 2020 13:02:24 -0400
Received: from localhost.localdomain (unknown [157.46.94.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF512145D;
        Mon, 20 Apr 2020 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587402144;
        bh=fraYpNQInSieEMwqioocy3rdP0VDN1sVShjt3tsDnu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CClwiXgV2eJ8HfEUWRwnUNVbGvxJteBm6rbSMnRi7/h8yMF6IFYUzLyD1R3seKA8O
         ySK3I48g2JrAu6uN97+uedncaTzs5U3EtBWfjKC+XRdK8a5CoehereIixskjxFEDlt
         RFHzVaN29QlTqAET5ZNca5b3c1s+E9WP+xN+QCfI=
From:   mani@kernel.org
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: serial: Document CTS/RTS gpios in STM32 UART
Date:   Mon, 20 Apr 2020 22:32:03 +0530
Message-Id: <20200420170204.24541-2-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420170204.24541-1-mani@kernel.org>
References: <20200420170204.24541-1-mani@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Document the use of CTS/RTS gpios for flow control in STM32 UART
controller. These properties can be used instead of 'st,hw-flow-ctrl'
for making use of any gpio pins for flow control instead of dedicated
pins. It should be noted that both CTS/RTS and 'st,hw-flow-ctrl'
properties cannot co-exist in a design.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 .../devicetree/bindings/serial/st,stm32-uart.yaml  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 238c44192d31..75b8521eb7cb 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -48,6 +48,12 @@ properties:
     minItems: 1
     maxItems: 2
 
+  cts-gpios:
+    maxItems: 1
+
+  rts-gpios:
+    maxItems: 1
+
   wakeup-source: true
 
   rs485-rts-delay: true
@@ -55,6 +61,14 @@ properties:
   linux,rs485-enabled-at-boot-time: true
   rs485-rx-during-tx: true
 
+if:
+  required:
+    - st,hw-flow-ctrl
+then:
+  properties:
+    cts-gpios: false
+    rts-gpios: false
+
 required:
   - compatible
   - reg
-- 
2.17.1

