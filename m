Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6CC530D1D
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEaLN6 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 07:13:58 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58722 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaLN6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 07:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Gzp8KfSgQvRYKFZ01QunVwyv7cpNB81rwCpXsUFUAI8=; b=BthQtLYUzRSWk2dKQDkg8RogVG
        X28j08ztaNm/122GTHqU+/0ehni5g3ylyZ9cxqI7AveZC/LdM+DSw6BzwbiXFZ6ShYYHt7HWFC5TU
        Xt+H/zjcnzqRmLQIFK9vsBlx1sEO/nnDtDJPXfbIicIEAhOR9ddZEyp4OEtDGXiPtsOMxgxR1nh03
        svB6yskTElbx8uZexWBHa03l3FFZy3kvSpKSaMIM3mmwRnuDqVeFnHHBDfaA3rMANNiAvV6HJi2+o
        Bp04b1KxTOd7N0BcOnxz0sQezjJz7WPpZ4i65DiWJ5zrXePwZZofKtKQZ0O/pzR6jjUl5ijxmtgEx
        E9ddmqsw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:49570 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWfTu-0000Om-0S; Fri, 31 May 2019 12:13:54 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWfTt-0003fW-22; Fri, 31 May 2019 12:13:53 +0100
In-Reply-To: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 2/6] ARM: sa1100/assabet: convert serial to gpiod APIs
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hWfTt-0003fW-22@rmk-PC.armlinux.org.uk>
Date:   Fri, 31 May 2019 12:13:53 +0100
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the Assabet serial modem control signals to use the gpiod APIs
rather than custom callbacks into platform code.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c | 91 +++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index d09c3f236186..bc035821a42b 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -522,6 +522,29 @@ static const struct gpio_keys_platform_data assabet_keys_pdata = {
 	.rep = 0,
 };
 
+static struct gpiod_lookup_table assabet_uart1_gpio_table = {
+	.dev_id = "sa11x0-uart.1",
+	.table = {
+		GPIO_LOOKUP("assabet", 16, "dtr", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 17, "rts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 25, "dcd", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 26, "cts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 27, "dsr", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
+static struct gpiod_lookup_table assabet_uart3_gpio_table = {
+	.dev_id = "sa11x0-uart.3",
+	.table = {
+		GPIO_LOOKUP("assabet", 28, "cts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 29, "dsr", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 30, "dcd", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 31, "rng", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static void __init assabet_init(void)
 {
 	/*
@@ -568,7 +591,10 @@ static void __init assabet_init(void)
 			neponset_resources, ARRAY_SIZE(neponset_resources));
 #endif
 	} else {
+		gpiod_add_lookup_table(&assabet_uart1_gpio_table);
+		gpiod_add_lookup_table(&assabet_uart3_gpio_table);
 		gpiod_add_lookup_table(&assabet_cf_vcc_gpio_table);
+
 		sa11x0_register_fixed_regulator(0, &assabet_cf_vcc_pdata,
 					assabet_cf_vcc_consumers,
 					ARRAY_SIZE(assabet_cf_vcc_consumers),
@@ -658,74 +684,13 @@ static void assabet_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 {
 	if (port->mapbase == _Ser1UTCR0) {
 		if (state)
-			ASSABET_BCR_clear(ASSABET_BCR_RS232EN |
-					  ASSABET_BCR_COM_RTS |
-					  ASSABET_BCR_COM_DTR);
-		else
-			ASSABET_BCR_set(ASSABET_BCR_RS232EN |
-					ASSABET_BCR_COM_RTS |
-					ASSABET_BCR_COM_DTR);
-	}
-}
-
-/*
- * Assabet uses COM_RTS and COM_DTR for both UART1 (com port)
- * and UART3 (radio module).  We only handle them for UART1 here.
- */
-static void assabet_set_mctrl(struct uart_port *port, u_int mctrl)
-{
-	if (port->mapbase == _Ser1UTCR0) {
-		u_int set = 0, clear = 0;
-
-		if (mctrl & TIOCM_RTS)
-			clear |= ASSABET_BCR_COM_RTS;
+			ASSABET_BCR_clear(ASSABET_BCR_RS232EN);
 		else
-			set |= ASSABET_BCR_COM_RTS;
-
-		if (mctrl & TIOCM_DTR)
-			clear |= ASSABET_BCR_COM_DTR;
-		else
-			set |= ASSABET_BCR_COM_DTR;
-
-		ASSABET_BCR_clear(clear);
-		ASSABET_BCR_set(set);
-	}
-}
-
-static u_int assabet_get_mctrl(struct uart_port *port)
-{
-	u_int ret = 0;
-	u_int bsr = ASSABET_BSR;
-
-	/* need 2 reads to read current value */
-	bsr = ASSABET_BSR;
-
-	if (port->mapbase == _Ser1UTCR0) {
-		if (bsr & ASSABET_BSR_COM_DCD)
-			ret |= TIOCM_CD;
-		if (bsr & ASSABET_BSR_COM_CTS)
-			ret |= TIOCM_CTS;
-		if (bsr & ASSABET_BSR_COM_DSR)
-			ret |= TIOCM_DSR;
-	} else if (port->mapbase == _Ser3UTCR0) {
-		if (bsr & ASSABET_BSR_RAD_DCD)
-			ret |= TIOCM_CD;
-		if (bsr & ASSABET_BSR_RAD_CTS)
-			ret |= TIOCM_CTS;
-		if (bsr & ASSABET_BSR_RAD_DSR)
-			ret |= TIOCM_DSR;
-		if (bsr & ASSABET_BSR_RAD_RI)
-			ret |= TIOCM_RI;
-	} else {
-		ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
+			ASSABET_BCR_set(ASSABET_BCR_RS232EN);
 	}
-
-	return ret;
 }
 
 static struct sa1100_port_fns assabet_port_fns __initdata = {
-	.set_mctrl	= assabet_set_mctrl,
-	.get_mctrl	= assabet_get_mctrl,
 	.pm		= assabet_uart_pm,
 };
 
-- 
2.7.4

