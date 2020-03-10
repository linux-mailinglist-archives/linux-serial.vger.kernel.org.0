Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00950180519
	for <lists+linux-serial@lfdr.de>; Tue, 10 Mar 2020 18:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCJRnl (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Mar 2020 13:43:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:20632 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgCJRnl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 13:43:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 10:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="234420081"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2020 10:43:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CC6106A; Tue, 10 Mar 2020 19:43:38 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/4] serial: core: Print escaped SysRq Magic sequence if enabled
Date:   Tue, 10 Mar 2020 19:43:35 +0200
Message-Id: <20200310174337.74109-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310174337.74109-1-andriy.shevchenko@linux.intel.com>
References: <20200310174337.74109-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is useful to see on the serial console the magic sequence itself
to enable SysRq without rummaging source code.

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: add tag
 drivers/tty/serial/serial_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ec3b833e9f22..e3f2afc15ad4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3191,8 +3191,11 @@ static const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
 
 static void uart_sysrq_on(struct work_struct *w)
 {
+	int sysrq_toggle_seq_len = strlen(sysrq_toggle_seq);
+
 	sysrq_toggle_support(1);
-	pr_info("SysRq is enabled by magic sequence on serial\n");
+	pr_info("SysRq is enabled by magic sequence '%*pE' on serial\n",
+		sysrq_toggle_seq_len, sysrq_toggle_seq);
 }
 static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
 
-- 
2.25.1

