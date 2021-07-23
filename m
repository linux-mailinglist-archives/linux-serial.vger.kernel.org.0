Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461873D38B5
	for <lists+linux-serial@lfdr.de>; Fri, 23 Jul 2021 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhGWJvS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 23 Jul 2021 05:51:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55596 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhGWJvP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 05:51:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7848C22644;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627036308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AT9USeK30OkpyXcRXj7cdK4wBY8dSNpXyscxya5EkHk=;
        b=b3RJoJ+WdkKL4Jfw2AELSC7efPaJIjz9IrbgqSwQjHl31pSZQnvAYI+aWhf0XrTB3Qdx0j
        YPPZ2ttjLYv6ouEfaDa5qej/+ax1GNX7fB1JW/B2F3AqBRrHk++cwtvBE+32NM4cdM5vfN
        CmRGyB5FxUjCWJL5DEk0LNiIyAniEHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627036308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AT9USeK30OkpyXcRXj7cdK4wBY8dSNpXyscxya5EkHk=;
        b=6AA5t1QP+gFsXmK+UXYMGTCF1dn1DaB+ZCVHX/YZUPz6VWo7ItbQnBrnB4RW/oOFpUYY2u
        uVCMjhfTAbaM4JDw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5D063A3B9D;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/8] tty: move tty_ldisc_receive_buf to tty_flip.h
Date:   Fri, 23 Jul 2021 12:31:44 +0200
Message-Id: <20210723103147.18250-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723103147.18250-1-jslaby@suse.cz>
References: <20210723103147.18250-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's the only remaining tty_buffer.c prototype residing in tty.h. Move
it along others to tty_flip.h.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty.h      | 3 ---
 include/linux/tty_flip.h | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 7f088d43db45..fad53f69a8ca 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -622,9 +622,6 @@ static inline int tty_port_users(struct tty_port *port)
 	return port->count + port->blocked_open;
 }
 
-extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
-				 const char *f, int count);
-
 /* n_tty.c */
 extern void n_tty_inherit_ops(struct tty_ldisc_ops *ops);
 #ifdef CONFIG_TTY
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 67d78dc553e1..615a2a87b2a7 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -4,6 +4,8 @@
 
 #include <linux/tty.h>
 
+struct tty_ldisc;
+
 extern int tty_buffer_set_limit(struct tty_port *port, int limit);
 extern unsigned int tty_buffer_space_avail(struct tty_port *port);
 extern int tty_buffer_request_room(struct tty_port *port, size_t size);
@@ -39,6 +41,9 @@ static inline int tty_insert_flip_string(struct tty_port *port,
 	return tty_insert_flip_string_fixed_flag(port, chars, TTY_NORMAL, size);
 }
 
+int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
+		const char *f, int count);
+
 extern void tty_buffer_lock_exclusive(struct tty_port *port);
 extern void tty_buffer_unlock_exclusive(struct tty_port *port);
 
-- 
2.32.0

