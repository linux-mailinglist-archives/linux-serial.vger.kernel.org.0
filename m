Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2434C3C97C
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbfFKK4T (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 06:56:19 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:60450 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbfFKK4T (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 06:56:19 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id BC764A16E9;
        Tue, 11 Jun 2019 12:56:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id knhNzh7QUifB; Tue, 11 Jun 2019 12:56:05 +0200 (CEST)
From:   Stefan Roese <sr@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2 v5] tty/serial/8250: use mctrl_gpio helpers
Date:   Tue, 11 Jun 2019 12:56:03 +0200
Message-Id: <20190611105603.4435-2-sr@denx.de>
In-Reply-To: <20190611105603.4435-1-sr@denx.de>
References: <20190611105603.4435-1-sr@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

This patch permits the usage for GPIOs to control
the CTS/RTS/DTR/DSR/DCD/RI signals.

Changed by Stefan:
Only call mctrl_gpio_init(), if the device has no ACPI companion device
to not break existing ACPI based systems. Also only use the mctrl_gpio_
functions when "gpios" is available.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stefan Roese <sr@denx.de>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v5:
- Dropped a few "if (up->gpios)" checks, as the mctrl_gpio_foo() API
  handles gpios == NULL (return)
- 8250_omap: Changed "IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios, ...))"
  to "up->gpios == NULL", as mctrl_gpio_to_gpiod() does not handle
  gpios == NULL correctly.

v4:
- Added Mika's reviewed by tag
- Added Johan to Cc

v3:
- Only call mctrl_gpio_init(), if the device has no ACPI companion device
  to not break existing ACPI based systems, as suggested by Andy

v2:
- No change

Please note that this patch was already applied before [1]. And later
reverted [2] because it introduced problems on some x86 based boards
(ACPI GPIO related). Here a detailed description of the issue at that
time:

https://lkml.org/lkml/2016/8/9/357
http://www.spinics.net/lists/linux-serial/msg23071.html

This is a re-send of the original patch that was applied at that time.
With patch 1/2 from this series this issue should be fixed now (please
note that I can't test it on such an x86 platform causing these
problems).

Andy (or Mika), perhaps it would be possible for you to test this
patch again, now with patch 1/2 of this series applied as well?
That would be really helpful.

Thanks,
Stefan

[1] 4ef03d328769 ("tty/serial/8250: use mctrl_gpio helpers")
[2] 5db4f7f80d16 ("Revert "tty/serial/8250: use mctrl_gpio helpers"")

 .../devicetree/bindings/serial/8250.txt       | 19 +++++++++
 drivers/tty/serial/8250/8250.h                | 40 ++++++++++++++++++-
 drivers/tty/serial/8250/8250_core.c           | 17 ++++++++
 drivers/tty/serial/8250/8250_omap.c           | 29 ++++++++------
 drivers/tty/serial/8250/8250_port.c           |  7 ++++
 drivers/tty/serial/8250/Kconfig               |  1 +
 include/linux/serial_8250.h                   |  1 +
 7 files changed, 100 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 3cba12f855b7..20d351f268ef 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -53,6 +53,9 @@ Optional properties:
   programmable TX FIFO thresholds.
 - resets : phandle + reset specifier pairs
 - overrun-throttle-ms : how long to pause uart rx when input overrun is encountered.
+- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
+  line respectively. It will use specified GPIO instead of the peripheral
+  function pin for the UART feature. If unsure, don't specify this property.
 
 Note:
 * fsl,ns16550:
@@ -74,3 +77,19 @@ Example:
 		interrupts = <10>;
 		reg-shift = <2>;
 	};
+
+Example for OMAP UART using GPIO-based modem control signals:
+
+	uart4: serial@49042000 {
+		compatible = "ti,omap3-uart";
+		reg = <0x49042000 0x400>;
+		interrupts = <80>;
+		ti,hwmods = "uart4";
+		clock-frequency = <48000000>;
+		cts-gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
+		rts-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+		dtr-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+		dsr-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		dcd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+		rng-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+	};
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ebfb0bd5bef5..441aab94264b 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -11,6 +11,8 @@
 #include <linux/serial_reg.h>
 #include <linux/dmaengine.h>
 
