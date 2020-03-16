Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33C7186530
	for <lists+linux-serial@lfdr.de>; Mon, 16 Mar 2020 07:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgCPGps (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 16 Mar 2020 02:45:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgCPGps (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Mar 2020 02:45:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A220AD07;
        Mon, 16 Mar 2020 06:45:45 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] vt: selection, fix double lock introduced by a merge
Date:   Mon, 16 Mar 2020 07:45:44 +0100
Message-Id: <20200316064544.4799-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The merge commit cb05c6c82fb0 (Merge 5.6-rc5 into tty-next) introduced a
double lock to set_selection_kernel. vc_sel.lock is locked both in
set_selection_kernel and its callee __set_selection_kernel now.

Remove the latter.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/tty/vt/selection.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 1a069979866c..582184dd386c 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -219,7 +219,6 @@ static int __set_selection_kernel(struct tiocl_selection *v, struct tty_struct *
 	if (ps > pe)	/* make vc_sel.start <= vc_sel.end */
 		swap(ps, pe);
 
-	mutex_lock(&vc_sel.lock);
 	if (vc_sel.cons != vc_cons[fg_console].d) {
 		clear_selection();
 		vc_sel.cons = vc_cons[fg_console].d;
-- 
2.25.1

