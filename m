Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 664F4FCCA
	for <lists+linux-serial@lfdr.de>; Tue, 30 Apr 2019 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfD3PZJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 30 Apr 2019 11:25:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:37127 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfD3PZI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Apr 2019 11:25:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 08:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="140130194"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 30 Apr 2019 08:24:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E912411F; Tue, 30 Apr 2019 18:24:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, John Garry <john.garry@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250_of: Use of_device_get_match_data()
Date:   Tue, 30 Apr 2019 18:24:52 +0300
Message-Id: <20190430152452.29883-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_of.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 0277479c87e9..9d11aa33f60d 100644
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
 	u32 tx_threshold;
 	int port_type;
 	int ret;
 
-	match = of_match_device(of_platform_serial_table, &ofdev->dev);
-	if (!match)
+	port_type = (unsigned int)of_device_get_match_data(&ofdev->dev);
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

