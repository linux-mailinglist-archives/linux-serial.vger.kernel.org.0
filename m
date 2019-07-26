Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328E975D1E
	for <lists+linux-serial@lfdr.de>; Fri, 26 Jul 2019 04:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfGZCk4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 25 Jul 2019 22:40:56 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:52708 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbfGZCk4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jul 2019 22:40:56 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6Q2Zi0Q029142;
        Thu, 25 Jul 2019 21:40:54 -0500
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2tx62hje49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jul 2019 21:40:54 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (us-aus-exhub1.ni.corp.natinst.com [130.164.68.41])
        by us-aus-skprod2.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x6Q2eroc019985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 25 Jul 2019 21:40:53 -0500
Received: from us-aus-exch3.ni.corp.natinst.com (130.164.68.13) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 25 Jul 2019 21:40:53 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch3.ni.corp.natinst.com (130.164.68.13) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 25 Jul 2019 21:40:53 -0500
Received: from my-pen-rd9.apac.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Thu, 25 Jul 2019 21:40:52 -0500
From:   jeyentam <je.yen.tam@ni.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jeyentam <je.yen.tam@ni.com>
Subject: [PATCH v5] serial/8250: Add support for NI-Serial PXI/PXIe+485 devices
Date:   Fri, 26 Jul 2019 10:40:46 +0800
Message-ID: <20190726024046.5873-1-je.yen.tam@ni.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_01:2019-07-26,2019-07-26 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.

Signed-off-by: jeyentam <je.yen.tam@ni.com>
---

v4 -> v5
- Remove blank lines between variable definitions.
- Remove trace_printk().

v3 -> v4:
- Add changes description.

v2 -> v3:
- Add "full" name for author
- Use BIT() macro for bits definition
- Remove unnecessary WARN_ON()
- Change debugging interface to ftrace
- Fix indentation
- Add NI PXIe-RS232 and PXI/PXIe-RS485 device IDs #defines

v1 -> v2:
- Fix unintended indentation

v1:
- Add and rename #defines for 16550 UART Port Control Register
- Add configuration for RS485 port.
- Add device setup for NI PXI/PXIe-RS485 family.
- Add PCI board attributes for NI PXIe-RS232 and PXI/PXIe-RS485 devices.

 drivers/tty/serial/8250/8250_pci.c | 292 ++++++++++++++++++++++++++++-
 1 file changed, 288 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index df41397de478..a675069571b2 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -730,8 +730,16 @@ static int pci_ni8430_init(struct pci_dev *dev)
 }
 
 /* UART Port Control Register */
