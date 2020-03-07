Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3838C17CD1C
	for <lists+linux-serial@lfdr.de>; Sat,  7 Mar 2020 10:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgCGJNZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 7 Mar 2020 04:13:25 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:51831 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgCGJNY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 7 Mar 2020 04:13:24 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7141923EB4;
        Sat,  7 Mar 2020 10:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583572402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aQvWXFXM1KKL95QbKcc07473AJv43uHjCpM12hw17EU=;
        b=gdS/SamMKlWk1FtIvy3xbj6EdrCJ6Et4Ll0kweAt/dxrCsb5GHM+0FGzQKKMlPw8gjZNyn
        XpFfbabLXyDghlj1M9FcZIp8NW+Cxv0FsH9dqOTUWsXnbuTQ6LuF2JMeKrSdDUA4RSxf3f
        BFuldIYKprhY5sHtcJwFrOa/BcQObtU=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: serial: lpuart: add ls1028a compatibility
Date:   Sat,  7 Mar 2020 10:13:01 +0100
Message-Id: <20200307091302.14881-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: 7141923EB4
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.536];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the LS1028A SoC compatibility string to the lpuart devicetree
bindings documentation.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes since v1:
 - add changelog text

 .../devicetree/bindings/serial/fsl-lpuart.txt          | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index c904e2e68332..e7448b92dd9d 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -6,6 +6,8 @@ Required properties:
     on Vybrid vf610 SoC with 8-bit register organization
   - "fsl,ls1021a-lpuart" for lpuart compatible with the one integrated
     on LS1021A SoC with 32-bit big-endian register organization
+  - "fsl,ls1028a-lpuart" for lpuart compatible with the one integrated
+    on LS1028A SoC with 32-bit little-endian register organization
   - "fsl,imx7ulp-lpuart" for lpuart compatible with the one integrated
     on i.MX7ULP SoC with 32-bit little-endian register organization
   - "fsl,imx8qxp-lpuart" for lpuart compatible with the one integrated
@@ -15,10 +17,10 @@ Required properties:
 - reg : Address and length of the register set for the device
 - interrupts : Should contain uart interrupt
 - clocks : phandle + clock specifier pairs, one for each entry in clock-names
-- clock-names : For vf610/ls1021a/imx7ulp, "ipg" clock is for uart bus/baud
-  clock. For imx8qxp lpuart, "ipg" clock is bus clock that is used to access
-  lpuart controller registers, it also requires "baud" clock for module to
-  receive/transmit data.
+- clock-names : For vf610/ls1021a/ls1028a/imx7ulp, "ipg" clock is for uart
+  bus/baud clock. For imx8qxp lpuart, "ipg" clock is bus clock that is used
+  to access lpuart controller registers, it also requires "baud" clock for
+  module to receive/transmit data.
 
 Optional properties:
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
-- 
2.20.1

