Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3974E114CCE
	for <lists+linux-serial@lfdr.de>; Fri,  6 Dec 2019 08:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLFHmN (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 6 Dec 2019 02:42:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39456 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbfLFHmN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Dec 2019 02:42:13 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6B7BB24DAD939D5DA602;
        Fri,  6 Dec 2019 15:42:11 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Dec 2019 15:42:02 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH v2] tty: omap-serial: remove set but unused variable
Date:   Fri, 6 Dec 2019 15:37:43 +0800
Message-ID: <1575617863-32484-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix the following warning:
drivers/tty/serial/omap-serial.c: In function serial_omap_rlsi:
drivers/tty/serial/omap-serial.c:496:16: warning: variable ch set but not used [-Wunused-but-set-variable]

The character read is useless according to the table 23-246 of the omap4
TRM. So we can drop it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/tty/serial/omap-serial.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6420ae5..5f808d8 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -493,10 +493,13 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
 static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
 {
 	unsigned int flag;
-	unsigned char ch = 0;
 
+	/*
+	 * Read one data character out to avoid stalling the receiver according
+	 * to the table 23-246 of the omap4 TRM.
+	 */
 	if (likely(lsr & UART_LSR_DR))
-		ch = serial_in(up, UART_RX);
+		serial_in(up, UART_RX);
 
 	up->port.icount.rx++;
 	flag = TTY_NORMAL;
-- 
1.7.12.4

