Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC491590E3
	for <lists+linux-serial@lfdr.de>; Tue, 11 Feb 2020 14:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgBKN4H (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Feb 2020 08:56:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:36160 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbgBKN4E (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Feb 2020 08:56:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 05:56:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="256476159"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2020 05:56:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 95AB11F6; Tue, 11 Feb 2020 15:56:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Li RongQing <lirongqing@baidu.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v1] serial: 8250: Check UPF_IRQ_SHARED in advance
Date:   Tue, 11 Feb 2020 15:55:59 +0200
Message-Id: <20200211135559.85960-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The commit 54e53b2e8081
  ("tty: serial: 8250: pass IRQ shared flag to UART ports")
nicely explained the problem:

---8<---8<---

On some systems IRQ lines between multiple UARTs might be shared. If so, the
irqflags have to be configured accordingly. The reason is: The 8250 port startup
code performs IRQ tests *before* the IRQ handler for that particular port is
registered. This is performed in serial8250_do_startup(). This function checks
whether IRQF_SHARED is configured and only then disables the IRQ line while
testing.

This test is performed upon each open() of the UART device. Imagine two UARTs
share the same IRQ line: On is already opened and the IRQ is active. When the
second UART is opened, the IRQ line has to be disabled while performing IRQ
tests. Otherwise an IRQ might handler might be invoked, but the IRQ itself
cannot be handled, because the corresponding handler isn't registered,
yet. That's because the 8250 code uses a chain-handler and invokes the
corresponding port's IRQ handling routines himself.

Unfortunately this IRQF_SHARED flag isn't configured for UARTs probed via device
tree even if the IRQs are shared. This way, the actual and shared IRQ line isn't
disabled while performing tests and the kernel correctly detects a spurious
IRQ. So, adding this flag to the DT probe solves the issue.

Note: The UPF_SHARE_IRQ flag is configured unconditionally. Therefore, the
IRQF_SHARED flag can be set unconditionally as well.

Example stack trace by performing `echo 1 > /dev/ttyS2` on a non-patched system:

|irq 85: nobody cared (try booting with the "irqpoll" option)
| [...]
|handlers:
|[<ffff0000080fc628>] irq_default_primary_handler threaded [<ffff00000855fbb8>] serial8250_interrupt
|Disabling IRQ #85

---8<---8<---

But unfortunately didn't fix the root cause. Let's try again here by moving
IRQ flag assignment from serial_link_irq_chain() to serial8250_do_startup().

This should fix the similar issue reported for 8250_pnp case.

Since this change we don't need to have custom solutions in 8250_aspeed_vuart
and 8250_of drivers, thus, drop them.

Fixes: 1c2f04937b3e ("serial: 8250: add IRQ trigger support")
Reported-by: Li RongQing <lirongqing@baidu.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 -
 drivers/tty/serial/8250/8250_core.c         | 5 ++---
 drivers/tty/serial/8250/8250_of.c           | 1 -
 drivers/tty/serial/8250/8250_port.c         | 4 ++++
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index d657aa14c3e4..c33e02cbde93 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -446,7 +446,6 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 		port.port.line = rc;
 
 	port.port.irq = irq_of_parse_and_map(np, 0);
-	port.port.irqflags = IRQF_SHARED;
 	port.port.handle_irq = aspeed_vuart_handle_irq;
 	port.port.iotype = UPIO_MEM;
 	port.port.type = PORT_16550A;
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ee03eaa80b34..6fb3e9c399f8 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -174,7 +174,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 	struct hlist_head *h;
 	struct hlist_node *n;
 	struct irq_info *i;
-	int ret, irq_flags = up->port.flags & UPF_SHARE_IRQ ? IRQF_SHARED : 0;
+	int ret;
 
 	mutex_lock(&hash_mutex);
 
@@ -209,9 +209,8 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 		INIT_LIST_HEAD(&up->list);
 		i->head = &up->list;
 		spin_unlock_irq(&i->lock);
-		irq_flags |= up->port.irqflags;
 		ret = request_irq(up->port.irq, serial8250_interrupt,
-				  irq_flags, up->port.name, i);
+				  up->port.irqflags, up->port.name, i);
 		if (ret < 0)
 			serial_do_unlink(i, up);
 	}
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 531ad67395e0..f6687756ec5e 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -202,7 +202,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	port->type = type;
 	port->uartclk = clk;
-	port->irqflags |= IRQF_SHARED;
 
 	if (of_property_read_bool(np, "no-loopback-test"))
 		port->flags |= UPF_SKIP_TEST;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ef96042ab3e8..d60c4ccaf312 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2137,6 +2137,10 @@ int serial8250_do_startup(struct uart_port *port)
 		}
 	}
 
+	/* Check if we need to have shared IRQs */
+	if (port->irq && (up->port.flags & UPF_SHARE_IRQ))
+		up->port.irqflags |= IRQF_SHARED;
+
 	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
 		unsigned char iir1;
 		/*
-- 
2.25.0

