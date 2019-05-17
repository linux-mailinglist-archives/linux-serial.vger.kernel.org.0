Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E5E216A0
	for <lists+linux-serial@lfdr.de>; Fri, 17 May 2019 12:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfEQKBm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 17 May 2019 06:01:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41625 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfEQKBm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 May 2019 06:01:42 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hRZgK-0008CT-Vg; Fri, 17 May 2019 12:01:40 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hRZgK-0003yx-Gh; Fri, 17 May 2019 12:01:40 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-serial@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] serial: imx: remove log spamming error message
Date:   Fri, 17 May 2019 12:01:38 +0200
Message-Id: <20190517100138.12910-1-s.hauer@pengutronix.de>
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

Each time the DMA engine signals a transaction error the driver prints
a message at error level. Getting transaction errors is pretty much
expected on baudrate mismatches and the correspoding error counters
are increased in this case properly. Remove the error message which
is possibly repeated at a very high rate which can lock up the whole
system.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dff75dc94731..8b752e895053 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1165,7 +1165,6 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport)
 			sport->port.icount.buf_overrun++;
 		tty_flip_buffer_push(port);
 	} else {
-		dev_err(sport->port.dev, "DMA transaction error.\n");
 		if (usr1 & USR1_FRAMERR) {
 			sport->port.icount.frame++;
 			imx_uart_writel(sport, USR1_FRAMERR, USR1);
-- 
2.20.1

