Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA467C9E9
	for <lists+linux-serial@lfdr.de>; Wed, 31 Jul 2019 19:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfGaRGI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 31 Jul 2019 13:06:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:3570 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbfGaRGH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Jul 2019 13:06:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 10:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="174229038"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jul 2019 10:06:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7DC7F56; Wed, 31 Jul 2019 20:05:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Subject: [PATCH v4 2/3] serial: 8250_exar: Extract PM routine from 8250_port
Date:   Wed, 31 Jul 2019 20:05:57 +0300
Message-Id: <20190731170558.52897-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731170558.52897-1-andriy.shevchenko@linux.intel.com>
References: <20190731170558.52897-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are Exar quirks in 8250_port which belong to 8250_exar module.
Extract PM routine to the correct module and do not contaminate generic code
with it.

Cc: Aaron Sierra <asierra@xes-inc.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 14 ++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 16 ++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 94212d9bf73f..1bf9adea2e61 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -36,6 +36,7 @@
 
 #define UART_EXAR_INT0		0x80
 #define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
+#define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
 #define UART_EXAR_DVID		0x8d	/* Device identification */
 
 #define UART_EXAR_FCTR		0x08	/* Feature Control Register */
@@ -128,6 +129,17 @@ struct exar8250 {
 	int			line[0];
 };
 
+static void exar_pm(struct uart_port *port, unsigned int state, unsigned int old)
+{
+	/*
+	 * Exar UARTs have a SLEEP register that enables or disables each UART
+	 * to enter sleep mode separately. On the XR17V35x the register
+	 * is accessible to each UART at the UART_EXAR_SLEEP offset, but
+	 * the UART channel may only write to the corresponding bit.
+	 */
+	serial_port_out(port, UART_EXAR_SLEEP, state ? 0xff : 0);
+}
+
 static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 			 int idx, unsigned int offset,
 			 struct uart_8250_port *port)
@@ -155,6 +167,8 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		port->port.type = PORT_XR17D15X;
 	}
 
+	port->port.pm = exar_pm;
+
 	return 0;
 }
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6729b82ed2e3..c3ba4c794fee 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -44,7 +44,6 @@
  * These are definitions for the Exar XR17V35X and XR17(C|D)15X
  */
 #define UART_EXAR_INT0		0x80
-#define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
 
 /* Nuvoton NPCM timeout register */
 #define UART_NPCM_TOR          7
@@ -708,19 +707,8 @@ EXPORT_SYMBOL_GPL(serial8250_rpm_put_tx);
 static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 {
 	unsigned char lcr = 0, efr = 0;
-	/*
-	 * Exar UARTs have a SLEEP register that enables or disables
-	 * each UART to enter sleep mode separately.  On the XR17V35x the
-	 * register is accessible to each UART at the UART_EXAR_SLEEP
-	 * offset but the UART channel may only write to the corresponding
-	 * bit.
-	 */
+
 	serial8250_rpm_get(p);
-	if ((p->port.type == PORT_XR17V35X) ||
-	   (p->port.type == PORT_XR17D15X)) {
-		serial_out(p, UART_EXAR_SLEEP, sleep ? 0xff : 0);
-		goto out;
-	}
 
 	if (p->capabilities & UART_CAP_SLEEP) {
 		if (p->capabilities & UART_CAP_EFR) {
@@ -737,7 +725,7 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 			serial_out(p, UART_LCR, lcr);
 		}
 	}
-out:
+
 	serial8250_rpm_put(p);
 }
 
-- 
2.20.1

