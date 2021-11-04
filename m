Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E96744582F
	for <lists+linux-serial@lfdr.de>; Thu,  4 Nov 2021 18:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhKDRVD (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Nov 2021 13:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233650AbhKDRVD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Nov 2021 13:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636046304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l89hx7/8/FrnaCKSeke77qbOyrO7Fe6LyIp+mc6FNKU=;
        b=DgQB+Wdit/13m1+HuxzaqrP80p2jWK66GcsI1Qn8VVgkmXy0PeVLjvDphxUzHq7WlH3/aE
        kZmZ8Ss6H9QWR6vjAOJJd6NDetOIbp+QH0N0WljjHIolBEbbDT7Fce7Eb36IvdnR7hvPHR
        j+gYwWxnKNnYyqMNO9PDT2vJGF17Dx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-CBrvaZyaMCuXIZIe2yKnxw-1; Thu, 04 Nov 2021 13:18:21 -0400
X-MC-Unique: CBrvaZyaMCuXIZIe2yKnxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBD7C1018720;
        Thu,  4 Nov 2021 17:18:19 +0000 (UTC)
Received: from wcosta.com (ovpn-116-33.gru2.redhat.com [10.97.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB52C19D9F;
        Thu,  4 Nov 2021 17:18:14 +0000 (UTC)
From:   wander@redhat.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Wander Lairson Costa <wander@redhat.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] tty: serial: Use fifo in 8250 console driver
Date:   Thu,  4 Nov 2021 14:17:31 -0300
Message-Id: <20211104171734.137707-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Wander Lairson Costa <wander@redhat.com>

Note: I am using a small test app + driver located at [0] for the
problem description. serco is a driver whose write function dispatches
to the serial controller. sertest is a user-mode app that writes n bytes
to the serial console using the serco driver.

Recently I got a report of a soft lockup while loading a bunch a
scsi_debug devices (> 500).

While investigating it, I noticed that the serial console throughput
(called by the printk code) is way below the configured speed of 115200
bps in a HP Proliant DL380 Gen9 server. I was expecting something above
10KB/s, but I got 2.5KB/s. I then built a simple driver [0] to isolate
the console from the printk code. Here it is:

$ time ./sertest -n 2500 /tmp/serco

real    0m0.997s
user    0m0.000s
sys     0m0.997s

With the help of the function tracer, I then noticed the serial
controller was taking around 410us seconds to dispatch one single byte:

$ trace-cmd record -p function_graph -g serial8250_console_write \
   ./sertest -n 1 /tmp/serco

$ trace-cmd report

            |  serial8250_console_write() {
 0.384 us   |    _raw_spin_lock_irqsave();
 1.836 us   |    io_serial_in();
 1.667 us   |    io_serial_out();
            |    uart_console_write() {
            |      serial8250_console_putchar() {
            |        wait_for_xmitr() {
 1.870 us   |          io_serial_in();
 2.238 us   |        }
 1.737 us   |        io_serial_out();
 4.318 us   |      }
 4.675 us   |    }
            |    wait_for_xmitr() {
 1.635 us   |      io_serial_in();
            |      __const_udelay() {
 1.125 us   |        delay_tsc();
 1.429 us   |      }
...
...
...
 1.683 us   |      io_serial_in();
            |      __const_udelay() {
 1.248 us   |        delay_tsc();
 1.486 us   |      }
 1.671 us   |      io_serial_in();
 411.342 us |    }

In another machine, I measured a throughput of 11.5KB/s, with the serial
controller taking between 80-90us to send each byte. That matches the
expected throughput for a configuration of 115200 bps.

This patch changes the serial8250_console_write to use the 16550 fifo
if available. In my artificial benchmark I could get a throughput
increase up to 100% in some cases, but in the real case described at the
beginning the gain was of about 25%.

[0] https://github.com/walac/serial-console-test

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/tty/serial/8250/8250.h      |  3 ++
 drivers/tty/serial/8250/8250_port.c | 63 +++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 6473361525d1..c711bf118cc1 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -83,6 +83,9 @@ struct serial8250_config {
 #define UART_CAP_MINI	BIT(17)	/* Mini UART on BCM283X family lacks:
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
+#define UART_CAP_CWFIFO BIT(18) /* Use the UART Fifo in
+				 * serial8250_console_write
+				 */
 
 #define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5775cbff8f6e..e58938c435c9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -82,7 +82,7 @@ static const struct serial8250_config uart_config[] = {
 		.tx_loadsz	= 16,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.rxtrig_bytes	= {1, 4, 8, 14},
-		.flags		= UART_CAP_FIFO,
+		.flags		= UART_CAP_FIFO | UART_CAP_CWFIFO,
 	},
 	[PORT_CIRRUS] = {
 		.name		= "Cirrus",
@@ -2063,10 +2063,7 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	serial8250_rpm_put(up);
 }
 
-/*
- *	Wait for transmitter & holding register to empty
- */
-static void wait_for_xmitr(struct uart_8250_port *up, int bits)
+static void wait_for_lsr(struct uart_8250_port *up, int bits)
 {
 	unsigned int status, tmout = 10000;
 
@@ -2083,6 +2080,16 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 		udelay(1);
 		touch_nmi_watchdog();
 	}
+}
+
+/*
+ *	Wait for transmitter & holding register to empty
+ */
+static void wait_for_xmitr(struct uart_8250_port *up, int bits)
+{
+	unsigned int tmout;
+
+	wait_for_lsr(up, bits);
 
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
@@ -3332,6 +3339,35 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
 }
 
+/*
+ * Print a string to the serial port using the device FIFO
+ *
+ * It sends fifosize bytes and then waits for the fifo
+ * to get empty.
+ */
+static void serial8250_console_fifo_write(struct uart_8250_port *up,
+		const char *s, unsigned int count)
+{
+	int i;
+	const char *end = s + count;
+	unsigned int fifosize = up->port.fifosize;
+	bool cr_sent = false;
+
+	while (s != end) {
+		wait_for_lsr(up, UART_LSR_THRE);
+
+		for (i = 0; i < fifosize && s != end; ++i) {
+			if (*s == '\n' && !cr_sent) {
+				serial_out(up, UART_TX, '\r');
+				cr_sent = true;
+			} else {
+				serial_out(up, UART_TX, *s++);
+				cr_sent = false;
+			}
+		}
+	}
+}
+
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...
@@ -3347,7 +3383,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	struct uart_8250_em485 *em485 = up->em485;
 	struct uart_port *port = &up->port;
 	unsigned long flags;
-	unsigned int ier;
+	unsigned int ier, use_fifo;
 	int locked = 1;
 
 	touch_nmi_watchdog();
@@ -3379,7 +3415,20 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		mdelay(port->rs485.delay_rts_before_send);
 	}
 
-	uart_console_write(port, s, count, serial8250_console_putchar);
+	use_fifo = (up->capabilities & UART_CAP_CWFIFO)
+		&& port->fifosize > 1
+		&& (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO)
+		/*
+		 * After we put a data in the fifo, the controller will send
+		 * it regardless of the CTS state. Therefore, only use fifo
+		 * if we don't use control flow.
+		 */
+		&& !(up->port.flags & UPF_CONS_FLOW);
+
+	if (use_fifo)
+		serial8250_console_fifo_write(up, s, count);
+	else
+		uart_console_write(port, s, count, serial8250_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
-- 
2.27.0

