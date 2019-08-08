Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328E6868EB
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390203AbfHHSkR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 14:40:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38232 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390196AbfHHSkR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 14:40:17 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hvnKg-0007K0-DQ; Thu, 08 Aug 2019 18:40:14 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org, sudipm.mukherjee@gmail.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Morris Ku <morris_ku@sunix.com>,
        Debbie Liu <debbie_liu@sunix.com>
Subject: [PATCH 2/2] parport: parport_serial: Add support for Sunix Multi I/O boards
Date:   Fri,  9 Aug 2019 02:40:04 +0800
Message-Id: <20190808184004.20162-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808184004.20162-1-kai.heng.feng@canonical.com>
References: <20190808184004.20162-1-kai.heng.feng@canonical.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Sunix Multi I/O boards are different to Timedia's.

This patch adds proper support for Sunix MIO boards with 1 parallel and
up to 4 serial ports.

Cc: Morris Ku <morris_ku@sunix.com>
Cc: Debbie Liu <debbie_liu@sunix.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/parport/parport_serial.c | 44 +++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 461fd8a24278..60d5d985113c 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -61,7 +61,10 @@ enum parport_pc_pci_cards {
 	wch_ch382_0s1p,
 	wch_ch382_2s1p,
 	brainboxes_5s1p,
-	sunix_2s1p,
+	sunix_4008a,
+	sunix_5069a,
+	sunix_5079a,
+	sunix_5099a,
 };
 
 /* each element directly indexed from enum list, above */
@@ -151,7 +154,10 @@ static struct parport_pc_pci cards[] = {
 	/* wch_ch382_0s1p*/		{ 1, { { 2, -1}, } },
 	/* wch_ch382_2s1p*/             { 1, { { 2, -1}, } },
 	/* brainboxes_5s1p */           { 1, { { 3, -1 }, } },
-	/* sunix_2s1p */                { 1, { { 3, -1 }, } },
+	/* sunix_4008a */		{ 1, { { 1, 2 }, } },
+	/* sunix_5069a */		{ 1, { { 1, 2 }, } },
+	/* sunix_5079a */		{ 1, { { 1, 2 }, } },
+	/* sunix_5099a */		{ 1, { { 1, 2 }, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] = {
@@ -261,13 +267,15 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTASHIELD, 0x4100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_5s1p },
 
-	/*
-	 * More SUNIX variations. At least one of these has part number
-	 * '5079A but subdevice 0x102. That board reports 0x0708 as
-	 * its PCI Class.
-	 */
+	/* Sunix boards */
 	{ PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, PCI_VENDOR_ID_SUNIX,
-	  0x0102, 0, 0, sunix_2s1p },
+	  0x0100, 0, 0, sunix_4008a },
+	{ PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, PCI_VENDOR_ID_SUNIX,
+	  0x0101, 0, 0, sunix_5069a },
+	{ PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, PCI_VENDOR_ID_SUNIX,
+	  0x0102, 0, 0, sunix_5079a },
+	{ PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, PCI_VENDOR_ID_SUNIX,
+	  0x0104, 0, 0, sunix_5099a },
 
 	{ 0, } /* terminate list */
 };
@@ -516,11 +524,23 @@ static struct pciserial_board pci_parport_serial_boards[] = {
 		.base_baud	= 921600,
 		.uart_offset	= 8,
 	},
-	[sunix_2s1p] = {
-		.flags		= FL_BASE0|FL_BASE_BARS,
+	[sunix_4008a] = {
+		.num_ports	= 0,
+	},
+	[sunix_5069a] = {
+		.num_ports	= 1,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
+	},
+	[sunix_5079a] = {
 		.num_ports	= 2,
-		.base_baud	= 921600,
-		.uart_offset	= 8,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
+	},
+	[sunix_5099a] = {
+		.num_ports	= 4,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
 	},
 };
 
-- 
2.17.1

