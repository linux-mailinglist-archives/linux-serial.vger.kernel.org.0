Return-Path: <linux-serial+bounces-169-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4562D7F6091
	for <lists+linux-serial@lfdr.de>; Thu, 23 Nov 2023 14:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00089281E71
	for <lists+linux-serial@lfdr.de>; Thu, 23 Nov 2023 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF4425577;
	Thu, 23 Nov 2023 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J2oTzRMu"
X-Original-To: linux-serial@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140B9D40;
	Thu, 23 Nov 2023 05:42:47 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 260A720015;
	Thu, 23 Nov 2023 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700746966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17GEQHKW3hft8e8aie/LHPht5WTW7K+RQAvTRzHMMlw=;
	b=J2oTzRMuXReaHruyR29ZHzYil+7VF3HvonBbAkejKWZCX+Vp56GgIUv5xpOURIZ7c4yRmB
	V8KJbvhq1sGWAMrz3Exx/zTy5fBhqb5774I3T7mi1DBahndhF5m3EGKCdqRfFEoQUzgunI
	ccrXW6U1dN+ANVAav3rwba1nTxQU3kNiPx0JWlIY2P/vmByFWx1ICEa2LhB8xHY0QJoiyv
	lVkTg2wA5jQrb47nqXl77QmageYNYnfN0Nv9y/T8SVSdjtpjIOhBYkO2U5oplAXOd3xzu/
	TqtVEs4grxjCXOLM9MmJfMKjMi2erHP7tBXpN5IyjOoWq8s5MtLgDpTXsebVYg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 23 Nov 2023 14:42:42 +0100
Subject: [PATCH v4 4/6] tty: serial: amba-pl011: replace TIOCMBIT macros by
 static functions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231123-mbly-uart-v4-4-7f913a74ff89@bootlin.com>
References: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
In-Reply-To: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com

The driver uses two TIOCMBIT macros inside pl011_{get,set}_mctrl to
simplify the logic. Those look scary to checkpatch because they contain
ifs without do-while loops.

Avoid the macros by creating small equivalent static functions; that
lets the compiler do its type checking & avoids checkpatch errors.

For the second instance __assign_bit is not usable because it deals with
unsigned long pointers whereas we have an unsigned int in
pl011_set_mctrl.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 45 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3beac358909f..cf9aefe2fd28 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1594,6 +1594,12 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 							0 : TIOCSER_TEMT;
 }
 
+static void pl011_maybe_set_bit(bool cond, unsigned int *ptr, unsigned int mask)
+{
+	if (cond)
+		*ptr |= mask;
+}
+
 static unsigned int pl011_get_mctrl(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -1601,18 +1607,22 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
 	unsigned int result = 0;
 	unsigned int status = pl011_read(uap, REG_FR);
 
-#define TIOCMBIT(uartbit, tiocmbit)	\
-	if (status & uartbit)		\
-		result |= tiocmbit
+	pl011_maybe_set_bit(status & UART01x_FR_DCD, &result, TIOCM_CAR);
+	pl011_maybe_set_bit(status & uap->vendor->fr_dsr, &result, TIOCM_DSR);
+	pl011_maybe_set_bit(status & uap->vendor->fr_cts, &result, TIOCM_CTS);
+	pl011_maybe_set_bit(status & uap->vendor->fr_ri, &result, TIOCM_RNG);
 
-	TIOCMBIT(UART01x_FR_DCD, TIOCM_CAR);
-	TIOCMBIT(uap->vendor->fr_dsr, TIOCM_DSR);
-	TIOCMBIT(uap->vendor->fr_cts, TIOCM_CTS);
-	TIOCMBIT(uap->vendor->fr_ri, TIOCM_RNG);
-#undef TIOCMBIT
 	return result;
 }
 
+static void pl011_assign_bit(bool cond, unsigned int *ptr, unsigned int mask)
+{
+	if (cond)
+		*ptr |= mask;
+	else
+		*ptr &= ~mask;
+}
+
 static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_amba_port *uap =
@@ -1621,23 +1631,16 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	cr = pl011_read(uap, REG_CR);
 
-#define	TIOCMBIT(tiocmbit, uartbit)		\
-	if (mctrl & tiocmbit)		\
-		cr |= uartbit;		\
-	else				\
-		cr &= ~uartbit
-
-	TIOCMBIT(TIOCM_RTS, UART011_CR_RTS);
-	TIOCMBIT(TIOCM_DTR, UART011_CR_DTR);
-	TIOCMBIT(TIOCM_OUT1, UART011_CR_OUT1);
-	TIOCMBIT(TIOCM_OUT2, UART011_CR_OUT2);
-	TIOCMBIT(TIOCM_LOOP, UART011_CR_LBE);
+	pl011_assign_bit(mctrl & TIOCM_RTS, &cr, UART011_CR_RTS);
+	pl011_assign_bit(mctrl & TIOCM_DTR, &cr, UART011_CR_DTR);
+	pl011_assign_bit(mctrl & TIOCM_OUT1, &cr, UART011_CR_OUT1);
+	pl011_assign_bit(mctrl & TIOCM_OUT2, &cr, UART011_CR_OUT2);
+	pl011_assign_bit(mctrl & TIOCM_LOOP, &cr, UART011_CR_LBE);
 
 	if (port->status & UPSTAT_AUTORTS) {
 		/* We need to disable auto-RTS if we want to turn RTS off */
-		TIOCMBIT(TIOCM_RTS, UART011_CR_RTSEN);
+		pl011_assign_bit(mctrl & TIOCM_RTS, &cr, UART011_CR_RTSEN);
 	}
-#undef TIOCMBIT
 
 	pl011_write(cr, uap, REG_CR);
 }

-- 
2.42.0


