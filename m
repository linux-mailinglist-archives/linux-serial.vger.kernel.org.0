Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D1D82EF6
	for <lists+linux-serial@lfdr.de>; Tue,  6 Aug 2019 11:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfHFJoo (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 05:44:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:14253 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFJon (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 05:44:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="174136880"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Aug 2019 02:43:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4BC785B; Tue,  6 Aug 2019 12:43:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/9] serial: 8250_dw: use pointer to uart local variable
Date:   Tue,  6 Aug 2019 12:43:15 +0300
Message-Id: <20190806094322.64987-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The use of pointer will simplify enabling runtime PM for the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 7b559f969f61..010d0a292e73 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -492,10 +492,10 @@ static void dw8250_setup_port(struct uart_port *p)
 
 static int dw8250_probe(struct platform_device *pdev)
 {
-	struct uart_8250_port uart = {};
+	struct uart_8250_port uart = {}, *up = &uart;
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int irq = platform_get_irq(pdev, 0);
-	struct uart_port *p = &uart.port;
+	struct uart_port *p = &up->port;
 	struct device *dev = &pdev->dev;
 	struct dw8250_data *data;
 	int err;
@@ -634,10 +634,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (p->fifosize) {
 		data->dma.rxconf.src_maxburst = p->fifosize / 4;
 		data->dma.txconf.dst_maxburst = p->fifosize / 4;
-		uart.dma = &data->dma;
+		up->dma = &data->dma;
 	}
 
-	data->line = serial8250_register_8250_port(&uart);
+	data->line = serial8250_register_8250_port(up);
 	if (data->line < 0) {
 		err = data->line;
 		goto err_reset;
-- 
2.20.1

