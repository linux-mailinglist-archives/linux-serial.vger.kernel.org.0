Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479F3161143
	for <lists+linux-serial@lfdr.de>; Mon, 17 Feb 2020 12:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgBQLkW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 17 Feb 2020 06:40:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:11231 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbgBQLkW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 06:40:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 03:40:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="407753485"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 17 Feb 2020 03:40:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CCCD25E2; Mon, 17 Feb 2020 13:40:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v3 5/6] serial: 8250_port: Don't use power management for kernel console
Date:   Mon, 17 Feb 2020 13:40:15 +0200
Message-Id: <20200217114016.49856-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Doing any kind of power management for kernel console is really bad idea.

First of all, it runs in poll and atomic mode. This fact attaches a limitation
on the functions that might be called. For example, pm_runtime_get_sync() might
sleep and thus can't be used. This call needs, for example, to bring the device
to powered on state on the system, where the power on sequence may require
on-atomic operations, such as Intel Cherrytrail with ACPI enumerated UARTs.
That said, on ACPI enabled platforms it might even call firmware for a job.

On the other hand pm_runtime_get() doesn't guarantee that device will become
powered on fast enough.

Besides that, imagine the case when console is about to print a kernel Oops and
it's powered off. In such an emergency case calling the complex functions is
not the best what we can do, taking into consideration that user wants to see
at least something of the last kernel word before it passes away.

Here we modify the 8250 console code to prevent runtime power management.

Note, there is a behaviour change for OMAP boards. It will require to detach
kernel console to become idle.

Link: https://lists.openwall.net/linux-kernel/2018/09/29/65
Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c |  9 +++++++++
 drivers/tty/serial/8250/8250_port.c | 24 ++++++++++++++++++++----
 include/linux/serial_8250.h         |  1 +
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index f2a33c9082a6..006d40853509 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -608,6 +608,14 @@ static int univ8250_console_setup(struct console *co, char *options)
 	return retval;
 }
 
+static int univ8250_console_exit(struct console *co)
+{
+	struct uart_port *port;
+
+	port = &serial8250_ports[co->index].port;
+	return serial8250_console_exit(port);
+}
+
 /**
  *	univ8250_console_match - non-standard console matching
  *	@co:	  registering console
@@ -666,6 +674,7 @@ static struct console univ8250_console = {
 	.write		= univ8250_console_write,
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
+	.exit		= univ8250_console_exit,
 	.match		= univ8250_console_match,
 	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
 	.index		= -1,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f398f162a1fd..f8a85244a6f1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3122,6 +3122,9 @@ static void serial8250_console_restore(struct uart_8250_port *up)
  *	any possible real use of the port...
  *
  *	The console_lock must be held when we get here.
+ *
+ *	Doing runtime PM is really a bad idea for the kernel console.
+ *	Thus, we assume the function is called when device is powered up.
  */
 void serial8250_console_write(struct uart_8250_port *up, const char *s,
 			      unsigned int count)
@@ -3133,8 +3136,6 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 
 	touch_nmi_watchdog();
 
-	serial8250_rpm_get(up);
-
 	if (oops_in_progress)
 		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
@@ -3177,7 +3178,6 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 
 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);
-	serial8250_rpm_put(up);
 }
 
 static unsigned int probe_baud(struct uart_port *port)
@@ -3201,6 +3201,7 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	int ret;
 
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
@@ -3210,7 +3211,22 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	else if (probe)
 		baud = probe_baud(port);
 
-	return uart_set_options(port, port->cons, baud, parity, bits, flow);
+	ret = uart_set_options(port, port->cons, baud, parity, bits, flow);
+	if (ret)
+		return ret;
+
+	if (port->dev)
+		pm_runtime_get_sync(port->dev);
+
+	return 0;
+}
+
+int serial8250_console_exit(struct uart_port *port)
+{
+	if (port->dev)
+		pm_runtime_put_sync(port->dev);
+
+	return 0;
 }
 
 #endif /* CONFIG_SERIAL_8250_CONSOLE */
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 6a8e8c48c882..8c7b16df7b09 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -176,6 +176,7 @@ void serial8250_set_defaults(struct uart_8250_port *up);
 void serial8250_console_write(struct uart_8250_port *up, const char *s,
 			      unsigned int count);
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe);
+int serial8250_console_exit(struct uart_port *port);
 
 extern void serial8250_set_isa_configurator(void (*v)
 					(int port, struct uart_port *up,
-- 
2.25.0

