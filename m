Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2436E689
	for <lists+linux-serial@lfdr.de>; Fri, 19 Jul 2019 15:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfGSNgY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 19 Jul 2019 09:36:24 -0400
Received: from foss.arm.com ([217.140.110.172]:43522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfGSNgY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jul 2019 09:36:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BC3D1509;
        Fri, 19 Jul 2019 06:36:23 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 642693F71A;
        Fri, 19 Jul 2019 06:36:22 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-serial@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Phil Elwell <phil@raspberrypi.org>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-rpi-kernel@lists.infradead.org
Subject: [RFC PATCH 2/2] serial: pl011: Don't bother pushing more TX data while TX irq is active
Date:   Fri, 19 Jul 2019 14:35:25 +0100
Message-Id: <1563543325-12463-3-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1563543325-12463-1-git-send-email-Dave.Martin@arm.com>
References: <1563543325-12463-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When the TX irq is active, writing chars to the TX FIFO from
anywhere except pl011_int() is pointless: the UART is already busy,
and new chars will be picked up by pl011_int() as soon as there is
FIFO space.

To reduce the scope for surprises, bail out of pl011_start_tx_pio()
without attempting to write to the FIFO or start TX DMA if the TX FIFO
interrupt is already in use.

This should also avoid pointless overhead in some situations.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Please test both with and without this patch.

I believe with the previous patch in place, this patch is not strictly
necessary.  However, if the UART is actively transmitting in the
background already, it does make sense not to waste time trying polling
the FIFO fill status or setting up DMA etc.
---
 drivers/tty/serial/amba-pl011.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e24bbc0..f28935a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1318,6 +1318,10 @@ static void pl011_start_tx(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
+	/* It's pointless to kick the UART if it's already transmitting... */
+	if (uap->im & UART011_TXIM)
+		return;
+
 	if (!pl011_dma_tx_start(uap))
 		pl011_start_tx_pio(uap);
 }
-- 
2.1.4

