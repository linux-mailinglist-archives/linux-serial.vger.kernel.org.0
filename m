Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB74592A7
	for <lists+linux-serial@lfdr.de>; Mon, 22 Nov 2021 17:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbhKVQJU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Nov 2021 11:09:20 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:42549 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhKVQJU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 11:09:20 -0500
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Nov 2021 11:09:20 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2188028026992;
        Mon, 22 Nov 2021 16:59:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 15F1B2ED3B7; Mon, 22 Nov 2021 16:59:20 +0100 (CET)
Message-Id: <21170e622a1aaf842a50b32146008b5374b3dd1d.1637596432.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 22 Nov 2021 16:58:24 +0100
Subject: [PATCH] serial: 8250: Fix RTS modem control while in rs485 mode
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Su Bao Cheng" <baocheng.su@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit f45709df7731 ("serial: 8250: Don't touch RTS modem control while
in rs485 mode") sought to prevent user space from interfering with rs485
communication by ignoring a TIOCMSET ioctl() which changes RTS polarity.

It did so in serial8250_do_set_mctrl(), which turns out to be too deep
in the call stack:  When a uart_port is opened, RTS polarity is set by
the rs485-aware function uart_port_dtr_rts().  It calls down to
serial8250_do_set_mctrl() and that particular RTS polarity change should
*not* be ignored.

The user-visible result is that on 8250_omap ports which use rs485 with
inverse polarity (RTS bit in MCR register is 1 to receive, 0 to send),
a newly opened port initially sets up RTS for sending instead of
receiving.  That's because omap_8250_startup() sets the cached value
up->mcr to 0 and omap_8250_restore_regs() subsequently writes it to the
MCR register.  Due to the commit, serial8250_do_set_mctrl() preserves
that incorrect register value:

do_sys_openat2
  do_filp_open
    path_openat
      vfs_open
        do_dentry_open
	  chrdev_open
	    tty_open
	      uart_open
	        tty_port_open
		  uart_port_activate
		    uart_startup
		      uart_port_startup
		        serial8250_startup
			  omap_8250_startup # up->mcr = 0
			uart_change_speed
			  serial8250_set_termios
			    omap_8250_set_termios
			      omap_8250_restore_regs
			        serial8250_out_MCR # up->mcr written
		  tty_port_block_til_ready
		    uart_dtr_rts
		      uart_port_dtr_rts
		        serial8250_set_mctrl
			  omap8250_set_mctrl
			    serial8250_do_set_mctrl # mcr[1] = 1 ignored

Fix by intercepting RTS changes from user space in uart_tiocmset()
instead.

Fixes: f45709df7731 ("serial: 8250: Don't touch RTS modem control while in rs485 mode")
Link: https://lore.kernel.org/linux-serial/20211027111644.1996921-1-baocheng.su@siemens.com/
Reported-by: Su Bao Cheng <baocheng.su@siemens.com>
Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Su Bao Cheng <baocheng.su@siemens.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Chao Zeng <chao.zeng@siemens.com>
Cc: stable@vger.kernel.org # v5.7+
---
 drivers/tty/serial/8250/8250_port.c | 7 -------
 drivers/tty/serial/serial_core.c    | 5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5775cbf..46e2079 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2024,13 +2024,6 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned char mcr;
 
-	if (port->rs485.flags & SER_RS485_ENABLED) {
-		if (serial8250_in_MCR(up) & UART_MCR_RTS)
-			mctrl |= TIOCM_RTS;
-		else
-			mctrl &= ~TIOCM_RTS;
-	}
-
 	mcr = serial8250_TIOCM_to_MCR(mctrl);
 
 	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1e738f2..6a38e9d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1075,6 +1075,11 @@ static int uart_tiocmget(struct tty_struct *tty)
 		goto out;
 
 	if (!tty_io_error(tty)) {
+		if (uport->rs485.flags & SER_RS485_ENABLED) {
+			set &= ~TIOCM_RTS;
+			clear &= ~TIOCM_RTS;
+		}
+
 		uart_update_mctrl(uport, set, clear);
 		ret = 0;
 	}
-- 
2.33.0

