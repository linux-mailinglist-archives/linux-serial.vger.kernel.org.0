Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A79B32B095
	for <lists+linux-serial@lfdr.de>; Wed,  3 Mar 2021 04:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348210AbhCCCRD (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 2 Mar 2021 21:17:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:39618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835896AbhCBGZI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:25:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E180EB03C;
        Tue,  2 Mar 2021 06:22:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>
Subject: [PATCH 37/44] USB: serial/keyspan, drop unneeded forward declarations
Date:   Tue,  2 Mar 2021 07:22:07 +0100
Message-Id: <20210302062214.29627-37-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Forward declarations make the code larger, harder to follow and rewrite.
Harder as the declarations are often omitted from global changes. Remove
forward declarations which are not really needed, i.e. when the
definition of the function is before its first use.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/keyspan.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 622077dcc344..b04a029e3657 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -41,27 +41,7 @@
 #define DRIVER_AUTHOR "Hugh Blemings <hugh@misc.nu"
 #define DRIVER_DESC "Keyspan USB to Serial Converter Driver"
 
-/* Function prototypes for Keyspan serial converter */
-static int keyspan_open(struct tty_struct *tty, struct usb_serial_port *port);
-static void keyspan_close(struct usb_serial_port *port);
-static void keyspan_dtr_rts(struct usb_serial_port *port, int on);
-static int keyspan_startup(struct usb_serial *serial);
-static void keyspan_disconnect(struct usb_serial *serial);
-static void keyspan_release(struct usb_serial *serial);
-static int keyspan_port_probe(struct usb_serial_port *port);
-static void keyspan_port_remove(struct usb_serial_port *port);
-static int keyspan_write_room(struct tty_struct *tty);
-static int keyspan_write(struct tty_struct *tty, struct usb_serial_port *port,
-			 const unsigned char *buf, int count);
 static void keyspan_send_setup(struct usb_serial_port *port, int reset_port);
-static void keyspan_set_termios(struct tty_struct *tty,
-				struct usb_serial_port *port,
-				struct ktermios *old);
-static void keyspan_break_ctl(struct tty_struct *tty, int break_state);
-static int keyspan_tiocmget(struct tty_struct *tty);
-static int keyspan_tiocmset(struct tty_struct *tty, unsigned int set,
-			    unsigned int clear);
-static int keyspan_fake_startup(struct usb_serial *serial);
 
 static int keyspan_usa19_calc_baud(struct usb_serial_port *port,
 				   u32 baud_rate, u32 baudclk,
-- 
2.30.1

