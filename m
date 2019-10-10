Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3357ED2EED
	for <lists+linux-serial@lfdr.de>; Thu, 10 Oct 2019 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfJJQwb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 10 Oct 2019 12:52:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46502 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfJJQwb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Oct 2019 12:52:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CED6D20094E;
        Thu, 10 Oct 2019 18:52:29 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C0E702007DF;
        Thu, 10 Oct 2019 18:52:29 +0200 (CEST)
Received: from fsr-ub1664-026.ea.freescale.net (fsr-ub1664-026.ea.freescale.net [10.171.81.59])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1319F2060B;
        Thu, 10 Oct 2019 18:52:29 +0200 (CEST)
From:   Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com
Cc:     jslaby@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@nxp.com>
Subject: [PATCH v6 1/5] dt-bindings: arm: fsl: Add the S32V234-EVB board
Date:   Thu, 10 Oct 2019 19:52:24 +0300
Message-Id: <1570726348-6420-2-git-send-email-stefan-gabriel.mirea@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570726348-6420-1-git-send-email-stefan-gabriel.mirea@nxp.com>
References: <1570726348-6420-1-git-send-email-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Eddy Petrișor <eddy.petrisor@nxp.com>

Add entry for the NXP S32V234 Customer Evaluation Board to the board/SoC
bindings.

Signed-off-by: Eddy Petrișor <eddy.petrisor@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1b4b4e6573b5..c211f4f82e25 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -335,4 +335,10 @@ properties:
               - fsl,ls2088a-rdb
           - const: fsl,ls2088a
 
+      - description: S32V234 based Boards
+        items:
+          - enum:
+              - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
+          - const: fsl,s32v234
+
 ...
-- 
2.22.0

