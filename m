Return-Path: <linux-serial+bounces-672-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D6A80A5AA
	for <lists+linux-serial@lfdr.de>; Fri,  8 Dec 2023 15:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EFF281ACF
	for <lists+linux-serial@lfdr.de>; Fri,  8 Dec 2023 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E3618E1D;
	Fri,  8 Dec 2023 14:37:18 +0000 (UTC)
X-Original-To: linux-serial@vger.kernel.org
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFA9173B;
	Fri,  8 Dec 2023 06:37:15 -0800 (PST)
Received: from lela.futurama.org (localhost.localdomain [IPv6:::1])
	by rhlx01.hs-esslingen.de (Postfix) with ESMTP id BD6342A00646;
	Fri,  8 Dec 2023 15:37:10 +0100 (CET)
Received: from dcbf.. (unknown [192.168.1.149])
	by lela.futurama.org (Postfix) with ESMTP id A40548032518;
	Fri,  8 Dec 2023 15:37:10 +0100 (CET)
From: Adrian Reber <areber@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2] tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE
Date: Fri,  8 Dec 2023 15:36:56 +0100
Message-ID: <20231208143656.1019-1-areber@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The capability CAP_CHECKPOINT_RESTORE was introduced to allow non-root
users to checkpoint and restore processes as non-root with CRIU.

This change extends CAP_CHECKPOINT_RESTORE to enable the CRIU option
'--shell-job' as non-root. CRIU's man-page describes the '--shell-job'
option like this:

  Allow one to dump shell jobs. This implies the restored task will
  inherit session and process group ID from the criu itself. This option
  also allows to migrate a single external tty connection, to migrate
  applications like top.

TIOCSLCKTRMIOS can only be done if the process has CAP_SYS_ADMIN and
this change extends it to CAP_SYS_ADMIN or CAP_CHECKPOINT_RESTORE.

With this change it is possible to checkpoint and restore processes
which have a tty connection as non-root if CAP_CHECKPOINT_RESTORE is
set.

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Adrian Reber <areber@redhat.com>
---
Changes in v2:
- replaced "if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))"
  with "if (!checkpoint_restore_ns_capable(&init_user_ns))" as suggested
  by Christian Brauner
- v1: https://lore.kernel.org/linux-serial/20231206134340.7093-1-areber@redhat.com/
---
 drivers/tty/tty_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 4b499301a3db..85de90eebc7b 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -844,7 +844,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios(&kterm,
@@ -861,7 +861,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios_1(&kterm,

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.43.0


