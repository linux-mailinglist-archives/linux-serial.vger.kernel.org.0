Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84258163F82
	for <lists+linux-serial@lfdr.de>; Wed, 19 Feb 2020 09:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgBSInG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 19 Feb 2020 03:43:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:44280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgBSIlX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EABA6AED8;
        Wed, 19 Feb 2020 08:41:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/24] n_hdlc: use clamp() for maxframe
Date:   Wed, 19 Feb 2020 09:41:00 +0100
Message-Id: <20200219084118.26491-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is easier to read. And use MAX_HDLC_FRAME_SIZE instead of magic
constant.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 87f22e57e4f6..a713a98fea2e 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -894,10 +894,7 @@ static int __init n_hdlc_init(void)
 	int status;
 
 	/* range check maxframe arg */
-	if (maxframe < 4096)
-		maxframe = 4096;
-	else if (maxframe > 65535)
-		maxframe = 65535;
+	maxframe = clamp(maxframe, 4096, MAX_HDLC_FRAME_SIZE);
 
 	status = tty_register_ldisc(N_HDLC, &n_hdlc_ldisc);
 	if (!status)
-- 
2.25.0

