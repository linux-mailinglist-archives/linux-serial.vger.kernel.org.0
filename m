Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25838554D1
	for <lists+linux-serial@lfdr.de>; Tue, 25 Jun 2019 18:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfFYQqk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 25 Jun 2019 12:46:40 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:40013 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfFYQqk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jun 2019 12:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WbHNl0iqFS+h/Y/NRQf+DQGfBRp0QLmLg6AqzLkUiMk=; b=Wb5N2Gy/kh5fxcqn+fyflXO42N
        hCO8zUeicEdo1j68Lh9U41jEl87O5CmJfciyb44t+IK1t0KYJNyS/iSb0Ei+Ou73FecQL3o3to1SR
        +wW6nvLr9v8VKl1gv1KPZVhSl73AVQoJKILCe1P4LAwAEasKk3ckbtk6jZrLimL70+vtW6RQ4X9qh
        8t8EBJ1bu35E6WX9ppY7M8jurhkU1VwOwhNcZfxmjRjutqNA+9IkMt58OG+vi0PCQ1PfmfCxzISU0
        7mCtuWfjUN3ZAKG/cz7oRCA3dhwjf7IxU872Q1mOkBbXoBkhza/CAJ+IYo2ysUp/Q6+3db6Zen2kd
        W81kNxCg==;
Received: from [10.7.4.141] (port=44632 helo=cello.cs.msu.ru)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hfo3F-0006Uf-L9; Tue, 25 Jun 2019 19:12:09 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, Arseny Maslennikov <ar@cs.msu.ru>
Date:   Tue, 25 Jun 2019 19:11:50 +0300
Message-Id: <20190625161153.29811-5-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625161153.29811-1-ar@cs.msu.ru>
References: <20190625161153.29811-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.7.4.141
X-SA-Exim-Mail-From: ar@cs.msu.ru
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.cs.msu.ru
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_ADSP_ALL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH v2 4/7] linux/signal.h: Ignore SIGINFO by default in new tasks
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This matches the behaviour of other Unix-like systems that have SIGINFO
and causes less harm to processes that do not install handlers for this
signal, making the keyboard status character non-fatal for them.

This is implemented with the assumption that SIGINFO is defined
to be equivalent to SIGPWR; still, there is no reason for PWR to
result in termination of the signal recipient anyway — it does not
indicate there is a fatal problem with the recipient's execution
context (like e.g. FPE/ILL do), and we have TERM/KILL for explicit
termination requests.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 include/linux/signal.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 9702016734b1..c365754ea647 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -360,7 +360,7 @@ extern bool unhandled_signal(struct task_struct *tsk, int sig);
  *	|  SIGSYS/SIGUNUSED  |	coredump 	|
  *	|  SIGSTKFLT         |	terminate	|
  *	|  SIGWINCH          |	ignore   	|
- *	|  SIGPWR            |	terminate	|
+ *	|  SIGPWR            |	ignore   	|
  *	|  SIGRTMIN-SIGRTMAX |	terminate       |
  *	+--------------------+------------------+
  *	|  non-POSIX signal  |  default action  |
@@ -411,7 +411,8 @@ extern bool unhandled_signal(struct task_struct *tsk, int sig);
 
 #define SIG_KERNEL_IGNORE_MASK (\
         rt_sigmask(SIGCONT)   |  rt_sigmask(SIGCHLD)   | \
-	rt_sigmask(SIGWINCH)  |  rt_sigmask(SIGURG)    )
+	rt_sigmask(SIGWINCH)  |  rt_sigmask(SIGURG)    | \
+	rt_sigmask(SIGINFO)			       )
 
 #define SIG_SPECIFIC_SICODES_MASK (\
 	rt_sigmask(SIGILL)    |  rt_sigmask(SIGFPE)    | \
-- 
2.20.1

