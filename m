Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACDBE11DA99
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbfLMAIu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:08:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46735 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731739AbfLMAIt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id k20so370428pll.13
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0o1BCAC6sUMX6rLNiGutpYWhmm9iWXFvl6JHodeKbf0=;
        b=mVJCppHBnfhDhhFyiyvo2t7C3ASY6Kvq3kiHtC5crXo6VCk36Nny62w+pjb8/fJjMV
         G8ZU54ssfXVATGkwG65+fj737ltfAPyB3Byi/Mol4WMq/7VSyuH9akqKQDR6spCd1hBe
         qBMoGH0/BKBCRDfXu+sTG9iGM6W2TQiC4GbIXE6r/UmBVxVQ5N4bWv8GFuGRVSeVow+c
         ky0VQtruLlYGsqBH2fjOblzQSl9JnXOn/R4xKZFNM4mS/ftMKc/fhOge5E+HF32OHwyO
         U8FuZ/ZSUxJr0x8uz/3dxacpAU8unVU+AlzEz4rNc/OxnldE6m8xLG5+DHe/QpnsVKTm
         Ui3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0o1BCAC6sUMX6rLNiGutpYWhmm9iWXFvl6JHodeKbf0=;
        b=laCSp4J9H5mkXXaHIOT+PU1JJzug5yfPUFNSOeMPtljucMBPQ3efp+kyjwvMzvB5hd
         IJ4Oohx3pvBeon3kbQdfSxY4816p8nQAD4W7kogq1xhg8EQFzmOcdtlhRTlNmiy1CHUe
         WVEm6d55vIRUjY6JgGLb0owfuEqOF9U1WMvg9Le6v7leNB7GZj+MYE3Sjfx/9Oz36spc
         sR4of8GbR+00wX047TpegZ6hZvy4BLA3xX3mmkdQu542ReQQY6pf+1aJgTRU8ORlHUCa
         pQSLErWwKkZEyCppgtPCPFWiikrn0g//gVbJAHfdPTfHz4i/oBB4fm/D4sGxTLmpAVSl
         kTqw==
X-Gm-Message-State: APjAAAWGpmjccsbMm96zQGOTaGlDBvOXlc/SSihDAKHFxjKdZhg9acOm
        1zWFOoMAZxRUHtSkEAhsiCjJdQ==
X-Google-Smtp-Source: APXvYqxx4jy7f4yj7AOp63lFXnBcqOv4IagCnBHox7INS4rOAac7dktUFIzlL4AahBUWl41qsOO5qg==
X-Received: by 2002:a17:90a:7144:: with SMTP id g4mr13287852pjs.32.1576195728995;
        Thu, 12 Dec 2019 16:08:48 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:48 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 32/58] tty/serial: Migrate pnx8xxx_uart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:31 +0000
Message-Id: <20191213000657.931618-33-dima@arista.com>
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

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/pnx8xxx_uart.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 223a9499104e..972d94e8d32b 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -10,10 +10,6 @@
  * Copyright (C) 2000 Deep Blue Solutions Ltd.
  */
 
-#if defined(CONFIG_SERIAL_PNX8XXX_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -220,9 +216,7 @@ static void pnx8xxx_rx_chars(struct pnx8xxx_port *sport)
 			else if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE))
 				flg = TTY_FRAME;
 
-#ifdef SUPPORT_SYSRQ
 			sport->port.sysrq = 0;
-#endif
 		}
 
 		if (uart_handle_sysrq_char(&sport->port, ch))
@@ -800,6 +794,7 @@ static int pnx8xxx_serial_probe(struct platform_device *pdev)
 			if (pnx8xxx_ports[i].port.mapbase != res->start)
 				continue;
 
+			pnx8xxx_ports[i].port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_PNX8XXX_CONSOLE);
 			pnx8xxx_ports[i].port.dev = &pdev->dev;
 			uart_add_one_port(&pnx8xxx_reg, &pnx8xxx_ports[i].port);
 			platform_set_drvdata(pdev, &pnx8xxx_ports[i]);
-- 
2.24.0

