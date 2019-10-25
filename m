Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B899E48F1
	for <lists+linux-serial@lfdr.de>; Fri, 25 Oct 2019 12:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502593AbfJYKx2 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 25 Oct 2019 06:53:28 -0400
Received: from mx1.unisoc.com ([222.66.158.135]:57144 "EHLO SHSQR01.unisoc.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390265AbfJYKx2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Oct 2019 06:53:28 -0400
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id x9PAU6lb053125
        for <linux-serial@vger.kernel.org>; Fri, 25 Oct 2019 18:30:06 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id x9PAThJV052054
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 25 Oct 2019 18:29:43 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.79) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 25 Oct 2019 18:29:43
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 2/3] dt-bindings: arm: Add bindings for Unisoc's SC9863A
Date:   Fri, 25 Oct 2019 18:29:14 +0800
Message-ID: <20191025102915.23677-3-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
References: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.79]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com x9PAThJV052054
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Added bindings for Unisoc's SC9863A board and SC9863A SoC.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 Documentation/devicetree/bindings/arm/sprd.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sprd.txt b/Documentation/devicetree/bindings/arm/sprd.txt
index 3df034b13e28..c244c911f8df 100644
--- a/Documentation/devicetree/bindings/arm/sprd.txt
+++ b/Documentation/devicetree/bindings/arm/sprd.txt
@@ -12,3 +12,11 @@ Required root node properties:
 SP9860G 3GFHD Board
 Required root node properties:
 	- compatible = "sprd,sp9860g-1h10", "sprd,sc9860";
+
+SC9863A SoC
+Required root node properties:
+	- compatible = "sprd,sc9863a"
+
+SP9863A-1H10 Board
+Required root node properties:
+	- compatible = "sprd,sp9863a-1h10", "sprd,sc9863a";
-- 
2.20.1


