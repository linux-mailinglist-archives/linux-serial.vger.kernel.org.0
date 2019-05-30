Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B582FF80
	for <lists+linux-serial@lfdr.de>; Thu, 30 May 2019 17:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfE3PgG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 May 2019 11:36:06 -0400
Received: from mail.javad.com ([54.86.164.124]:59880 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfE3PgF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 May 2019 11:36:05 -0400
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A862554540;
        Thu, 30 May 2019 15:30:08 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@gnss.ru smtp.helo=localhost6.localdomain6
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id x4UFU7x4026002;
        Thu, 30 May 2019 18:30:07 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id x4UFU7YX025999;
        Thu, 30 May 2019 18:30:07 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 5/8] serial: imx: do not stop Rx/Tx on termios change
Date:   Thu, 30 May 2019 18:29:47 +0300
Message-Id: <20190530152950.25377-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
In-Reply-To: <20190530152950.25377-1-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx_set_termios(): stopping receiver and transmitter does harm when
something that doesn't touch transmission format/rate changes, such as
RTS/CTS handshake.

OTOH, it does no good on baud rate or format change, as
synchronization on upper-level protocols is still required to do it
right.

Therefore, just stop doing it.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fb82fc6..469a0c3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1643,9 +1643,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	old_ucr2 = imx_uart_readl(sport, UCR2);
 	imx_uart_writel(sport, old_ucr2 & ~UCR2_ATEN, UCR2);
 
-	/* then, disable everything */
-	imx_uart_writel(sport, old_ucr2 & ~(UCR2_TXEN | UCR2_RXEN | UCR2_ATEN), UCR2);
-
 	/* custom-baudrate handling */
 	div = sport->port.uartclk / (baud * 16);
 	if (baud == 38400 && quot != div)
-- 
2.10.0.1.g57b01a3

