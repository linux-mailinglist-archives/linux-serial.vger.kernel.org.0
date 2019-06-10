Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 445963B11F
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2019 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbfFJIpE (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Jun 2019 04:45:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40422 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388489AbfFJIpD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jun 2019 04:45:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so7288717wmj.5
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2019 01:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=qNwGVD0v2tDJVOma8Me2tLXYHNv3uP9ayQAL5Zl5p8M=;
        b=nSxgBY6UD0ogbvDpleZuxipRQtaVHmWNbd3+eNF78yabI2JIsfMO39rdkJuMbNNNEe
         uIru4cBb1MmPcYWj/kOLluu1HIst5DczKJbRnNe3C7chIny78xJnJTbDtp/bTTC1rJ9A
         CmsykBhDqPh7Zez/O5wtjuOyEWDN1wnP4Jnzw4pIcLWrTRNn2YEDYEE0JRNkS8JYgE/M
         AjOs8MemHx6dr4ab2ob+j1UcCcxRGLyhd5CdXX244kUkBitDNEIpROnrP/ooYoi31a1c
         SkWZtppIKK3rhjmELkQWW0VubtKtcsVIwBvkvM4IJPb/n+25vEnNmktuAdmvI1nxggCR
         X/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=qNwGVD0v2tDJVOma8Me2tLXYHNv3uP9ayQAL5Zl5p8M=;
        b=POGgDXbX4ojyLTEV70EALDhRSnu5LRVVS/dLBmoPOvI5EjptHpWh81Hi5R4EMl2SAO
         A2f1kLjuf+p6P9wVfgO6io4+jCn4koBVYjnRDtD+inXy47fNcYbOsXx8Lp4BjbbPDQJL
         jWjox7wj7O+tISzN+6TxhTj5hTWHdUNQnv1QFMKB4eHDaXW7LwS0SN5FIuk3FLHStfSj
         v/vnKwXUCmQJmXaQZwPl0xCLO+xIuSMsFpe2sFEhNyiVyZSXwMdqxvwODSlKX3SIsOKG
         z9fjSn9wTVPbF38xcCl1ZqHlFwGHIabJ/nDjCAJEegc3gkluFmUDr+USz5I14l0spR/o
         hd3A==
X-Gm-Message-State: APjAAAX/QnXLL4afGFjWKSToK386vrD9VuXvh/n2VPEaz8nE+aexvgIG
        HTF4lEYAWVMvsFVqN8quRJZo1A==
X-Google-Smtp-Source: APXvYqzqd62YGTXD2QtIldC59KTmIjNitmODkstbY2lZa1eC733LOO1gBiQtxJ40qqkDdHCG3xx5MQ==
X-Received: by 2002:a1c:750d:: with SMTP id o13mr12156907wmc.35.1560156301810;
        Mon, 10 Jun 2019 01:45:01 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j132sm17445435wmj.21.2019.06.10.01.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 01:45:01 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] serial: xilinx_uartps: Fix warnings in the driver
Date:   Mon, 10 Jun 2019 10:44:55 +0200
Message-Id: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch fixes the below warning

        -->Symbolic permissions 'S_IRUGO' are not preferred.
           Consider using octal permissions '0444'.
        -->macros should not use a trailing semicolon.
        -->line over 80 characters.
        -->void function return statements are not generally useful.
        -->Prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Happy to split it if needed.
---
 drivers/tty/serial/xilinx_uartps.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 605354fd60b1..6af2886f5ba7 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -35,12 +35,12 @@
 
 /* Rx Trigger level */
 static int rx_trigger_level = 56;
-module_param(rx_trigger_level, uint, S_IRUGO);
+module_param(rx_trigger_level, uint, 0444);
 MODULE_PARM_DESC(rx_trigger_level, "Rx trigger level, 1-63 bytes");
 
 /* Rx Timeout */
 static int rx_timeout = 10;
-module_param(rx_timeout, uint, S_IRUGO);
+module_param(rx_timeout, uint, 0444);
 MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 
 /* Register offsets for the UART. */
@@ -199,7 +199,7 @@ struct cdns_platform_data {
 	u32 quirks;
 };
 #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
-		clk_rate_change_nb);
+		clk_rate_change_nb)
 
 /**
  * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.
@@ -312,7 +312,8 @@ static void cdns_uart_handle_tx(void *dev_id)
 	} else {
 		numbytes = port->fifosize;
 		while (numbytes && !uart_circ_empty(&port->state->xmit) &&
-		       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
+		       !(readl(port->membase + CDNS_UART_SR) &
+						CDNS_UART_SR_TXFULL)) {
 			/*
 			 * Get the data from the UART circular buffer
 			 * and write it to the cdns_uart's TX_FIFO
@@ -1073,8 +1074,6 @@ static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 		cpu_relax();
 
 	spin_unlock_irqrestore(&port->lock, flags);
-
-	return;
 }
 #endif
 
-- 
2.17.1

