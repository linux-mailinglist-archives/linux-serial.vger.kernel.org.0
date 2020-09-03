Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1D325B8AE
	for <lists+linux-serial@lfdr.de>; Thu,  3 Sep 2020 04:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgICCT6 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 2 Sep 2020 22:19:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgICCT5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Sep 2020 22:19:57 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EECF7A41C329C003F42F;
        Thu,  3 Sep 2020 10:19:55 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 3 Sep 2020
 10:19:49 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] serial: imx: Delete duplicated argument to | in imx_uart_probe
Date:   Thu, 3 Sep 2020 10:19:22 +0800
Message-ID: <20200903021922.316760-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When calculate ucr1 UCR1_TRDYEN is duplicate.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/tty/serial/imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index ce8c472cf385..4e6ead1f650e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2389,8 +2389,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 
 	/* Disable interrupts before requesting them */
 	ucr1 = imx_uart_readl(sport, UCR1);
-	ucr1 &= ~(UCR1_ADEN | UCR1_TRDYEN | UCR1_IDEN | UCR1_RRDYEN |
-		 UCR1_TRDYEN | UCR1_RTSDEN);
+	ucr1 &= ~(UCR1_ADEN | UCR1_TRDYEN | UCR1_IDEN | UCR1_RRDYEN | UCR1_RTSDEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
 	if (!imx_uart_is_imx1(sport) && sport->dte_mode) {
-- 
2.25.4

