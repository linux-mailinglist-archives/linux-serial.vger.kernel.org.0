Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2DCE6B5EB
	for <lists+linux-serial@lfdr.de>; Wed, 17 Jul 2019 07:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfGQF3B (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 17 Jul 2019 01:29:01 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34776 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfGQF3B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Jul 2019 01:29:01 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0485420023F;
        Wed, 17 Jul 2019 07:28:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 70E5B200349;
        Wed, 17 Jul 2019 07:28:55 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B230D402ED;
        Wed, 17 Jul 2019 13:28:46 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jslaby@suse.com, fugang.duan@nxp.com,
        u.kleine-koenig@pengutronix.de, festevam@gmail.com
Subject: [PATCH tty/serial 5/5] tty: serial: fsl_lpuart: correct the FIFO depth size
Date:   Wed, 17 Jul 2019 13:19:30 +0800
Message-Id: <20190717051930.15514-6-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190717051930.15514-1-fugang.duan@nxp.com>
References: <20190717051930.15514-1-fugang.duan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

VF610/LS1021a/i.MX7ULP/i.MX8QXP reference manual describe the
TXFIFOSIZE/RXFIFOSIZE field as below.

000b - FIFO/Buffer depth = 1 dataword.
001b - FIFO/Buffer depth = 4 datawords.
010b - FIFO/Buffer depth = 8 datawords.
011b - FIFO/Buffer depth = 16 datawords.
100b - FIFO/Buffer depth = 32 datawords.
101b - FIFO/Buffer depth = 64 datawords.
110b - FIFO/Buffer depth = 128 datawords.
111b - FIFO/Buffer depth = 256 datawords. (Reserved for VF610)

So the FIFO depth should be: 0x1 << (val ? (val + 1) : 0)

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ba87b58..d15e65f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -214,6 +214,7 @@
 #define UARTFIFO_TXSIZE_OFF	4
 #define UARTFIFO_RXFE		0x00000008
 #define UARTFIFO_RXSIZE_OFF	0
+#define UARTFIFO_DEPTH(x)	(0x1 << ((x) ? ((x) + 1) : 0))
 
 #define UARTWATER_COUNT_MASK	0xff
 #define UARTWATER_TXCNT_OFF	8
@@ -1380,13 +1381,12 @@ static int lpuart_startup(struct uart_port *port)
 	/* determine FIFO size and enable FIFO mode */
 	temp = readb(sport->port.membase + UARTPFIFO);
 
-	sport->txfifo_size = 0x1 << (((temp >> UARTPFIFO_TXSIZE_OFF) &
-		UARTPFIFO_FIFOSIZE_MASK) + 1);
-
+	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_TXSIZE_OFF) &
+					    UARTPFIFO_FIFOSIZE_MASK);
 	sport->port.fifosize = sport->txfifo_size;
 
-	sport->rxfifo_size = 0x1 << (((temp >> UARTPFIFO_RXSIZE_OFF) &
-		UARTPFIFO_FIFOSIZE_MASK) + 1);
+	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_RXSIZE_OFF) &
+					    UARTPFIFO_FIFOSIZE_MASK);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
@@ -1431,13 +1431,12 @@ static int lpuart32_startup(struct uart_port *port)
 	/* determine FIFO size */
 	temp = lpuart32_read(&sport->port, UARTFIFO);
 
-	sport->txfifo_size = 0x1 << (((temp >> UARTFIFO_TXSIZE_OFF) &
-		UARTFIFO_FIFOSIZE_MASK) - 1);
-
+	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_TXSIZE_OFF) &
+					    UARTFIFO_FIFOSIZE_MASK);
 	sport->port.fifosize = sport->txfifo_size;
 
-	sport->rxfifo_size = 0x1 << (((temp >> UARTFIFO_RXSIZE_OFF) &
-		UARTFIFO_FIFOSIZE_MASK) - 1);
+	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_RXSIZE_OFF) &
+					    UARTFIFO_FIFOSIZE_MASK);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-- 
2.7.4

