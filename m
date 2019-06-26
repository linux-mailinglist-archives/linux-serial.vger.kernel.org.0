Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136F056669
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 12:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfFZKQF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 06:16:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53495 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZKQF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 06:16:05 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hg4yC-00076f-5v; Wed, 26 Jun 2019 12:16:04 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hg4y7-0006s7-C9; Wed, 26 Jun 2019 12:15:59 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-serial@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2] serial: imx: use UPF_AUTO_CTS
Date:   Wed, 26 Jun 2019 12:15:57 +0200
Message-Id: <20190626101557.26299-3-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626101557.26299-1-s.hauer@pengutronix.de>
References: <20190626101557.26299-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The i.MX driver doesn't set the UPF_AUTO_CTS flag which means that
uart_handle_cts_change() will stop/start the receiver on CTS changes.
This is completely unnecessary as the hardware will handle CTS
changes automatically.

With UPF_AUTO_CTS enabled uart_handle_cts_change() boils down to
increasing the CTS statistic counter. For clarity inline increasing
the counter instead of calling uart_handle_cts_change().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0419a084c0ed..82f987dab066 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -703,13 +703,11 @@ static void imx_uart_start_tx(struct uart_port *port)
 static irqreturn_t imx_uart_rtsint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
-	u32 usr1;
 
 	spin_lock(&sport->port.lock);
 
 	imx_uart_writel(sport, USR1_RTSD, USR1);
-	usr1 = imx_uart_readl(sport, USR1) & USR1_RTSS;
-	uart_handle_cts_change(&sport->port, !!usr1);
+	sport->port.icount.cts++;
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 
 	spin_unlock(&sport->port.lock);
@@ -1588,6 +1586,9 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	} else if (termios->c_cflag & CRTSCTS) {
 		if (ucr2 & UCR2_CTS)
 			ucr2 |= UCR2_CTSC;
+		port->status |= UPSTAT_AUTOCTS;
+	} else {
+		port->status &= ~UPSTAT_AUTOCTS;
 	}
 
 	if (termios->c_cflag & CRTSCTS)
@@ -1706,6 +1707,9 @@ static void imx_uart_config_port(struct uart_port *port, int flags)
 
 	if (flags & UART_CONFIG_TYPE)
 		sport->port.type = PORT_IMX;
+
+	if (sport->have_rtscts)
+		sport->port.flags |= UPF_AUTO_CTS;
 }
 
 /*
-- 
2.20.1

