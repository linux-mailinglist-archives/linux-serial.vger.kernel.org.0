Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824D76F3D0
	for <lists+linux-serial@lfdr.de>; Sun, 21 Jul 2019 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfGUPBh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 21 Jul 2019 11:01:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:44860 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfGUPBh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Jul 2019 11:01:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2019 08:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,291,1559545200"; 
   d="scan'208";a="169023548"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2019 08:01:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8A5D6BD; Sun, 21 Jul 2019 18:01:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250_exar: Use struct_size() helper
Date:   Sun, 21 Jul 2019 18:01:35 +0300
Message-Id: <20190721150135.82065-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array.

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 4f8f45e2fc1d..8867deb09cd9 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -536,9 +536,7 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 
 	nr_ports = board->num_ports ? board->num_ports : pcidev->device & 0x0f;
 
-	priv = devm_kzalloc(&pcidev->dev, sizeof(*priv) +
-			    sizeof(unsigned int) * nr_ports,
-			    GFP_KERNEL);
+	priv = devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-- 
2.20.1

