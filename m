Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A403A67C04
	for <lists+linux-serial@lfdr.de>; Sat, 13 Jul 2019 23:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfGMVMC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 13 Jul 2019 17:12:02 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:37654 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfGMVMB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Jul 2019 17:12:01 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992479AbfGMVMAQB0uN (ORCPT
        <rfc822;linux-serial@vger.kernel.org> + 1 other);
        Sat, 13 Jul 2019 23:12:00 +0200
Date:   Sat, 13 Jul 2019 23:11:58 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 4/5] usb: gadget: u_serial: Fix starving write
Message-ID: <20190713211158.GE25753@lenoch>
References: <20190713210853.GA25753@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713210853.GA25753@lenoch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Writing to ttyGS unconnected to host currently fills port_write_buf
which then causes gs_write_room to return 0 and boot hangs waiting
for connection.
Fix that by dropping previsous data if free space in port_write_buf
reaches treshold and host is unconnected.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: New patch

 drivers/usb/gadget/function/u_serial.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 558a6929ce68..2dd6e1211d4a 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -79,6 +79,7 @@
  */
 #define QUEUE_SIZE		16
 #define WRITE_BUF_SIZE		8192		/* TX only */
+#define WRITE_BUF_TRESHOLD	1024
 #define GS_CONSOLE_BUF_SIZE	8192
 
 /* console info */
@@ -562,7 +563,7 @@ static int gs_start_io(struct gs_port *port)
 
 	/* unblock any pending writes into our circular buffer */
 	if (started) {
-		tty_wakeup(port->port.tty);
+		gs_start_tx(port);
 	} else {
 		gs_free_requests(ep, head, &port->read_allocated);
 		gs_free_requests(port->port_usb->in, &port->write_pool,
@@ -758,6 +759,7 @@ static int gs_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
 	struct gs_port	*port = tty->driver_data;
 	unsigned long	flags;
+	int		avail, cnt;
 
 	pr_vdebug("gs_write: ttyGS%d (%p) writing %d bytes\n",
 			port->port_num, tty, count);
@@ -766,8 +768,16 @@ static int gs_write(struct tty_struct *tty, const unsigned char *buf, int count)
 	if (count)
 		count = kfifo_in(&port->port_write_buf, buf, count);
 	/* treat count == 0 as flush_chars() */
-	if (port->port_usb)
+	if (port->port_usb) {
 		gs_start_tx(port);
+	} else {
+		avail = kfifo_avail(&port->port_write_buf);
+		if (avail < WRITE_BUF_TRESHOLD) {
+			cnt = WRITE_BUF_TRESHOLD - avail;
+			while (cnt--)
+				kfifo_skip(&port->port_write_buf);
+		}
+	}
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
 	return count;
@@ -784,6 +794,9 @@ static int gs_put_char(struct tty_struct *tty, unsigned char ch)
 
 	spin_lock_irqsave(&port->port_lock, flags);
 	status = kfifo_put(&port->port_write_buf, ch);
+	if (!port->port_usb &&
+	     kfifo_avail(&port->port_write_buf) < WRITE_BUF_TRESHOLD)
+		kfifo_skip(&port->port_write_buf);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
 	return status;
@@ -799,6 +812,8 @@ static void gs_flush_chars(struct tty_struct *tty)
 	spin_lock_irqsave(&port->port_lock, flags);
 	if (port->port_usb)
 		gs_start_tx(port);
+	else
+		kfifo_reset_out(&port->port_write_buf);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 }
 
@@ -806,11 +821,10 @@ static int gs_write_room(struct tty_struct *tty)
 {
 	struct gs_port	*port = tty->driver_data;
 	unsigned long	flags;
-	int		room = 0;
+	int		room;
 
 	spin_lock_irqsave(&port->port_lock, flags);
-	if (port->port_usb)
-		room = kfifo_avail(&port->port_write_buf);
+	room = kfifo_avail(&port->port_write_buf);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
 	pr_vdebug("gs_write_room: (%d,%p) room=%d\n",
@@ -823,7 +837,7 @@ static int gs_chars_in_buffer(struct tty_struct *tty)
 {
 	struct gs_port	*port = tty->driver_data;
 	unsigned long	flags;
-	int		chars = 0;
+	int		chars;
 
 	spin_lock_irqsave(&port->port_lock, flags);
 	chars = kfifo_len(&port->port_write_buf);
-- 
2.22.0

