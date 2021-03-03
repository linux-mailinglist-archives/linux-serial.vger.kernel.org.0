Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7432B2E9
	for <lists+linux-serial@lfdr.de>; Wed,  3 Mar 2021 04:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbhCCCJn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 2 Mar 2021 21:09:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:39616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577538AbhCBGXu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:23:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F373EAF99;
        Tue,  2 Mar 2021 06:22:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/44] tty: n_tty, set tty_ldisc_ops::owner
Date:   Tue,  2 Mar 2021 07:21:39 +0100
Message-Id: <20210302062214.29627-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Set tty_ldisc_ops::owner to THIS_MODULE. This has no effect currently as
n_tty cannot be built as a module. If someone ever tries to modularize
tty, we wouldn't manage module's reference count as in other ldiscs. So
fix this just in case.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 7c53185bce57..a6f3c5c148eb 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2488,6 +2488,7 @@ static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
 }
 
 static struct tty_ldisc_ops n_tty_ops = {
+	.owner		 = THIS_MODULE,
 	.name            = "n_tty",
 	.open            = n_tty_open,
 	.close           = n_tty_close,
-- 
2.30.1

