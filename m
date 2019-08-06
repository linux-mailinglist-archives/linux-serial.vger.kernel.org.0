Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F4382EF7
	for <lists+linux-serial@lfdr.de>; Tue,  6 Aug 2019 11:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbfHFJoo (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 05:44:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:14253 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732197AbfHFJoo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 05:44:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="373998729"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2019 02:43:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B4B2420; Tue,  6 Aug 2019 12:43:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 8/9] serial: 8250_lpss: Get rid of custom LPSS_DEVICE() macro
Date:   Tue,  6 Aug 2019 12:43:21 +0300
Message-Id: <20190806094322.64987-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since PCI core provides a generic PCI_DEVICE_DATA() macro,
replace LPSS_DEVICE() with former one.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 2bb30e688433..cfe0ab443250 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -356,17 +356,15 @@ static const struct lpss8250_board qrk_board = {
 	.exit = qrk_serial_exit,
 };
 
-#define LPSS_DEVICE(id, board) { PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&board }
-
 static const struct pci_device_id pci_ids[] = {
-	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_QRK_UARTx, qrk_board),
-	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BYT_UART1, byt_board),
-	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BYT_UART2, byt_board),
-	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BSW_UART1, byt_board),
-	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BSW_UART2, byt_board),
-	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BDW_UART1, byt_board),
-	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BDW_UART2, byt_board),
-	{ },
+	{ PCI_DEVICE_DATA(INTEL, QRK_UARTx, &qrk_board) },
+	{ PCI_DEVICE_DATA(INTEL, BYT_UART1, &byt_board) },
+	{ PCI_DEVICE_DATA(INTEL, BYT_UART2, &byt_board) },
+	{ PCI_DEVICE_DATA(INTEL, BSW_UART1, &byt_board) },
+	{ PCI_DEVICE_DATA(INTEL, BSW_UART2, &byt_board) },
+	{ PCI_DEVICE_DATA(INTEL, BDW_UART1, &byt_board) },
+	{ PCI_DEVICE_DATA(INTEL, BDW_UART2, &byt_board) },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_ids);
 
-- 
2.20.1

