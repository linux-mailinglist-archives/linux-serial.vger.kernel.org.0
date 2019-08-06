Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE8182EF0
	for <lists+linux-serial@lfdr.de>; Tue,  6 Aug 2019 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbfHFJnh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 05:43:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:42923 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFJnh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 05:43:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="164931391"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2019 02:43:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 96FFD445; Tue,  6 Aug 2019 12:43:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 9/9] serial: 8250_lpss: Enable HS UART on Elkhart Lake
Date:   Tue,  6 Aug 2019 12:43:22 +0300
Message-Id: <20190806094322.64987-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Intel Elkhart Lake may use High Speed UART from OSE IP block.
This is different to what we have in main LPSS, though compatible
with older version of it, which is handled by this driver.

Enable OSE HS UART on Intel Elkhart Lake by adding PCI IDs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index cfe0ab443250..5f72ef3ea574 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -24,6 +24,13 @@
 #define PCI_DEVICE_ID_INTEL_BSW_UART1	0x228a
 #define PCI_DEVICE_ID_INTEL_BSW_UART2	0x228c
 
+#define PCI_DEVICE_ID_INTEL_EHL_UART0	0x4b96
+#define PCI_DEVICE_ID_INTEL_EHL_UART1	0x4b97
+#define PCI_DEVICE_ID_INTEL_EHL_UART2	0x4b98
+#define PCI_DEVICE_ID_INTEL_EHL_UART3	0x4b99
+#define PCI_DEVICE_ID_INTEL_EHL_UART4	0x4b9a
+#define PCI_DEVICE_ID_INTEL_EHL_UART5	0x4b9b
+
 #define PCI_DEVICE_ID_INTEL_BDW_UART1	0x9ce3
 #define PCI_DEVICE_ID_INTEL_BDW_UART2	0x9ce4
 
@@ -349,6 +356,11 @@ static const struct lpss8250_board byt_board = {
 	.setup = byt_serial_setup,
 };
 
+static const struct lpss8250_board ehl_board = {
+	.freq = 200000000,
+	.base_baud = 12500000,
+};
+
 static const struct lpss8250_board qrk_board = {
 	.freq = 44236800,
 	.base_baud = 2764800,
@@ -358,6 +370,12 @@ static const struct lpss8250_board qrk_board = {
 
 static const struct pci_device_id pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, QRK_UARTx, &qrk_board) },
+	{ PCI_DEVICE_DATA(INTEL, EHL_UART0, &ehl_board) },
+	{ PCI_DEVICE_DATA(INTEL, EHL_UART1, &ehl_board) },
+	{ PCI_DEVICE_DATA(INTEL, EHL_UART2, &ehl_board) },
+	{ PCI_DEVICE_DATA(INTEL, EHL_UART3, &ehl_board) },
+	{ PCI_DEVICE_DATA(INTEL, EHL_UART4, &ehl_board) },
+	{ PCI_DEVICE_DATA(INTEL, EHL_UART5, &ehl_board) },
 	{ PCI_DEVICE_DATA(INTEL, BYT_UART1, &byt_board) },
 	{ PCI_DEVICE_DATA(INTEL, BYT_UART2, &byt_board) },
 	{ PCI_DEVICE_DATA(INTEL, BSW_UART1, &byt_board) },
-- 
2.20.1

