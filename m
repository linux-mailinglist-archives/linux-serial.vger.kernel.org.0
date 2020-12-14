Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB12D98FF
	for <lists+linux-serial@lfdr.de>; Mon, 14 Dec 2020 14:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407976AbgLNNhs (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 14 Dec 2020 08:37:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9879 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgLNNhq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 08:37:46 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cvj8l3110z7G9Z;
        Mon, 14 Dec 2020 21:36:23 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:36:49 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] tty/serial/imx: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:37:19 +0800
Message-ID: <20201214133719.3893-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index cacf7266a262..4a959efb7849 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2312,7 +2312,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
 	sport->port.membase = base;
-	sport->port.type = PORT_IMX,
+	sport->port.type = PORT_IMX;
 	sport->port.iotype = UPIO_MEM;
 	sport->port.irq = rxirq;
 	sport->port.fifosize = 32;
-- 
2.22.0

