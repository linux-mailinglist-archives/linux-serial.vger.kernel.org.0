Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4796A12720A
	for <lists+linux-serial@lfdr.de>; Fri, 20 Dec 2019 01:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLTAKH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 19 Dec 2019 19:10:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55691 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfLTAKH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Dec 2019 19:10:07 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ii5rl-0004At-8J; Fri, 20 Dec 2019 00:10:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Timur Tabi <timur@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: ucc_uart: remove redundant assignment to pointer bdp
Date:   Fri, 20 Dec 2019 00:10:00 +0000
Message-Id: <20191220001000.39859-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable bdp is being initialized with a value that is never
read and it is being updated later with a new value. The initialization
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/ucc_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index afc2a5d69202..99a069ed3636 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -336,8 +336,6 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 	struct uart_port *port = &qe_port->port;
 	struct circ_buf *xmit = &port->state->xmit;
 
-	bdp = qe_port->rx_cur;
-
 	/* Handle xon/xoff */
 	if (port->x_char) {
 		/* Pick next descriptor and fill from buffer */
-- 
2.24.0

