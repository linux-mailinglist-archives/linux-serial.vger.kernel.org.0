Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74982178F7E
	for <lists+linux-serial@lfdr.de>; Wed,  4 Mar 2020 12:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgCDLWZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 4 Mar 2020 06:22:25 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:4424 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbgCDLWZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Mar 2020 06:22:25 -0500
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Mar 2020 16:52:22 +0530
Received: from c-rojay-linux.qualcomm.com ([10.206.21.80])
  by ironmsg02-blr.qualcomm.com with ESMTP; 04 Mar 2020 16:52:07 +0530
Received: by c-rojay-linux.qualcomm.com (Postfix, from userid 88981)
        id 387A71753; Wed,  4 Mar 2020 16:52:06 +0530 (IST)
From:   Roja Rani Yarubandi <rojay@codeaurora.org>
To:     gregkh@linuxfoundation.org
Cc:     swboyd@chromium.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        akashast@codeaurora.org, rojay@codeaurora.org,
        msavaliy@qti.qualcomm.com
Subject: [PATCH V4] tty: serial: qcom_geni_serial: Fix GPIO swapping with workaround
Date:   Wed,  4 Mar 2020 16:52:03 +0530
Message-Id: <20200304112203.408-1-rojay@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add capability to support RX-TX, CTS-RTS pins swap in HW.

Configure UART_IO_MACRO_CTRL register accordingly if RX-TX pair
or CTS-RTS pair or both pairs swapped.

Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
---
Changes in V2:
- As per Greg's comment removed the change id.

Changes in V3:
- As per Bjorn's comment using of_property_read_bool() to read dtsi entries.
- As per Matthias's comment add capability to support individual pairs swap,
  that is, only RX-TX swap and only CTS-RTS swap cases.

Changes in V4:
- As per Matthias's comment changed IO_MACRO_IO0_SEL definition.

 drivers/tty/serial/qcom_geni_serial.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 191abb18fc2a..34d7aaf163bd 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -21,6 +21,7 @@
 
 /* UART specific GENI registers */
 #define SE_UART_LOOPBACK_CFG		0x22c
+#define SE_UART_IO_MACRO_CTRL		0x240
 #define SE_UART_TX_TRANS_CFG		0x25c
 #define SE_UART_TX_WORD_LEN		0x268
 #define SE_UART_TX_STOP_BIT_LEN		0x26c
@@ -95,6 +96,12 @@
 #define CTS_RTS_SORTED	BIT(1)
 #define RX_TX_CTS_RTS_SORTED	(RX_TX_SORTED | CTS_RTS_SORTED)
 
+/* UART pin swap value */
+#define DEFAULT_IO_MACRO_IO0_IO1_MASK		GENMASK(3, 0)
+#define IO_MACRO_IO0_SEL		0x3
+#define DEFAULT_IO_MACRO_IO2_IO3_MASK		GENMASK(15, 4)
+#define IO_MACRO_IO2_IO3_SWAP		0x4640
+
 #ifdef CONFIG_CONSOLE_POLL
 #define CONSOLE_RX_BYTES_PW 1
 #else
@@ -119,6 +126,8 @@ struct qcom_geni_serial_port {
 
 	unsigned int tx_remaining;
 	int wakeup_irq;
+	bool rx_tx_swap;
+	bool cts_rts_swap;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -826,6 +835,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	u32 rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
 	u32 proto;
+	u32 pin_swap;
 
 	if (uart_console(uport)) {
 		port->tx_bytes_pw = 1;
@@ -846,6 +856,20 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	get_tx_fifo_size(port);
 
 	writel(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
+
+	pin_swap = readl(uport->membase + SE_UART_IO_MACRO_CTRL);
+	if (port->rx_tx_swap) {
+		pin_swap &= ~DEFAULT_IO_MACRO_IO2_IO3_MASK;
+		pin_swap |= IO_MACRO_IO2_IO3_SWAP;
+	}
+	if (port->cts_rts_swap) {
+		pin_swap &= ~DEFAULT_IO_MACRO_IO0_IO1_MASK;
+		pin_swap |= IO_MACRO_IO0_SEL;
+	}
+	/* Configure this register if RX-TX, CTS-RTS pins are swapped */
+	if (port->rx_tx_swap || port->cts_rts_swap)
+		writel(pin_swap, uport->membase + SE_UART_IO_MACRO_CTRL);
+
 	/*
 	 * Make an unconditional cancel on the main sequencer to reset
 	 * it else we could end up in data loss scenarios.
@@ -1289,6 +1313,12 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (!console)
 		port->wakeup_irq = platform_get_irq_optional(pdev, 1);
 
+	if (of_property_read_bool(pdev->dev.of_node, "rx-tx-swap"))
+		port->rx_tx_swap = true;
+
+	if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
+		port->cts_rts_swap = true;
+
 	uport->private_data = drv;
 	platform_set_drvdata(pdev, port);
 	port->handle_rx = console ? handle_rx_console : handle_rx_uart;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

