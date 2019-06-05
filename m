Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BCC35C94
	for <lists+linux-serial@lfdr.de>; Wed,  5 Jun 2019 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfFEMWh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 5 Jun 2019 08:22:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37746 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfFEMWg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jun 2019 08:22:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id 20so12312671pgr.4;
        Wed, 05 Jun 2019 05:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XvD01gwGwPNuRPEhXmAmu4eDP7JeVIjlGNk8Nfd1TVU=;
        b=MyVhaRsQfmeV0VJna801iFQDl6WPANoMVnR9955VixVVj/TS72OIqr+9CxTQnv5Z2r
         bY/pHzQ0OSdSy4TLkWT5ns9BOwfmo9nBB10bHjge4DqGCAEg13oMu1W5MQyb+/ZZ4anu
         w448lLZ9+EBtKQtJsbdT7r+yuPHgkxXGSE/xJYj6PAPv59BpZmtn8HDH43LwLaLauFXp
         75/iSq81hjWhYECyf/gvfjxrWOHiIu64ZuF6BHddPPK3Wqmd2PJk5HLbt00gBlTXOgBB
         Ae9AU6xw4Hzsc2i/v027AEM5hSnX8xz/ww8hplc2mGucvM3woWSxaB5DXsHhojhotIdQ
         DBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XvD01gwGwPNuRPEhXmAmu4eDP7JeVIjlGNk8Nfd1TVU=;
        b=RzPs/rsSJGIczNcboTQgkIg/tnkHuFtnMm1xRHGcN1OitT0TBkFBZNHmnxxpPkuILc
         Y8chzaxJYuuW2NbX1WvLBVmdg5Xl/DuVzYwPL71vN5Boqbm6Dpm90t62Y66mGotPTTg/
         QZ5YAh4k9xBVqcKV9hBU/thteYZo65WHOn/En/HB8T4fprRjwwUpDflWEmcCyBUaIgC3
         zuq5CHejXlSy+OeQhWF8FOllwjpvwJhuZF4WedHNlVIYl4eNp/ELQF1s1cCLi6Udk2cM
         ff5MlyE9ck6iTLwmgDGHHHqg3OMTRiQvx2oHNOCFTAcvbOpPzmnBCet5AFYiwuJP0bMp
         noFw==
X-Gm-Message-State: APjAAAXvK7M195+9g4kfXSBA6DV6wFNTr/PeZSNyBA0dHON4PqR4gWgs
        rVO21kyLvKhX1/e4FQ6eLao=
X-Google-Smtp-Source: APXvYqzHCuU7Z6N3vPTHx/riiLS2gEmWEYSbb+cJlSKkH+OC/ineeAYzJs1YUjLCINDbYB1cLpZOjA==
X-Received: by 2002:a63:f257:: with SMTP id d23mr3999590pgk.305.1559737356026;
        Wed, 05 Jun 2019 05:22:36 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id q22sm3322094pff.63.2019.06.05.05.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 05:22:35 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com
Cc:     sudheer Kumar veliseti <sudheer.open@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch 2/5] build configuration for AST2500 DMA UART driver
Date:   Wed,  5 Jun 2019 17:53:12 +0530
Message-Id: <1559737395-28542-3-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
References: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: sudheer Kumar veliseti <sudheer.open@gmail.com>

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---
 drivers/tty/serial/8250/Kconfig  | 35 +++++++++++++++++++++++++++++++-
 drivers/tty/serial/8250/Makefile |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 15c2c5463835..c793466a1c47 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -45,7 +45,7 @@ config SERIAL_8250_DEPRECATED_OPTIONS
 	  keep the 8250_core.* options around until they revert the changes
 	  they already did.
 
-	  If 8250 is built as a module, this adds 8250_core alias instead. 
+	  If 8250 is built as a module, this adds 8250_core alias instead.
 
 	  If you did not notice yet and/or you have userspace from pre-3.7, it
 	  is safe (and recommended) to say N here.
@@ -189,6 +189,39 @@ config SERIAL_8250_RUNTIME_UARTS
 	  with the module parameter "nr_uarts", or boot-time parameter
 	  8250.nr_uarts
 
+config  AST_SERIAL_DMA_UART
+        tristate "AST UART driver with DMA"
+        select SERIAL_CORE
+        help
+          UART driver with DMA support for Aspeed BMC AST25XX.
+          this driver supports UARTs in AST2500,AST2600. It uses
+          DMA channel of DMA engines present in these chips.
+          since this dma engine is used only by UARTs it is not
+          added as a separate DMA driver instead added as a layer
+          within UART driver.
+
+
+config AST_NR_DMA_UARTS
+        int "Maximum number of uart dma serial ports"
+        depends on AST_SERIAL_DMA_UART
+        default "4"
+        help
+          Set this to the number of serial ports you want the driver
+          to support.  This includes any ports discovered via ACPI or
+          PCI enumeration and any ports that may be added at run-time
+          via hot-plug, or any ISA multi-port serial cards.
+
+config AST_RUNTIME_DMA_UARTS
+        int "Number of uart dma serial ports to register at runtime"
+        depends on AST_SERIAL_DMA_UART
+        range 0 AST_NR_DMA_UARTS
+        default "4"
+        help
+          Set this to the maximum number of serial ports you want
+          the kernel to register at boot time.  This can be overridden
+          with the module parameter "nr_uarts", or boot-time parameter
+          8250.nr_uarts
+
 config SERIAL_8250_EXTENDED
 	bool "Extended 8250/16550 serial driver options"
 	depends on SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 18751bc63a84..54d40e5c6e2a 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
 obj-$(CONFIG_SERIAL_8250_MOXA)		+= 8250_moxa.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
+obj-$(CONFIG_AST_SERIAL_DMA_UART)	+= 8250_ast2500_uart_dma.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.17.1

