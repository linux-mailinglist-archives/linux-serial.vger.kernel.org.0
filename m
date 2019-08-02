Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F6C7FD9F
	for <lists+linux-serial@lfdr.de>; Fri,  2 Aug 2019 17:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbfHBPeZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 2 Aug 2019 11:34:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:63230 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfHBPeZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Aug 2019 11:34:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 08:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="257009881"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2019 08:34:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E425716A; Fri,  2 Aug 2019 18:34:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] serial: 8250_exar: Replace msleep(1) with usleep_range()
Date:   Fri,  2 Aug 2019 18:34:22 +0300
Message-Id: <20190802153422.11131-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802153422.11131-1-andriy.shevchenko@linux.intel.com>
References: <20190802153422.11131-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As explained in Documentation/timers/timers-howto.rst
the small amount of milliseconds sometimes produces
much longer delays.

Replace msleep(1) with usleep_range(1000, 1100).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index f81d5c4fa232..1a3b27d1bd61 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -177,7 +177,7 @@ static void exar_shutdown(struct uart_port *port)
 		lsr = serial_in(up, UART_LSR);
 		if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
 			break;
-		msleep(1);
+		usleep_range(1000, 1100);
 	} while (!uart_circ_empty(xmit) && --i);
 
 	serial8250_do_shutdown(port);
-- 
2.20.1

