Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5513641D6F1
	for <lists+linux-serial@lfdr.de>; Thu, 30 Sep 2021 11:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349666AbhI3KAw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 Sep 2021 06:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349654AbhI3KAv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 06:00:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6850A617E6;
        Thu, 30 Sep 2021 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632995948;
        bh=K6FKq2NmXzk9TyUl3buQDg5LY+AZGHy3lCAN8OTMS+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j55llJTKngc1+hMJWvXPWn19sADxZcVBf4JHQ4qKkG+U08ke/2NLrv4HIF+rRncI/
         1EF8kbqokFB9FJK8aQuzHZ5XhD4gXdDKRothlVX2j4uAyglO8YjuTm9cwe81Dxcoba
         EVP3P4buA3rx12Nyf3FcDZbjDsm9KWsw71yxu4P17Q8W7nEWJDuOe9Xpi1P3BzzW8w
         TaAHz4yeQNOgT4i8a+dpWuV1l2hvgqMA7n8FpvwcTOX3SOsizF1oNgNTXbff/0+Oig
         Dam+vg9Umobl1FemjbuSyfQOjYNTGzarSZ5Z4B2tpNvG8DveJxsSVoh0wNKw07veah
         fqYF4bvtvb7Yw==
Received: by pali.im (Postfix)
        id 29166E79; Thu, 30 Sep 2021 11:59:08 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 6/6] serial: mvebu-uart: implement support for baudrates higher than 230400
Date:   Thu, 30 Sep 2021 11:58:38 +0200
Message-Id: <20210930095838.28145-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930095838.28145-1-pali@kernel.org>
References: <20210930095838.28145-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This change implements simple usage of fractional divisor. When main
divisor D is too large to represent requested baudrate then use divisor M
from fractional divisor feature. All the M prescalers are set to same and
maximal value 63, so fractional part is not used at all.

Tests showed that UART at 1500000 baudrate via this configuration is stable
and usable. So there is no need to implement complicated calculation of
fractional coefficients yet.

To use this feature with higher baudrates, it is required to use UART clock
provided by UART clock driver. Default boot xtal clock is not capable of
higher baudrates and this change also contains code for determining upper
limit of possible baudrate.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/tty/serial/mvebu-uart.c | 79 ++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index f3fb1f3718f2..925b3e0c098c 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -99,6 +99,7 @@
 #define UART_OSAMP		0x14
 #define  OSAMP_DEFAULT_DIVISOR	16
 #define  OSAMP_DIVISORS_MASK	0x3F3F3F3F
+#define  OSAMP_MAX_DIVISOR	63
 
 #define MVEBU_NR_UARTS		2
 
@@ -479,18 +480,59 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 		return -EOPNOTSUPP;
 
 	/*
-	 * The baudrate is derived from the UART clock thanks to two divisors:
-	 *   > D ("baud generator"): can divide the clock from 2 to 2^10 - 1.
-	 *   > M ("fractional divisor"): allows a better accuracy for
-	 *     baudrates higher than 230400.
+	 * The baudrate is derived from the UART clock thanks to divisors:
+	 *   > d1 * d2 ("TBG divisors"): can divide only TBG clock from 1 to 6
+	 *   > D ("baud generator"): can divide the clock from 1 to 1023
+	 *   > M ("fractional divisor"): allows a better accuracy (from 1 to 63)
 	 *
-	 * As the derivation of M is rather complicated, the code sticks to its
-	 * default value (x16) when all the prescalers are zeroed, and only
-	 * makes use of D to configure the desired baudrate.
+	 * Exact formulas for calculating baudrate:
+	 *
+	 * with default x16 scheme:
+	 *   baudrate = xtal / (d * 16)
+	 *   baudrate = tbg / (d1 * d2 * d * 16)
+	 *
+	 * with fractional divisor:
+	 *   baudrate = 10 * xtal / (d * (3 * (m1 + m2) + 2 * (m3 + m4)))
+	 *   baudrate = 10 * tbg / (d1*d2 * d * (3 * (m1 + m2) + 2 * (m3 + m4)))
+	 *
+	 * Oversampling value:
+	 *   osamp = (m1 << 0) | (m2 << 8) | (m3 << 16) | (m4 << 24);
+	 *
+	 * Where m1 controls number of clock cycles per bit for bits 1,2,3;
+	 * m2 for bits 4,5,6; m3 for bits 7,8 and m4 for bits 9,10.
+	 *
+	 * To simplify baudrate setup set all the M prescalers to same value.
+	 * For 9600 baudrate and higher it is enough to use just default (x16)
+	 * divisor or fractional divisor with M = 63, so there is no need to
+	 * use real fractional support (when the M prescalers are not equal).
+	 *
+	 * When all the M prescalers are zeroed then default (x16) divisor is
+	 * used. Default x16 scheme is more stable than M (fractional divisor),
+	 * so use M only when D divisor is not enough to derivate baudrate.
+	 *
+	 * Member port->uartclk is either xtal clock rate or TBG clock rate
+	 * divided by (d1 * d2). So UART clock driver already sets d1 and d2
+	 * divisors and UART driver cannot change them. Moreover they are
+	 * shared with both UARTs.
 	 */
