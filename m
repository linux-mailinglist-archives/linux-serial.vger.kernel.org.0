Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DCD3AC374
	for <lists+linux-serial@lfdr.de>; Fri, 18 Jun 2021 08:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhFRGSy (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 18 Jun 2021 02:18:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60224 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhFRGRz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A493721B61;
        Fri, 18 Jun 2021 06:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXQIKufr277A9Hb8SIwvq0VOLlbbqdJ0NwvdvrU0O/o=;
        b=gZVrbBY5L7G9+njWUqFcvPX1FRcUisz9LmeuuMkg8I/93IcJEkh9KifoeslQdn++gZFSOC
        ysIpuXugS4shdACVQqmwk8iHG50boO0WAY1+oKDva4gu/LnMpsWj0AY0KQuuD5dKJqGQ3M
        2b2+bSwwT0XRVzKP0Zd5ElbxSaOAtLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXQIKufr277A9Hb8SIwvq0VOLlbbqdJ0NwvdvrU0O/o=;
        b=e+ofj4F7urEPjxi7PJVfI/e3sjZA0lWdR2LhlhaeMAft5HB8f/0GJV/im7CXhsa3mfjPbI
        PZVMghUB4oYfbKBQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7BE2CA3B9F;
        Fri, 18 Jun 2021 06:15:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 54/70] mxser: remove pointless ioaddr checks
Date:   Fri, 18 Jun 2021 08:15:00 +0200
Message-Id: <20210618061516.662-55-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

struct mxser_port::ioaddr can never be NULL once set in ->probe. Hence
the checks for it are pointless. Remove them.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 81e2b72fca3f..e5f8d08de8fd 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -446,9 +446,6 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
 	unsigned char cval;
 	u64 timeout;
 
-	if (!info->ioaddr)
-		return -1;
-
 	if (newspd > info->board->max_baud)
 		return -1;
 
@@ -519,8 +516,6 @@ static void mxser_change_speed(struct tty_struct *tty)
 	unsigned char status;
 
 	cflag = tty->termios.c_cflag;
-	if (!info->ioaddr)
-		return;
 
 	mxser_set_baud(tty, tty_get_baud_rate(tty));
 
@@ -724,7 +719,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 
 	spin_lock_irqsave(&info->slock, flags);
 
-	if (!info->ioaddr || !info->type) {
+	if (!info->type) {
 		set_bit(TTY_IO_ERROR, &tty->flags);
 		free_page(page);
 		spin_unlock_irqrestore(&info->slock, flags);
@@ -1097,10 +1092,6 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 		return -EIO;
 
 	mutex_lock(&port->mutex);
-	if (!info->ioaddr) {
-		mutex_unlock(&port->mutex);
-		return -ENODEV;
-	}
 
 	if (ss->irq != info->board->irq ||
 			ss->port != info->ioaddr) {
-- 
2.32.0

