Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4B5F655
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfGDKJ3 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 06:09:29 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47194 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfGDKJ3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 06:09:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9B06020059E;
        Thu,  4 Jul 2019 12:09:27 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BB232005A7;
        Thu,  4 Jul 2019 12:09:24 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 877FA402EB;
        Thu,  4 Jul 2019 18:09:19 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jslaby@suse.com, fugang.duan@nxp.com,
        u.kleine-koenig@pengutronix.de, daniel.baluta@nxp.com
Subject: [PATCH tty/serial 2/2] dt-bindings: serial: lpuart: add the clock requirement for imx8qxp
Date:   Thu,  4 Jul 2019 18:00:21 +0800
Message-Id: <20190704100021.10859-3-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190704100021.10859-1-fugang.duan@nxp.com>
References: <20190704100021.10859-1-fugang.duan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Add the baud clock requirement for imx8qxp.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index 21483ba..3495eee 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -13,7 +13,10 @@ Required properties:
 - reg : Address and length of the register set for the device
 - interrupts : Should contain uart interrupt
 - clocks : phandle + clock specifier pairs, one for each entry in clock-names
-- clock-names : should contain: "ipg" - the uart clock
+- clock-names : For vf610/ls1021a/imx7ulp, "ipg" clock is for uart bus/baud
+  clock. For imx8qxp lpuart, "ipg" clock is bus clock that is used to access
+  lpuart controller registers, it also requires "baud" clock for module to
+  receive/transmit data.
 
 Optional properties:
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
-- 
2.7.4

