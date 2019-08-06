Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44FE682EF2
	for <lists+linux-serial@lfdr.de>; Tue,  6 Aug 2019 11:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfHFJoK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 05:44:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:10177 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFJoK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 05:44:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="373364934"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2019 02:43:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7581639A; Tue,  6 Aug 2019 12:43:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/9] serial: 8250_lpss: add fractional divisor support
Date:   Tue,  6 Aug 2019 12:43:19 +0300
Message-Id: <20190806094322.64987-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register.

Now the preparation is done, it's easy to add the feature support.
This patch firstly tries to get the fractional divisor width during
probe, then setups specific get_divisor() and set_divisor() hook.

Among other changes the FIFO size is now retrieved from the hardware.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 3bf23770c188..0c6aa990db3d 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -113,7 +113,6 @@ static unsigned int byt_get_mctrl(struct uart_port *port)
 static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 {
 	struct dw_dma_slave *param = &lpss->dma_param;
-	struct uart_8250_port *up = up_to_u8250p(port);
 	struct pci_dev *pdev = to_pci_dev(port->dev);
 	unsigned int dma_devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), 0);
 	struct pci_dev *dma_dev = pci_get_slot(pdev->bus, dma_devfn);
@@ -139,10 +138,6 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	param->m_master = 0;
 	param->p_master = 1;
 
-	/* TODO: Detect FIFO size automaticaly for DesignWare 8250 */
-	port->fifosize = 64;
-	up->tx_loadsz = 64;
-
 	lpss->dma_maxburst = 16;
 
 	port->set_termios = byt_set_termios;
@@ -316,6 +311,8 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
+	dw8250_setup_port(&uart.port);
+
 	ret = lpss8250_dma_setup(lpss, &uart);
 	if (ret)
 		goto err_exit;
-- 
2.20.1

