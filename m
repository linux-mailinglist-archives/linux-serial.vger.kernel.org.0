Return-Path: <linux-serial+bounces-171-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED33E7F6092
	for <lists+linux-serial@lfdr.de>; Thu, 23 Nov 2023 14:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3161C210DA
	for <lists+linux-serial@lfdr.de>; Thu, 23 Nov 2023 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4182125578;
	Thu, 23 Nov 2023 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sl+3KmbI"
X-Original-To: linux-serial@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91480D41;
	Thu, 23 Nov 2023 05:42:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFB9920013;
	Thu, 23 Nov 2023 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700746967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Axpf3/ym3riiBLvwrKRQW22UpcQG/DDMdTP47PTMwFk=;
	b=Sl+3KmbIFIPbuoAbyEPAZJ7bkeFwMWoGDhKagTp1l+FB/2BsVDGSyz2MqLbLUY99XAo0pu
	gSzKSI5nk8vcf3TYBpBLDMcReKL7yAecVe8LbFJZ92I0LpXFUoUgYcUdNt9PT9/1WXmmXi
	LIJ69jIYUCCsoHwF4QNyi/G3D7nNE/bKyDs5yn8i+br+ORMA1vin4MXGabe8m3dZwCy8+9
	jmALJsAtT6clJ0ITl2928+jydoSuo/249jcvvPqYZ/vDptoJ7kD0h1Oga4EexnX0qfWYtg
	AQUHXU3RczmE9lp6HzWpWLlf70tRfUdvh1re8XeRqxR6GbzhGHbwpXmxm1vBnA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 23 Nov 2023 14:42:43 +0100
Subject: [PATCH v4 5/6] tty: serial: amba-pl011: unindent
 pl011_console_get_options function body
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231123-mbly-uart-v4-5-7f913a74ff89@bootlin.com>
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

The whole function body is encapsulated inside an if-condition. Reverse
the if logic and early return to remove one indentation level.

Also turn two nested ifs into a single one at the end of the function.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 43 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cf9aefe2fd28..4185d6fd243b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2369,35 +2369,34 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 static void pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 				      int *parity, int *bits)
 {
-	if (pl011_read(uap, REG_CR) & UART01x_CR_UARTEN) {
-		unsigned int lcr_h, ibrd, fbrd;
+	unsigned int lcr_h, ibrd, fbrd;
 
-		lcr_h = pl011_read(uap, REG_LCRH_TX);
+	if (!(pl011_read(uap, REG_CR) & UART01x_CR_UARTEN))
+		return;
 
-		*parity = 'n';
-		if (lcr_h & UART01x_LCRH_PEN) {
-			if (lcr_h & UART01x_LCRH_EPS)
-				*parity = 'e';
-			else
-				*parity = 'o';
-		}
+	lcr_h = pl011_read(uap, REG_LCRH_TX);
 
-		if ((lcr_h & 0x60) == UART01x_LCRH_WLEN_7)
-			*bits = 7;
+	*parity = 'n';
+	if (lcr_h & UART01x_LCRH_PEN) {
+		if (lcr_h & UART01x_LCRH_EPS)
+			*parity = 'e';
 		else
-			*bits = 8;
+			*parity = 'o';
+	}
 
-		ibrd = pl011_read(uap, REG_IBRD);
-		fbrd = pl011_read(uap, REG_FBRD);
+	if ((lcr_h & 0x60) == UART01x_LCRH_WLEN_7)
+		*bits = 7;
+	else
+		*bits = 8;
 
-		*baud = uap->port.uartclk * 4 / (64 * ibrd + fbrd);
+	ibrd = pl011_read(uap, REG_IBRD);
+	fbrd = pl011_read(uap, REG_FBRD);
 
-		if (uap->vendor->oversampling) {
-			if (pl011_read(uap, REG_CR)
-				  & ST_UART011_CR_OVSFACT)
-				*baud *= 2;
-		}
-	}
+	*baud = uap->port.uartclk * 4 / (64 * ibrd + fbrd);
+
+	if (uap->vendor->oversampling &&
+	    (pl011_read(uap, REG_CR) & ST_UART011_CR_OVSFACT))
+		*baud *= 2;
 }
 
 static int pl011_console_setup(struct console *co, char *options)

-- 
2.42.0


