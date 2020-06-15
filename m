Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74281F90A4
	for <lists+linux-serial@lfdr.de>; Mon, 15 Jun 2020 09:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgFOHvn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 15 Jun 2020 03:51:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:39986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgFOHtP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4B2B1AFDF;
        Mon, 15 Jun 2020 07:49:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/38] vt: remove 25 years stale comment
Date:   Mon, 15 Jun 2020 09:48:39 +0200
Message-Id: <20200615074910.19267-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

vc_cons was made global (non-static) in 1.3.38, almost 25 years ago.
Remove a comment which says that it would be a disadvantage to do so :P.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/console_struct.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 81f7afcd061a..40ed52f67bc5 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -167,8 +167,7 @@ struct vc {
 	struct work_struct SAK_work;
 
 	/* might add  scrmem, kbd  at some time,
-	   to have everything in one place - the disadvantage
-	   would be that vc_cons etc can no longer be static */
+	   to have everything in one place */
 };
 
 extern struct vc vc_cons [MAX_NR_CONSOLES];
-- 
2.27.0

