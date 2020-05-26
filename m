Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FEF1DC985
	for <lists+linux-serial@lfdr.de>; Thu, 21 May 2020 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgEUJMD (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 21 May 2020 05:12:03 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:59138 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbgEUJMC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 May 2020 05:12:02 -0400
Received: from zenbar.fritz.box (pd95ef28a.dip0.t-ipconnect.de [217.94.242.138])
        by mail.bugwerft.de (Postfix) with ESMTPSA id BC45640BCC0;
        Thu, 21 May 2020 09:09:00 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 1/6] dt-bindings: sc16is7xx: Add flag to activate IrDA mode
Date:   Thu, 21 May 2020 11:11:47 +0200
Message-Id: <20200521091152.404404-2-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521091152.404404-1-daniel@zonque.org>
References: <20200521091152.404404-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Pascal Huerst <pascal.huerst@gmail.com>

This series of uart controllers is able to work in IrDA mode.
This adds a property to the device tree to enable that feature on
selected ports if needed.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
index c1091a923a89..4d1f55abe876 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
@@ -21,6 +21,8 @@ Optional properties:
   the second cell is used to specify the GPIO polarity:
     0 = active high,
     1 = active low.
+- linux,irda-mode-ports: An array that lists the indices of the port that
+			 should operate in IrDA mode.
 
 Example:
         sc16is750: sc16is750@51 {
@@ -55,6 +57,8 @@ Optional properties:
   the second cell is used to specify the GPIO polarity:
     0 = active high,
     1 = active low.
+- linux,irda-mode-ports: An array that lists the indices of the port that
+			 should operate in IrDA mode.
 
 Example:
 	sc16is750: sc16is750@0 {
-- 
2.26.2

