Return-Path: <linux-serial+bounces-8203-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCB6A4D800
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 10:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352A33AF620
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331CF1FCFF0;
	Tue,  4 Mar 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wh0p7d1m"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132151FCD08
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080315; cv=none; b=l1yxa62dU7tAQ7IDOBw2bBCXucJxlhDZBgYtasHttmo2tYNPfrO+QoB/iSzA/wrlmD966RzgxCfCkTFTVOMzeIcUm5xy9l2W1PoeR/zanuWD1IdvncYGfzmMhiMaiT0DAeEUvbogpyyhkVwwibtJKhWkZZw4oFJM9NiRYM7psbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080315; c=relaxed/simple;
	bh=0WzzU6roBd+wb4BiPZv1ShxdEyf/59sH8xjJyNyyB/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Em0KnUEEbwZ4GTK0UGIInaIEIFG7gQhCLGm3gn0PGUkXG6YvLmtLHh7tX6+6SNqywqAXpRJgFuRa54WsjIblVj3xkMu1yLPyB+OX5sQ3HHiDBAAeX5vo1YYRpgbQo+XzRNUpvQiImeQ81sdBMxoA9TpSybzuCsDujmgiB6vXIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wh0p7d1m; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5e4aecbd88fso6572746a12.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 01:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080311; x=1741685111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQzJ/uCYeuflL88Y+3MrtFVv4DOW+ANfKOTFJKL+x3k=;
        b=wh0p7d1mjdtMiWzX6JifVSMlyDbfquromP2hXI9swu0UckrXjg+KapyWKe4+isArG5
         +WQTOi0BO0kSQQrQBCGflLtx+0A71hf6+xdEQkCrRln8Bqvu8tdARqkv5ukxp8G3e/k7
         iSiXeN/vXRN10lnnGKwQu+jP+3OZPgKWcqMbzNGOsFTavr82IrCscNunXuuXzj+HvrhX
         8Rxp3/c3CZC+Av8z4pNssAcHPbtWFZuYEMo29Eh57WTdbMp2HI7z3kmaaP18tPND6/wn
         ZVy8i8KUp6sIeXDWBayZHFgIt0D08SiE1NOnjm+sof8Prrll8Jd00oukEmJrFpUiDXjc
         ZQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080311; x=1741685111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQzJ/uCYeuflL88Y+3MrtFVv4DOW+ANfKOTFJKL+x3k=;
        b=NwBlLHX1Uajn5cstPZVitBhQWz7aXVq9wZKkaAdLcpOjUX0nPpgxYy+0b9t9LXx80V
         354YpFjPTYGzrsjkZKwBBfDbRljSl5HATH43nnK9uH6WkXD0xr/jjPOsTBsVpVu7UeJl
         633t8APhPm6J6iQAuE5ZDKpBeGsXaxSQpzd7NOKKzIhPRITCl7gqdJNIIMu6/Sg72El4
         /Zh+H3d/f9CuIUzkTNQXKzuNHX63A57wqBStgukEv7MmjTPZFCwXdkP3Z59+cBHruj0y
         npoEYFy3ZdnCebzB2R2KykqKATxvHHn8Z2HzrVemKmM8pzrkztyhP30dTjNZi+pVvIwM
         oneg==
X-Forwarded-Encrypted: i=1; AJvYcCVhn84qY48Ibp4R9mUuo12r9XeM6o4OyNLmGe/7tbWNchO5L705AVCEaopQcP9VF6Cyo/qs5mMYXSSfxnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0KovU6BSgdO/IeNU3UqmTYXSTZiGJVcaCKElfgmd6i3TUPg6
	YhRrxfXcPdiKcWlCrqxZmfS3+JQkw3+Ge2K/d601aDZR/qhfVEwWsV+N1QByGaNbPeDciBw4oQ=
	=
X-Google-Smtp-Source: AGHT+IEscl/eFn4ca6UhacAGwIAp5Klg5dZiDSUgtMEvBWdRgY7g8fjyLx/wTScj6YAQy9EZGzNV9TOR0A==
X-Received: from edbfd23.prod.google.com ([2002:a05:6402:3897:b0:5e4:d495:16dd])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:268f:b0:5e0:3f83:92ab
 with SMTP id 4fb4d7f45d1cf-5e4d6b87d70mr17084911a12.30.1741080311449; Tue, 04
 Mar 2025 01:25:11 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:00 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-2-elver@google.com>
Subject: [PATCH v2 01/34] compiler_types: Move lock checking attributes to compiler-capability-analysis.h
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The conditional definition of lock checking macros and attributes is
about to become more complex. Factor them out into their own header for
better readability, and to make it obvious which features are supported
by which mode (currently only Sparse). This is the first step towards
generalizing towards "capability analysis".

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler-capability-analysis.h | 32 ++++++++++++++++++++
 include/linux/compiler_types.h               | 18 ++---------
 2 files changed, 34 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/compiler-capability-analysis.h

diff --git a/include/linux/compiler-capability-analysis.h b/include/linux/compiler-capability-analysis.h
new file mode 100644
index 000000000000..7546ddb83f86
--- /dev/null
+++ b/include/linux/compiler-capability-analysis.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros and attributes for compiler-based static capability analysis.
+ */
+
+#ifndef _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
+#define _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
+
+#ifdef __CHECKER__
+
+/* Sparse context/lock checking support. */
+# define __must_hold(x)		__attribute__((context(x,1,1)))
+# define __acquires(x)		__attribute__((context(x,0,1)))
+# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
+# define __releases(x)		__attribute__((context(x,1,0)))
+# define __acquire(x)		__context__(x,1)
+# define __release(x)		__context__(x,-1)
+# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
+
+#else /* !__CHECKER__ */
+
+# define __must_hold(x)
+# define __acquires(x)
+# define __cond_acquires(x)
+# define __releases(x)
+# define __acquire(x)		(void)0
+# define __release(x)		(void)0
+# define __cond_lock(x, c)	(c)
+
+#endif /* __CHECKER__ */
+
+#endif /* _LINUX_COMPILER_CAPABILITY_ANALYSIS_H */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 981cc3d7e3aa..4a458e41293c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -24,6 +24,8 @@
 # define BTF_TYPE_TAG(value) /* nothing */
 #endif
 
+#include <linux/compiler-capability-analysis.h>
+
 /* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
 #ifdef __CHECKER__
 /* address spaces */
@@ -34,14 +36,6 @@
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
 static inline void __chk_user_ptr(const volatile void __user *ptr) { }
 static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
-/* context/locking */
-# define __must_hold(x)	__attribute__((context(x,1,1)))
-# define __acquires(x)	__attribute__((context(x,0,1)))
-# define __cond_acquires(x) __attribute__((context(x,0,-1)))
-# define __releases(x)	__attribute__((context(x,1,0)))
-# define __acquire(x)	__context__(x,1)
-# define __release(x)	__context__(x,-1)
-# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
 /* other */
 # define __force	__attribute__((force))
 # define __nocast	__attribute__((nocast))
@@ -62,14 +56,6 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 
 # define __chk_user_ptr(x)	(void)0
 # define __chk_io_ptr(x)	(void)0
-/* context/locking */
-# define __must_hold(x)
-# define __acquires(x)
-# define __cond_acquires(x)
-# define __releases(x)
-# define __acquire(x)	(void)0
-# define __release(x)	(void)0
-# define __cond_lock(x,c) (c)
 /* other */
 # define __force
 # define __nocast
-- 
2.48.1.711.g2feabab25a-goog


