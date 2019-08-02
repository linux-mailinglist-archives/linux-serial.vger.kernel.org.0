Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6E07FDA1
	for <lists+linux-serial@lfdr.de>; Fri,  2 Aug 2019 17:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbfHBPeb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 2 Aug 2019 11:34:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:54451 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387684AbfHBPeb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Aug 2019 11:34:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 08:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="175614528"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2019 08:34:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D4A25101; Fri,  2 Aug 2019 18:34:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] serial: 8250_exar: Refactor exar_shutdown()
Date:   Fri,  2 Aug 2019 18:34:21 +0300
Message-Id: <20190802153422.11131-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802153422.11131-1-andriy.shevchenko@linux.intel.com>
References: <20190802153422.11131-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_exar.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 873aa6b0c2f3..f81d5c4fa232 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -169,19 +169,16 @@ static void xr17v35x_set_divisor(struct uart_port *p, unsigned int baud,
 static void exar_shutdown(struct uart_port *port)
 {
 	unsigned char lsr;
-	bool tx_complete = 0;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct circ_buf *xmit = &port->state->xmit;
-	int i = 0;
+	unsigned int i = 1000;
 
 	do {
 		lsr = serial_in(up, UART_LSR);
 		if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
-			tx_complete = 1;
-		else
-			tx_complete = 0;
+			break;
 		msleep(1);
-	} while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);
+	} while (!uart_circ_empty(xmit) && --i);
 
 	serial8250_do_shutdown(port);
 }
-- 
2.20.1

