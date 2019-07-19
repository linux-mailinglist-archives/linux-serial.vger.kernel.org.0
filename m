Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A596E688
	for <lists+linux-serial@lfdr.de>; Fri, 19 Jul 2019 15:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfGSNgX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 19 Jul 2019 09:36:23 -0400
Received: from foss.arm.com ([217.140.110.172]:43508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfGSNgX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jul 2019 09:36:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EF2D337;
        Fri, 19 Jul 2019 06:36:22 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 110273F71A;
        Fri, 19 Jul 2019 06:36:20 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-serial@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Phil Elwell <phil@raspberrypi.org>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-rpi-kernel@lists.infradead.org
Subject: [RFC PATCH 1/2] serial: pl011: Fix dropping of TX chars due to irq race
Date:   Fri, 19 Jul 2019 14:35:24 +0100
Message-Id: <1563543325-12463-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1563543325-12463-1-git-send-email-Dave.Martin@arm.com>
References: <1563543325-12463-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When serial_core pushes some new TX chars via a call to
pl011_start_tx(), it can race with irqs triggered by ongoing
transmission.

Normally the port lock protects against this kind of thing, but
temporary releasing of the lock during calls from pl011_int() to
pl011_{,dma_}rx_chars() allows pl011_start_tx() to race.

For performance reasons, pl011_tx_chars(, true) always assumes that
the TX FIFO interrupt trigger condition holds, i.e., the FIFO is
empty to the trigger threshold.  This means that we can write chars
to fill the FIFO back up without the expense of polling the FIFO
fill status.  However, this assumes that no data is written to the
FIFO in the meantime by other code: this is where the race with
pl011_start_tx_pio() breaks things.

Reorder pl011_int() so that no code releases the port lock in
between reading the interrupt status bits and calling
pl011_tx_chars().  This ensures that TXIS in the fetched status
accurately reflects the state of the TX FIFO, and ensures that
there is no race to fill the FIFO.

Fixes: 1e84d22322ce ("serial/amba-pl011: Refactor and simplify TX FIFO handling")
Reported-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 89ade21..e24bbc0 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1492,6 +1492,13 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 					       UART011_RXIS),
 				    uap, REG_ICR);
 
+			/*
+			 * Don't unlock uap->port.lock before here:
+			 * Stale TXIS status can lead to a FIFO overfill.
+			 */
+			if (status & UART011_TXIS)
+				pl011_tx_chars(uap, true);
+
 			if (status & (UART011_RTIS|UART011_RXIS)) {
 				if (pl011_dma_rx_running(uap))
 					pl011_dma_rx_irq(uap);
-- 
2.1.4

