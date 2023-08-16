Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4503A77D8B4
	for <lists+linux-serial@lfdr.de>; Wed, 16 Aug 2023 04:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbjHPC6C (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 15 Aug 2023 22:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbjHPC5b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Aug 2023 22:57:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D352136
        for <linux-serial@vger.kernel.org>; Tue, 15 Aug 2023 19:57:28 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQXlQ1pF7zNmph;
        Wed, 16 Aug 2023 10:53:54 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 10:57:25 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <jirislaby@kernel.org>, <jannh@google.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <guozihua@huawei.com>
Subject: [PATCH V3 RESEND] tty: tty_jobctrl: fix pid memleak in disassociate_ctty()
Date:   Wed, 16 Aug 2023 10:57:00 +0800
Message-ID: <20230816025700.179769-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is a pid leakage:
------------------------------
unreferenced object 0xffff88810c181940 (size 224):
  comm "sshd", pid 8191, jiffies 4294946950 (age 524.570s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
    ff ff ff ff 6b 6b 6b 6b ff ff ff ff ff ff ff ff  ....kkkk........
  backtrace:
    [<ffffffff814774e6>] kmem_cache_alloc+0x5c6/0x9b0
    [<ffffffff81177342>] alloc_pid+0x72/0x570
    [<ffffffff81140ac4>] copy_process+0x1374/0x2470
    [<ffffffff81141d77>] kernel_clone+0xb7/0x900
    [<ffffffff81142645>] __se_sys_clone+0x85/0xb0
    [<ffffffff8114269b>] __x64_sys_clone+0x2b/0x30
    [<ffffffff83965a72>] do_syscall_64+0x32/0x80
    [<ffffffff83a00085>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

It turns out that there is a race condition between disassociate_ctty() and
tty_signal_session_leader(), which caused this leakage.

The pid memleak is triggered by the following race:
task[sshd]                     task[bash]
-----------------------        -----------------------
                               disassociate_ctty();
                               spin_lock_irq(&current->sighand->siglock);
                               put_pid(current->signal->tty_old_pgrp);
                               current->signal->tty_old_pgrp = NULL;
                               tty = tty_kref_get(current->signal->tty);
                               spin_unlock_irq(&current->sighand->siglock);
tty_vhangup();
tty_lock(tty);
...
tty_signal_session_leader();
spin_lock_irq(&p->sighand->siglock);
...
if (tty->ctrl.pgrp) //tty->ctrl.pgrp is not NULL
p->signal->tty_old_pgrp = get_pid(tty->ctrl.pgrp); //An extra get
spin_unlock_irq(&p->sighand->siglock);
...
tty_unlock(tty);
                               if (tty) {
                                   tty_lock(tty);
                                   ...
                                   put_pid(tty->ctrl.pgrp);
                                   tty->ctrl.pgrp = NULL; //It's too late
                                   ...
                                   tty_unlock(tty);
                               }

The issue is believed to be introduced by commit c8bcd9c5be24 ("tty:
Fix ->session locking") who moves the unlock of siglock in
disassociate_ctty() above "if (tty)", making a small window allowing
tty_signal_session_leader() to kick in. It can be easily reproduced by
adding a delay before "if (tty)" and at the entrance of
tty_signal_session_leader().

To fix this issue, we move "put_pid(current->signal->tty_old_pgrp)" after
"tty->ctrl.pgrp = NULL".

Fixes: c8bcd9c5be24 ("tty: Fix ->session locking")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Co-developed-by: GUO Zihua <guozihua@huawei.com>
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 drivers/tty/tty_jobctrl.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 0d04287da098..ef8741c3e662 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -300,12 +300,7 @@ void disassociate_ctty(int on_exit)
 		return;
 	}
 
-	spin_lock_irq(&current->sighand->siglock);
-	put_pid(current->signal->tty_old_pgrp);
-	current->signal->tty_old_pgrp = NULL;
-	tty = tty_kref_get(current->signal->tty);
-	spin_unlock_irq(&current->sighand->siglock);
-
+	tty = get_current_tty();
 	if (tty) {
 		unsigned long flags;
 
@@ -320,6 +315,16 @@ void disassociate_ctty(int on_exit)
 		tty_kref_put(tty);
 	}
 
+	/* If tty->ctrl.pgrp is not NULL, it may be assigned to
+	 * current->signal->tty_old_pgrp in a race condition, and
+	 * cause pid memleak. Release current->signal->tty_old_pgrp
+	 * after tty->ctrl.pgrp set to NULL.
+	 */
+	spin_lock_irq(&current->sighand->siglock);
+	put_pid(current->signal->tty_old_pgrp);
+	current->signal->tty_old_pgrp = NULL;
+	spin_unlock_irq(&current->sighand->siglock);
+
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
 	session_clear_tty(task_session(current));
-- 
2.17.1

