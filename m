Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4655666A
	for <lists+linux-serial@lfdr.de>; Wed, 26 Jun 2019 12:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfFZKQO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 26 Jun 2019 06:16:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38703 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZKQO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jun 2019 06:16:14 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hg4yC-00076e-5q; Wed, 26 Jun 2019 12:16:04 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hg4y7-0006s4-Bh; Wed, 26 Jun 2019 12:15:59 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-serial@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] serial: imx: remove duplicate handling of CTS change
Date:   Wed, 26 Jun 2019 12:15:56 +0200
Message-Id: <20190626101557.26299-2-s.hauer@pengutronix.de>
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

We have an interrupt for the CTS input (RTS in FSL speech). Its handler
calls uart_handle_cts_change(), so we shouldn't do this in
imx_uart_mctrl_check() again.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a5e80a028e83..0419a084c0ed 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -805,12 +805,8 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport);
 static unsigned int imx_uart_get_hwmctrl(struct imx_port *sport)
 {
 	unsigned int tmp = TIOCM_DSR;
-	unsigned usr1 = imx_uart_readl(sport, USR1);
 	unsigned usr2 = imx_uart_readl(sport, USR2);
 
-	if (usr1 & USR1_RTSS)
-		tmp |= TIOCM_CTS;
-
 	/* in DCE mode DCDIN is always 0 */
 	if (!(usr2 & USR2_DCDIN))
 		tmp |= TIOCM_CAR;
@@ -843,8 +839,6 @@ static void imx_uart_mctrl_check(struct imx_port *sport)
 		sport->port.icount.dsr++;
 	if (changed & TIOCM_CAR)
 		uart_handle_dcd_change(&sport->port, status & TIOCM_CAR);
-	if (changed & TIOCM_CTS)
-		uart_handle_cts_change(&sport->port, status & TIOCM_CTS);
 
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 }
-- 
2.20.1

