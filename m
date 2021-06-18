Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F633AC34B
	for <lists+linux-serial@lfdr.de>; Fri, 18 Jun 2021 08:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhFRGSE (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 18 Jun 2021 02:18:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46744 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhFRGRl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E0D1D1FDE7;
        Fri, 18 Jun 2021 06:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knifx1Wyo/CwkTtpPLHWcfMdFsNclZb01S3JsAqoMRY=;
        b=PvagUU4+kjDESkKGmXsVd3t7+jp/HhMpyqJ2vfMsrwjYSl2ogTsQXjwHUPrbWZ1dDndNyZ
        NT8Vy7YuiLUUezRvdt6TUVWKbimPsDXbF17mi+waqgGgvF5DNFRFrL91K9oJTtSnYhnpyG
        7ObRH1Csvut2YLW5jxqn4/ypYGyoDWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knifx1Wyo/CwkTtpPLHWcfMdFsNclZb01S3JsAqoMRY=;
        b=XL4bsrBtOaOIl3EJVk4/pPR0aiPpxDRGUX+h2vWoqBFdAOq1LLVh4QiW04wJintTTCAr1R
        NtT50Q43jxONdNBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C0CF4A3B9E;
        Fri, 18 Jun 2021 06:15:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 27/70] mxser: remove MOXA_GETDATACOUNT ioctl
Date:   Fri, 18 Jun 2021 08:14:33 +0200
Message-Id: <20210618061516.662-28-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

1) MOXA_GETDATACOUNT is broken at least since commit ecbbfd44a08f (TTY:
   move tty buffers to tty_port) in 2012.
   Even though it's mentioned in the mon_p moxa utility, obviously noone
   ever tried that in that timeframe.
2) The ioctl definition was never exposed to userspace, so noone should
   actually be reliably using this.

Provided the above, remove this mxser-special ioctl.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index ebe657426636..9e241f8bd814 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -50,7 +50,6 @@
  */
 
 #define MOXA			0x400
-#define MOXA_GETDATACOUNT	(MOXA + 23)
 #define MOXA_HighSpeedOn	(MOXA + 61)
 #define MOXA_GETMSTATUS		(MOXA + 65)
 #define MOXA_SET_OP_MODE	(MOXA + 66)
@@ -268,12 +267,6 @@ MODULE_DESCRIPTION("MOXA Smartio/Industio Family Multiport Board Device Driver")
 module_param(ttymajor, int, 0);
 MODULE_LICENSE("GPL");
 
-struct mxser_log {
-	int tick;
-	unsigned long rxcnt[MXSER_PORTS];
-	unsigned long txcnt[MXSER_PORTS];
-};
-
 struct mxser_board;
 
 struct mxser_port {
@@ -335,7 +328,6 @@ struct mxser_mstatus {
 
 static struct mxser_board mxser_boards[MXSER_BOARDS];
 static struct tty_driver *mxvar_sdriver;
-static struct mxser_log mxvar_log;
 
 static void mxser_enable_must_enchance_mode(unsigned long baseio)
 {
@@ -1431,15 +1423,8 @@ static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
 	struct tty_struct *tty;
 	int status;
 	unsigned int i, j;
-	int ret = 0;
 
 	switch (cmd) {
-	case MOXA_GETDATACOUNT:
-		/* The receive side is locked by port->slock but it isn't
-		   clear that an exact snapshot is worth copying here */
-		if (copy_to_user(argp, &mxvar_log, sizeof(mxvar_log)))
-			ret = -EFAULT;
-		return ret;
 	case MOXA_GETMSTATUS: {
 		struct mxser_mstatus ms, __user *msu = argp;
 		for (i = 0; i < MXSER_BOARDS; i++)
@@ -1934,8 +1919,6 @@ static u8 mxser_receive_chars(struct tty_struct *tty,
 	if (!mxser_receive_chars_new(tty, port, status, &cnt))
 		status = mxser_receive_chars_old(tty, port, status, &cnt);
 
-	mxvar_log.rxcnt[tty->index] += cnt;
-
 	tty_flip_buffer_push(&port->port);
 
 	return status;
@@ -1948,7 +1931,6 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 	if (port->x_char) {
 		outb(port->x_char, port->ioaddr + UART_TX);
 		port->x_char = 0;
-		mxvar_log.txcnt[tty->index]++;
 		port->icount.tx++;
 		return;
 	}
@@ -1974,7 +1956,6 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 		if (--port->xmit_cnt <= 0)
 			break;
 	} while (--count > 0);
-	mxvar_log.txcnt[tty->index] += (cnt - port->xmit_cnt);
 
 	port->icount.tx += (cnt - port->xmit_cnt);
 
-- 
2.32.0

