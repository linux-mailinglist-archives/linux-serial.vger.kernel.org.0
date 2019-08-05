Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 751088165E
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2019 12:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfHEKFW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 5 Aug 2019 06:05:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:11295 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfHEKFW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Aug 2019 06:05:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 03:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="325272105"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 05 Aug 2019 03:05:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 37E936A; Mon,  5 Aug 2019 13:05:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Robert Middleton <robert.middleton@rm5248.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
Date:   Mon,  5 Aug 2019 13:05:17 +0300
Message-Id: <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
References: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

First of all, boolean variable should be assigned with boolean values.
Second, it's not needed at all in this case.

Drop unneeded boolean variable and use 'break' statement instead.

While here, change iterations to be more visible by moving the number of them
to the variable definition block.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: Check kernel buffer first as in the original conditional (Robert)
 drivers/tty/serial/8250/8250_exar.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 873aa6b0c2f3..8f9baae92831 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -169,19 +169,18 @@ static void xr17v35x_set_divisor(struct uart_port *p, unsigned int baud,
 static void exar_shutdown(struct uart_port *port)
 {
 	unsigned char lsr;
-	bool tx_complete = 0;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct circ_buf *xmit = &port->state->xmit;
-	int i = 0;
+	unsigned int retries = 1000;
 
 	do {
+		if (uart_circ_empty(xmit))
+			break;
 		lsr = serial_in(up, UART_LSR);
 		if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
-			tx_complete = 1;
-		else
-			tx_complete = 0;
+			break;
 		msleep(1);
-	} while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);
+	} while (--retries);
 
 	serial8250_do_shutdown(port);
 }
-- 
2.20.1

