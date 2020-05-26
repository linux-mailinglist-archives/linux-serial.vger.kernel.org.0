Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB801C33F3
	for <lists+linux-serial@lfdr.de>; Mon,  4 May 2020 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgEDID4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 4 May 2020 04:03:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:14808 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbgEDID4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 May 2020 04:03:56 -0400
IronPort-SDR: 96dErIf2SM0VV2qg/lPcmpLHnjbeeftSVGIEFFw7pfrz4wz1WOR8+35rpFmHQAo2X8BIbnHn0t
 AeIPc7752TyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 01:03:56 -0700
IronPort-SDR: nZCtHP4Q2NHk4kV0pT8l85ac64rPdmA8lkuw0bhAOEL6f3kipt5VoTwUtn/PU9+hHrSvDvmtAc
 M2cuRZu1qIag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="369023110"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2020 01:03:55 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH] serial: lantiq: Add x86 in Kconfig dependencies for Lantiq serial driver
Date:   Mon,  4 May 2020 16:03:52 +0800
Message-Id: <96fd193c0a8939d27641ff93573545c02313048f.1588577002.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Lantiq serial driver/IP is reused for a x86 based SoC as well.
Update the Kconfig accordingly.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0aea76cd67ff..4b0a7b98f8c7 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1035,7 +1035,7 @@ config SERIAL_SIFIVE_CONSOLE
 
 config SERIAL_LANTIQ
 	bool "Lantiq serial driver"
-	depends on LANTIQ
+	depends on (LANTIQ || X86) || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
-- 
2.11.0

