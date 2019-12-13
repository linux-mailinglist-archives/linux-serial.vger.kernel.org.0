Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4811DAEA
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbfLMAIL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:08:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42385 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbfLMAIL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id x13so377961plr.9
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7vj+qwFtP7xVmHBgaa06jNzp38vBtMsISF/N9QYy00=;
        b=QCtRZf+DpfijvCDxwWd0IInXC860Nhs1gnLTLXGzQrEyny0IANF6c+HSGP+7/iHmdU
         DM5EdeqGyMXymv4UANFp1Z+5EsiHLvgA6yQ+XcMwy+PTcU7R7QFRT2hVgHWVQ/j363l8
         BgI12yjHkE8/3iqxZ3W2zBJMKdvk4VHuyqHjOre1o03hbAnZy/wYG5+qne5I+RuQXv4x
         6O5l4VOyLvv304hUlJOOE+OQBsUq2Uci45yCHYWyQpxJJ/Rqm2pwQa1A9i1DIc80NKuk
         J9YnQDJtbDSrO/95A7qkhUTtDFXEIcXzu6MQ32q41T9H333pdp1QRtBVdj0+kRMAtNdK
         zuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7vj+qwFtP7xVmHBgaa06jNzp38vBtMsISF/N9QYy00=;
        b=OhKr3nNQ/bsHGnvF6TyGBkUmDqroXzj599J7QkZ1KE/+XbxhxqiVqAeXJuqT10dQvn
         t8f1A4XR/dVb41WpzgnPmHOTBpI3uZsLmekpNP61/eof6c5cD7UANQKipbVUNL2oIiK3
         txnJpPDOcEIRbqLrzsXmLvoBRxB4nuUeKlER3ZYe/pDwcAOy3PnvN0zNnqUUR08qUs61
         L7323QYxsAV+pIrq/SIYBpoSXEGRiI4HDYHry1NmNNwyrtJieGgloXtmzBjeRHxNbvqC
         7nZ1/tFP7B5JLDP8qshWDCwR07pFa9xfmq7OR1kKlcY76m07bp7sobhbVs3hJqaXdlLB
         TeiA==
X-Gm-Message-State: APjAAAWtKBYeVJzn80AHEzKo6B7OERBJaaGVr0bUQ+tbdnyoYiDTi+a5
        uzEfTCCGLnZh9kSdIyr+g5RkjA==
X-Google-Smtp-Source: APXvYqwLlbH3BL8PWw8R26CwvErqXpqt7+6m7DaqfHW7yx/zTlishWw5KaaIcP1V5keny7voOTKrsA==
X-Received: by 2002:a17:902:9a02:: with SMTP id v2mr12665787plp.221.1576195690418;
        Thu, 12 Dec 2019 16:08:10 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:09 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 19/58] tty/serial: Migrate imx to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:18 +0000
Message-Id: <20191213000657.931618-20-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/imx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a9e20e6c63ad..83c6e2ac0e8d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -8,10 +8,6 @@
  * Copyright (C) 2004 Pengutronix
  */
 
-#if defined(CONFIG_SERIAL_IMX_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -779,9 +775,7 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
 			if (rx & URXD_OVRRUN)
 				flg = TTY_OVERRUN;
 
-#ifdef SUPPORT_SYSRQ
 			sport->port.sysrq = 0;
-#endif
 		}
 
 		if (sport->port.ignore_status_mask & URXD_DUMMY_READ)
@@ -2231,6 +2225,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	sport->port.iotype = UPIO_MEM;
 	sport->port.irq = rxirq;
 	sport->port.fifosize = 32;
+	sport->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE);
 	sport->port.ops = &imx_uart_pops;
 	sport->port.rs485_config = imx_uart_rs485_config;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
-- 
2.24.0

