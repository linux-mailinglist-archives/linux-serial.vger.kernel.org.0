Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E937A1E759F
	for <lists+linux-serial@lfdr.de>; Fri, 29 May 2020 07:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgE2FvI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 29 May 2020 01:51:08 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:56520 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgE2FvH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 May 2020 01:51:07 -0400
Received: from zenbar.fritz.box (p57bc97c6.dip0.t-ipconnect.de [87.188.151.198])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 5C1194230C4;
        Fri, 29 May 2020 05:51:05 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: sc16is7xx: Add flag to activate IrDA mode
Date:   Fri, 29 May 2020 07:50:57 +0200
Message-Id: <20200529055058.1606910-2-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529055058.1606910-1-daniel@zonque.org>
References: <20200529055058.1606910-1-daniel@zonque.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
index c1091a923a89..0fa8e3e43bf8 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
@@ -21,6 +21,8 @@ Optional properties:
   the second cell is used to specify the GPIO polarity:
     0 = active high,
     1 = active low.
+- irda-mode-ports: An array that lists the indices of the port that
+		   should operate in IrDA mode.
 
 Example:
         sc16is750: sc16is750@51 {
@@ -55,6 +57,8 @@ Optional properties:
   the second cell is used to specify the GPIO polarity:
     0 = active high,
     1 = active low.
+- irda-mode-ports: An array that lists the indices of the port that
+		   should operate in IrDA mode.
 
 Example:
 	sc16is750: sc16is750@0 {
-- 
2.26.2