+#include "../serial_mctrl_gpio.h"
+
 struct uart_8250_dma {
 	int (*tx_dma)(struct uart_8250_port *p);
 	int (*rx_dma)(struct uart_8250_port *p);
@@ -142,11 +144,47 @@ void serial8250_em485_destroy(struct uart_8250_port *p);
 static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
 {
 	serial_out(up, UART_MCR, value);
+
+	if (up->gpios) {
+		int mctrl_gpio = 0;
+
+		if (value & UART_MCR_RTS)
+			mctrl_gpio |= TIOCM_RTS;
+		if (value & UART_MCR_DTR)
+			mctrl_gpio |= TIOCM_DTR;
+
+		mctrl_gpio_set(up->gpios, mctrl_gpio);
+	}
 }
 
 static inline int serial8250_in_MCR(struct uart_8250_port *up)
 {
-	return serial_in(up, UART_MCR);
+	int mctrl;
+
+	mctrl = serial_in(up, UART_MCR);
+
+	if (up->gpios) {
+		int mctrl_gpio = 0;
+
+		/* save current MCR values */
+		if (mctrl & UART_MCR_RTS)
+			mctrl_gpio |= TIOCM_RTS;
+		if (mctrl & UART_MCR_DTR)
+			mctrl_gpio |= TIOCM_DTR;
+
+		mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
+		if (mctrl_gpio & TIOCM_RTS)
+			mctrl |= UART_MCR_RTS;
+		else
+			mctrl &= ~UART_MCR_RTS;
+
+		if (mctrl_gpio & TIOCM_DTR)
+			mctrl |= UART_MCR_DTR;
+		else
+			mctrl &= ~UART_MCR_DTR;
+	}
+
+	return mctrl;
 }
 
 #if defined(__alpha__) && !defined(CONFIG_PCI)
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e441221e04b9..a4470771005f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -14,6 +14,7 @@
  *	      serial8250_register_8250_port() ports
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
@@ -982,6 +983,8 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 	uart = serial8250_find_match_or_unused(&up->port);
 	if (uart && uart->port.type != PORT_8250_CIR) {
+		struct mctrl_gpios *gpios;
+
 		if (uart->port.dev)
 			uart_remove_one_port(&serial8250_reg, &uart->port);
 
@@ -1016,6 +1019,20 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (up->port.flags & UPF_FIXED_TYPE)
 			uart->port.type = up->port.type;
 
+		/*
+		 * Only call mctrl_gpio_init(), if the device has no ACPI
+		 * companion device
+		 */
+		if (!has_acpi_companion(uart->port.dev)) {
+			gpios = mctrl_gpio_init(&uart->port, 0);
+			if (IS_ERR(gpios)) {
+				if (PTR_ERR(gpios) != -ENOSYS)
+					return PTR_ERR(gpios);
+			} else {
+				uart->gpios = gpios;
+			}
+		}
+
 		serial8250_set_defaults(uart);
 
 		/* Possibly override default I/O functions.  */
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 0a8316632d75..620330599d39 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -141,18 +141,20 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	serial8250_do_set_mctrl(port, mctrl);
 
-	/*
-	 * Turn off autoRTS if RTS is lowered and restore autoRTS setting
-	 * if RTS is raised
-	 */
-	lcr = serial_in(up, UART_LCR);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
-		priv->efr |= UART_EFR_RTS;
-	else
-		priv->efr &= ~UART_EFR_RTS;
-	serial_out(up, UART_EFR, priv->efr);
-	serial_out(up, UART_LCR, lcr);
+	if (up->gpios == 0) {
+		/*
+		 * Turn off autoRTS if RTS is lowered and restore autoRTS
+		 * setting if RTS is raised
+		 */
+		lcr = serial_in(up, UART_LCR);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
+			priv->efr |= UART_EFR_RTS;
+		else
+			priv->efr &= ~UART_EFR_RTS;
+		serial_out(up, UART_EFR, priv->efr);
+		serial_out(up, UART_LCR, lcr);
+	}
 }
 
 /*
@@ -453,7 +455,8 @@ static void omap_8250_set_termios(struct uart_port *port,
 	priv->efr = 0;
 	up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
 
-	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
+	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW &&
+	    up->gpios == 0) {
 		/* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
 		up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
 		priv->efr |= UART_EFR_CTS;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2304a84eee3b..b86a16e2c9b6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1662,6 +1662,8 @@ static void serial8250_disable_ms(struct uart_port *port)
 	if (up->bugs & UART_BUG_NOMSR)
 		return;
 
+	mctrl_gpio_disable_ms(up->gpios);
+
 	up->ier &= ~UART_IER_MSI;
 	serial_port_out(port, UART_IER, up->ier);
 }
@@ -1674,6 +1676,8 @@ static void serial8250_enable_ms(struct uart_port *port)
 	if (up->bugs & UART_BUG_NOMSR)
 		return;
 
+	mctrl_gpio_enable_ms(up->gpios);
+
 	up->ier |= UART_IER_MSI;
 
 	serial8250_rpm_get(up);
@@ -1951,6 +1955,9 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
 	serial8250_rpm_put(up);
 
 	ret = 0;
+	if (up->gpios)
+		return mctrl_gpio_get(up->gpios, &ret);
+
 	if (status & UART_MSR_DCD)
 		ret |= TIOCM_CAR;
 	if (status & UART_MSR_RI)
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 296115f6a4d8..509f6a3bb9ff 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -8,6 +8,7 @@ config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
 	depends on !S390
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO if GPIOLIB
 	---help---
 	  This selects whether you want to include the driver for the standard
 	  serial ports.  The standard answer is Y.  People who might say N
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 5e0b59422a68..bb2bc99388ca 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -110,6 +110,7 @@ struct uart_8250_port {
 						 *   if no_console_suspend
 						 */
 	unsigned char		probe;
+	struct mctrl_gpios	*gpios;
 #define UART_PROBE_RSA	(1 << 0)
 
 	/*
-- 
2.22.0

