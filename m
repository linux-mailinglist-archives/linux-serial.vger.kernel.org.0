Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D462E03C5
	for <lists+linux-serial@lfdr.de>; Tue, 22 Dec 2020 02:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgLVBV6 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 21 Dec 2020 20:21:58 -0500
Received: from mail.prewas.sk ([212.5.209.170]:58163 "EHLO mail.prewas.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgLVBV5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Dec 2020 20:21:57 -0500
X-Greylist: delayed 7284 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2020 20:21:56 EST
dkim-signature: v=1; a=rsa-sha256; d=3ksolutions.sk; s=mail.prewas.sk;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding;
        bh=auBEDWBmf7aYlVfpZA/b2NqrrsbRX4B4mzNnQ3FRxdY=;
        b=UyN3yLeW4dvjQIs4Qgtf9MBrC86hElB+R7NJBSSZV3VJQPKorxdyBnUfykaw4jyQ5a2iEuyOrQ4XlmjSzMShLOYLg6KbReGS/X+AwKRIvVh0fqiXR8n8F5JMaJgiD7Rja78Yc0VHa7diWz8d0DOw3lUf8orFO8j5jKVfuOxymtVMO0LL//xd1lmRqhyNAWv7OuFpEK2NWmwktP0zT0qGRs25CMNUf/gnC0wXTYXxx/iOGgAJXL1RWJ17HB
        JjDaqk7P8P1Srw0yVeOqJGHkX0aopMAncEeQbTwa4/VTGMP4iD5S1d68iG6p1YxwQwhiId7nEUrPW5cvgb0fBPfxMWyQ==
Received: from localhost.localdomain (Unknown [10.0.1.41])
        by mail.prewas.sk with ESMTPSA
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
        ; Tue, 22 Dec 2020 00:19:24 +0100
From:   Ivan Sistik <sistik@3ksolutions.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Ivan Sistik <sistik@3ksolutions.sk>
Subject: [PATCH] tty: serial: amba-pl011: added RS485 support
Date:   Tue, 22 Dec 2020 00:18:48 +0100
Message-Id: <20201221231848.55259-1-sistik@3ksolutions.sk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch is ported and corrected version of my previous patch which can
be reviewed here:
https://lore.kernel.org/lkml/20200106235203.27256-1-sistik@3ksolutions.sk/

I have been waiting for some time to see if Lukas Wunner <lukas@wunner.de>
will create patch with his own solution.

Now I am successfully running my imeplementation for almost one year in
production environment. There are no problems with it. I have made
corrections to patch according to notes from Greg Kroah-Hartman
<gregkh@linuxfoundation.org>.

Patch content:

AMBA PL011 do not have hardware support for RS485. This implementation is
for drive enable signal (DE), which switch direction of RS485 driver chip.
This signal si drived by RTS pin. Correct multiplexor settings have to be
provided to Device Tree. Usually it is 'ctsrts', which is used for enabling
of HW flow control, too.

DE signal is switched by starting transmition from serial core and data
transfer is initiated by first hrtimer if there is delay before send
enabled.

There is missing FIFO empty interrupt in PL011. It is replaced by second
hrtimer which is started if there are no more data in port transmit buffer.
Notice that port transmit buffer is not the same as HW TX FIFO. Time of
this timmer is set to char send time and it is running until fifo is empty.
This kind of implementation cause that there can be unwanted delay of one
timer tick before DE signal is switched. This is used to prevent data loss
during transmit. Second timer can start first if there is delay after send
enabled.

Signed-off-by: Ivan Sistik <sistik@3ksolutions.sk>
---
 arch/arm/configs/bcm2835_defconfig |   1 +
 drivers/tty/serial/Kconfig         |  11 +
 drivers/tty/serial/amba-pl011.c    | 474 ++++++++++++++++++++++++++++-
 3 files changed, 483 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 519ff58e6..c2f630937 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -86,6 +86,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_BCM2835AUX=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_AMBA_PL011_SOFT_RS485=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_TTY_PRINTK=y
 CONFIG_I2C_CHARDEV=y
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a9751a83d..c33461511 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -75,6 +75,17 @@ config SERIAL_AMBA_PL011_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
+config SERIAL_AMBA_PL011_SOFT_RS485
+	bool "RS485 software direction switching for ARM AMBA PL011 serial"
+	depends on SERIAL_AMBA_PL011=y
+	help
+	  Enable RS485 software direction switching of driver enable (RTS pin)
+	  for ARM AMBA PL011 serial. AMBA PL011 does not have HW support for
+	  RS485. This driver use 2 hrtimers. One is used for rs485 delays.
+	  Secon one is used for polling of TX FIFO. There is not TX FIFO
+	  empty interrupt in PL011. Secondary timer is started by empty
+	  transmit buffer.
+
 config SERIAL_EARLYCON_ARM_SEMIHOST
 	bool "Early console using ARM semihosting"
 	depends on ARM64 || ARM
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 16720c97a..f45b9042b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -46,6 +46,7 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/math64.h>
 
 #include "amba-pl011.h"
 
@@ -60,6 +61,18 @@
 #define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
 #define UART_DUMMY_DR_RX	(1 << 16)
 
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+/*
+ * Enum with current status
+ */
+enum rs485_status {
+	rs485_receiving,
+	rs485_delay_before_send,
+	rs485_sending,
+	rs485_delay_after_send
+};
+#endif
+
 static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
 	[REG_DR] = UART01x_DR,
 	[REG_FR] = UART01x_FR,
@@ -270,6 +283,16 @@ struct uart_amba_port {
 	unsigned int		old_cr;		/* state during shutdown */
 	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
 	char			type[12];
+
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+	enum rs485_status	rs485_current_status; /* status used for RTS */
+	enum rs485_status	rs485_next_status; /* this status after tick */
+	struct hrtimer		rs485_delay_timer;
+	struct hrtimer		rs485_tx_empty_poll_timer;
+	unsigned long		send_char_time;	/* send char (nanoseconds) */
+	bool			rs485_last_char_sending;
+#endif
+
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	bool			using_tx_dma;
@@ -280,6 +303,25 @@ struct uart_amba_port {
 #endif
 };
 
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+
+static void pl011_rs485_start_rts_delay(struct uart_amba_port *uap);
+
+#define RS485_SET_RTS_SIGNAL(pUAP, value)		\
+	do {						\
+		unsigned int rts_temp_cr;		\
+		rts_temp_cr = pl011_read(pUAP, REG_CR);	\
+		if (!(value))				\
+			rts_temp_cr |= UART011_CR_RTS;	\
+		else					\
+			rts_temp_cr &= ~UART011_CR_RTS;	\
+		pl011_write(rts_temp_cr, pUAP, REG_CR);	\
+	} while (0)
+
+#define RS485_TX_FIFO_EMPTY(pUAP)			\
+	(pl011_read(pUAP, REG_FR) & UART011_FR_TXFE)
+#endif
+
 static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
 	unsigned int reg)
 {
@@ -1301,6 +1343,11 @@ static void pl011_stop_tx(struct uart_port *port)
 	uap->im &= ~UART011_TXIM;
 	pl011_write(uap->im, uap, REG_IMSC);
 	pl011_dma_tx_stop(uap);
+
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+	if (uap->port.rs485.flags & SER_RS485_ENABLED)
+		pl011_rs485_start_rts_delay(uap);
+#endif
 }
 
 static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
@@ -1319,8 +1366,123 @@ static void pl011_start_tx(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
-	if (!pl011_dma_tx_start(uap))
-		pl011_start_tx_pio(uap);
+#define START_PL011_TX()				\
+	do {						\
+		if (!pl011_dma_tx_start(uap))		\
+			pl011_start_tx_pio(uap);	\
+	} while (0)
+
+#ifndef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+	START_PL011_TX();
+#else
+
+#define CANCEL_RS485_TIMERS()						 \
+	do {								 \
+		hrtimer_try_to_cancel(&(uap->rs485_delay_timer));	 \
+		hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));\
+	} while (0)
+
+	if (uap->port.rs485.flags & SER_RS485_ENABLED) {
+		ktime_t ktime;
+
+		switch (uap->rs485_current_status) {
+		case rs485_delay_after_send:
+			/* stop old delay timer */
+			CANCEL_RS485_TIMERS();
+
+			/* check if timer expired */
+			if (uap->rs485_current_status
+					!= rs485_delay_after_send) {
+				/* Timer expired and RTS is in wrong state.*/
+				uap->rs485_current_status
+					= rs485_delay_before_send;
+				uap->rs485_next_status = rs485_sending;
+
+				/* Set RTS */
+				RS485_SET_RTS_SIGNAL(uap,
+					uap->port.rs485.flags
+						& SER_RS485_RTS_ON_SEND);
+
+				/* Start timer */
+				ktime = ktime_set(0,
+					  uap->port.rs485
+						.delay_rts_before_send
+					  * 1000000L);
+
+				hrtimer_start(
+					&(uap->rs485_delay_timer),
+					ktime,
+					HRTIMER_MODE_REL);
+				return;
+			}
+
+			/* timer was stopped and driver can continue sending */
+			uap->rs485_current_status = rs485_sending;
+			uap->rs485_next_status = rs485_sending;
+
+			/* driver is already in sending state */
+			START_PL011_TX();
+			break;
+
+
+		case rs485_sending:
+			/* stop old timer. There can be running timer	*/
+			/* which is checking TX FIFO empty flag		*/
+			CANCEL_RS485_TIMERS();
+
+			/* driver is already in sending state */
+			START_PL011_TX();
+			break;
+
+		case rs485_receiving:
+		default:
+			/* stop old timer. There can be running timer	*/
+			/* which is checking TX FIFO empty flag		*/
+			CANCEL_RS485_TIMERS();
+
+			/* Set RTS */
+			RS485_SET_RTS_SIGNAL(uap,
+				     uap->port.rs485.flags
+					     & SER_RS485_RTS_ON_SEND);
+
+			if (uap->port.rs485.delay_rts_before_send == 0) {
+				/* Change state */
+				uap->rs485_current_status
+					= rs485_sending;
+				uap->rs485_next_status
+					= rs485_sending;
+
+				/* driver is in sending state */
+				START_PL011_TX();
+				break;
+			}
+
+			/* Change state */
+			uap->rs485_current_status
+				= rs485_delay_before_send;
+			uap->rs485_next_status = rs485_sending;
+
+			/* Start timer */
+			ktime = ktime_set(0,
+				  uap->port.rs485.delay_rts_before_send
+				  * 1000000L);
+			hrtimer_start(&(uap->rs485_delay_timer),
+				ktime,
+				HRTIMER_MODE_REL);
+			break;
+
+		case rs485_delay_before_send:
+			/* do nothing because delay timer should be running */
+			break;
+		}
+	} else {
+		START_PL011_TX();
+	}
+#undef CANCEL_RS485_TIMERS
+
+#endif
+
+#undef START_PL011_TX
 }
 
 static void pl011_stop_rx(struct uart_port *port)
