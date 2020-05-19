Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8893A1D9F1C
	for <lists+linux-serial@lfdr.de>; Tue, 19 May 2020 20:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgESSV4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 19 May 2020 14:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgESSVz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 May 2020 14:21:55 -0400
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD07BC08C5C0;
        Tue, 19 May 2020 11:21:55 -0700 (PDT)
Received: from zenbar.fritz.box (pd95ef292.dip0.t-ipconnect.de [217.94.242.146])
        by mail.bugwerft.de (Postfix) with ESMTPSA id EA73E40AEC4;
        Tue, 19 May 2020 18:18:58 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com
Subject: [PATCH v2 1/6] dt-bindings: sc16is7xx: Add flag to activate IrDA mode
Date:   Tue, 19 May 2020 20:21:42 +0200
Message-Id: <20200519182147.218713-2-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519182147.218713-1-daniel@zonque.org>
References: <20200519182147.218713-1-daniel@zonque.org>
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

