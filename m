Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0DB2FF84
	for <lists+linux-serial@lfdr.de>; Thu, 30 May 2019 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfE3PgH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 May 2019 11:36:07 -0400
Received: from mail.javad.com ([54.86.164.124]:59878 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfE3PgG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 May 2019 11:36:06 -0400
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 15C7254542;
        Thu, 30 May 2019 15:30:08 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@gnss.ru smtp.helo=localhost6.localdomain6
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id x4UFU75k026052;
        Thu, 30 May 2019 18:30:07 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id x4UFU7Q0026030;
        Thu, 30 May 2019 18:30:07 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 7/8] serial: imx: fix data breakage on termios change
Date:   Thu, 30 May 2019 18:29:49 +0300
Message-Id: <20190530152950.25377-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
In-Reply-To: <20190530152950.25377-1-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_set_termios(): avoid writing baud rate divider registers when the
values to be written are the same as current. Any writing seems to
restart transmission/receiving logic in the hardware, that leads to
data breakage even when rate doesn't in fact change. E.g., user
switches RTS/CTS handshake and suddenly gets broken bytes.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4b9c560..db3fb4c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1537,7 +1537,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int baud, quot;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 	unsigned long div;
-	unsigned long num, denom;
+	unsigned long num, denom, old_ubir, old_ubmr;
 	uint64_t tdiv64;
 
 	/*
@@ -1660,8 +1660,21 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	ufcr = (ufcr & (~UFCR_RFDIV)) | UFCR_RFDIV_REG(div);
 	imx_uart_writel(sport, ufcr, UFCR);
 
-	imx_uart_writel(sport, num, UBIR);
-	imx_uart_writel(sport, denom, UBMR);
+	/*
+	 *  Two registers below should always be written both and in this
+	 *  particular order. One consequence is that we need to check if any of
+	 *  them changes and then update both. We do need the check for change
+	 *  as even writing the same values seem to "restart"
+	 *  transmission/receiving logic in the hardware, that leads to data
+	 *  breakage even when rate doesn't in fact change. E.g., user switches
+	 *  RTS/CTS handshake and suddenly gets broken bytes.
+	 */
+	old_ubir = imx_uart_readl(sport, UBIR);
+	old_ubmr = imx_uart_readl(sport, UBMR);
+	if (old_ubir != num || old_ubmr != denom) {
+		imx_uart_writel(sport, num, UBIR);
+		imx_uart_writel(sport, denom, UBMR);
+	}
 
 	if (!imx_uart_is_imx1(sport))
 		imx_uart_writel(sport, sport->port.uartclk / div / 1000,
-- 
2.10.0.1.g57b01a3

