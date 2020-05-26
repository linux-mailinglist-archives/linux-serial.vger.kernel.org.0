Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3E1CB222
	for <lists+linux-serial@lfdr.de>; Fri,  8 May 2020 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgEHOnh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 8 May 2020 10:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgEHOnh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 May 2020 10:43:37 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 May 2020 07:43:37 PDT
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12B64C061A0C;
        Fri,  8 May 2020 07:43:37 -0700 (PDT)
Received: from zenbar.fritz.box (pD95EF03D.dip0.t-ipconnect.de [217.94.240.61])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 0180340648D;
        Fri,  8 May 2020 14:35:21 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        pascal.huerst@gmail.com
Subject: [PATCH 1/4] dt-bindings: sc16is7xx: Add flag to activate IrDA mode
Date:   Fri,  8 May 2020 16:37:54 +0200
Message-Id: <20200508143757.2609740-2-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508143757.2609740-1-daniel@zonque.org>
References: <20200508143757.2609740-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Pascal Huerst <pascal.huerst@gmail.com>

This series of uart controllers is able to work in IrDA mode.
This adds a flag to the device tree to enable that feature if needed.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
---
 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
index c1091a923a89..9317c320c82c 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
@@ -21,6 +21,8 @@ Optional properties:
   the second cell is used to specify the GPIO polarity:
     0 = active high,
     1 = active low.
+- linux,irda-mode-port-0: Use IrDA mode on port #0
+- linux,irda-mode-port-1: Use IrDA mode on port #1 (for dual-port devices only)
 
 Example:
         sc16is750: sc16is750@51 {
@@ -55,6 +57,8 @@ Optional properties:
   the second cell is used to specify the GPIO polarity:
     0 = active high,
     1 = active low.
+- linux,irda-mode-port-0: Use IrDA mode on port #0
+- linux,irda-mode-port-1: Use IrDA mode on port #1 (for dual-port devices only)
 
 Example:
 	sc16is750: sc16is750@0 {
-- 
2.26.2

