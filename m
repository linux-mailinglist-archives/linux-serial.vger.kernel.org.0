Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8002B5F656
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfGDKJa (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 06:09:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47178 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfGDKJ3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 06:09:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 12F8F2005AE;
        Thu,  4 Jul 2019 12:09:27 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E9F02005A9;
        Thu,  4 Jul 2019 12:09:23 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C58CA402E5;
        Thu,  4 Jul 2019 18:09:18 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jslaby@suse.com, fugang.duan@nxp.com,
        u.kleine-koenig@pengutronix.de, daniel.baluta@nxp.com
Subject: [PATCH tty/serial 1/2] tty: serial: fsl_lpuart: add imx8qxp support
Date:   Thu,  4 Jul 2019 18:00:20 +0800
Message-Id: <20190704100021.10859-2-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190704100021.10859-1-fugang.duan@nxp.com>
References: <20190704100021.10859-1-fugang.duan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

The lpuart of imx8ulp is basically the same as imx7ulp, but it
has new feature support based on imx7ulp, like it can assert a
DMA request on EOP(end-of-packet). imx8ulp lpuart use two clocks,
one is ipg bus clock that is used to access registers, the other
is baud clock that is used to transmit-receive data.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 106 ++++++++++++++++++++++++++++++++--------
 1 file changed, 86 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 2f24d97..92dad2b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -234,9 +234,18 @@
 
 static DEFINE_IDA(fsl_lpuart_ida);
 
+enum lpuart_type {
+	VF610_LPUART,
+	LS1021A_LPUART,
+	IMX7ULP_LPUART,
+	IMX8QXP_LPUART,
+};
+
 struct lpuart_port {
 	struct uart_port	port;
-	struct clk		*clk;
+	enum lpuart_type	devtype;
+	struct clk		*ipg_clk;
+	struct clk		*baud_clk;
 	unsigned int		txfifo_size;
 	unsigned int		rxfifo_size;
 
@@ -261,19 +270,29 @@ struct lpuart_port {
 };
 
 struct lpuart_soc_data {
-	char	iotype;
-	u8	reg_off;
+	enum lpuart_type devtype;
+	char iotype;
+	u8 reg_off;
 };
 
 static const struct lpuart_soc_data vf_data = {
+	.devtype = VF610_LPUART,
 	.iotype = UPIO_MEM,
 };
 
 static const struct lpuart_soc_data ls_data = {
+	.devtype = LS1021A_LPUART,
 	.iotype = UPIO_MEM32BE,
 };
 
-static struct lpuart_soc_data imx_data = {
+static struct lpuart_soc_data imx7ulp_data = {
+	.devtype = IMX7ULP_LPUART,
+	.iotype = UPIO_MEM32,
+	.reg_off = IMX_REG_OFF,
+};
+
+static struct lpuart_soc_data imx8qxp_data = {
+	.devtype = IMX8QXP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
 };
@@ -281,7 +300,8 @@ static struct lpuart_soc_data imx_data = {
 static const struct of_device_id lpuart_dt_ids[] = {
 	{ .compatible = "fsl,vf610-lpuart",	.data = &vf_data, },
 	{ .compatible = "fsl,ls1021a-lpuart",	.data = &ls_data, },
-	{ .compatible = "fsl,imx7ulp-lpuart",	.data = &imx_data, },
+	{ .compatible = "fsl,imx7ulp-lpuart",	.data = &imx7ulp_data, },
+	{ .compatible = "fsl,imx8qxp-lpuart",	.data = &imx8qxp_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
@@ -289,6 +309,11 @@ MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
 /* Forward declare this for the dma callbacks*/
 static void lpuart_dma_tx_complete(void *arg);
 
+static inline bool is_imx8qxp_lpuart(struct lpuart_port *sport)
+{
+	return sport->devtype == IMX8QXP_LPUART;
+}
+
 static inline u32 lpuart32_read(struct uart_port *port, u32 off)
 {
 	switch (port->iotype) {
@@ -314,6 +339,39 @@ static inline void lpuart32_write(struct uart_port *port, u32 val,
 	}
 }
 
+static int __lpuart_enable_clks(struct lpuart_port *sport, bool is_en)
+{
+	int ret = 0;
+
+	if (is_en) {
+		ret = clk_prepare_enable(sport->ipg_clk);
+		if (ret)
+			return ret;
+
+		ret = clk_prepare_enable(sport->baud_clk);
+		if (ret) {
+			clk_disable_unprepare(sport->ipg_clk);
+			return ret;
+		}
+	} else {
+		clk_disable_unprepare(sport->baud_clk);
+		clk_disable_unprepare(sport->ipg_clk);
+	}
+
+	return 0;
+}
+
+static unsigned int lpuart_get_baud_clk_rate(struct lpuart_port *sport)
+{
+	if (is_imx8qxp_lpuart(sport))
+		return clk_get_rate(sport->baud_clk);
+
+	return clk_get_rate(sport->ipg_clk);
+}
+
+#define lpuart_enable_clks(x)	__lpuart_enable_clks(x, true)
+#define lpuart_disable_clks(x)	__lpuart_enable_clks(x, false)
+
 static void lpuart_stop_tx(struct uart_port *port)
 {
 	unsigned char temp;
@@ -2069,7 +2127,7 @@ lpuart_console_get_options(struct lpuart_port *sport, int *baud,
 	brfa = readb(sport->port.membase + UARTCR4);
 	brfa &= UARTCR4_BRFA_MASK;
 
-	uartclk = clk_get_rate(sport->clk);
+	uartclk = lpuart_get_baud_clk_rate(sport);
 	/*
 	 * baud = mod_clk/(16*(sbr[13]+(brfa)/32)
 	 */
@@ -2112,7 +2170,7 @@ lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
 	bd = lpuart32_read(&sport->port, UARTBAUD);
 	bd &= UARTBAUD_SBR_MASK;
 	sbr = bd;
-	uartclk = clk_get_rate(sport->clk);
+	uartclk = lpuart_get_baud_clk_rate(sport);
 	/*
 	 * baud = mod_clk/(16*(sbr[13]+(brfa)/32)
 	 */
@@ -2286,6 +2344,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->port.mapbase = res->start;
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
+	sport->devtype = sdata->devtype;
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cannot obtain irq\n");
@@ -2301,20 +2360,27 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	sport->port.rs485_config = lpuart_config_rs485;
 
-	sport->clk = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(sport->clk)) {
-		ret = PTR_ERR(sport->clk);
-		dev_err(&pdev->dev, "failed to get uart clk: %d\n", ret);
+	sport->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(sport->ipg_clk)) {
+		ret = PTR_ERR(sport->ipg_clk);
+		dev_err(&pdev->dev, "failed to get uart ipg clk: %d\n", ret);
 		return ret;
 	}
 
-	ret = clk_prepare_enable(sport->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable uart clk: %d\n", ret);
-		return ret;
+	sport->baud_clk = NULL;
+	if (is_imx8qxp_lpuart(sport)) {
+		sport->baud_clk = devm_clk_get(&pdev->dev, "baud");
+		if (IS_ERR(sport->baud_clk)) {
+			ret = PTR_ERR(sport->baud_clk);
+			dev_err(&pdev->dev, "failed to get uart baud clk: %d\n", ret);
+			return ret;
+		}
 	}
 
-	sport->port.uartclk = clk_get_rate(sport->clk);
+	ret = lpuart_enable_clks(sport);
+	if (ret)
+		return ret;
+	sport->port.uartclk = lpuart_get_baud_clk_rate(sport);
 
 	lpuart_ports[sport->port.line] = sport;
 
@@ -2362,7 +2428,7 @@ static int lpuart_probe(struct platform_device *pdev)
 
 failed_attach_port:
 failed_irq_request:
-	clk_disable_unprepare(sport->clk);
+	lpuart_disable_clks(sport);
 	return ret;
 }
 
@@ -2374,7 +2440,7 @@ static int lpuart_remove(struct platform_device *pdev)
 
 	ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
 
-	clk_disable_unprepare(sport->clk);
+	lpuart_disable_clks(sport);
 
 	if (sport->dma_tx_chan)
 		dma_release_channel(sport->dma_tx_chan);
@@ -2439,7 +2505,7 @@ static int lpuart_suspend(struct device *dev)
 	}
 
 	if (sport->port.suspended && !irq_wake)
-		clk_disable_unprepare(sport->clk);
+		lpuart_disable_clks(sport);
 
 	return 0;
 }
@@ -2451,7 +2517,7 @@ static int lpuart_resume(struct device *dev)
 	unsigned long temp;
 
 	if (sport->port.suspended && !irq_wake)
-		clk_prepare_enable(sport->clk);
+		lpuart_enable_clks(sport);
 
 	if (lpuart_is_32(sport)) {
 		lpuart32_setup_watermark(sport);
-- 
2.7.4

