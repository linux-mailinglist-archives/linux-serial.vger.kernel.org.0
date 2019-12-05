Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3DD11408C
	for <lists+linux-serial@lfdr.de>; Thu,  5 Dec 2019 13:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfLEMJQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 5 Dec 2019 07:09:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729096AbfLEMJP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Dec 2019 07:09:15 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DFCF9591E827F0113D36;
        Thu,  5 Dec 2019 20:09:13 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Dec 2019 20:09:06 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] tty: omap-serial: remove set but unused variable
Date:   Thu, 5 Dec 2019 20:04:36 +0800
Message-ID: <1575547476-51996-1-git-send-email-wangxiongfeng2@huawei.com>
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

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/tty/serial/omap-serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6420ae5..54ee3ae 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -493,10 +493,9 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
 static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
 {
 	unsigned int flag;
-	unsigned char ch = 0;
 
 	if (likely(lsr & UART_LSR_DR))
-		ch = serial_in(up, UART_RX);
+		serial_in(up, UART_RX);
 
 	up->port.icount.rx++;
 	flag = TTY_NORMAL;
-- 
1.7.12.4

