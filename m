Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048B55DDD1
	for <lists+linux-serial@lfdr.de>; Wed,  3 Jul 2019 07:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfGCFwq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 3 Jul 2019 01:52:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbfGCFwq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Jul 2019 01:52:46 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 27B034BD0BDF765E245B;
        Wed,  3 Jul 2019 13:52:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Wed, 3 Jul 2019 13:52:35 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>, Stefan Roese <sr@denx.de>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-serial@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] serial: 8250: 8250_core: Fix missing unlock on error in serial8250_register_8250_port()
Date:   Wed, 3 Jul 2019 05:59:08 +0000
Message-ID: <20190703055908.141294-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the missing unlock before return from function serial8250_register_8250_port()
in the error handling case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/tty/serial/8250/8250_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a4470771005f..df3bcc0b2d74 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1026,8 +1026,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (!has_acpi_companion(uart->port.dev)) {
 			gpios = mctrl_gpio_init(&uart->port, 0);
 			if (IS_ERR(gpios)) {
-				if (PTR_ERR(gpios) != -ENOSYS)
-					return PTR_ERR(gpios);
+				if (PTR_ERR(gpios) != -ENOSYS) {
+					ret = PTR_ERR(gpios);
+					goto out_unlock;
+				}
 			} else {
 				uart->gpios = gpios;
 			}
@@ -1099,6 +1101,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		}
 	}
 
+out_unlock:
 	mutex_unlock(&serial_mutex);
 
 	return ret;





