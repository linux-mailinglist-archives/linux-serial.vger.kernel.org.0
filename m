Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78261C59F8
	for <lists+linux-serial@lfdr.de>; Tue,  5 May 2020 16:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgEEOts (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 5 May 2020 10:49:48 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:45527 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgEEOts (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 May 2020 10:49:48 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id A383B100A5F0F;
        Tue,  5 May 2020 16:49:45 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 3114D610EE1A;
        Tue,  5 May 2020 16:49:45 +0200 (CEST)
X-Mailbox-Line: From a91b9392e8e7914cae16f59beb1ffe6b335f81c9 Mon Sep 17 00:00:00 2001
Message-Id: <a91b9392e8e7914cae16f59beb1ffe6b335f81c9.1588505407.git.lukas@wunner.de>
In-Reply-To: <cover.1588505407.git.lukas@wunner.de>
References: <cover.1588505407.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 5 May 2020 16:42:04 +0200
Subject: [PATCH 4/4] serial: 8250: Support rs485 bus termination GPIO
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit e8759ad17d41 ("serial: uapi: Add support for bus termination")
introduced the ability to enable rs485 bus termination from user space.
So far the feature is only used by a single driver, 8250_exar.c, using a
hardcoded GPIO pin specific to Siemens IOT2040 products.

Provide for a more generic solution by allowing specification of an
rs485 bus termination GPIO pin in the device tree:  Amend the serial
core to retrieve the GPIO from the device tree (or ACPI table) and amend
the default ->rs485_config() callback for 8250 drivers to change the
GPIO on request from user space.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/tty/serial/8250/8250_port.c |  4 ++++
 drivers/tty/serial/serial_core.c    | 24 ++++++++++++++++++++++++
 include/linux/serial_core.h         |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f77bf820b7a3..b5b630d02110 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -681,6 +681,10 @@ int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485)
 	memset(rs485->padding, 0, sizeof(rs485->padding));
 	port->rs485 = *rs485;
 
+	if (port->rs485_term_gpio)
+		gpiod_set_value(port->rs485_term_gpio,
+				rs485->flags & SER_RS485_TERMINATE_BUS);
+
 	/*
 	 * Both serial8250_em485_init() and serial8250_em485_destroy()
 	 * are idempotent.
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 43b6682877d5..7c929aad066e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3317,6 +3317,7 @@ int uart_get_rs485_mode(struct uart_port *port)
 	 * to get to a defined state with the following properties:
 	 */
 	rs485conf->flags &= ~(SER_RS485_RX_DURING_TX | SER_RS485_ENABLED |
+			      SER_RS485_TERMINATE_BUS |
 			      SER_RS485_RTS_AFTER_SEND);
 	rs485conf->flags |= SER_RS485_RTS_ON_SEND;
 
@@ -3331,6 +3332,29 @@ int uart_get_rs485_mode(struct uart_port *port)
 		rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
 	}
 
+	if (port->rs485_term_gpio)
+		devm_gpiod_put(dev, port->rs485_term_gpio);
+
+	port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",
+		GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT);
+	if (IS_ERR(port->rs485_term_gpio)) {
+		ret = PTR_ERR(port->rs485_term_gpio);
+		port->rs485_term_gpio = NULL;
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Cannot get rs485-term-gpios\n");
+		return ret;
+	}
+
+	if (port->rs485_term_gpio) {
+		ret = gpiod_get_value(port->rs485_term_gpio);
+		if (ret < 0) {
+			dev_err(dev, "Cannot get rs485-term-gpios value\n");
+			return ret;
+		}
+		if (ret)
+			rs485conf->flags |= SER_RS485_TERMINATE_BUS;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b649a2b894e7..9fd550e7946a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/console.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/circ_buf.h>
 #include <linux/spinlock.h>
@@ -251,6 +252,7 @@ struct uart_port {
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
+	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };
-- 
2.26.2

