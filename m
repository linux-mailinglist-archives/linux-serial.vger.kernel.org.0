Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A16D939
	for <lists+linux-serial@lfdr.de>; Fri, 19 Jul 2019 04:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGSC74 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 18 Jul 2019 22:59:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58182 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726015AbfGSC74 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jul 2019 22:59:56 -0400
X-UUID: b46f2d8561aa45c9ae2e0868a59a8ce5-20190719
X-UUID: b46f2d8561aa45c9ae2e0868a59a8ce5-20190719
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <changqi.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1746597379; Fri, 19 Jul 2019 10:59:47 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 19 Jul 2019 10:59:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 19 Jul 2019 10:59:45 +0800
From:   Changqi Hu <changqi.hu@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Changqi Hu <changqi.hu@mediatek.com>,
        Peter Shih <pihsun@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH v3] serial: 8250-mtk: modify mtk uart power and clock management
Date:   Fri, 19 Jul 2019 10:59:42 +0800
Message-ID: <1563505182-2408-1-git-send-email-changqi.hu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

modify mtk uart runtime interface, add uart clock use count.
merge patch v1 and patch v2 together.

Signed-off-by: Changqi Hu <changqi.hu@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 50 ++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index f470ded..a07c8ae 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -31,6 +31,7 @@
 #define MTK_UART_RXTRI_AD	0x14	/* RX Trigger address */
 #define MTK_UART_FRACDIV_L	0x15	/* Fractional divider LSB address */
 #define MTK_UART_FRACDIV_M	0x16	/* Fractional divider MSB address */
+#define MTK_UART_DEBUG0	0x18
 #define MTK_UART_IER_XOFFI	0x20	/* Enable XOFF character interrupt */
 #define MTK_UART_IER_RTSI	0x40	/* Enable RTS Modem status interrupt */
 #define MTK_UART_IER_CTSI	0x80	/* Enable CTS Modem status interrupt */
@@ -386,9 +387,18 @@ static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
 static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(data->line);
 
-	clk_disable_unprepare(data->uart_clk);
-	clk_disable_unprepare(data->bus_clk);
+	/* wait until UART in idle status */
+	while
+		(serial_in(up, MTK_UART_DEBUG0));
+
+	if (data->clk_count == 0U) {
+		dev_dbg(dev, "%s clock count is 0\n", __func__);
+	} else {
+		clk_disable_unprepare(data->bus_clk);
+		data->clk_count--;
+	}
 
 	return 0;
 }
@@ -398,16 +408,16 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 	int err;
 
-	err = clk_prepare_enable(data->uart_clk);
-	if (err) {
-		dev_warn(dev, "Can't enable clock\n");
-		return err;
-	}
-
-	err = clk_prepare_enable(data->bus_clk);
-	if (err) {
-		dev_warn(dev, "Can't enable bus clock\n");
-		return err;
+	if (data->clk_count > 0U) {
+		dev_dbg(dev, "%s clock count is %d\n", __func__,
+			data->clk_count);
+	} else {
+		err = clk_prepare_enable(data->bus_clk);
+		if (err) {
+			dev_warn(dev, "Can't enable bus clock\n");
+			return err;
+		}
+		data->clk_count++;
 	}
 
 	return 0;
@@ -417,12 +427,14 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 {
 	if (!state)
-		pm_runtime_get_sync(port->dev);
+		if (!mtk8250_runtime_resume(port->dev))
+			pm_runtime_get_sync(port->dev);
 
 	serial8250_do_pm(port, state, old);
 
 	if (state)
-		pm_runtime_put_sync_suspend(port->dev);
+		if (!pm_runtime_put_sync_suspend(port->dev))
+			mtk8250_runtime_suspend(port->dev);
 }
 
 #ifdef CONFIG_SERIAL_8250_DMA
@@ -499,6 +511,8 @@ static int mtk8250_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->clk_count = 0;
+
 	if (pdev->dev.of_node) {
 		err = mtk8250_probe_of(pdev, &uart.port, data);
 		if (err)
@@ -531,6 +545,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
+	pm_runtime_enable(&pdev->dev);
 	err = mtk8250_runtime_resume(&pdev->dev);
 	if (err)
 		return err;
@@ -539,9 +554,6 @@ static int mtk8250_probe(struct platform_device *pdev)
 	if (data->line < 0)
 		return data->line;
 
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
 	return 0;
 }
 
@@ -552,11 +564,13 @@ static int mtk8250_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	serial8250_unregister_port(data->line);
-	mtk8250_runtime_suspend(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		mtk8250_runtime_suspend(&pdev->dev);
+
 	return 0;
 }
 
-- 
1.8.1.1.dirty