@@ -1476,6 +1638,169 @@ static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
 	dummy_read = pl011_read(uap, REG_ICR);
 }
 
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+
+/*
+ * Change state according to pending delay
+ * Locking: port is locked in this function
+ */
+static enum hrtimer_restart
+pl011_rs485_tx_poll_timer(struct hrtimer *timer)
+{
+	unsigned long flags;
+	ktime_t ktime;
+
+	struct uart_amba_port *uap =
+		container_of(timer, struct uart_amba_port,
+			     rs485_tx_empty_poll_timer);
+
+	spin_lock_irqsave(&uap->port.lock, flags);
+
+	if (!(uart_circ_empty(&uap->port.state->xmit))) {
+		spin_unlock_irqrestore(&uap->port.lock, flags);
+		return HRTIMER_NORESTART;
+	}
+
+	if (!RS485_TX_FIFO_EMPTY(uap) || !uap->rs485_last_char_sending) {
+		/*
+		 *  FIFO is empty but there is last char in transmit shift
+		 * register so we need one more tick
+		 */
+		uap->rs485_last_char_sending = RS485_TX_FIFO_EMPTY(uap);
+
+		hrtimer_forward_now(timer, ktime_set(0, uap->send_char_time));
+
+		spin_unlock_irqrestore(&uap->port.lock, flags);
+		return HRTIMER_RESTART;
+	}
+
+	/* Check if delay after send is set*/
+	if (uap->port.rs485.delay_rts_after_send == 0) {
+		/* Change state */
+		uap->rs485_current_status = rs485_receiving;
+		uap->rs485_next_status = rs485_receiving;
+
+		/* if there is no delay after send change RTS value*/
+		RS485_SET_RTS_SIGNAL(uap,
+			     uap->port.rs485.flags
+				     & SER_RS485_RTS_AFTER_SEND);
+
+		spin_unlock_irqrestore(&uap->port.lock, flags);
+		return HRTIMER_NORESTART;
+	}
+
+	/* Change state */
+	uap->rs485_current_status = rs485_delay_after_send;
+	uap->rs485_next_status = rs485_receiving;
+
+	/* RTS will be set in timer handler */
+
+	/* Start delay timer */
+	ktime = ktime_set(0, (uap->port.rs485.delay_rts_after_send
+			* 1000000L));
+	hrtimer_start(&(uap->rs485_delay_timer), ktime, HRTIMER_MODE_REL);
+
+	spin_unlock_irqrestore(&uap->port.lock, flags);
+	return HRTIMER_NORESTART;
+}
+
+/*
+ * Change state according to pending delay
+ * Locking: port is locked in this function
+ */
+static enum hrtimer_restart
+pl011_rs485_timer(struct hrtimer *timer)
+{
+	unsigned long flags;
+
+	struct uart_amba_port *uap =
+		container_of(timer, struct uart_amba_port, rs485_delay_timer);
+
+	spin_lock_irqsave(&uap->port.lock, flags);
+
+	if (uap->rs485_current_status == uap->rs485_next_status) {
+		/* timer was canceled or handled */
+		spin_unlock_irqrestore(&uap->port.lock, flags);
+		return HRTIMER_NORESTART;
+	}
+
+	switch (uap->rs485_current_status) {
+	case rs485_delay_before_send:
+		uap->rs485_current_status = rs485_sending;
+		uap->rs485_next_status = rs485_sending;
+		if (!pl011_dma_tx_start(uap))
+			pl011_start_tx_pio(uap);
+
+		spin_unlock_irqrestore(&uap->port.lock, flags);
+		return HRTIMER_NORESTART;
+
+	case rs485_delay_after_send:
+		uap->rs485_current_status = rs485_receiving;
+		uap->rs485_next_status = rs485_receiving;
+		RS485_SET_RTS_SIGNAL(uap,
+			     uap->port.rs485.flags
+				     & SER_RS485_RTS_AFTER_SEND);
+
+		spin_unlock_irqrestore(&uap->port.lock, flags);
+		return HRTIMER_NORESTART;
+
+	default:
+		spin_unlock_irqrestore(&uap->port.lock, flags);
+		return HRTIMER_NORESTART;
+	}
+}
+
+/*
+ * Evaluate transmit buffer status and start delay to off
+ * Locking: called with port lock held and IRQs disabled
+ */
+static void pl011_rs485_start_rts_delay(struct uart_amba_port *uap)
+{
+	ktime_t ktime;
+
+	if (uap->rs485_current_status == rs485_receiving)
+		return;
+
+	/* if there is timeout in progress cancel it and start new */
+	hrtimer_try_to_cancel(&(uap->rs485_delay_timer));
+	hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));
+
+
+	if (!RS485_TX_FIFO_EMPTY(uap)
+			|| uap->port.rs485.delay_rts_after_send == 0) {
+		/*
+		 * Schedule validation timer if there is data in TX FIFO
+		 * because there is not TX FIFO empty interrupt
+		 */
+
+		uap->rs485_current_status = rs485_sending;
+		uap->rs485_next_status = rs485_sending;
+
+		uap->rs485_last_char_sending = false;
+
+		ktime = ktime_set(0, uap->send_char_time);
+		hrtimer_start(&(uap->rs485_tx_empty_poll_timer),
+			ktime,
+			HRTIMER_MODE_REL);
+		return;
+	}
+
+	/* Change state */
+	uap->rs485_current_status = rs485_delay_after_send;
+	uap->rs485_next_status = rs485_receiving;
+
+	/* RTS will be set in timer handler */
+
+	/* Start timer */
+	ktime = ktime_set(0, (uap->port.rs485.delay_rts_after_send
+			* 1000000L));
+
+	hrtimer_start(&(uap->rs485_delay_timer),
+		ktime,
+		HRTIMER_MODE_REL);
+}
+#endif
+
 static irqreturn_t pl011_int(int irq, void *dev_id)
 {
 	struct uart_amba_port *uap = dev_id;
@@ -1499,9 +1824,11 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 				else
 					pl011_rx_chars(uap);
 			}
