Return-Path: <linux-serial+bounces-55-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0777F2BC5
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 12:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343122826AB
	for <lists+linux-serial@lfdr.de>; Tue, 21 Nov 2023 11:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BC048795;
	Tue, 21 Nov 2023 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-serial@vger.kernel.org
Received: from muru.com (muru.com [72.249.23.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5187511A;
	Tue, 21 Nov 2023 03:33:04 -0800 (PST)
Received: from hillo.muru.com (localhost [127.0.0.1])
	by muru.com (Postfix) with ESMTP id 6933880CC;
	Tue, 21 Nov 2023 11:33:01 +0000 (UTC)
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
Subject: [PATCH v3 3/3] serial: core: Move console character device handling from printk
Date: Tue, 21 Nov 2023 13:31:57 +0200
Message-ID: <20231121113203.61341-4-tony@atomide.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121113203.61341-1-tony@atomide.com>
References: <20231121113203.61341-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need for console_setup() to try to figure out the console
character device name for serial ports early on before uart_add_one_port()
has been called. And for early debug console we have earlycon.

Let's handle the serial port specific commandline options in the serial
core subsystem and drop the handling from printk. The serial core
subsystem can just call add_preferred_console() when the serial port is
getting initialized.

Note that eventually we may want to set up driver specific console quirk
handling for the serial port device drivers to use. But we need to figure
out which driver(s) need to call the quirk. So for now, we just move the
sparc quirk and handle it directly.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base_bus.c | 66 ++++++++++++++++++++++++++++
 kernel/printk/printk.c               | 30 +------------
 2 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -206,6 +206,43 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
 
+#ifdef __sparc__
+
+/* Handle Sparc ttya and ttyb options as done in console_setup() */
+static int serial_base_add_sparc_console(struct uart_driver *drv,
+					 struct uart_port *port)
+{
+	const char *name = NULL;
+	int ret;
+
+	switch (port->line) {
+	case 0:
+		name = "ttya";
+		break;
+	case 1:
+		name = "ttyb";
+		break;
+	default:
+		return 0;
+	}
+
+	ret = add_preferred_console_match(name, drv->dev_name, port->line);
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	return 0;
+}
+
+#else
+
+static inline int serial_base_add_sparc_console(struct uart_driver *drv,
+						struct uart_port *port)
+{
+	return 0;
+}
+
+#endif
+
 /*
  * serial_base_add_preferred_console - Adds a preferred console
  * @drv: Serial port device driver
@@ -225,6 +262,8 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 				      struct uart_port *port)
 {
 	const char *port_match __free(kfree);
+	const char *char_match __free(kfree);
+	const char *nmbr_match __free(kfree);
 	int ret;
 
 	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
@@ -232,6 +271,33 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 	if (!port_match)
 		return -ENOMEM;
 
+	char_match = kasprintf(GFP_KERNEL, "%s%i", drv->dev_name, port->line);
+	if (!char_match)
+		return -ENOMEM;
+
+	/* Handle ttyS specific options */
+	if (!strncmp(drv->dev_name, "ttyS", 4)) {
+		/* No name, just a number */
+		nmbr_match = kasprintf(GFP_KERNEL, "%i", port->line);
+		if (!nmbr_match)
+			return -ENODEV;
+
+		ret = add_preferred_console_match(nmbr_match, drv->dev_name,
+						  port->line);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		/* Sparc ttya and ttyb */
+		ret = serial_base_add_sparc_console(drv, port);
+		if (ret)
+			return ret;
+	}
+
+	/* Handle the traditional character device name style console=ttyS0 */
+	ret = add_preferred_console_match(char_match, drv->dev_name, port->line);
+	if (ret && ret != -ENOENT)
+		return ret;
+
 	/* Translate a hardware addressing style console=DEVNAME:0.0 */
 	ret = add_preferred_console_match(port_match, drv->dev_name, port->line);
 	if (ret && ret != -ENOENT)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2438,9 +2438,7 @@ __setup("console_msg_format=", console_msg_format_setup);
  */
 static int __init console_setup(char *str)
 {
-	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
-	char *s, *options, *brl_options = NULL;
-	int idx;
+	char *brl_options = NULL;
 
 	/*
 	 * Save the console for possible driver subsystem use. Bail out early
@@ -2463,32 +2461,6 @@ static int __init console_setup(char *str)
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
-	/*
-	 * Decode str into name, index, options.
-	 */
-	if (str[0] >= '0' && str[0] <= '9') {
-		strcpy(buf, "ttyS");
-		strncpy(buf + 4, str, sizeof(buf) - 5);
-	} else {
-		strncpy(buf, str, sizeof(buf) - 1);
-	}
-	buf[sizeof(buf) - 1] = 0;
-	options = strchr(str, ',');
-	if (options)
-		*(options++) = 0;
-#ifdef __sparc__
-	if (!strcmp(str, "ttya"))
-		strcpy(buf, "ttyS0");
-	if (!strcmp(str, "ttyb"))
-		strcpy(buf, "ttyS1");
-#endif
-	for (s = buf; *s; s++)
-		if (isdigit(*s) || *s == ',')
-			break;
-	idx = simple_strtoul(s, NULL, 10);
-	*s = 0;
-
-	__add_preferred_console(buf, idx, options, brl_options, true);
 	return 1;
 }
 __setup("console=", console_setup);
-- 
2.42.1

