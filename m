Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716A722D836
	for <lists+linux-serial@lfdr.de>; Sat, 25 Jul 2020 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgGYOuE (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 25 Jul 2020 10:50:04 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:36753 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgGYOuE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Jul 2020 10:50:04 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BDTWF4GC3z1qs03;
        Sat, 25 Jul 2020 16:50:01 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BDTWF3T2cz1qr5G;
        Sat, 25 Jul 2020 16:50:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id r5q1MyADoMcV; Sat, 25 Jul 2020 16:50:00 +0200 (CEST)
X-Auth-Info: UU9uXTc+bnB6IxSZRb7MZKChlEBkzB6qeQAsbGeSug8=
Received: from desktop.lan (ip-86-49-101-166.net.upcbroadband.cz [86.49.101.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 25 Jul 2020 16:50:00 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V2] serial: stm32: Add RS485 RTS GPIO control
Date:   Sat, 25 Jul 2020 16:49:47 +0200
Message-Id: <20200725144947.537007-1-marex@denx.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

While the STM32 does support RS485 drive-enable control within the
UART IP itself, some systems have the drive-enable line connected
to a pin which cannot be pinmuxed as RTS. Add support for toggling
the RTS GPIO line using the modem control GPIOs to provide at least
some sort of emulation.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-stm32@st-md-mailman.stormreply.com
---
V2: Use mctrl_gpio_set() instead of stm32_set_mctrl()
---
 drivers/tty/serial/stm32-usart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index d1c5e536a167..143300a80090 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -129,9 +129,13 @@ static int stm32_config_rs485(struct uart_port *port,
 		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
 			cr3 &= ~USART_CR3_DEP;
 			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
+			mctrl_gpio_set(stm32_port->gpios,
+					stm32_port->port.mctrl & ~TIOCM_RTS);
 		} else {
 			cr3 |= USART_CR3_DEP;
 			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
+			mctrl_gpio_set(stm32_port->gpios,
+					stm32_port->port.mctrl | TIOCM_RTS);
 		}
 
 		writel_relaxed(cr3, port->membase + ofs->cr3);
@@ -847,9 +851,13 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
 			cr3 &= ~USART_CR3_DEP;
 			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
+			mctrl_gpio_set(stm32_port->gpios,
+					stm32_port->port.mctrl & ~TIOCM_RTS);
 		} else {
 			cr3 |= USART_CR3_DEP;
 			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
+			mctrl_gpio_set(stm32_port->gpios,
+					stm32_port->port.mctrl | TIOCM_RTS);
 		}
 
 	} else {
-- 
2.27.0

