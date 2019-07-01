Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29902639C
	for <lists+linux-serial@lfdr.de>; Wed, 22 May 2019 14:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfEVMRO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 22 May 2019 08:17:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45745 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbfEVMRO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 May 2019 08:17:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 458BTM0ZB4z9v2JC;
        Wed, 22 May 2019 14:17:11 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=aSA1itul; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2tBcVXNsQ-sn; Wed, 22 May 2019 14:17:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 458BTL6PbWz9v2JB;
        Wed, 22 May 2019 14:17:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558527430; bh=ULpgX9HYncfSaEjyyyTwrdNHRBTq+jrPPxiAH/Bi1aw=;
        h=From:Subject:To:Cc:Date:From;
        b=aSA1itulWnmknDSRHJhSq1WT91YKt9nFX1g2vucCgzWDHHhNM0nDTcVysFxUvQZic
         1v9U+CpLqpd8blZoTTPh8TgLi0ZrXGB2y7lrwuGlEn9MQBjybBAVdsixui/i5AXygf
         0bmPvZ5IMK1zkqvNUvDbvhChGB8o7760K93FkHZU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F6C18B840;
        Wed, 22 May 2019 14:17:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id a6HB5Dsaeycs; Wed, 22 May 2019 14:17:12 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A5E98B83E;
        Wed, 22 May 2019 14:17:12 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E04AD68430; Wed, 22 May 2019 12:17:11 +0000 (UTC)
Message-Id: <d99f90e2107d7bff3adc187b5ce36a79cc786bfd.1558527014.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] tty: serial: cpm_uart - fix init when SMC is relocated
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Date:   Wed, 22 May 2019 12:17:11 +0000 (UTC)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SMC relocation can also be activated earlier by the bootloader,
so the driver's behaviour cannot rely on selected kernel config.

When the SMC is relocated, CPM_CR_INIT_TRX cannot be used.

But the only thing CPM_CR_INIT_TRX does is to clear the
rstate and tstate registers, so this can be done manually,
even when SMC is not relocated.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 9ab921201444 ("cpm_uart: fix non-console port startup bug")
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index b929c7ae3a27..7bab9a3eda92 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -407,7 +407,16 @@ static int cpm_uart_startup(struct uart_port *port)
 			clrbits16(&pinfo->sccp->scc_sccm, UART_SCCM_RX);
 		}
 		cpm_uart_initbd(pinfo);
-		cpm_line_cr_cmd(pinfo, CPM_CR_INIT_TRX);
+		if (IS_SMC(pinfo)) {
+			out_be32(&pinfo->smcup->smc_rstate, 0);
+			out_be32(&pinfo->smcup->smc_tstate, 0);
+			out_be16(&pinfo->smcup->smc_rbptr,
+				 in_be16(&pinfo->smcup->smc_rbase));
+			out_be16(&pinfo->smcup->smc_tbptr,
+				 in_be16(&pinfo->smcup->smc_tbase));
+		} else {
+			cpm_line_cr_cmd(pinfo, CPM_CR_INIT_TRX);
+		}
 	}
 	/* Install interrupt handler. */
 	retval = request_irq(port->irq, cpm_uart_int, 0, "cpm_uart", port);
@@ -861,16 +870,14 @@ static void cpm_uart_init_smc(struct uart_cpm_port *pinfo)
 	         (u8 __iomem *)pinfo->tx_bd_base - DPRAM_BASE);
 
 /*
- *  In case SMC1 is being relocated...
+ *  In case SMC is being relocated...
  */
-#if defined (CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
 	out_be16(&up->smc_rbptr, in_be16(&pinfo->smcup->smc_rbase));
 	out_be16(&up->smc_tbptr, in_be16(&pinfo->smcup->smc_tbase));
 	out_be32(&up->smc_rstate, 0);
 	out_be32(&up->smc_tstate, 0);
 	out_be16(&up->smc_brkcr, 1);              /* number of break chars */
 	out_be16(&up->smc_brkec, 0);
-#endif
 
 	/* Set up the uart parameters in the
 	 * parameter ram.
@@ -884,8 +891,6 @@ static void cpm_uart_init_smc(struct uart_cpm_port *pinfo)
 	out_be16(&up->smc_brkec, 0);
 	out_be16(&up->smc_brkcr, 1);
 
-	cpm_line_cr_cmd(pinfo, CPM_CR_INIT_TRX);
-
 	/* Set UART mode, 8 bit, no parity, one stop.
 	 * Enable receive and transmit.
 	 */
-- 
2.13.3

