Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A2C30D24
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 13:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEaLOW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 07:14:22 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58762 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfEaLOW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 07:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sEApIaqlXAgNfqtUPcWBB7YpvkDyHM3SN5uqZlRAsYo=; b=fkkbJs4Oi5jsy0SQIGVC/6dIqx
        q5p/8I6Z95onuyyCUWbn28DwQgzYUGQkild6jOwRLzBnod0VR4O6IS0qdqUwFvILkP6HkXTALo6nr
        RrZxhx86059zw6+2C2NoLsEoI9zG2v9f2ISLhoPA9rPZp3ZWOjdaj1oj3KOtPMaRMzmtvV0+OEFJ+
        dUMuD7Qtc9LyfKx3Bm+TtMDtVxIAeVzBjpLua6kbpHsQavQGZaG5eWh2VRE7e6EC90ORvyQqLT+Jl
        qC0jUbrwk+MGXU5GfMGqF+2Non0Z9XstKCJ7oFcgKv1HrA/XXc9evOgIuo5/SGmGcUcXv+3KWHltt
        1jGI+1SQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39632 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWfUA-0000PF-9O; Fri, 31 May 2019 12:14:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWfU8-0003fr-DP; Fri, 31 May 2019 12:14:08 +0100
In-Reply-To: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 5/6] ARM: sa1100/hackkit: remove empty serial mctrl functions
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hWfU8-0003fr-DP@rmk-PC.armlinux.org.uk>
Date:   Fri, 31 May 2019 12:14:08 +0100
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Remove the empty serial modem control signal functions from hackkit
as these are unnecessary - the core code can copes fine without
these.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/hackkit.c | 48 ------------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 643d5f2d9af9..9faf602666cf 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -49,8 +49,6 @@
 /* init funcs */
 static void __init hackkit_map_io(void);
 
-static u_int hackkit_get_mctrl(struct uart_port *port);
-static void hackkit_set_mctrl(struct uart_port *port, u_int mctrl);
 static void hackkit_uart_pm(struct uart_port *port, u_int state, u_int oldstate);
 
 /**********************************************************************
@@ -71,8 +69,6 @@ static struct map_desc hackkit_io_desc[] __initdata = {
 };
 
 static struct sa1100_port_fns hackkit_port_fns __initdata = {
-	.set_mctrl	= hackkit_set_mctrl,
-	.get_mctrl	= hackkit_get_mctrl,
 	.pm		= hackkit_uart_pm,
 };
 
@@ -105,50 +101,6 @@ static void hackkit_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 	/* TODO: switch on/off uart in powersave mode */
 }
 
-/*
- * Note! this can be called from IRQ context.
- * FIXME: No modem ctrl lines yet.
- */
-static void hackkit_set_mctrl(struct uart_port *port, u_int mctrl)
-{
-#if 0
-	if (port->mapbase == _Ser1UTCR0) {
-		u_int set = 0, clear = 0;
-
-		if (mctrl & TIOCM_RTS)
-			set |= PT_CTRL2_RS1_RTS;
-		else
-			clear |= PT_CTRL2_RS1_RTS;
-
-		if (mctrl & TIOCM_DTR)
-			set |= PT_CTRL2_RS1_DTR;
-		else
-			clear |= PT_CTRL2_RS1_DTR;
-
-		PTCTRL2_clear(clear);
-		PTCTRL2_set(set);
-	}
-#endif
-}
-
-static u_int hackkit_get_mctrl(struct uart_port *port)
-{
-	u_int ret = 0;
-#if 0
-	u_int irqsr = PT_IRQSR;
-
-	/* need 2 reads to read current value */
-	irqsr = PT_IRQSR;
-
-	/* TODO: check IRQ source register for modem/com
-	 status lines and set them correctly. */
-#endif
-
-	ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
-
-	return ret;
-}
-
 static struct mtd_partition hackkit_partitions[] = {
 	{
 		.name		= "BLOB",
-- 
2.7.4

