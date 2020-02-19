Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD7B163F79
	for <lists+linux-serial@lfdr.de>; Wed, 19 Feb 2020 09:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgBSIlY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 19 Feb 2020 03:41:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:44310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgBSIlY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3E3D2B03B;
        Wed, 19 Feb 2020 08:41:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/24] n_hdlc: remove unused backup_tty
Date:   Wed, 19 Feb 2020 09:41:04 +0100
Message-Id: <20200219084118.26491-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's only set to NULL and never properly used.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index d0e538ba51ea..ae6b9a45ae81 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -125,7 +125,6 @@ struct n_hdlc_buf_list {
  * struct n_hdlc - per device instance data structure
  * @magic - magic value for structure
  * @tty - ptr to TTY structure
- * @backup_tty - TTY to use if tty gets closed
  * @tbusy - reentrancy flag for tx wakeup code
  * @woke_up - FIXME: describe this field
  * @tx_buf_list - list of pending transmit frame buffers
@@ -136,7 +135,6 @@ struct n_hdlc_buf_list {
 struct n_hdlc {
 	int			magic;
 	struct tty_struct	*tty;
-	struct tty_struct	*backup_tty;
 	int			tbusy;
 	int			woke_up;
 	struct n_hdlc_buf_list	tx_buf_list;
@@ -267,15 +265,9 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 	clear_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
 #endif
 	tty->disc_data = NULL;
-	if (tty == n_hdlc->backup_tty)
-		n_hdlc->backup_tty = NULL;
 	if (tty != n_hdlc->tty)
 		return;
-	if (n_hdlc->backup_tty) {
-		n_hdlc->tty = n_hdlc->backup_tty;
-	} else {
-		n_hdlc_release (n_hdlc);
-	}
+	n_hdlc_release (n_hdlc);
 }	/* end of n_hdlc_tty_close() */
 
 /**
-- 
2.25.0

