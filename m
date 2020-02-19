Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7E0163F4C
	for <lists+linux-serial@lfdr.de>; Wed, 19 Feb 2020 09:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgBSIlV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 19 Feb 2020 03:41:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:44230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgBSIlV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A0F0AD88;
        Wed, 19 Feb 2020 08:41:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/24] n_hdlc: remove unused macros
Date:   Wed, 19 Feb 2020 09:40:56 +0100
Message-Id: <20200219084118.26491-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

VERSION and bset are unused. Remove them.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 9e115ecf920d..881da4d440c8 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -87,9 +87,6 @@
 #include <linux/interrupt.h>
 #include <linux/ptrace.h>
 
-#undef VERSION
-#define VERSION(major,minor,patch) (((((major)<<8)+(minor))<<8)+(patch))
-
 #include <linux/poll.h>
 #include <linux/in.h>
 #include <linux/ioctl.h>
@@ -186,8 +183,6 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *cp,
 			       char *fp, int count);
 static void n_hdlc_tty_wakeup(struct tty_struct *tty);
 
-#define bset(p,b)	((p)[(b) >> 5] |= (1 << ((b) & 0x1f)))
-
 #define tty2n_hdlc(tty)	((struct n_hdlc *) ((tty)->disc_data))
 #define n_hdlc2tty(n_hdlc)	((n_hdlc)->tty)
 
-- 
2.25.0

