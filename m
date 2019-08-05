Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B718165C
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2019 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfHEKFW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 5 Aug 2019 06:05:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:50920 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbfHEKFW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Aug 2019 06:05:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 03:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="167929785"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 05 Aug 2019 03:05:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 418BF124; Mon,  5 Aug 2019 13:05:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Robert Middleton <robert.middleton@rm5248.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] serial: 8250_exar: Replace msleep(1) with usleep_range()
Date:   Mon,  5 Aug 2019 13:05:18 +0300
Message-Id: <20190805100518.9818-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
References: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
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
v2: no change
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 8f9baae92831..5e6c34f50bb5 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -179,7 +179,7 @@ static void exar_shutdown(struct uart_port *port)
 		lsr = serial_in(up, UART_LSR);
 		if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
 			break;
-		msleep(1);
+		usleep_range(1000, 1100);
 	} while (--retries);
 
 	serial8250_do_shutdown(port);
-- 
2.20.1

