Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768A281F00
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2019 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfHEOZm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 5 Aug 2019 10:25:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:17115 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbfHEOZm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Aug 2019 10:25:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 07:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="164666469"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2019 07:25:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BF9D6124; Mon,  5 Aug 2019 17:25:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Robert Middleton <robert.middleton@rm5248.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/2] serial: 8250_exar: Consolidate callback assignments in default_setup()
Date:   Mon,  5 Aug 2019 17:25:34 +0300
Message-Id: <20190805142535.21948-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For better maintenance consolidate port callbacks in default_setup().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no change
 drivers/tty/serial/8250/8250_exar.c | 43 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 3e93bd2326c9..873aa6b0c2f3 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -166,6 +166,26 @@ static void xr17v35x_set_divisor(struct uart_port *p, unsigned int baud,
 	serial_port_out(p, 0x2, quot_frac);
 }
 
+static void exar_shutdown(struct uart_port *port)
+{
+	unsigned char lsr;
+	bool tx_complete = 0;
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct circ_buf *xmit = &port->state->xmit;
+	int i = 0;
+
+	do {
+		lsr = serial_in(up, UART_LSR);
+		if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
+			tx_complete = 1;
+		else
+			tx_complete = 0;
+		msleep(1);
+	} while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);
+
+	serial8250_do_shutdown(port);
+}
+
 static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 			 int idx, unsigned int offset,
 			 struct uart_8250_port *port)
@@ -197,6 +217,7 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	}
 
 	port->port.pm = exar_pm;
+	port->port.shutdown = exar_shutdown;
 
 	return 0;
 }
@@ -519,27 +540,6 @@ static irqreturn_t exar_misc_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void
-exar_shutdown(struct uart_port *port)
-{
-	unsigned char lsr;
-	bool tx_complete = 0;
-	struct uart_8250_port *up = up_to_u8250p(port);
-	struct circ_buf *xmit = &port->state->xmit;
-	int i = 0;
-
-	do {
-		lsr = serial_in(up, UART_LSR);
-		if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
-			tx_complete = 1;
-		else
-			tx_complete = 0;
-		msleep(1);
-	} while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);
-
-	serial8250_do_shutdown(port);
-}
-
 static int
 exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
@@ -580,7 +580,6 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	uart.port.flags = UPF_SHARE_IRQ | UPF_EXAR_EFR | UPF_FIXED_TYPE | UPF_FIXED_PORT;
 	uart.port.irq = pci_irq_vector(pcidev, 0);
 	uart.port.dev = &pcidev->dev;
-	uart.port.shutdown = exar_shutdown;
 
 	rc = devm_request_irq(&pcidev->dev, uart.port.irq, exar_misc_handler,
 			 IRQF_SHARED, "exar_uart", priv);
-- 
2.20.1

