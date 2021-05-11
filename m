Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2381937AFD7
	for <lists+linux-serial@lfdr.de>; Tue, 11 May 2021 22:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhEKUDN (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 May 2021 16:03:13 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:60363 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhEKUDM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 May 2021 16:03:12 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B93C022279;
        Tue, 11 May 2021 22:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620763324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eWat/uaNT8zuWgkLaQGDRnaJaTaP83Jd9BLW2TH7L8=;
        b=cjYkYXsgXNNv+GysoEKCsLm7SpKDqSSk2/Lmm90WRqFm0dM/8FfCyMLnXsjC121wL++Bq0
        kN0X6LFYtHCNU9AJc9+SG5KGZXynPjbvKCjvj38HNFWkYfCHZ/wpmuE6Dz4gMSaj5D2X9L
        miSxS2pHWrPFGGkATg6CNcXkpX7RQLg=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 7/8] serial: fsl_lpuart: add loopback support
Date:   Tue, 11 May 2021 22:01:47 +0200
Message-Id: <20210511200148.11934-8-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511200148.11934-1-michael@walle.cc>
References: <20210511200148.11934-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The LPUART can loop the RX and TX signal. Add support for it.

Please note, this was only tested on the 32 bit version of the LPUART.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 36 +++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 19714047d571..5e66f628e895 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1403,22 +1403,54 @@ static int lpuart32_config_rs485(struct uart_port *port,
 
 static unsigned int lpuart_get_mctrl(struct uart_port *port)
 {
-	return 0;
+	unsigned int mctrl = 0;
+	u8 reg;
+
+	reg = readb(port->membase + UARTCR1);
+	if (reg & UARTCR1_LOOPS)
+		mctrl |= TIOCM_LOOP;
+
+	return mctrl;
 }
 
 static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 {
-	return 0;
+	unsigned int mctrl = 0;
+	u32 reg;
+
+	reg = lpuart32_read(port, UARTCTRL);
+	if (reg & UARTCTRL_LOOPS)
+		mctrl |= TIOCM_LOOP;
+
+	return mctrl;
 }
 
 static void lpuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	u8 reg;
+
+	reg = readb(port->membase + UARTCR1);
+
+	/* for internal loopback we need LOOPS=1 and RSRC=0 */
+	reg &= ~(UARTCR1_LOOPS | UARTCR1_RSRC);
+	if (mctrl & TIOCM_LOOP)
+		reg |= UARTCR1_LOOPS;
 
+	writeb(reg, port->membase + UARTCR1);
 }
 
 static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	u32 reg;
+
+	reg = lpuart32_read(port, UARTCTRL);
+
+	/* for internal loopback we need LOOPS=1 and RSRC=0 */
+	reg &= ~(UARTCTRL_LOOPS | UARTCTRL_RSRC);
+	if (mctrl & TIOCM_LOOP)
+		reg |= UARTCTRL_LOOPS;
 
+	lpuart32_write(port, reg, UARTCTRL);
 }
 
 static void lpuart_break_ctl(struct uart_port *port, int break_state)
-- 
2.20.1