+
 	m_divisor = OSAMP_DEFAULT_DIVISOR;
 	d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
 
+	if (d_divisor > BRDV_BAUD_MAX) {
+		/*
+		 * Experiments showed that small M divisors are unstable.
+		 * So use maximal possible M = 63 and calculate D divisor.
+		 */
+		m_divisor = OSAMP_MAX_DIVISOR;
+		d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
+	}
+
+	if (d_divisor < 1)
+		d_divisor = 1;
+	else if (d_divisor > BRDV_BAUD_MAX)
+		d_divisor = BRDV_BAUD_MAX;
+
 	spin_lock_irqsave(&mvebu_uart_lock, flags);
 	brdv = readl(port->membase + UART_BRDV);
 	brdv &= ~BRDV_BAUD_MASK;
@@ -500,6 +542,9 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 
 	osamp = readl(port->membase + UART_OSAMP);
 	osamp &= ~OSAMP_DIVISORS_MASK;
+	if (m_divisor != OSAMP_DEFAULT_DIVISOR)
+		osamp |= (m_divisor << 0) | (m_divisor << 8) |
+			(m_divisor << 16) | (m_divisor << 24);
 	writel(osamp, port->membase + UART_OSAMP);
 
 	return 0;
@@ -529,14 +574,14 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 		port->ignore_status_mask |= STAT_RX_RDY(port) | STAT_BRK_ERR;
 
 	/*
-	 * Maximal divisor is 1023 * 16 when using default (x16) scheme.
-	 * Maximum achievable frequency with simple baudrate divisor is 230400.
-	 * Since the error per bit frame would be of more than 15%, achieving
-	 * higher frequencies would require to implement the fractional divisor
-	 * feature.
+	 * Maximal divisor is 1023 and maximal fractional divisor is 63. And
+	 * experiments showed that baudrates above 1/80 of base clock are not
+	 * stable and usable. So disallow baudrate above 1/80 of the base clock.
+	 * When port->uartclk is not available then mvebu_uart_baud_rate_set()
+	 * fails so values min_baud and max_baud in this case does not matter.
 	 */
-	min_baud = DIV_ROUND_UP(port->uartclk, 1023 * 16);
-	max_baud = 230400;
+	min_baud = DIV_ROUND_UP(port->uartclk, BRDV_BAUD_MAX*OSAMP_MAX_DIVISOR);
+	max_baud = port->uartclk / 80;
 
 	baud = uart_get_baud_rate(port, termios, old, min_baud, max_baud);
 	if (mvebu_uart_baud_rate_set(port, baud)) {
@@ -1394,14 +1439,14 @@ static int mvebu_uart_clock_probe(struct platform_device *pdev)
 			 * Calculate the smallest TBG d1 and d2 divisors that
 			 * still can provide 9600 baudrate.
 			 */
-			d1 = DIV_ROUND_UP(rate, 9600 * OSAMP_DEFAULT_DIVISOR *
+			d1 = DIV_ROUND_UP(rate, 9600 * OSAMP_MAX_DIVISOR *
 						BRDV_BAUD_MAX);
 			if (d1 < 1)
 				d1 = 1;
 			else if (d1 > CLK_TBG_DIV1_MAX)
 				d1 = CLK_TBG_DIV1_MAX;
 
-			d2 = DIV_ROUND_UP(rate, 9600 * OSAMP_DEFAULT_DIVISOR *
+			d2 = DIV_ROUND_UP(rate, 9600 * OSAMP_MAX_DIVISOR *
 						BRDV_BAUD_MAX * d1);
 			if (d2 < 1)
 				d2 = 1;
@@ -1416,7 +1461,7 @@ static int mvebu_uart_clock_probe(struct platform_device *pdev)
 		}
 
 		/* Skip clock source which cannot provide 9600 baudrate */
-		if (rate > 9600 * OSAMP_DEFAULT_DIVISOR * BRDV_BAUD_MAX * d1 * d2)
+		if (rate > 9600 * OSAMP_MAX_DIVISOR * BRDV_BAUD_MAX * d1 * d2)
 			continue;
 
 		/*
-- 
2.20.1