+
 			if (status & (UART011_DSRMIS|UART011_DCDMIS|
 				      UART011_CTSMIS|UART011_RIMIS))
 				pl011_modem_status(uap);
+
 			if (status & UART011_TXIS)
 				pl011_tx_chars(uap, true);
 
@@ -1618,6 +1945,11 @@ static void pl011_quiesce_irqs(struct uart_port *port)
 	 */
 	pl011_write(pl011_read(uap, REG_IMSC) & ~UART011_TXIM, uap,
 		    REG_IMSC);
+
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+	if (uap->port.rs485.flags & SER_RS485_ENABLED)
+		pl011_rs485_start_rts_delay(uap);
+#endif
 }
 
 static int pl011_get_poll_char(struct uart_port *port)
@@ -1690,6 +2022,27 @@ static int pl011_hwinit(struct uart_port *port)
 		if (plat->init)
 			plat->init();
 	}
+
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+	/*
+	 * Initialize timers used for RS485
+	 */
+	hrtimer_init(&(uap->rs485_delay_timer),
+		CLOCK_MONOTONIC,
+		HRTIMER_MODE_REL);
+
+	uap->rs485_delay_timer.function = &pl011_rs485_timer;
+
+	hrtimer_init(&(uap->rs485_tx_empty_poll_timer),
+		CLOCK_MONOTONIC,
+		HRTIMER_MODE_REL);
+
+	uap->rs485_tx_empty_poll_timer.function = &pl011_rs485_tx_poll_timer;
+
+	uap->rs485_current_status = rs485_receiving;
+	RS485_SET_RTS_SIGNAL(uap, false);
+#endif
+
 	return 0;
 }
 
