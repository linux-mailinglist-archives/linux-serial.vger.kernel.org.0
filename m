Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AE381F01
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2019 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfHEOZm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 5 Aug 2019 10:25:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:11914 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfHEOZm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Aug 2019 10:25:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 07:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="349124474"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 05 Aug 2019 07:25:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF37011C; Mon,  5 Aug 2019 17:25:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Robert Middleton <robert.middleton@rm5248.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/2] serial: 8250_exar: Replace msleep(1) with usleep_range()
Date:   Mon,  5 Aug 2019 17:25:35 +0300
Message-Id: <20190805142535.21948-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805142535.21948-1-andriy.shevchenko@linux.intel.com>
References: <20190805142535.21948-1-andriy.shevchenko@linux.intel.com>
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
v3: previous patch in the series has been dropped for now, thus,
    this one reconstructed accordingly
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 873aa6b0c2f3..597eb9d16f21 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -180,7 +180,7 @@ static void exar_shutdown(struct uart_port *port)
 			tx_complete = 1;
 		else
 			tx_complete = 0;
-		msleep(1);
+		usleep_range(1000, 1100);
 	} while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);
 
 	serial8250_do_shutdown(port);
-- 
2.20.1

