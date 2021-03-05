Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9CF32E031
	for <lists+linux-serial@lfdr.de>; Fri,  5 Mar 2021 04:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCEDko (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Mar 2021 22:40:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13061 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhCEDkn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Mar 2021 22:40:43 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DsD3W5wgszMjKC;
        Fri,  5 Mar 2021 11:38:31 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Mar 2021 11:40:33 +0800
From:   'Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Karol Gugala <kgugala@antmicro.com>,
        "Mateusz Holenko" <mholenko@antmicro.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Filip Kokosinski" <fkokosinski@antmicro.com>
CC:     <linux-serial@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] serial: liteuart: fix return value check in liteuart_probe()
Date:   Fri, 5 Mar 2021 03:49:29 +0000
Message-ID: <20210305034929.3234352-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_platform_get_and_ioremap_resource()
returns ERR_PTR() and never returns NULL. The NULL test in the return
value check should be replaced with IS_ERR().

Fixes: 1da81e5562fa ("drivers/tty/serial: add LiteUART driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/tty/serial/liteuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 64842f3539e1..0b06770642cb 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -270,8 +270,8 @@ static int liteuart_probe(struct platform_device *pdev)
 
 	/* get membase */
 	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
-	if (!port->membase)
-		return -ENXIO;
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
 
 	/* values not from device tree */
 	port->dev = &pdev->dev;

