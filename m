Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B355672D6F
	for <lists+linux-serial@lfdr.de>; Wed, 24 Jul 2019 13:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfGXL1A (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 24 Jul 2019 07:27:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44889 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGXL1A (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Jul 2019 07:27:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so20784255pfe.11
        for <linux-serial@vger.kernel.org>; Wed, 24 Jul 2019 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FoqBTgs4AkNjzSs+5n95Gopb34h0GfFFpK1n3P9zUZQ=;
        b=bK7aqyWVYcE8yqhGUqeago+quwlcTG6ZWABm4/DYjIDEjsQHQuye9ct5NXICYY/u9z
         Dr80hg2Bk7lid7kcBxLoJEtYi89aMGc8Oy9QFuPse/IxHw7aLIQ3a3LAIZmP03jEYjXl
         ss6jdDdusdUd+SkAGgem+aWgVJHZH4hn9wck2xerXofQ9l2usWo0egdsCGthquX9khvb
         UiJB7l4tW6iPlUeTsAzmCt1hXnrCJsax74rTuLWPNezAAoU6hGbenSwUJ1rDT0LDNYIQ
         ABvgu8DywxcZWhXCreR9I5Rohex5DROUGPbOeCdrAzm8tNWSqk+RDkfJIlyBC0o9aL6O
         FSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FoqBTgs4AkNjzSs+5n95Gopb34h0GfFFpK1n3P9zUZQ=;
        b=efD0k9km5uijPFSM2zZJR9wFAEX8Fnqct43bAqySVFDWXo9ujdPvjYN0tu2AlOrTwW
         RvR+1hX/GR2JsTwEC6nEx+eks2WXhZV/uylR+xBBZLQrJleeqCEX2nkjjeFpj0NBVjtl
         7kPO6qUe8EHwN6U6r1hQ7vIFlM1pO4po8OC7tNcKfLaCnmZWKaHbKbWQgfEY/H7GvTzL
         VSRq429gG8XEyrWwd6ctOkQFJxG7Aib2JjtvubU2QsZzT1x3D1TH0HltVf6aATEznMbf
         oD+h9hxV5A2U1CvJ4jaamH4mRPUBZ+v+MRTraUwQ7c5lHCJwEAvw0u5H+5wj5v4J6uQJ
         Jz8Q==
X-Gm-Message-State: APjAAAXn7GcpYa0tWx1vQHht8uwTQyQP5koSqnpfz2P5wjoiUUC0w+0M
        daHP6cdTx+vRgFBMc6Vdur8UzcbQ
X-Google-Smtp-Source: APXvYqylrCSaCdCBbbdy/frB2Pyg6LAKIUiFhvXQjVbODRZKfdqmB7Q/a/RkBZIFBMzAZS3xVoadtw==
X-Received: by 2002:a17:90a:c596:: with SMTP id l22mr49933002pjt.46.1563967619100;
        Wed, 24 Jul 2019 04:26:59 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (114-36-237-209.dynamic-ip.hinet.net. [114.36.237.209])
        by smtp.gmail.com with ESMTPSA id p20sm31132228pgi.81.2019.07.24.04.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 04:26:58 -0700 (PDT)
From:   morrisku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, morris_ku@sunix.com,
        morrisku <saumah@gmail.com>
Subject: [PATCH] Add driver for SUNIX serial board
Date:   Wed, 24 Jul 2019 19:26:47 +0800
Message-Id: <20190724112647.4177-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch add support for SUNIX serial board.

Signed-off-by: morrisku <saumah@gmail.com>
---
 serial/Kconfig      |  11 ++
 serial/Makefile     |   1 +
 serial/sunix_uart.c | 357 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 369 insertions(+)
 create mode 100644 serial/sunix_uart.c

diff --git a/serial/Kconfig b/serial/Kconfig
index 0d31251..f9ae108 100644
--- a/serial/Kconfig
+++ b/serial/Kconfig
@@ -1618,6 +1618,17 @@ config SERIAL_MILBEAUT_USIO_PORTS
 	depends on SERIAL_MILBEAUT_USIO
 	default "4"
 
+config SERIAL_SUNIX
+	tristate "SUNIX pci serial port support"
+	depends on SERIAL_8250
+	select SERIAL_CORE
+	help
+	  Say Y here if you have a SUNIX serial card.
+	  If unsure, say N.
+
+	  This driver can also be built as a module. The module will be called
+	  sunix_pci_serial. If you want to do that, say M here.
+
 config SERIAL_MILBEAUT_USIO_CONSOLE
 	bool "Support for console on MILBEAUT USIO/UART serial port"
 	depends on SERIAL_MILBEAUT_USIO=y
diff --git a/serial/Makefile b/serial/Makefile
index 79c3d51..cecccc6 100644
--- a/serial/Makefile
+++ b/serial/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
 obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
 obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
 obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
+obj-$(CONFIG_SERIAL_SUNIX)	+= sunix_uart.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/serial/sunix_uart.c b/serial/sunix_uart.c
new file mode 100644
index 0000000..d227d7a
--- /dev/null
+++ b/serial/sunix_uart.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *	Driver for SUNIX PCI serial board
+ *	Based on drivers/tty/serial/8250/8250_pci.c
+ *	by Linus Torvalds, Theodore Ts'o.
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License.
+ */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/tty.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+#include <linux/serial_core.h>
+#include <linux/8250_pci.h>
+#include <linux/bitops.h>
+#include <linux/dmaengine.h>
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+
+
+struct sunix_pci_board {
+	kernel_ulong_t driver_data;
+	struct pci_dev *pdev;
+	unsigned int num_ports;
+	int line[0];
+};
+
+
+enum {
+	sunix_pci_1s = 0,
+	sunix_pci_2s,
+	sunix_pci_4s,
+	sunix_pci_8s,
+	sunix_pci_16s
+};
+
+
+static struct sunix_pci_board sunix_pci_boards[] = {
+	[sunix_pci_1s] = {.num_ports = 1},
+	[sunix_pci_2s] = {.num_ports = 2},
+	[sunix_pci_4s] = {.num_ports = 4},
+	[sunix_pci_8s] = {.num_ports = 8},
+	[sunix_pci_16s] = {.num_ports = 16},
+};
+
+
+struct sunix_pci_board *snx_init_ports(struct pci_dev *pdev,
+				kernel_ulong_t driver_data)
+{
+	struct uart_8250_port uart;
+	struct sunix_pci_board *board;
+	unsigned int num_ports;
+	int i, bar, offset;
+
+	num_ports = sunix_pci_boards[driver_data].num_ports;
+
+	board = kzalloc(sizeof(struct sunix_pci_board) +
+			sizeof(unsigned int) * num_ports, GFP_KERNEL);
+	if (!board) {
+		board = ERR_PTR(-ENOMEM);
+		goto err_out;
+	}
+
+	board->driver_data = driver_data;
+	board->pdev = pdev;
+	board->num_ports = num_ports;
+
+	memset(&uart, 0, sizeof(uart));
+	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF |
+					UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+	uart.port.uartclk = 921600 * 16;
+	uart.port.irq = pdev->irq;
+	uart.port.dev = &pdev->dev;
+	uart.port.type = PORT_16C950;
+	uart.port.fifosize = 128;
+
+	for (i = 0; i < num_ports; i++) {
+
+		switch (i) {
+		case 0:
+			bar = 0; offset = 0; break;
+		case 1:
+			bar = 0; offset = 8; break;
+		case 2:
+			bar = 0; offset = 16; break;
+		case 3:
+			bar = 0; offset = 24; break;
+		case 4:
+			bar = 1; offset = 0; break;
+		case 5:
+			bar = 1; offset = 8; break;
+		case 6:
+			bar = 1; offset = 16; break;
+		case 7:
+			bar = 1; offset = 24; break;
+		case 8:
+			bar = 1; offset = 64; break;
+		case 9:
+			bar = 1; offset = 72; break;
+		case 10:
+			bar = 1; offset = 80; break;
+		case 11:
+			bar = 1; offset = 88; break;
+		case 12:
+			bar = 1; offset = 128; break;
+		case 13:
+			bar = 1; offset = 136; break;
+		case 14:
+			bar = 1; offset = 144; break;
+		case 15:
+			bar = 1; offset = 152; break;
+		}
+
+		uart.port.iotype = UPIO_PORT;
+		uart.port.iobase = pci_resource_start(pdev, bar) + offset;
+		uart.port.mapbase = 0;
+		uart.port.membase = NULL;
+		uart.port.regshift = 0;
+
+		board->line[i] = serial8250_register_8250_port(&uart);
+		if (board->line[i] < 0) {
+			printk(KERN_INFO "sunix_pci_serial : Couldn't register serial port %s: %d\n",
+			pci_name(pdev), board->line[i]);
+			break;
+		}
+	}
+
+	return board;
+
+err_out:
+	return board;
+}
+
+
+void snx_detach_ports(struct sunix_pci_board *board)
+{
+
+	int i;
+
+	for (i = 0; i < board->num_ports; i++)
+		serial8250_unregister_port(board->line[i]);
+}
+
+
+void snx_remove_ports(struct sunix_pci_board *board)
+{
+	snx_detach_ports(board);
+	kfree(board);
+}
+
+
+void snx_suspend_ports(struct sunix_pci_board *board)
+{
+	int i;
+
+	for (i = 0; i < board->num_ports; i++) {
+		if (board->line[i] >= 0)
+			serial8250_suspend_port(board->line[i]);
+
+	}
+}
+
+
+void snx_resume_ports(struct sunix_pci_board *board)
+{
+
+	int i;
+
+	for (i = 0; i < board->num_ports; i++) {
+		if (board->line[i] >= 0)
+			serial8250_resume_port(board->line[i]);
+	}
+}
+
+
+#ifdef CONFIG_PM_SLEEP
+static int snx_suspend_one(struct device *dev)
+{
+
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct sunix_pci_board *board = pci_get_drvdata(pdev);
+
+	if (board)
+		snx_suspend_ports(board);
+
+	return  0;
+}
+
+
+static int snx_resume_one(struct device *dev)
+{
+
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct sunix_pci_board *board = pci_get_drvdata(pdev);
+	int err;
+
+	if (board) {
+		err = pci_enable_device(pdev);
+		if (err)
+			printk(KERN_INFO "sunix_pci_serial : Unable to re-enable ports\n");
+
+		snx_resume_ports(board);
+	}
+
+	return 0;
+}
+#endif
+
+
+static pci_ers_result_t snx_err_io_error_detected(struct pci_dev *pdev,
+		pci_channel_state_t state)
+{
+
+	struct sunix_pci_board *board = pci_get_drvdata(pdev);
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	if (board)
+		snx_detach_ports(board);
+
+	pci_disable_device(pdev);
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+
+static pci_ers_result_t snx_err_io_slot_reset(struct pci_dev *pdev)
+{
+
+	int rc;
+
+	rc = pci_enable_device(pdev);
+	if (rc)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	pci_restore_state(pdev);
+	pci_save_state(pdev);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+
+static void snx_err_io_resume(struct pci_dev *pdev)
+{
+	struct sunix_pci_board *board = pci_get_drvdata(pdev);
+	struct sunix_pci_board *new;
+
+	if (!board)
+		return;
+
+	new = snx_init_ports(pdev, board->driver_data);
+	if (!IS_ERR(new)) {
+		pci_set_drvdata(pdev, new);
+		kfree(board);
+	}
+}
+
+
+static int sunix_pci_serial_init_one(struct pci_dev *pdev,
+			const struct pci_device_id *ent)
+{
+
+	struct sunix_pci_board *board;
+	int rc;
+
+	if (ent->driver_data >= ARRAY_SIZE(sunix_pci_boards)) {
+		printk(KERN_INFO "sunix_pci_serial : Invalid driver_data:%ld\n",
+							ent->driver_data);
+		return -EINVAL;
+	}
+
+	rc = pci_enable_device(pdev);
+	pci_save_state(pdev);
+
+	if (rc)
+		return rc;
+
+	board = snx_init_ports(pdev, ent->driver_data);
+	if (IS_ERR(board)) {
+		rc = PTR_ERR(board);
+		return rc;
+	}
+
+	pci_set_drvdata(pdev, board);
+	return 0;
+}
+
+
+static void sunix_pci_serial_remove_one(struct pci_dev *pdev)
+{
+
+	struct sunix_pci_board *board = pci_get_drvdata(pdev);
+
+	snx_remove_ports(board);
+}
+
+
+static SIMPLE_DEV_PM_OPS(sunix_pci_serial_pm_ops,
+				snx_suspend_one, snx_resume_one);
+
+
+static struct pci_device_id sunix_pci_serial_id_tbl[] = {
+	// 5027A - 1S
+	{ 0x1fd4, 0x1999, 0x1fd4, 0x0001, 0, 0, sunix_pci_1s },
+	// 5037A,P2102,CDK1037,DIO0802 - 2S
+	{ 0x1fd4, 0x1999, 0x1fd4, 0x0002, 0, 0, sunix_pci_2s },
+	// 5056A,P2104,CDK1056,DIO1604,DIO3204 - 4S
+	{ 0x1fd4, 0x1999, 0x1fd4, 0x0004, 0, 0, sunix_pci_4s },
+	// P3104 - 4S
+	{ 0x1fd4, 0x1999, 0x1fd4, 0x0084, 0, 0, sunix_pci_4s },
+	// 5066A,P2108 - 8S
+	{ 0x1fd4, 0x1999, 0x1fd4, 0x0008, 0, 0, sunix_pci_8s },
+	// P3108 - 8S
+	{ 0x1fd4, 0x1999, 0x1fd4, 0x0088, 0, 0, sunix_pci_8s },
+	// 5016A,P2116 - 16S
+	{ 0x1fd4, 0x1999, 0x1fd4, 0x0010, 0, 0, sunix_pci_16s },
+	//
+	{0}
+};
+MODULE_DEVICE_TABLE(pci, sunix_pci_serial_id_tbl);
+
+
+static const struct pci_error_handlers sunix_pci_serial_err_handler = {
+	.error_detected = snx_err_io_error_detected,
+	.slot_reset		= snx_err_io_slot_reset,
+	.resume			= snx_err_io_resume,
+};
+
+
+static struct pci_driver sunix_pci_serial_driver = {
+	.name			= "sunix_pci_serial",
+	.probe			= sunix_pci_serial_init_one,
+	.remove			= sunix_pci_serial_remove_one,
+	.driver			= {
+		.pm			= &sunix_pci_serial_pm_ops,
+	},
+	.id_table		= sunix_pci_serial_id_tbl,
+	.err_handler	= &sunix_pci_serial_err_handler,
+};
+
+
+module_pci_driver(sunix_pci_serial_driver);
+
+MODULE_AUTHOR("SUNIX Co., Ltd.<info@sunix.com.tw>");
+MODULE_DESCRIPTION("SUNIX PCI serial board driver");
+MODULE_LICENSE("GPL");
+
+
-- 
2.17.1

