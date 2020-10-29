Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02129EA94
	for <lists+linux-serial@lfdr.de>; Thu, 29 Oct 2020 12:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgJ2LcY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 29 Oct 2020 07:32:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:57024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgJ2LcY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 209CFAC1D;
        Thu, 29 Oct 2020 11:32:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/17] vt: keyboard, include linux/spinlock.h
Date:   Thu, 29 Oct 2020 12:32:07 +0100
Message-Id: <20201029113222.32640-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We use spin locks, but don't include linux/spinlock.h in keyboards.c. So
fix this up.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 69bbb6c1b3de..275093a15564 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -33,6 +33,7 @@
 #include <linux/tty_flip.h>
 #include <linux/mm.h>
 #include <linux/nospec.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-- 
2.29.1

