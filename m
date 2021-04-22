Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B64367D14
	for <lists+linux-serial@lfdr.de>; Thu, 22 Apr 2021 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhDVJAS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 22 Apr 2021 05:00:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17024 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbhDVJAR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 05:00:17 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FQrrQ6GSGzPqVN;
        Thu, 22 Apr 2021 16:56:38 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 22 Apr 2021 16:59:30 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/3] dt-bindings: serial: Normalize the node name of the serial port
Date:   Thu, 22 Apr 2021 16:58:35 +0800
Message-ID: <20210422085837.513-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210422085837.513-1-thunder.leizhen@huawei.com>
References: <20210422085837.513-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Only letters, digits, and commas that describe the base address of the
serial port in hexadecimal format are allowed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 65e75d040521..71aec7fda07d 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -21,7 +21,7 @@ description:
 
 properties:
   $nodename:
-    pattern: "^serial(@.*)?$"
+    pattern: "^serial(@[0-9a-f,]+)?$"
 
   cts-gpios:
     maxItems: 1
-- 
2.21.1


