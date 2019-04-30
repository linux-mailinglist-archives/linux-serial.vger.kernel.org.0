Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF21FFE6
	for <lists+linux-serial@lfdr.de>; Tue, 30 Apr 2019 20:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfD3SqD (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 30 Apr 2019 14:46:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:59485 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfD3SqD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Apr 2019 14:46:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 11:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="140178010"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 30 Apr 2019 11:46:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4AA4511F; Tue, 30 Apr 2019 21:45:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, John Garry <john.garry@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] serial: 8250_of: Use of_device_get_match_data()
Date:   Tue, 30 Apr 2019 21:45:59 +0300
Message-Id: <20190430184559.35206-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use of_device_get_match_data() to simplify the code a bit.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- cast to longer type to avoid "cast from pointer to integer of different size"
- change type of port_type to unsigned int
 drivers/tty/serial/8250/8250_of.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 0277479c87e9..1308b3d1e17a 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -205,18 +205,16 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 /*
  * Try to register a serial port
  */
-static const struct of_device_id of_platform_serial_table[];
 static int of_platform_serial_probe(struct platform_device *ofdev)
 {
-	const struct of_device_id *match;
 	struct of_serial_info *info;
 	struct uart_8250_port port8250;
+	unsigned int port_type;
 	u32 tx_threshold;
-	int port_type;
 	int ret;
 
-	match = of_match_device(of_platform_serial_table, &ofdev->dev);
-	if (!match)
+	port_type = (unsigned long)of_device_get_match_data(&ofdev->dev);
+	if (port_type == PORT_UNKNOWN)
 		return -EINVAL;
 
 	if (of_property_read_bool(ofdev->dev.of_node, "used-by-rtas"))
@@ -226,7 +224,6 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	if (info == NULL)
 		return -ENOMEM;
 
-	port_type = (unsigned long)match->data;
 	memset(&port8250, 0, sizeof(port8250));
 	ret = of_platform_serial_setup(ofdev, port_type, &port8250.port, info);
 	if (ret)
-- 
2.20.1