@@ -1873,6 +2226,16 @@ static void pl011_shutdown(struct uart_port *port)
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+	if (uap->port.rs485.flags & SER_RS485_ENABLED) {
+		hrtimer_try_to_cancel(&(uap->rs485_delay_timer));
+		hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));
+
+		uap->rs485_current_status = rs485_receiving;
+		RS485_SET_RTS_SIGNAL(uap, true);
+	}
+#endif
+
 	pl011_disable_interrupts(uap);
 
 	pl011_dma_shutdown(uap);
@@ -1955,6 +2318,24 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long flags;
 	unsigned int baud, quot, clkdiv;
 
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+	unsigned int transfer_bit_count;
+	unsigned long char_transfer_time;
+
+	/*
+	 * Calculate bit count which will be send
+	 * by UART. It is used for calculation of
+	 * time required to start timer until TX FIFO (HW) is empty
+	 * There is not interrupt for FIFO empty in PL011.
+	 * There is only FIFO empty flag in REG_FR.
+	 */
+	transfer_bit_count = 0;
+
+#define	ADD_DATA_BITS(bits)	(transfer_bit_count += bits)
+#else
+#define	ADD_DATA_BITS(bits)
+#endif
+
 	if (uap->vendor->oversampling)
 		clkdiv = 8;
 	else
