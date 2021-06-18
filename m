Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668EC3AC388
	for <lists+linux-serial@lfdr.de>; Fri, 18 Jun 2021 08:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhFRGTT (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 18 Jun 2021 02:19:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59716 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFRGR6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2202D21B6D;
        Fri, 18 Jun 2021 06:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6dbF/oprEWZa6shDksahK+hYcvu3XoBqYTwdnzgUz8=;
        b=Y5Gtm6Uiz+4FybSTaiqsr2uP+vX8LUdj6CCapOkDN7VASp7YjF0WEndLI0MBMzkHV0Gf4K
        SMUBZEKH7xIUwwfdYfY5dmTaA7bIlGM7gsD/7dyWlBNfdhGWop+qN27sAXfi1wm9Eka/X/
        eJSQ4gHWvNtkFzaPONfDb1DZVVKwZpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6dbF/oprEWZa6shDksahK+hYcvu3XoBqYTwdnzgUz8=;
        b=e8pRHiVLR9Iikgz5AbvSPoW1BLODkbPT7LMmQBhxzH1X+8ZbpdFFx22YrPoXuDg4IyUXbh
        8E3Pet89Sq9BFkDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F1229A3B9F;
        Fri, 18 Jun 2021 06:15:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 61/70] mxser: decrypt FCR values
Date:   Fri, 18 Jun 2021 08:15:07 +0200
Message-Id: <20210618061516.662-62-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently, some of the values written to FCR are magic constants. But
they are composed of well-defined bits. Use these named macros in place
of the constants.

No changes in objdump -d.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 1a8698e58b1c..c8ba062d8824 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1580,7 +1580,9 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 
 		ch = inb(port->ioaddr + UART_RX);
 		if (hwid && (status & UART_LSR_OE))
-			outb(0x23, port->ioaddr + UART_FCR);
+			outb(UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
+					MOXA_MUST_FCR_GDA_MODE_ENABLE,
+					port->ioaddr + UART_FCR);
 		status &= port->read_status_mask;
 		if (status & port->ignore_status_mask) {
 			if (++ignored > 100)
@@ -1693,7 +1695,9 @@ static bool mxser_port_isr(struct mxser_port *port)
 	tty = tty_port_tty_get(&port->port);
 	if (!tty || port->closing || !tty_port_initialized(&port->port)) {
 		status = inb(port->ioaddr + UART_LSR);
-		outb(0x27, port->ioaddr + UART_FCR);
+		outb(MOXA_MUST_FCR_GDA_MODE_ENABLE | UART_FCR_ENABLE_FIFO |
+				UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+				port->ioaddr + UART_FCR);
 		inb(port->ioaddr + UART_MSR);
 
 		error = true;
-- 
2.32.0

