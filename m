Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD604B3EE
	for <lists+linux-serial@lfdr.de>; Wed, 19 Jun 2019 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfFSITe (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 19 Jun 2019 04:19:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43270 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfFSITe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Jun 2019 04:19:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so2283019wru.10
        for <linux-serial@vger.kernel.org>; Wed, 19 Jun 2019 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ROT1dnVLPb+Jpsj/aZaMU+qvqhHlnAfctcDNJk6k84Q=;
        b=bM2u8tYl4Fi42Ad/eq9UFF/UBgp2Bfle6CeXZMBewk/dMLbjpEvS1vA1VCiIbG/V1K
         tNGUzf5W098Bo/AiTsQr1IBKz9npubHHBY3N4GQ7vDpv7Qcokpukpnd3VPnAAQiiOzGo
         tQVNy+9PjNOfN6EPspzEaXPdSUceIOBAFTZyeEipYNmmD12PjasMN18zxar6lkXU2lc1
         A/CdTDkk8+NCsh+NTcqxQiKEDzpv+vAtTt0vH5Eu+f5OFI+ivcO5tSpinpkuzHr4yI5e
         IuN5nhOg/QzWYn6XXrBP2qUVjAwPzJfwC+Mw9CGNqxJhw5S3Q2hstHLOP0TemreGehxn
         x/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ROT1dnVLPb+Jpsj/aZaMU+qvqhHlnAfctcDNJk6k84Q=;
        b=jHgg//Ty6C5PkGBm9UTWaOluKJi6ihMiHwqJcb6oDo2CcoqbN8r4eqQ0sEFo7CPGKl
         4ywsjbKAuiZuQ1uznmTaEiaiHylvMUm8FJ8qmkkoa+zl57L3kCUcO884J+babPwjkGZp
         Ebu/KrN4IWQRxaz27+N0XJ3kfV7ZNbvKBQWvrAECzM2f/m5nN2dE9O0Ojc/hzsRueUBp
         GqfU3uQZFFt1ONcYUuIIQ6uHOjxgbsQ4skEKkRrUgO9nih2GvCL39TkISNcez/S2SG3I
         ldj8Tu6qtX3i06gzGRewSOMoDGm4a2dRe1ztGE32fDZUnbeYuJrap63va/qKcFo6lnLJ
         pUeA==
X-Gm-Message-State: APjAAAUQWXE/3d+gacY6il4l8xjqUMgkfQBwcp6hsnwPxlvEucS5V0to
        3hvc4wRa1Yo24onVQ9zmRqYRB0pZ9cw=
X-Google-Smtp-Source: APXvYqyeYCIT/BGv4NQOmdNgeTyEnaN5j6OA4vRxS4KgYek2fVF1j6cdfaFPDKTcdBecWEz519ksOw==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr28377716wrn.120.1560932371798;
        Wed, 19 Jun 2019 01:19:31 -0700 (PDT)
Received: from mpc.fritz.box (x5f741697.dyn.telefonica.de. [95.116.22.151])
        by smtp.gmail.com with ESMTPSA id s10sm1217107wmf.8.2019.06.19.01.19.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 01:19:31 -0700 (PDT)
From:   Oliver Barta <o.barta89@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Oliver Barta <o.barta89@gmail.com>
Subject: [PATCH] Revert "serial: 8250: Don't service RX FIFO if interrupts are disabled"
Date:   Wed, 19 Jun 2019 10:16:39 +0200
Message-Id: <20190619081639.325-1-o.barta89@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 2e9fe539108320820016f78ca7704a7342788380.

Reading LSR unconditionally but processing the error flags only if
UART_IIR_RDI bit was set before in IIR may lead to a loss of transmission
error information on UARTs where the transmission error flags are cleared
by a read of LSR. Information are lost in case an error is detected right
before the read of LSR while processing e.g. an UART_IIR_THRI interrupt.

Signed-off-by: Oliver Barta <o.barta89@gmail.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d2f3310abe54..682300713be4 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1869,8 +1869,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	status = serial_port_in(port, UART_LSR);
 
-	if (status & (UART_LSR_DR | UART_LSR_BI) &&
-	    iir & UART_IIR_RDI) {
+	if (status & (UART_LSR_DR | UART_LSR_BI)) {
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
-- 
2.20.1