-#define NI8430_PORTCON	0x0f
-#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
+#define NI16550_PCR_OFFSET	0x0f
+#define NI16550_PCR_RS422	0x00
+#define NI16550_PCR_ECHO_RS485	0x01
+#define NI16550_PCR_DTR_RS485	0x02
+#define NI16550_PCR_AUTO_RS485	0x03
+#define NI16550_PCR_WIRE_MODE_MASK	0x03
+#define NI16550_PCR_TXVR_ENABLE_BIT	BIT(3)
+#define NI16550_PCR_RS485_TERMINATION_BIT	BIT(6)
+#define NI16550_ACR_DTR_AUTO_DTR	(0x2 << 3)
+#define NI16550_ACR_DTR_MANUAL_DTR	(0x0 << 3)
 
 static int
 pci_ni8430_setup(struct serial_private *priv,
@@ -753,14 +761,117 @@ pci_ni8430_setup(struct serial_private *priv,
 		return -ENOMEM;
 
 	/* enable the transceiver */
-	writeb(readb(p + offset + NI8430_PORTCON) | NI8430_PORTCON_TXVR_ENABLE,
-	       p + offset + NI8430_PORTCON);
+	writeb(readb(p + offset + NI16550_PCR_OFFSET) | NI16550_PCR_TXVR_ENABLE_BIT,
+	       p + offset + NI16550_PCR_OFFSET);
 
 	iounmap(p);
 
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
+static int pci_ni8431_config_rs485(struct uart_port *port,
+	struct serial_rs485 *rs485)
+{
+	u8 pcr, acr;
+	struct uart_8250_port *up;
+
+	up = container_of(port, struct uart_8250_port, port);
+	acr = up->acr;
+	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* RS-485 */
+		if ((rs485->flags & SER_RS485_RX_DURING_TX) &&
+			(rs485->flags & SER_RS485_RTS_ON_SEND)) {
+			dev_dbg(port->dev, "Invalid 2-wire mode\n");
+			return -EINVAL;
+		}
+
+		if (rs485->flags & SER_RS485_RX_DURING_TX) {
+			/* Echo */
+			dev_vdbg(port->dev, "2-wire DTR with echo\n");
+			pcr |= NI16550_PCR_ECHO_RS485;
+			acr |= NI16550_ACR_DTR_MANUAL_DTR;
+		} else {
+			/* Auto or DTR */
+			if (rs485->flags & SER_RS485_RTS_ON_SEND) {
+				/* Auto */
+				dev_vdbg(port->dev, "2-wire Auto\n");
+				pcr |= NI16550_PCR_AUTO_RS485;
+				acr |= NI16550_ACR_DTR_AUTO_DTR;
+			} else {
+				/* DTR-controlled */
+				/* No Echo */
+				dev_vdbg(port->dev, "2-wire DTR no echo\n");
+				pcr |= NI16550_PCR_DTR_RS485;
+				acr |= NI16550_ACR_DTR_MANUAL_DTR;
+			}
+		}
+	} else {
+		/* RS-422 */
+		dev_vdbg(port->dev, "4-wire\n");
+		pcr |= NI16550_PCR_RS422;
+		acr |= NI16550_ACR_DTR_MANUAL_DTR;
+	}
+
+	dev_dbg(port->dev, "write pcr: 0x%08x\n", pcr);
+	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
+
+	up->acr = acr;
+	port->serial_out(port, UART_SCR, UART_ACR);
+	port->serial_out(port, UART_ICR, up->acr);
+
+	/* Update the cache. */
+	port->rs485 = *rs485;
+
+	return 0;
+}
+
+static int pci_ni8431_setup(struct serial_private *priv,
+		 const struct pciserial_board *board,
+		 struct uart_8250_port *uart, int idx)
+{
+	u8 pcr, acr;
+	struct pci_dev *dev = priv->dev;
+	void __iomem *addr;
+	unsigned int bar, offset = board->first_offset;
+
+	if (idx >= board->num_ports)
+		return 1;
+
+	bar = FL_GET_BASE(board->flags);
+	offset += idx * board->uart_offset;
+
+	addr = pci_ioremap_bar(dev, bar);
+	if (!addr)
+		return -ENOMEM;
+
+	/* enable the transceiver */
+	writeb(readb(addr + NI16550_PCR_OFFSET) | NI16550_PCR_TXVR_ENABLE_BIT,
+		addr + NI16550_PCR_OFFSET);
+
+	pcr = readb(addr + NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
+
+	/* set wire mode to default RS-422 */
+	pcr |= NI16550_PCR_RS422;
+	acr = NI16550_ACR_DTR_MANUAL_DTR;
+
+	/* write port configuration to register */
+	writeb(pcr, addr + NI16550_PCR_OFFSET);
+
+	/* access and write to UART acr register */
+	writeb(UART_ACR, addr + UART_SCR);
+	writeb(acr, addr + UART_ICR);
+
+	uart->port.rs485_config = &pci_ni8431_config_rs485;
+
+	iounmap(addr);
+
+	return setup_port(priv, uart, bar, offset, board->reg_shift);
+}
+
 static int pci_netmos_9900_setup(struct serial_private *priv,
 				const struct pciserial_board *board,
 				struct uart_8250_port *port, int idx)
@@ -1731,6 +1842,15 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_ACCESIO_PCIE_COM_8SM	0x10E9
 #define PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4SM	0x11D8
 
+#define PCIE_DEVICE_ID_NI_PXIE8430_2328	0x74C2
+#define PCIE_DEVICE_ID_NI_PXIE8430_23216	0x74C1
+#define PCI_DEVICE_ID_NI_PXI8431_4852	0x7081
+#define PCI_DEVICE_ID_NI_PXI8431_4854	0x70DE
+#define PCI_DEVICE_ID_NI_PXI8431_4858	0x70E3
+#define PCI_DEVICE_ID_NI_PXI8433_4852	0x70E9
+#define PCI_DEVICE_ID_NI_PXI8433_4854	0x70ED
+#define PCIE_DEVICE_ID_NI_PXIE8431_4858	0x74C4
+#define PCIE_DEVICE_ID_NI_PXIE8431_48516	0x74C3
 
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
@@ -1956,6 +2076,87 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_ni8430_setup,
 		.exit		= pci_ni8430_exit,
 	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCIE_DEVICE_ID_NI_PXIE8430_2328,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8430_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCIE_DEVICE_ID_NI_PXIE8430_23216,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8430_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCI_DEVICE_ID_NI_PXI8431_4852,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCI_DEVICE_ID_NI_PXI8431_4854,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCI_DEVICE_ID_NI_PXI8431_4858,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCI_DEVICE_ID_NI_PXI8433_4852,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCI_DEVICE_ID_NI_PXI8433_4854,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCIE_DEVICE_ID_NI_PXIE8431_4858,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCIE_DEVICE_ID_NI_PXIE8431_48516,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
 	/* Quatech */
 	{
 		.vendor		= PCI_VENDOR_ID_QUATECH,
@@ -2679,6 +2880,13 @@ enum pci_board_num_t {
 	pbn_ni8430_4,
 	pbn_ni8430_8,
 	pbn_ni8430_16,
+	pbn_ni8430_pxie_8,
+	pbn_ni8430_pxie_16,
+	pbn_ni8431_2,
+	pbn_ni8431_4,
+	pbn_ni8431_8,
+	pbn_ni8431_pxie_8,
+	pbn_ni8431_pxie_16,
 	pbn_ADDIDATA_PCIe_1_3906250,
 	pbn_ADDIDATA_PCIe_2_3906250,
 	pbn_ADDIDATA_PCIe_4_3906250,
@@ -3320,6 +3528,55 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset	= 0x10,
 		.first_offset	= 0x800,
 	},
+	[pbn_ni8430_pxie_16] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 16,
+		.base_baud	= 3125000,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8430_pxie_8] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 3125000,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8431_8] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 3686400,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8431_4] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 4,
+		.base_baud	= 3686400,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8431_2] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 2,
+		.base_baud	= 3686400,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8431_pxie_16] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 16,
+		.base_baud	= 3125000,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8431_pxie_8] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 3125000,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
 	/*
 	 * ADDI-DATA GmbH PCI-Express communication cards <info@addi-data.com>
 	 */
@@ -5003,6 +5260,33 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8432_2324,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_ni8430_4 },
+	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8430_2328,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_pxie_8 },
+	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8430_23216,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_pxie_16 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8431_4852,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_2 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8431_4854,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_4 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8431_4858,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_8 },
+	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8431_4858,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_pxie_8 },
+	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8431_48516,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_pxie_16 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8433_4852,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_2 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8433_4854,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_4 },
 
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
-- 
2.17.1

