Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6403815D6B4
	for <lists+linux-serial@lfdr.de>; Fri, 14 Feb 2020 12:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgBNLnr (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Feb 2020 06:43:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:11576 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbgBNLnq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 06:43:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 03:43:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="234434014"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2020 03:43:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B6C954AB; Fri, 14 Feb 2020 13:43:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 7/8] serial: 8250_mtk: Remove duplicating code to disable DMA
Date:   Fri, 14 Feb 2020 13:43:38 +0200
Message-Id: <20200214114339.53897-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The core already handles the kernel console case and disables DMA
for any serial device used for above mentioned purposes.

Thus, remove duplicating code to disable DMA for kernel console.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 4d067f515f74..3edd5791ada8 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -183,10 +183,6 @@ static int mtk8250_startup(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct mtk8250_data *data = port->private_data;
 
-	/* disable DMA for console */
-	if (uart_console(port))
-		up->dma = NULL;
-
 	if (up->dma) {
 		data->rx_status = DMA_RX_START;
 		uart_circ_clear(&port->state->xmit);
-- 
2.25.0

