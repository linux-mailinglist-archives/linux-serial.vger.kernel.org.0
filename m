Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B723932B050
	for <lists+linux-serial@lfdr.de>; Wed,  3 Mar 2021 04:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbhCCCPl (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 2 Mar 2021 21:15:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:39636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835878AbhCBGYU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED885B032;
        Tue,  2 Mar 2021 06:22:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 31/44] tty: xtensa/iss, remove stale comments
Date:   Tue,  2 Mar 2021 07:22:01 +0100
Message-Id: <20210302062214.29627-31-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These are likely taken over from amiserial. iss doesn't do anything of
that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/platforms/iss/console.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 5d7f9c638437..3b89d9ceb06a 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -37,13 +37,6 @@ static struct timer_list serial_timer;
 
 static DEFINE_SPINLOCK(timer_lock);
 
-/*
- * This routine is called whenever a serial port is opened.  It
- * enables interrupts for a serial port, linking in its async structure into
- * the IRQ chain.   It also performs the serial-specific
- * initialization for the tty structure.
- */
-
 static void rs_poll(struct timer_list *);
 
 static int rs_open(struct tty_struct *tty, struct file * filp)
@@ -58,17 +51,6 @@ static int rs_open(struct tty_struct *tty, struct file * filp)
 	return 0;
 }
 
-
-/*
- * ------------------------------------------------------------
- * iss_serial_close()
- *
- * This routine is called when the serial port gets closed.  First, we
- * wait for the last remaining data to be sent.  Then, we unlink its
- * async structure from the interrupt chain if necessary, and we free
- * that IRQ if nothing is left in the chain.
- * ------------------------------------------------------------
- */
 static void rs_close(struct tty_struct *tty, struct file * filp)
 {
 	spin_lock_bh(&timer_lock);
-- 
2.30.1

