Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67830D1C
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 13:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEaLNw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 07:13:52 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58710 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaLNv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 07:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8bjlRRQk+fTkUda6A12qG2OKezeVUJOTB3AnBDWrHLE=; b=VXlsy3cDvivDOr6KXVxYbnmIM8
        joZVoF0PFIZdiB5fHbAqNhCcKA8xInT9eFUyvrKziyslsuIzM7jl64EBxVYX+IDA7mLytm7WmzFox
        C2FiWpchXXP93ow2C/3OIAijU61d4NK/7rNpnoB52pMbrQcV9FxRmQbSNshpHJNgEHJ+WwIxZLPno
        bAsFYrpd9LYUcQxjyMItPtR7eZ+1ya87nUYrLpOBRSh2znxY9BQm8FjhjDY1r0xeCXkUk85ANgICA
        +/6f//501g9t921nnC2ZVLFV5+KCwLHU8Q8NxG/UJiVGjAwcG4Ox58s7MSz4qPTOtrJQugjsW32U4
        8OLKtpdQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49054 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWfTo-0000Od-I4; Fri, 31 May 2019 12:13:48 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWfTn-0003fP-Rl; Fri, 31 May 2019 12:13:47 +0100
In-Reply-To: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 1/6] serial: sa1100: add support for mctrl gpios
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hWfTn-0003fP-Rl@rmk-PC.armlinux.org.uk>
Date:   Fri, 31 May 2019 12:13:47 +0100
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add support for the generic mctrl gpio helper.  This will allow us to
convert several board files to use the gpiod tables to assign GPIOs to
serial ports, rather than needing to have private function callbacks.

If the generic mctrl gpio helper fails, ignore the mctrl gpios rather
than preventing the (possibly console) serial port from being created.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/tty/serial/Kconfig  |  1 +
 drivers/tty/serial/sa1100.c | 42 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 72966bc0ac76..f4372ac1a774 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -511,6 +511,7 @@ config SERIAL_SA1100
 	bool "SA1100 serial port support"
 	depends on ARCH_SA1100
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
 	  If you have a machine based on a SA1100/SA1110 StrongARM(R) CPU you
 	  can enable its onboard serial port by enabling this option.
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index a399772be3fc..97bdfeccbea9 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -28,6 +28,8 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
+#include "serial_mctrl_gpio.h"
+
 /* We've been assigned a range on the "Low-density serial ports" major */
 #define SERIAL_SA1100_MAJOR	204
 #define MINOR_START		5
@@ -77,6 +79,7 @@ struct sa1100_port {
 	struct uart_port	port;
 	struct timer_list	timer;
 	unsigned int		old_status;
+	struct mctrl_gpios	*gpios;
 };
 
 /*
@@ -174,6 +177,8 @@ static void sa1100_enable_ms(struct uart_port *port)
 		container_of(port, struct sa1100_port, port);
 
 	mod_timer(&sport->timer, jiffies);
+
+	mctrl_gpio_enable_ms(sport->gpios);
 }
 
 static void
@@ -322,11 +327,21 @@ static unsigned int sa1100_tx_empty(struct uart_port *port)
 
 static unsigned int sa1100_get_mctrl(struct uart_port *port)
 {
-	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+	struct sa1100_port *sport =
+		container_of(port, struct sa1100_port, port);
+	int ret = TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+
+	mctrl_gpio_get(sport->gpios, &ret);
+
+	return ret;
 }
 
 static void sa1100_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	struct sa1100_port *sport =
+		container_of(port, struct sa1100_port, port);
+
+	mctrl_gpio_set(sport->gpios, mctrl);
 }
 
 /*
@@ -842,6 +857,27 @@ static int sa1100_serial_resume(struct platform_device *dev)
 	return 0;
 }
 
+static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
+{
+	sport->port.dev = &dev->dev;
+	sport->gpios = mctrl_gpio_init_noauto(sport->port.dev, 0);
+	if (IS_ERR(sport->gpios)) {
+		int err = PTR_ERR(sport->gpios);
+
+		dev_err(sport->port.dev, "failed to get mctrl gpios: %d\n",
+			err);
+
+		if (err == -EPROBE_DEFER)
+			return err;
+
+		sport->gpios = NULL;
+	}
+
+	platform_set_drvdata(dev, sport);
+
+	return uart_add_one_port(&sa1100_reg, &sport->port);
+}
+
 static int sa1100_serial_probe(struct platform_device *dev)
 {
 	struct resource *res = dev->resource;
@@ -856,9 +892,7 @@ static int sa1100_serial_probe(struct platform_device *dev)
 			if (sa1100_ports[i].port.mapbase != res->start)
 				continue;
 
-			sa1100_ports[i].port.dev = &dev->dev;
-			uart_add_one_port(&sa1100_reg, &sa1100_ports[i].port);
-			platform_set_drvdata(dev, &sa1100_ports[i]);
+			sa1100_serial_add_one_port(&sa1100_ports[i], dev);
 			break;
 		}
 	}
-- 
2.7.4

