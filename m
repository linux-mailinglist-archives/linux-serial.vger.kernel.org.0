Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5802917A54C
	for <lists+linux-serial@lfdr.de>; Thu,  5 Mar 2020 13:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgCEMbL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 5 Mar 2020 07:31:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:25222 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgCEMbL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Mar 2020 07:31:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 04:31:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="387488685"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 05 Mar 2020 04:31:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8AF7F107; Thu,  5 Mar 2020 14:31:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] MAINTAINERS: Add missed files related to Synopsys DesignWare UART
Date:   Thu,  5 Mar 2020 14:31:08 +0200
Message-Id: <20200305123108.41320-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

8250_dw has been split to library part and the driver, the library
is being used by 8250_lpss, which represents Synosys DesignWare UART
(with optional Synopsys Designware DMA) enumerated by PCI.

Add missed above mentioned files to the database record for review.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 59ba0ab550b6..7b3fbc471bc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16163,6 +16163,8 @@ SYNOPSYS DESIGNWARE 8250 UART DRIVER
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 S:	Maintained
 F:	drivers/tty/serial/8250/8250_dw.c
+F:	drivers/tty/serial/8250/8250_dwlib.*
+F:	drivers/tty/serial/8250/8250_lpss.c
 
 SYNOPSYS DESIGNWARE APB GPIO DRIVER
 M:	Hoan Tran <hoan@os.amperecomputing.com>
-- 
2.25.1

