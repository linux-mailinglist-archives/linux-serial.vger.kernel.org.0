Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B563821E0
	for <lists+linux-serial@lfdr.de>; Mon, 17 May 2021 01:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhEPXHh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 16 May 2021 19:07:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:43978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231776AbhEPXHg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 16 May 2021 19:07:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEB8DB11A;
        Sun, 16 May 2021 23:06:19 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/9] dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK1808
Date:   Mon, 17 May 2021 01:05:44 +0200
Message-Id: <20210516230551.12469-3-afaerber@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516230551.12469-1-afaerber@suse.de>
References: <20210516230551.12469-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a Rockchip RK1808 compatible.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 87ef1e218152..68545e421bbe 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -23,6 +23,7 @@ properties:
       - items:
           - enum:
               - rockchip,px30-uart
+              - rockchip,rk1808-uart
               - rockchip,rk3036-uart
               - rockchip,rk3066-uart
               - rockchip,rk3188-uart
-- 
2.31.1