@@ -1981,29 +2362,53 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
 		lcr_h = UART01x_LCRH_WLEN_5;
+		ADD_DATA_BITS(7);
 		break;
 	case CS6:
 		lcr_h = UART01x_LCRH_WLEN_6;
+		ADD_DATA_BITS(8);
 		break;
 	case CS7:
 		lcr_h = UART01x_LCRH_WLEN_7;
+		ADD_DATA_BITS(9);
 		break;
 	default: // CS8
 		lcr_h = UART01x_LCRH_WLEN_8;
+		ADD_DATA_BITS(10);
 		break;
 	}
-	if (termios->c_cflag & CSTOPB)
+
+	if (termios->c_cflag & CSTOPB) {
 		lcr_h |= UART01x_LCRH_STP2;
+		ADD_DATA_BITS(1);
+	}
+
 	if (termios->c_cflag & PARENB) {
 		lcr_h |= UART01x_LCRH_PEN;
+		ADD_DATA_BITS(1);
+
 		if (!(termios->c_cflag & PARODD))
 			lcr_h |= UART01x_LCRH_EPS;
+
 		if (termios->c_cflag & CMSPAR)
 			lcr_h |= UART011_LCRH_SPS;
 	}
+
+#undef ADD_DATA_BITS
+
 	if (uap->fifosize > 1)
 		lcr_h |= UART01x_LCRH_FEN;
 
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+	/* Calculate time required to send one char (nanoseconds) */
+	char_transfer_time =
+		(unsigned long) div_u64(
+				mul_u32_u32(
+					(u32)transfer_bit_count,
+					(u32)NSEC_PER_SEC),
+				(u32)baud);
+#endif
+
 	spin_lock_irqsave(&port->lock, flags);
 
 	/*
@@ -2020,6 +2425,11 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	old_cr = pl011_read(uap, REG_CR);
 	pl011_write(0, uap, REG_CR);
 
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+	/* Update send_char_time in locked context */
+	uap->send_char_time = char_transfer_time;
+#endif
+
 	if (termios->c_cflag & CRTSCTS) {
 		if (old_cr & UART011_CR_RTS)
 			old_cr |= UART011_CR_RTSEN;
@@ -2091,6 +2501,7 @@ static const char *pl011_type(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
+
 	return uap->port.type == PORT_AMBA ? uap->type : NULL;
 }
 
@@ -2122,6 +2533,47 @@ static void pl011_config_port(struct uart_port *port, int flags)
 	}
 }
 
