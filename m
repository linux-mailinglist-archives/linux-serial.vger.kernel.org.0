Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE84429EAA5
	for <lists+linux-serial@lfdr.de>; Thu, 29 Oct 2020 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgJ2Lcp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 29 Oct 2020 07:32:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:57248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbgJ2Lc3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46212ABF4;
        Thu, 29 Oct 2020 11:32:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/17] vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl
Date:   Thu, 29 Oct 2020 12:32:16 +0100
Message-Id: <20201029113222.32640-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

KDGKBSENT (the getter) needs only 'user_kdgkb->kb_func' from the
userspace, i.e. the index. Then it needs a buffer for a local copy of
'kb_string'.

KDSKBSENT (the setter) needs a copy up to the length of
'user_kdgkb->kb_string'.

That means, we obtain the index before the switch-case and use it in
both paths and:
1) allocate full space in the getter case, and
2) copy the string only in the setter case. We do it by strndup_user
   helper now which was not available when this function was written.

Given we copy the two members of 'struct kbsentry' separately, we no
longer need a local definition. Hence we need to change all the sizeofs
here too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 42 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 55014f57a3de..81afe0438b34 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2021,7 +2021,7 @@ int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
 /* FIXME: This one needs untangling */
 int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
-	struct kbsentry *kbs;
+	char *kbs;
 	u_char *q;
 	int sz, fnw_sz;
 	int delta;
@@ -2034,39 +2034,37 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 	if (!capable(CAP_SYS_TTY_CONFIG))
 		perm = 0;
 
-	kbs = kmalloc(sizeof(*kbs), GFP_KERNEL);
-	if (!kbs) {
-		ret = -ENOMEM;
-		goto reterr;
-	}
+	if (get_user(kb_func, &user_kdgkb->kb_func))
+		return -EFAULT;
 
-	/* we mostly copy too much here (512bytes), but who cares ;) */
-	if (copy_from_user(kbs, user_kdgkb, sizeof(struct kbsentry))) {
-		ret = -EFAULT;
-		goto reterr;
-	}
-	kbs->kb_string[sizeof(kbs->kb_string)-1] = '\0';
-	kb_func = array_index_nospec(kbs->kb_func, MAX_NR_FUNC);
+	kb_func = array_index_nospec(kb_func, MAX_NR_FUNC);
 
 	switch (cmd) {
 	case KDGKBSENT: {
 		/* size should have been a struct member */
 		ssize_t len = sizeof(user_kdgkb->kb_string);
 
+		kbs = kmalloc(len, GFP_KERNEL);
+		if (!kbs)
+			return -ENOMEM;
+
 		spin_lock_irqsave(&func_buf_lock, flags);
-		len = strlcpy(kbs->kb_string, func_table[kb_func] ? : "", len);
+		len = strlcpy(kbs, func_table[kb_func] ? : "", len);
 		spin_unlock_irqrestore(&func_buf_lock, flags);
 
-		ret = copy_to_user(user_kdgkb->kb_string, kbs->kb_string,
-				len + 1) ? -EFAULT : 0;
+		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
+			-EFAULT : 0;
 
 		goto reterr;
 	}
 	case KDSKBSENT:
-		if (!perm) {
-			ret = -EPERM;
-			goto reterr;
-		}
+		if (!perm)
+			return -EPERM;
+
+		kbs = strndup_user(user_kdgkb->kb_string,
+				sizeof(user_kdgkb->kb_string));
+		if (IS_ERR(kbs))
+			return PTR_ERR(kbs);
 
 		fnw = NULL;
 		fnw_sz = 0;
@@ -2084,7 +2082,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		else
 			fj = first_free;
 		/* buffer usage increase by new entry */
-		delta = (q ? -strlen(q) : 1) + strlen(kbs->kb_string);
+		delta = (q ? -strlen(q) : 1) + strlen(kbs);
 
 		if (delta <= funcbufleft) { 	/* it fits in current buf */
 		    if (j < MAX_NR_FUNC) {
@@ -2136,7 +2134,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		    funcbufsize = sz;
 		}
 		/* finally insert item itself */
-		strcpy(func_table[kb_func], kbs->kb_string);
+		strcpy(func_table[kb_func], kbs);
 		spin_unlock_irqrestore(&func_buf_lock, flags);
 		break;
 	}
-- 
2.29.1

