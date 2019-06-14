Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB34564B
	for <lists+linux-serial@lfdr.de>; Fri, 14 Jun 2019 09:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfFNH2H (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Jun 2019 03:28:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46981 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfFNH2H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jun 2019 03:28:07 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hbgd3-0001vY-ER; Fri, 14 Jun 2019 09:28:05 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hbgd1-0001Jk-UL; Fri, 14 Jun 2019 09:28:03 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-serial@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] serial: imx: fix RTS/CTS setting
Date:   Fri, 14 Jun 2019 09:28:01 +0200
Message-Id: <20190614072801.3187-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
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

The correct setting of the RTS pin depends on the CRTSCTS termios setting:

- When CRTSCTS is disabled then RTS shall be controlled by the TIOCM_RTS
  flag.
- When CRTSCTS is enabled the expected behaviour of the RTS pin is:
  - When TIOCM_RTS is set then let the receiver control RTS.
  - When the TIOCM_RTS flag is cleared then RTS shall be deasserted (to let
    the upper layers throttle the transfer even when the FIFO in the UART has
    enough space).

This patch fixes this behaviour. Previously the RTS pin has always been
controlled by the receiver once the TIOCM_RTS flag was set and the CRTSCTS
setting hasn't been taken into account.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b752e895053..0eddca6455ad 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -216,6 +216,7 @@ struct imx_port {
 	unsigned int		dma_is_enabled:1;
 	unsigned int		dma_is_rxing:1;
 	unsigned int		dma_is_txing:1;
+	unsigned int		crtscts:1;
 	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
 	struct scatterlist	rx_sgl, tx_sgl[2];
 	void			*rx_buf;
@@ -967,9 +968,18 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		u32 ucr2;
 
 		ucr2 = imx_uart_readl(sport, UCR2);
+
 		ucr2 &= ~(UCR2_CTS | UCR2_CTSC);
-		if (mctrl & TIOCM_RTS)
-			ucr2 |= UCR2_CTS | UCR2_CTSC;
+
+		if (mctrl & TIOCM_RTS) {
+			if (sport->crtscts)
+				/* let the receiver control RTS */
+				ucr2 |= UCR2_CTSC;
+			else
+				/* Force RTS active */
+				ucr2 |= UCR2_CTS;
+		}
+
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
@@ -1554,6 +1564,11 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		ucr2 = UCR2_SRST | UCR2_IRTS;
 
+	if (termios->c_cflag & CRTSCTS)
+		sport->crtscts = true;
+	else
+		sport->crtscts = false;
+
 	if (termios->c_cflag & CRTSCTS) {
 		if (sport->have_rtscts) {
 			ucr2 &= ~UCR2_IRTS;
-- 
2.20.1

