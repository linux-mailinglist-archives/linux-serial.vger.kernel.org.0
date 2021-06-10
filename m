Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0EA3A335F
	for <lists+linux-serial@lfdr.de>; Thu, 10 Jun 2021 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFJSlU (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 10 Jun 2021 14:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhFJSlU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Jun 2021 14:41:20 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99A7EC061760
        for <linux-serial@vger.kernel.org>; Thu, 10 Jun 2021 11:39:23 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0C88A92009D; Thu, 10 Jun 2021 20:39:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0678D92009B;
        Thu, 10 Jun 2021 20:39:20 +0200 (CEST)
Date:   Thu, 10 Jun 2021 20:39:20 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] serial: 8250: Define RX trigger levels for OxSemi 950
 devices
In-Reply-To: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2106101300280.2092@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Oxford Semiconductor 950 serial port devices have a 128-byte FIFO and in 
the enhanced (650) mode, which we select in `autoconfig_has_efr' with 
the ECB bit set in the EFR register, they support the receive interrupt 
trigger level selectable with FCR bits 7:6 from the set of 16, 32, 112, 
120.  This applies to the original OX16C950 discrete UART[1] as well as 
950 cores embedded into more complex devices.

For these devices we set the default to 112, which sets an excessively 
high level of 112 or 7/8 of the FIFO capacity, unlike with other port 
types where we choose at most 1/2 of their respective FIFO capacities.  
Additionally we don't make the trigger level configurable.  Consequently 
frequent input overruns happen with high bit rates where hardware flow 
control cannot be used (e.g. terminal applications) even with otherwise 
highly-performant systems.

Lower the default receive interrupt trigger level to 32 then, and make 
it configurable.  Document the trigger levels along with other port 
types, including the set of 16, 32, 64, 112 for the transmit interrupt 
as well[2].

References:

[1] "OX16C950 rev B High Performance UART with 128 byte FIFOs", Oxford 
    Semiconductor, Inc., DS-0031, Sep 05, Table 10: "Receiver Trigger 
    Levels", p. 22

[2] same, Table 9: "Transmit Interrupt Trigger Levels", p. 22

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/tty/serial/8250/8250_port.c |    3 ++-
 include/uapi/linux/serial_reg.h     |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

linux-serial-8250-oxsemi-fifo.diff
Index: linux-malta-cbus-uart/drivers/tty/serial/8250/8250_port.c
===================================================================
--- linux-malta-cbus-uart.orig/drivers/tty/serial/8250/8250_port.c
+++ linux-malta-cbus-uart/drivers/tty/serial/8250/8250_port.c
@@ -122,7 +122,8 @@ static const struct serial8250_config ua
 		.name		= "16C950/954",
 		.fifo_size	= 128,
 		.tx_loadsz	= 128,
-		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
+		.rxtrig_bytes	= {16, 32, 112, 120},
 		/* UART_CAP_EFR breaks billionon CF bluetooth card. */
 		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,
 	},
Index: linux-malta-cbus-uart/include/uapi/linux/serial_reg.h
===================================================================
--- linux-malta-cbus-uart.orig/include/uapi/linux/serial_reg.h
+++ linux-malta-cbus-uart/include/uapi/linux/serial_reg.h
@@ -62,6 +62,7 @@
  * ST16C654:	 8  16  56  60		 8  16  32  56	PORT_16654
  * TI16C750:	 1  16  32  56		xx  xx  xx  xx	PORT_16750
  * TI16C752:	 8  16  56  60		 8  16  32  56
+ * OX16C950:	16  32 112 120		16  32  64 112	PORT_16C950
  * Tegra:	 1   4   8  14		16   8   4   1	PORT_TEGRA
  */
 #define UART_FCR_R_TRIG_00	0x00
