Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9A423BB5D
	for <lists+linux-serial@lfdr.de>; Tue,  4 Aug 2020 15:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgHDNsL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 4 Aug 2020 09:48:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:25023 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgHDNsL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Aug 2020 09:48:11 -0400
IronPort-SDR: ucq8lnQCov88+HW9gdGvR1+hJCH1dialbmJa1vDagJZ1htKf712kR9w+fhSLMQanXs1wM9aiDV
 8qTSAiNpzMPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="153471946"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="153471946"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 06:48:10 -0700
IronPort-SDR: Jf3W/Nq2M8m4Y4JGOX9U47OpS7O/gbmKRQ4kmNZOoC1aZaCRp/ycuqaAD58l6z0G+8SHqoeCnA
 kha+mPx8AjnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="366903422"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2020 06:48:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7471C11C; Tue,  4 Aug 2020 16:48:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: sa1100: use platform_get_resource()
Date:   Tue,  4 Aug 2020 16:48:07 +0300
Message-Id: <20200804134807.11589-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use platform_get_resource() to fetch the memory resource
instead of open-coded variant.

While here, fail the probe if no resource found or no port is added.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/sa1100.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index 75c2a22895f9..f5fab1dd96bc 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -879,22 +879,20 @@ static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform
 
 static int sa1100_serial_probe(struct platform_device *dev)
 {
-	struct resource *res = dev->resource;
+	struct resource *res;
 	int i;
 
-	for (i = 0; i < dev->num_resources; i++, res++)
-		if (res->flags & IORESOURCE_MEM)
-			break;
-
-	if (i < dev->num_resources) {
-		for (i = 0; i < NR_PORTS; i++) {
-			if (sa1100_ports[i].port.mapbase != res->start)
-				continue;
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 
-			sa1100_serial_add_one_port(&sa1100_ports[i], dev);
+	for (i = 0; i < NR_PORTS; i++)
+		if (sa1100_ports[i].port.mapbase == res->start)
 			break;
-		}
-	}
+	if (i == NR_PORTS)
+		return -ENODEV;
+
+	sa1100_serial_add_one_port(&sa1100_ports[i], dev);
 
 	return 0;
 }
-- 
2.27.0