+/*
+ * Configure RS485
+ * Locking: called with port lock held and IRQs disabled
+ */
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+static int pl011_config_rs485(struct uart_port *port,
+			      struct serial_rs485 *rs485)
+{
+	bool was_disabled;
+	struct uart_amba_port *uap =
+			container_of(port, struct uart_amba_port, port);
+
+	was_disabled = !(port->rs485.flags & SER_RS485_ENABLED);
+
+	port->rs485.flags = rs485->flags;
+	port->rs485.delay_rts_after_send = rs485->delay_rts_after_send;
+	port->rs485.delay_rts_before_send = rs485->delay_rts_before_send;
+
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		unsigned int cr;
+
+		hrtimer_try_to_cancel(&(uap->rs485_delay_timer));
+		hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));
+
+		/* If RS485 is enabled, disable auto RTS */
+		cr = pl011_read(uap, REG_CR);
+		cr &= ~UART011_CR_RTSEN;
+		pl011_write(cr, uap, REG_CR);
+
+		uap->rs485_current_status = rs485_receiving;
+		RS485_SET_RTS_SIGNAL(uap,
+			     port->rs485.flags
+				     & SER_RS485_RTS_AFTER_SEND);
+	} else {
+		RS485_SET_RTS_SIGNAL(uap, true);
+	}
+
+	return 0;
+}
+#endif
+
 /*
  * verify the new serial_struct (for TIOCSSERIAL).
  */
@@ -2647,6 +3099,12 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.irq = dev->irq[0];
 	uap->port.ops = &amba_pl011_pops;
 
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+	uap->port.rs485_config = &pl011_config_rs485;
+	uap->port.rs485.flags = 0;	/* RS485 is not enabled by default */
+	dev_info(&dev->dev, "Software switching for RS485 enabled\n");
+#endif
+
 	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
 
 	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
@@ -2819,10 +3277,15 @@ static struct amba_driver pl011_driver = {
 
 static int __init pl011_init(void)
 {
+#ifndef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
 	printk(KERN_INFO "Serial: AMBA PL011 UART driver\n");
+#else
+	printk(KERN_INFO "Serial: AMBA PL011 UART driver with soft RS485 support\n");
+#endif
 
 	if (platform_driver_register(&arm_sbsa_uart_platform_driver))
 		pr_warn("could not register SBSA UART platform driver\n");
+
 	return amba_driver_register(&pl011_driver);
 }
 
@@ -2832,6 +3295,11 @@ static void __exit pl011_exit(void)
 	amba_driver_unregister(&pl011_driver);
 }
 
+#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
+#undef RS485_SET_RTS_SIGNAL
+#undef RS485_TX_FIFO_EMPTY
+#endif
+
 /*
  * While this can be a module, if builtin it's most likely the console
  * So let's leave module_exit but move module_init to an earlier place
-- 
2.25.1


