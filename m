Return-Path: <linux-serial+bounces-7298-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF83B9FA218
	for <lists+linux-serial@lfdr.de>; Sat, 21 Dec 2024 20:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173FC161B61
	for <lists+linux-serial@lfdr.de>; Sat, 21 Dec 2024 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE491632D2;
	Sat, 21 Dec 2024 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+DnH7a7"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEC290F;
	Sat, 21 Dec 2024 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734808267; cv=none; b=gOEEn0gvR5msCVMcdNmF7rqQ4YqzUrX0hJFfHFD4kflhjz46vn9JMhNTopoQfy9CPmFTqrejHjEK3+yaoGwJL3hK89ic3y1EwXRxGongvNGf2HIFsvovK2d5tqja7n3T8/j2huzLDu/nb9x/WdYkHGHDsrwThMH4+4y0IM71Ep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734808267; c=relaxed/simple;
	bh=dbZekWCBFJGefU3x3a2lF2LK8Sg1cUx/oM6Dsyo+yaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bpav15xQ9DxjgHvFc6R8N5oAqHGXpVNmoUpVjPSMAl8lLn4WEHEi/HSJ4Q+5tUbrjKCUQgDSZ19Tp5+LXSAKFrDvU/El28YT0a0iKEJlZjlCgXY1DbJk6NgdTz+47HmflEqxiK9MoBieGARH8qCuZIwHh72ETvsvm5qHWA71ruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+DnH7a7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C40A4C4CECE;
	Sat, 21 Dec 2024 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734808266;
	bh=dbZekWCBFJGefU3x3a2lF2LK8Sg1cUx/oM6Dsyo+yaU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=d+DnH7a7iqqZ1OHv47Aj+jI8PG7k933dxnE31/GNOg5Uel1QwzoT5UTJ7Zspzg6fI
	 emBU3BaPFLDAc4CKPfnz80Fle/mtg+Zife5qvM5UfK5OC0CgeCrModh1GByr/cmsOq
	 zGc29Eb2R/HH5eONX5sBnIxO99iy3SqH08SJVFM4/bbRkdKI7R/6K6XJgi2rHHcUXZ
	 1qkDKeS0YB9yBw18jQh3o3CdwSePHvnG6nwKpk7AY0wbrV3M/6ts2b+9YAvTNnur9q
	 xKF0erwrlFXjpfO2HLkJPfwtQ5X2z+cknE4ncLuArQtvNy0PSMrw4zb9kZLwCbzKBN
	 zCw+ZW1fjGSlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4546E7718D;
	Sat, 21 Dec 2024 19:11:06 +0000 (UTC)
From: Miroslav Ondra via B4 Relay <devnull+ondra.faster.cz@kernel.org>
Date: Sat, 21 Dec 2024 20:11:04 +0100
Subject: [PATCH v3] serial: amba-pl011: Fix RTS handling in RS485 mode
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-amba-rts-v3-1-d3d444681419@faster.cz>
X-B4-Tracking: v=1; b=H4sIAMcSZ2cC/03Muw7CMAyF4VepPGOUuMVcJt4DMSSpQzO0RU5UI
 aq+O1Enxk/n6F8hiybJcGtWUFlSTvNU0R4aCIObXoKprwYy1Fkii270DrVkDCfmzopnPnuo97d
 KTJ899XhWR51HLIOK+wsYxtHlIooLoUVDTJc+mJbD9R734Ri+sG0/2yR94JgAAAA=
X-Change-ID: 20241221-amba-rts-c56641eb667b
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Miroslav Ondra <ondra@faster.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734808265; l=8755;
 i=ondra@faster.cz; s=20241119; h=from:subject:message-id;
 bh=7ww/fR+R85ZDHAyR5oTN8K0ZX8dloPYYuhfT7PVTHig=;
 b=z+ZpYP/eKWyQH4FovOr7wq4aqgZLEDeo3R2grj2HYncGHjLBFEcihivRZuvG5buXdc5Vw2BZQ
 gLMw737c8zNDJVRP3Iz0nnmRu94H0WUupYuhcz5lukdJHcXVxkLx4OA
X-Developer-Key: i=ondra@faster.cz; a=ed25519;
 pk=OgmjYvFJ0npSTnp6LOgY/siJeZ/6t3nOEs4jE9vm0Oc=
X-Endpoint-Received: by B4 Relay for ondra@faster.cz/20241119 with
 auth_id=282
X-Original-From: Miroslav Ondra <ondra@faster.cz>
Reply-To: ondra@faster.cz

From: Miroslav Ondra <ondra@faster.cz>

Data loss on serial line was observed during communication through
serial ports ttyAMA1 and ttyAMA2 interconnected via RS485 transcievers.
Both ports are in one BCM2711 (Compute Module CM40) and they share
the same interrupt line.

