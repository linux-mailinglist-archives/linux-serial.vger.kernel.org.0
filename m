Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB1459737
	for <lists+linux-serial@lfdr.de>; Mon, 22 Nov 2021 23:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbhKVWST (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Nov 2021 17:18:19 -0500
Received: from mailnode.rz.hs-mannheim.de ([141.19.1.96]:48616 "EHLO
        hs-mannheim.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233409AbhKVWSI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 17:18:08 -0500
Received: from [176.199.208.88] (account willenberg@hs-mannheim.de HELO localhost.localdomain)
  by hs-mannheim.de (CommuniGate Pro SMTP 6.2.14)
  with ESMTPSA id 55700081; Mon, 22 Nov 2021 23:14:56 +0100
From:   Ruediger Willenberg <r.willenberg@hs-mannheim.de>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, git@xilinx.com,
        shubhrajyoti.datta@xilinx.com, michal.simek@xilinx.com,
        Ruediger Willenberg <r.willenberg@hs-mannheim.de>
Subject: [PATCH v3] serial: uartlite: Move out-of-range port-numbers into ULITE_NR_UARTS range
Date:   Tue, 23 Nov 2021 00:14:46 +0100
Message-Id: <20211122231446.85138-1-r.willenberg@hs-mannheim.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
the device tree port-number property is outside that range. This
happens when there are other UART types in the system because the
Xilinx device tree generator numbers all UARTs consecutively;
as a result, not as many Uartlites as specified by the
SERIAL_UARTLITE_NR_UARTS parameter could be successfully added.

Signed-off-by: Ruediger Willenberg <r.willenberg@hs-mannheim.de>
---
Changes in v3:
 - corrected indentation to strict formatting

Changes in v2:
 - give KERN_NOTICE when changing the id,
   with reference to the requested port-number

 drivers/tty/serial/uartlite.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index d3d9566e5dbd..51e3f8086d31 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -631,15 +631,17 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 {
 	struct uart_port *port;
 	int rc;
+	int oor_id = -1;
 
-	/* if id = -1; then scan for a free id and use that */
-	if (id < 0) {
+	/* if id -1 or out of range; then scan for a free id and use that */
+	if (id < 0 || id >= ULITE_NR_UARTS) {
+		oor_id = id;
 		for (id = 0; id < ULITE_NR_UARTS; id++)
 			if (ulite_ports[id].mapbase == 0)
 				break;
 	}
-	if (id < 0 || id >= ULITE_NR_UARTS) {
-		dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
+	if (id == ULITE_NR_UARTS) {
+		dev_err(dev, "maximum number of %s assigned\n", ULITE_NAME);
 		return -EINVAL;
 	}
 
@@ -677,6 +679,11 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 		return rc;
 	}
 
+	if (oor_id >= 0)
+		dev_notice(dev,
+			   "assigned uartlite with device tree port-number=<%i> to %s%i\n",
+			   oor_id, ULITE_NAME, id);
+
 	return 0;
 }
 
-- 
2.25.1

