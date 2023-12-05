Return-Path: <linux-serial+bounces-462-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F46804B38
	for <lists+linux-serial@lfdr.de>; Tue,  5 Dec 2023 08:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D40281555
	for <lists+linux-serial@lfdr.de>; Tue,  5 Dec 2023 07:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026A225A2;
	Tue,  5 Dec 2023 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="iiapsB0i"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFDCC9;
	Mon,  4 Dec 2023 23:35:35 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id AA5FA60354;
	Tue,  5 Dec 2023 07:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1701761734;
	bh=KP1Y9auzSXohgEBe/nM2pmeM9gWKTqhwu5purIjrJ30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iiapsB0ixP6Lf5/Ezprk5y448kv3RZzHmd3IR5yz1x4boItzQnnZN11PbSNvN4enQ
	 lDKVr1994kakOMmX+ogP1Op4G+bxETd9sZFScCMmtNYjxc1UwE4+y2gdGMvfJwaE9s
	 V8kI5Jt0inhXmcn+M91J/uYeJpf4vh/NYcboNbJ4JUPcibvYlOIKc0IgVghIOL7FId
	 TkU901sjzOfjZBktm6wHzHswdJLjBfsRSQjvyiY4kqUFAIokWViTP25Dif4IJ6Bw2+
	 4iVNJ1o9hw3SqFTC2GeJa7rcONy9JExiEdV/pd1/gfybmm0MI3wnz+JJk5lfEvJxVj
	 z5jGjoOALQFpA==
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
Subject: [PATCH v4 3/4] serial: core: Handle serial console options
Date: Tue,  5 Dec 2023 09:32:35 +0200
Message-ID: <20231205073255.20562-4-tony@atomide.com>
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

In order to start moving the serial console quirks out of console_setup(),
let's add parsing for the quirks to the serial core layer. We can use
add_preferred_console_match() to handle the quirks.

At this point we can't drop the quirks from console_setup() because it
would confuse add_preferred_console(). And try_enable_default_console()
would get called before try_enable_preferred_console().

Note that eventually we may want to set up driver specific console quirk
handling for the serial port device drivers to use. But we need to figure
out which driver(s) need to call the quirk. So for now, we just handle the
sparc quirk directly.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base_bus.c | 67 ++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -207,6 +207,43 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 
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
 static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
 				       int port_id)
 {
@@ -240,12 +277,42 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 				      struct uart_port *port)
 {
 	const char *port_match __free(kfree);
+	const char *char_match __free(kfree) = NULL;
+	const char *nmbr_match __free(kfree) = NULL;
+	int ret;
 
 	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
 			       port->ctrl_id, port->port_id);
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
+		ret = serial_base_add_one_prefcon(nmbr_match, drv->dev_name,
+						  port->line);
+		if (ret)
+			return ret;
+
+		/* Sparc ttya and ttyb */
+		ret = serial_base_add_sparc_console(drv, port);
+		if (ret)
+			return ret;
+	}
+
+	/* Handle the traditional character device name style console=ttyS0 */
+	ret = serial_base_add_one_prefcon(char_match, drv->dev_name, port->line);
+	if (ret)
+		return ret;
+
 	/* Translate a hardware addressing style console=DEVNAME:0.0 */
 	return serial_base_add_one_prefcon(port_match, drv->dev_name, port->line);
 }
-- 
2.43.0