The problem is caused by long waiting for tx queue flush in the function
pl011_rs485_tx_stop. Udelay or mdelay are used to wait.
The function is called from the interrupt handler. If multiple devices
share a single interrupt line, late processing of pending interrupts
and data loss may occur. When operation of both devices are synchronous,
collisions are quite often.

This rework is based on the method used in tty/serial/imx.c
Use hrtimer instead of udelay and mdelay calls.
Replace simple bool variable rs485_tx_started by 4-state variable
rs485_tx_state.

Tested-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Signed-off-by: Miroslav Ondra <ondra@faster.cz>
---
Thanks Lino for testing.
Thanks Greg for the advice.
---
Changes in v3:
- Collect tags from tester
- Link to v2: https://lore.kernel.org/r/20241206-master-v2-1-02628dc036c9@faster.cz

Changes in v2:
- Reword commit message to explain the problem.
- Link to v1: https://lore.kernel.org/r/20241123-master-v1-1-260194426ea3@faster.cz
---
 drivers/tty/serial/amba-pl011.c | 126 ++++++++++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 69b7a3e1e418e200944b0b0429b6341d71ecff26..04212c823a91d5a343327292d8ffd95be1465473 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -248,6 +248,13 @@ struct pl011_dmatx_data {
 	bool			queued;
 };
 
+enum pl011_rs485_tx_state {
+	OFF,
+	WAIT_AFTER_RTS,
+	SEND,
+	WAIT_AFTER_SEND,
+};
+
 /*
  * We wrap our port structure around the generic uart_port.
  */
@@ -261,8 +268,10 @@ struct uart_amba_port {
 	unsigned int		fifosize;	/* vendor-specific */
 	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
 	char			type[12];
-	bool			rs485_tx_started;
-	unsigned int		rs485_tx_drain_interval; /* usecs */
+	ktime_t			rs485_tx_drain_interval; /* nano */
+	enum pl011_rs485_tx_state	rs485_tx_state;
+	struct hrtimer		trigger_start_tx;
+	struct hrtimer		trigger_stop_tx;
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	unsigned int		dmacr;		/* dma control reg */
@@ -1260,30 +1269,31 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
 
 static void pl011_rs485_tx_stop(struct uart_amba_port *uap)
 {
-	/*
-	 * To be on the safe side only time out after twice as many iterations
-	 * as fifo size.
-	 */
-	const int MAX_TX_DRAIN_ITERS = uap->port.fifosize * 2;
 	struct uart_port *port = &uap->port;
-	int i = 0;
 	u32 cr;
 
-	/* Wait until hardware tx queue is empty */
-	while (!pl011_tx_empty(port)) {
-		if (i > MAX_TX_DRAIN_ITERS) {
-			dev_warn(port->dev,
-				 "timeout while draining hardware tx queue\n");
-			break;
-		}
+	if (uap->rs485_tx_state == SEND)
+		uap->rs485_tx_state = WAIT_AFTER_SEND;
 
-		udelay(uap->rs485_tx_drain_interval);
-		i++;
+	if (uap->rs485_tx_state == WAIT_AFTER_SEND) {
+		/* Schedule hrtimer if tx queue not empty */
+		if (!pl011_tx_empty(port)) {
+			hrtimer_start(&uap->trigger_stop_tx,
+				      uap->rs485_tx_drain_interval,
+				      HRTIMER_MODE_REL);
+			return;
+		}
+		if (port->rs485.delay_rts_after_send > 0) {
+			hrtimer_start(&uap->trigger_stop_tx,
+				      ms_to_ktime(port->rs485.delay_rts_after_send),
+				      HRTIMER_MODE_REL);
+			return;
+		}
+		/* Continue without any delay */
+	} else if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
+		hrtimer_try_to_cancel(&uap->trigger_start_tx);
 	}
 
-	if (port->rs485.delay_rts_after_send)
-		mdelay(port->rs485.delay_rts_after_send);
-
 	cr = pl011_read(uap, REG_CR);
 
 	if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
@@ -1296,7 +1306,7 @@ static void pl011_rs485_tx_stop(struct uart_amba_port *uap)
 	cr |= UART011_CR_RXE;
 	pl011_write(cr, uap, REG_CR);
 
-	uap->rs485_tx_started = false;
+	uap->rs485_tx_state = OFF;
 }
 
 static void pl011_stop_tx(struct uart_port *port)
@@ -1304,11 +1314,18 @@ static void pl011_stop_tx(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
+	if (port->rs485.flags & SER_RS485_ENABLED &&
+	    uap->rs485_tx_state == WAIT_AFTER_RTS) {
+		pl011_rs485_tx_stop(uap);
+		return;
+	}
+
 	uap->im &= ~UART011_TXIM;
 	pl011_write(uap->im, uap, REG_IMSC);
 	pl011_dma_tx_stop(uap);
 
-	if ((port->rs485.flags & SER_RS485_ENABLED) && uap->rs485_tx_started)
+	if (port->rs485.flags & SER_RS485_ENABLED &&
+	    uap->rs485_tx_state != OFF)
 		pl011_rs485_tx_stop(uap);
 }
 
@@ -1328,10 +1345,19 @@ static void pl011_rs485_tx_start(struct uart_amba_port *uap)
 	struct uart_port *port = &uap->port;
 	u32 cr;
 
+	if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
+		uap->rs485_tx_state = SEND;
+		return;
+	}
+	if (uap->rs485_tx_state == WAIT_AFTER_SEND) {
+		hrtimer_try_to_cancel(&uap->trigger_stop_tx);
+		uap->rs485_tx_state = SEND;
+		return;
+	}
+	/* uap->rs485_tx_state == OFF */
 	/* Enable transmitter */
 	cr = pl011_read(uap, REG_CR);
 	cr |= UART011_CR_TXE;
