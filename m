Return-Path: <linux-serial+bounces-461-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61359804B36
	for <lists+linux-serial@lfdr.de>; Tue,  5 Dec 2023 08:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF561C20D21
	for <lists+linux-serial@lfdr.de>; Tue,  5 Dec 2023 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD814AAC;
	Tue,  5 Dec 2023 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="dScPxv1T"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CACCB;
	Mon,  4 Dec 2023 23:34:59 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 95683604C8;
	Tue,  5 Dec 2023 07:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1701761698;
	bh=p9bVc8SN18pkf5fGyGvpGvB/HvwuCPyy9bQrY91rxWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dScPxv1TXRzix3fva8AOs/JaPP4lI65gYaqPanXdcc1f25QWeaOm8Sb/gVvG/5QwQ
	 zsEMi7JHw2bi+Cxs3kaxWB7HYs0NQFlsqkv00yzwQsMcsl8uCul7fRanNx6wKamll2
	 MjPaHI+cpT3q7tGAYfCbkLlrB6ADe+pTPB7eIqpS15etC8/UtQOEggzu+wtTDPHv/U
	 LgFmN8y5WCQELZVjdP7AtWI3TT8ARiPlSoQ56Y2NOmeq2c9u578AVrhQUtrOE9YFGs
	 046vEiUSRFMNqb3bxbqEWo4SYlB6KLYJ6RwYU7/fVZk9OT/U2N4OihHequkOL8/1h0
	 eOzdAfCZIL+bw==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 2/4] serial: core: Add support for DEVNAME:0.0 style naming for kernel console
Date: Tue,  5 Dec 2023 09:32:34 +0200
Message-ID: <20231205073255.20562-3-tony@atomide.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205073255.20562-1-tony@atomide.com>
References: <20231205073255.20562-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can now add hardware based addressing for serial ports. Starting with
commit 84a9582fd203 ("serial: core: Start managing serial controllers to
enable runtime PM"), and all the related fixes to this commit, the serial
core now knows to which serial port controller the ports are connected.

The serial ports can be addressed with DEVNAME:0.0 style naming. The names
are something like 00:04:0.0 for a serial port on qemu, and something like
2800000.serial:0.0 on platform device using systems like ARM64 for example.

The DEVNAME is the unique serial port hardware controller device name, AKA
the name for port->dev. The 0.0 are the serial core controller id and port
id.

Typically 0.0 are used for each controller and port instance unless the
serial port hardware controller has multiple controllers or ports.

Using DEVNAME:0.0 style naming actually solves two long term issues for
addressing the serial ports:

1. According to Andy Shevchenko, using DEVNAME:0.0 style naming fixes an
   issue where depending on the BIOS settings, the kernel serial port ttyS
   instance number may change if HSUART is enabled

2. Device tree using architectures no longer necessarily need to specify
   aliases to find a specific serial port, and we can just allocate the
   ttyS instance numbers dynamically in whatever probe order

To do this, let's match the hardware addressing style console name to
the character device name used, and add a preferred console using the
character device name.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base.h     | 14 ++++++++
 drivers/tty/serial/serial_base_bus.c | 48 ++++++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c     |  4 +++
 3 files changed, 66 insertions(+)

diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -45,3 +45,17 @@ void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port
 
 int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
 void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);
+
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+
+int serial_base_add_preferred_console(struct uart_driver *drv,
+				      struct uart_port *port);
+#else
+static inline
+int serial_base_add_preferred_console(struct uart_driver *drv,
+				      struct uart_port *port)
+{
+	return 0;
+}
+
+#endif
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -8,6 +8,7 @@
  * The serial core bus manages the serial core controller instances.
  */
 
+#include <linux/cleanup.h>
 #include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/idr.h>
@@ -204,6 +205,53 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 	put_device(&port_dev->dev);
 }
 
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+
+static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
+				       int port_id)
+{
+	int ret;
+
+	ret = add_preferred_console_match(match, dev_name, port_id);
+	if (ret == -ENOENT)
+		return 0;
+
+	return ret;
+}
+
+/**
+ * serial_base_add_preferred_console - Adds a preferred console
+ * @drv: Serial port device driver
+ * @port: Serial port instance
+ *
+ * Tries to add a preferred console for a serial port if specified in the
+ * kernel command line. Supports both the traditional character device such
+ * as console=ttyS0, and a hardware addressing based console=DEVNAME:0.0
+ * style name.
+ *
+ * Translates the kernel command line option using a hardware based addressing
+ * console=DEVNAME:0.0 to the serial port character device such as ttyS0.
+ *
+ * Note that duplicates are ignored by add_preferred_console().
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int serial_base_add_preferred_console(struct uart_driver *drv,
+				      struct uart_port *port)
+{
+	const char *port_match __free(kfree);
+
+	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
+			       port->ctrl_id, port->port_id);
+	if (!port_match)
+		return -ENOMEM;
+
+	/* Translate a hardware addressing style console=DEVNAME:0.0 */
+	return serial_base_add_one_prefcon(port_match, drv->dev_name, port->line);
+}
+
+#endif
+
 static int serial_base_init(void)
 {
 	int ret;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3359,6 +3359,10 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	if (ret)
 		goto err_unregister_ctrl_dev;
 
+	ret = serial_base_add_preferred_console(drv, port);
+	if (ret)
+		goto err_unregister_port_dev;
+
 	ret = serial_core_add_one_port(drv, port);
 	if (ret)
 		goto err_unregister_port_dev;
-- 
2.43.0

