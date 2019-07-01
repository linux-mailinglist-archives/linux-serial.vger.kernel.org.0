Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253AD30EDF
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfEaN3a (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 09:29:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17637 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbfEaN3a (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 09:29:30 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6EEA1810B1C503DC496B;
        Fri, 31 May 2019 21:29:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 31 May 2019 21:29:19 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Baruch Siach <baruch@tkos.co.il>,
        <linux-serial@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] tty/serial: digicolor: Fix digicolor-usart already registered warning
Date:   Fri, 31 May 2019 21:37:33 +0800
Message-ID: <20190531133733.16243-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When modprobe/rmmod/modprobe module, if platform_driver_register() fails,
the kernel complained,

  proc_dir_entry 'driver/digicolor-usart' already registered
  WARNING: CPU: 1 PID: 5636 at fs/proc/generic.c:360 proc_register+0x19d/0x270

Fix this by adding uart_unregister_driver() when platform_driver_register() fails.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/tty/serial/digicolor-usart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index f460cca139e2..13ac36e2da4f 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -541,7 +541,11 @@ static int __init digicolor_uart_init(void)
 	if (ret)
 		return ret;
 
-	return platform_driver_register(&digicolor_uart_platform);
+	ret = platform_driver_register(&digicolor_uart_platform);
+	if (ret)
+		uart_unregister_driver(&digicolor_uart);
+
+	return ret;
 }
 module_init(digicolor_uart_init);
 
-- 
2.20.1

