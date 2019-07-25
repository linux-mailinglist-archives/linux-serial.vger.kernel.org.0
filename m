Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5D75713
	for <lists+linux-serial@lfdr.de>; Thu, 25 Jul 2019 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfGYSiM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 25 Jul 2019 14:38:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43956 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfGYSiM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jul 2019 14:38:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so16744041pld.10
        for <linux-serial@vger.kernel.org>; Thu, 25 Jul 2019 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npxna6+n+4ONaMcGcCGKLmZp/6GRMXWyfhc+QLsiEVw=;
        b=Q/XoOpyXq46zTo5ehcCTQ0NqiAPD05+1WN7Ekt3ELa8yoSSDktWSfi5vLOX6UKFj4d
         Hv2rrV1BKlNMnv0dvTfZae3PwzcH4Vd+wij3CQ8z8hdzn8rZDpoLMu+HiYoPKY41lu3U
         Y2HPP/F+5Kfa4x1tqhZhfbcjX6AhxnP8ywR8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npxna6+n+4ONaMcGcCGKLmZp/6GRMXWyfhc+QLsiEVw=;
        b=o4QHpYRPOzLB5G+X8kpyy93xiuO62fEWvMaosK2H9M+v4teUhN8Y6wT4VO9udKeqTa
         ysbXKuyBXUh7nvPydhwCCix2IvMHrLxrN6mT/IpAjFMStEqMgq1V+rOCmsxoV2YFd3su
         nAVjw2ToSpxwttoZzZRH1pI44VFqMg/xC83IKtzQjkq02+cwFBXWDYyTFyBMisLuk4mn
         YnH1zdiui0rB3jAkQ6auL8K5HOLMHO0Hl62HZyaoI8vAk7BkBb6HL92L52mf2ErbdR4b
         Y55x5jpj+4wU0poobgBbsJsyxY5+QrWuYaemrW9ZUayFmPeIc2SaiHJ4Vd0kAYnZk4EP
         qdvg==
X-Gm-Message-State: APjAAAUIdqnYGUAljaglcVO93fmeiw2qUeeWrUeNWG/bB88cHYvHUnLn
        /pFcqKwJWC0DmVmrLsHRGmVDuw==
X-Google-Smtp-Source: APXvYqzcg6tbTZXUi/ksxaA2L3t2OfQeJvaYoa8UKfYplKmCwDz4Z4M5u5LmMv5+PdG1eLWIRRO7rA==
X-Received: by 2002:a17:902:1566:: with SMTP id b35mr94613083plh.147.1564079891325;
        Thu, 25 Jul 2019 11:38:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id l26sm47484684pgb.90.2019.07.25.11.38.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:38:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] kgdboc: disable the console lock when in kgdb
Date:   Thu, 25 Jul 2019 11:35:51 -0700
Message-Id: <20190725183551.169208-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After commit ddde3c18b700 ("vt: More locking checks") kdb / kgdb has
become useless because my console is filled with spews of:

WARNING: CPU: 0 PID: 0 at .../drivers/tty/vt/vt.c:3846 con_is_visible+0x50/0x74
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc1+ #48
Hardware name: Rockchip (Device Tree)
Backtrace:
[<c020ce9c>] (dump_backtrace) from [<c020d188>] (show_stack+0x20/0x24)
[<c020d168>] (show_stack) from [<c0a8fc14>] (dump_stack+0xb0/0xd0)
[<c0a8fb64>] (dump_stack) from [<c0232c58>] (__warn+0xec/0x11c)
[<c0232b6c>] (__warn) from [<c0232dc4>] (warn_slowpath_null+0x4c/0x58)
[<c0232d78>] (warn_slowpath_null) from [<c06338a0>] (con_is_visible+0x50/0x74)
[<c0633850>] (con_is_visible) from [<c0634078>] (con_scroll+0x108/0x1ac)
[<c0633f70>] (con_scroll) from [<c0634160>] (lf+0x44/0x88)
[<c063411c>] (lf) from [<c06363ec>] (vt_console_print+0x1a4/0x2bc)
[<c0636248>] (vt_console_print) from [<c02f628c>] (vkdb_printf+0x420/0x8a4)
[<c02f5e6c>] (vkdb_printf) from [<c02f6754>] (kdb_printf+0x44/0x60)
[<c02f6714>] (kdb_printf) from [<c02fa6f4>] (kdb_main_loop+0xf4/0x6e0)
[<c02fa600>] (kdb_main_loop) from [<c02fd5f0>] (kdb_stub+0x268/0x398)
[<c02fd388>] (kdb_stub) from [<c02f3ba0>] (kgdb_cpu_enter+0x1f8/0x674)
[<c02f39a8>] (kgdb_cpu_enter) from [<c02f4330>] (kgdb_handle_exception+0x1c4/0x1fc)
[<c02f416c>] (kgdb_handle_exception) from [<c0210fe0>] (kgdb_compiled_brk_fn+0x30/0x3c)
[<c0210fb0>] (kgdb_compiled_brk_fn) from [<c020d7ac>] (do_undefinstr+0x180/0x1a0)
[<c020d62c>] (do_undefinstr) from [<c0201b44>] (__und_svc_finish+0x0/0x3c)
...
[<c02f3224>] (kgdb_breakpoint) from [<c02f3310>] (sysrq_handle_dbg+0x58/0x6c)
[<c02f32b8>] (sysrq_handle_dbg) from [<c062abf0>] (__handle_sysrq+0xac/0x154)

Let's disable this warning when we're in kgdb to avoid the spew.  The
whole system is stopped when we're in kgdb so we can't exactly wait
for someone else to drop the lock.  Presumably the best we can do is
to disable the warning and hope for the best.

Fixes: ddde3c18b700 ("vt: More locking checks")
Cc: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/kgdboc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index bfe5e9e034ec..c7d51b51898f 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -277,10 +277,14 @@ static void kgdboc_pre_exp_handler(void)
 	/* Increment the module count when the debugger is active */
 	if (!kgdb_connected)
 		try_module_get(THIS_MODULE);
+
+	atomic_inc(&ignore_console_lock_warning);
 }
 
 static void kgdboc_post_exp_handler(void)
 {
+	atomic_dec(&ignore_console_lock_warning);
+
 	/* decrement the module count when the debugger detaches */
 	if (!kgdb_connected)
 		module_put(THIS_MODULE);
-- 
2.22.0.709.g102302147b-goog