-
 	/* Disable receiver if half-duplex */
 	if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
 		cr &= ~UART011_CR_RXE;
@@ -1343,10 +1369,14 @@ static void pl011_rs485_tx_start(struct uart_amba_port *uap)
 
 	pl011_write(cr, uap, REG_CR);
 
-	if (port->rs485.delay_rts_before_send)
-		mdelay(port->rs485.delay_rts_before_send);
-
-	uap->rs485_tx_started = true;
+	if (port->rs485.delay_rts_before_send > 0) {
+		uap->rs485_tx_state = WAIT_AFTER_RTS;
+		hrtimer_start(&uap->trigger_start_tx,
+			      ms_to_ktime(port->rs485.delay_rts_before_send),
+			      HRTIMER_MODE_REL);
+	} else {
+		uap->rs485_tx_state = SEND;
+	}
 }
 
 static void pl011_start_tx(struct uart_port *port)
@@ -1355,13 +1385,44 @@ static void pl011_start_tx(struct uart_port *port)
 	    container_of(port, struct uart_amba_port, port);
 
 	if ((uap->port.rs485.flags & SER_RS485_ENABLED) &&
-	    !uap->rs485_tx_started)
+	    uap->rs485_tx_state != SEND) {
 		pl011_rs485_tx_start(uap);
+		if (uap->rs485_tx_state == WAIT_AFTER_RTS)
+			return;
+	}
 
 	if (!pl011_dma_tx_start(uap))
 		pl011_start_tx_pio(uap);
 }
 
+static enum hrtimer_restart pl011_trigger_start_tx(struct hrtimer *t)
+{
+	struct uart_amba_port *uap =
+	    container_of(t, struct uart_amba_port, trigger_start_tx);
+	unsigned long flags;
+
+	uart_port_lock_irqsave(&uap->port, &flags);
+	if (uap->rs485_tx_state == WAIT_AFTER_RTS)
+		pl011_start_tx(&uap->port);
+	uart_port_unlock_irqrestore(&uap->port, flags);
+
+	return HRTIMER_NORESTART;
+}
+
+static enum hrtimer_restart pl011_trigger_stop_tx(struct hrtimer *t)
+{
+	struct uart_amba_port *uap =
+	    container_of(t, struct uart_amba_port, trigger_stop_tx);
+	unsigned long flags;
+
+	uart_port_lock_irqsave(&uap->port, &flags);
+	if (uap->rs485_tx_state == WAIT_AFTER_SEND)
+		pl011_rs485_tx_stop(uap);
+	uart_port_unlock_irqrestore(&uap->port, flags);
+
+	return HRTIMER_NORESTART;
+}
+
 static void pl011_stop_rx(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -1953,7 +2014,7 @@ static void pl011_shutdown(struct uart_port *port)
 
 	pl011_dma_shutdown(uap);
 
-	if ((port->rs485.flags & SER_RS485_ENABLED) && uap->rs485_tx_started)
+	if ((port->rs485.flags & SER_RS485_ENABLED && uap->rs485_tx_state != OFF))
 		pl011_rs485_tx_stop(uap);
 
 	free_irq(uap->port.irq, uap);
@@ -2098,7 +2159,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * with the given baud rate. We use this as the poll interval when we
 	 * wait for the tx queue to empty.
 	 */
-	uap->rs485_tx_drain_interval = DIV_ROUND_UP(bits * 1000 * 1000, baud);
+	uap->rs485_tx_drain_interval = ns_to_ktime(DIV_ROUND_UP(bits * NSEC_PER_SEC, baud));
 
 	pl011_setup_status_masks(port, termios);
 
@@ -2807,6 +2868,11 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		}
 	}
 
+	hrtimer_init(&uap->trigger_start_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&uap->trigger_stop_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	uap->trigger_start_tx.function = pl011_trigger_start_tx;
+	uap->trigger_stop_tx.function = pl011_trigger_stop_tx;
+
 	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
 	if (ret)
 		return ret;

---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20241221-amba-rts-c56641eb667b

Best regards,
-- 
Miroslav Ondra <ondra@faster.cz>



