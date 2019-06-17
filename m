Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE244849F
	for <lists+linux-serial@lfdr.de>; Mon, 17 Jun 2019 15:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfFQNxY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 17 Jun 2019 09:53:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:16781 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfFQNxY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Jun 2019 09:53:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 06:53:24 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2019 06:53:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 843BA177; Mon, 17 Jun 2019 16:53:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Vignesh R <vigneshr@ti.com>, Ferry Toth <ftoth@exalondelft.nl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250: factor out serial8250_{set,clear}_THRI() helpers
Date:   Mon, 17 Jun 2019 16:53:20 +0300
Message-Id: <20190617135320.14199-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Factor out similar code pieces that set or clear UART_IER_THRI bit to
serial8250_{set,clear}_THRI() helpers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h      | 18 ++++++++++++++++++
 drivers/tty/serial/8250/8250_dma.c  | 11 +++--------
 drivers/tty/serial/8250/8250_omap.c | 14 +++-----------
 drivers/tty/serial/8250/8250_port.c | 10 ++--------
 4 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ebfb0bd5bef5..93756ea540d6 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -128,6 +128,24 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
 	up->dl_write(up, value);
 }
 
+static inline bool serial8250_set_THRI(struct uart_8250_port *up)
+{
+	if (up->ier & UART_IER_THRI)
+		return false;
+	up->ier |= UART_IER_THRI;
+	serial_out(up, UART_IER, up->ier);
+	return true;
+}
+
+static inline bool serial8250_clear_THRI(struct uart_8250_port *up)
+{
+	if (!(up->ier & UART_IER_THRI))
+		return false;
+	up->ier &= ~UART_IER_THRI;
+	serial_out(up, UART_IER, up->ier);
+	return true;
+}
+
 struct uart_8250_port *serial8250_get_port(int line);
 
 void serial8250_rpm_get(struct uart_8250_port *p);
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index bfa1a857f3ff..890fa7ddaa7f 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -34,10 +34,8 @@ static void __dma_tx_complete(void *param)
 		uart_write_wakeup(&p->port);
 
 	ret = serial8250_tx_dma(p);
-	if (ret) {
-		p->ier |= UART_IER_THRI;
-		serial_port_out(&p->port, UART_IER, p->ier);
-	}
+	if (ret)
+		serial8250_set_THRI(p);
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
 }
@@ -100,10 +98,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	dma_async_issue_pending(dma->txchan);
 	if (dma->tx_err) {
 		dma->tx_err = 0;
-		if (p->ier & UART_IER_THRI) {
-			p->ier &= ~UART_IER_THRI;
-			serial_out(p, UART_IER, p->ier);
-		}
+		serial8250_clear_THRI(p);
 	}
 	return 0;
 err:
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 0a8316632d75..ed25cfc3be13 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -923,15 +923,13 @@ static void omap_8250_dma_tx_complete(void *param)
 		ret = omap_8250_tx_dma(p);
 		if (ret)
 			en_thri = true;
-
 	} else if (p->capabilities & UART_CAP_RPM) {
 		en_thri = true;
 	}
 
 	if (en_thri) {
 		dma->tx_err = 1;
-		p->ier |= UART_IER_THRI;
-		serial_port_out(&p->port, UART_IER, p->ier);
+		serial8250_set_THRI(p);
 	}
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
@@ -959,10 +957,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 			ret = -EBUSY;
 			goto err;
 		}
-		if (p->ier & UART_IER_THRI) {
-			p->ier &= ~UART_IER_THRI;
-			serial_out(p, UART_IER, p->ier);
-		}
+		serial8250_clear_THRI(p);
 		return 0;
 	}
 
@@ -1020,10 +1015,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 	if (dma->tx_err)
 		dma->tx_err = 0;
 
-	if (p->ier & UART_IER_THRI) {
-		p->ier &= ~UART_IER_THRI;
-		serial_out(p, UART_IER, p->ier);
-	}
+	serial8250_clear_THRI(p);
 	if (skip_byte)
 		serial_out(p, UART_TX, xmit->buf[xmit->tail]);
 	return 0;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fdb6fd084386..e0d66891d8df 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1502,11 +1502,8 @@ static void __stop_tx_rs485(struct uart_8250_port *p)
 
 static inline void __do_stop_tx(struct uart_8250_port *p)
 {
-	if (p->ier & UART_IER_THRI) {
-		p->ier &= ~UART_IER_THRI;
-		serial_out(p, UART_IER, p->ier);
+	if (serial8250_clear_THRI(p))
 		serial8250_rpm_put_tx(p);
-	}
 }
 
 static inline void __stop_tx(struct uart_8250_port *p)
@@ -1555,10 +1552,7 @@ static inline void __start_tx(struct uart_port *port)
 	if (up->dma && !up->dma->tx_dma(up))
 		return;
 
-	if (!(up->ier & UART_IER_THRI)) {
-		up->ier |= UART_IER_THRI;
-		serial_port_out(port, UART_IER, up->ier);
-
+	if (serial8250_set_THRI(up)) {
 		if (up->bugs & UART_BUG_TXEN) {
 			unsigned char lsr;
 
-- 
2.20.1

