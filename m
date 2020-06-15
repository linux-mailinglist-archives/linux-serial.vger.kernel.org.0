Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE31F9083
	for <lists+linux-serial@lfdr.de>; Mon, 15 Jun 2020 09:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgFOHuh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 15 Jun 2020 03:50:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:40060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728871AbgFOHtT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2745EB03D;
        Mon, 15 Jun 2020 07:49:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 22/38] vt: make tc write more obvious in vc_con_write_normal
Date:   Mon, 15 Jun 2020 09:48:54 +0200
Message-Id: <20200615074910.19267-22-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Nested ternary operators spread over 4 lines are really evil for
reading. Turn the outer one to proper 'if'. Now, we see, there is a
common path, so the code can be simplified. This way, the code is
understandable now.

Checked using symbolic execution (klee), that the old and new behaviors
are the same.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 72ae8ede1ac9..4686f8b9251d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2787,11 +2787,14 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 		if (vc->vc_decim)
 			insert_char(vc, 1);
 		vc_uniscr_putc(vc, next_c);
-		scr_writew(himask ?
-			     ((vc_attr << 8) & ~himask) +
-			     ((tc & 0x100) ? himask : 0) + (tc & 0xff) :
-			     (vc_attr << 8) + tc,
-			   (u16 *)vc->vc_pos);
+
+		if (himask)
+			tc = ((tc & 0x100) ? himask : 0) |
+			      (tc &  0xff);
+		tc |= (vc_attr << 8) & ~himask;
+
+		scr_writew(tc, (u16 *)vc->vc_pos);
+
 		if (con_should_update(vc) && draw->x < 0) {
 			draw->x = vc->state.x;
 			draw->from = vc->vc_pos;
-- 
2.27.0

