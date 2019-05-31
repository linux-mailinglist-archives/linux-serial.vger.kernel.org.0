Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B830D1E
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEaLOE (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 07:14:04 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58734 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaLOE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 07:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/kzikQ15PIWXB4mHJpGrjLzRGjyFUcAPIzWetE5H09c=; b=LBxstYM2jUWJcOU2V8bJ2HlcHI
        4W10capyj8qPTRjbqvmSJNFnr7KK3+9bdLX7n7D9B27/ZS9oSL+mQ8kUni2Y8Qn/6Blu4xCIGmNqG
        EsKB5UFFWmJnGZ1W+9ZoYrFCg8foqazHypvSEQ3TsIbtXwh8GAfu/qYKtPDWdEjqMNkEzyHvJrkWU
        dxAtfjGxG7AcsfWuelCnFX50rirj8G9NpTnXW2b3Y3CecAVAhrlp9udSDYwIpQp5MXmrDwH2m57rz
        x7ik7dSIEMvwLo2lgoJVLBtLDk27pz3pygv+UHXBSu32XKL1ehNQgmj8DL/4nBZKyatkKL51+vwdc
        oXLRQiPw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49058 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWfTz-0000Ov-Ct; Fri, 31 May 2019 12:13:59 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWfTy-0003fd-5R; Fri, 31 May 2019 12:13:58 +0100
In-Reply-To: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 3/6] ARM: sa1100/h3xxx: convert serial to gpiod APIs
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hWfTy-0003fd-5R@rmk-PC.armlinux.org.uk>
Date:   Fri, 31 May 2019 12:13:58 +0100
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the iPAQ H3xxx serial modem control signals to use the gpiod
APIs rather than custom callbacks into platform code.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/h3xxx.c | 64 ++++++++------------------------------------
 1 file changed, 11 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index 36a78b0c106f..e7362292612a 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -87,57 +87,6 @@ static struct resource h3xxx_flash_resource =
 /*
  * H3xxx uart support
  */
-static struct gpio h3xxx_uart_gpio[] = {
-	{ H3XXX_GPIO_COM_DCD,	GPIOF_IN,		"COM DCD" },
-	{ H3XXX_GPIO_COM_CTS,	GPIOF_IN,		"COM CTS" },
-	{ H3XXX_GPIO_COM_RTS,	GPIOF_OUT_INIT_LOW,	"COM RTS" },
-};
-
-static bool h3xxx_uart_request_gpios(void)
-{
-	static bool h3xxx_uart_gpio_ok;
-	int rc;
-
-	if (h3xxx_uart_gpio_ok)
-		return true;
-
-	rc = gpio_request_array(h3xxx_uart_gpio, ARRAY_SIZE(h3xxx_uart_gpio));
-	if (rc)
-		pr_err("h3xxx_uart_request_gpios: error %d\n", rc);
-	else
-		h3xxx_uart_gpio_ok = true;
-
-	return h3xxx_uart_gpio_ok;
-}
-
-static void h3xxx_uart_set_mctrl(struct uart_port *port, u_int mctrl)
-{
-	if (port->mapbase == _Ser3UTCR0) {
-		if (!h3xxx_uart_request_gpios())
-			return;
-		gpio_set_value(H3XXX_GPIO_COM_RTS, !(mctrl & TIOCM_RTS));
-	}
-}
-
-static u_int h3xxx_uart_get_mctrl(struct uart_port *port)
-{
-	u_int ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
-
-	if (port->mapbase == _Ser3UTCR0) {
-		if (!h3xxx_uart_request_gpios())
-			return ret;
-		/*
-		 * DCD and CTS bits are inverted in GPLR by RS232 transceiver
-		 */
-		if (gpio_get_value(H3XXX_GPIO_COM_DCD))
-			ret &= ~TIOCM_CD;
-		if (gpio_get_value(H3XXX_GPIO_COM_CTS))
-			ret &= ~TIOCM_CTS;
-	}
-
-	return ret;
-}
-
 static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 {
 	if (port->mapbase == _Ser3UTCR0) {
@@ -170,12 +119,20 @@ static int h3xxx_uart_set_wake(struct uart_port *port, u_int enable)
 }
 
 static struct sa1100_port_fns h3xxx_port_fns __initdata = {
-	.set_mctrl	= h3xxx_uart_set_mctrl,
-	.get_mctrl	= h3xxx_uart_get_mctrl,
 	.pm		= h3xxx_uart_pm,
 	.set_wake	= h3xxx_uart_set_wake,
 };
 
+static struct gpiod_lookup_table h3xxx_uart3_gpio_table = {
+	.dev_id = "sa11x0-uart.3",
+	.table = {
+		GPIO_LOOKUP("gpio", H3XXX_GPIO_COM_DCD, "dcd", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", H3XXX_GPIO_COM_CTS, "cts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", H3XXX_GPIO_COM_RTS, "rts", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /*
  * EGPIO
  */
@@ -283,6 +240,7 @@ static struct gpiod_lookup_table h3xxx_pcmcia_gpio_table = {
 void __init h3xxx_mach_init(void)
 {
 	gpiod_add_lookup_table(&h3xxx_pcmcia_gpio_table);
+	gpiod_add_lookup_table(&h3xxx_uart3_gpio_table);
 	sa1100_register_uart_fns(&h3xxx_port_fns);
 	sa11x0_register_mtd(&h3xxx_flash_data, &h3xxx_flash_resource, 1);
 	platform_add_devices(h3xxx_devices, ARRAY_SIZE(h3xxx_devices));
-- 
2.7.4

