Return-Path: <linux-serial+bounces-8210-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40482A4D838
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 10:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F356A1889DB5
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0351FFC52;
	Tue,  4 Mar 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb1nBASW"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D521FF7D3
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080335; cv=none; b=r350mvbKmXDUMVAEimjDPP8BHnz872PIVgj3RdmwqlWAOohVIJrO6oEaEJtsooStqkA90vZhG9F3Bqd6Bc8LGiwFgsesxn+i3buSHcUWYosrfTmveHKTZo34IcPEJWmae2RXw3z8nG3cLwl1Oc9Bs+WnxsRIt/Pv+Ino7PHXTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080335; c=relaxed/simple;
	bh=+0AhSChSdbaQqCdL8eyMWAMV0x5uSNgRkyq4GhMylgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ncl50EFgdP8+/FcFSmaXJffeuY0Yy9p7gcwf/ypXXUsCvSLT+/YBtTZNdQkKGncPWriAFAvOyuyApkYp5PX7PFVDhNZ5aXQQq4OdCrBdn6YoLru+hVepL05hv0QrK7DDS7woLPb4EQ/2/tqzTjaxnCYF0RkTWb96xdi6kRicAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bb1nBASW; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5da15447991so6390050a12.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 01:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080331; x=1741685131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Cj4Mr4frgnHfVo0V+RYccK4MiV1UgllCsbw+qa66U=;
        b=Bb1nBASWDmiZNZzrXsJJPRcYeogyI1al6Ek0KrmmrG7nApQgFmtcsw/JFayZ4ieQ9X
         xVz3Qe0xFdtu9qdm/UAIFhzVX8pQRuZRg+WiYYvPi8zM9o6rAdtWUlyYsm20p5o5pGIg
         dPSEIdBQt3HDBblrFg3WL/4m3h7vydCPdwi3BVcTmbeitr7c0K8whIm4lfhiHN+Y9/BZ
         s0O7M3dgj0qfkhKddO5gklnGceBQZ+qgpSHss4NOgBpX6vsLuCc9SpOOciKZ5bfInh9J
         AwW6rBrS4WEmQBSCSrdaQinu3rVYoB30NG7Jl2I8osspYez2S4o6G7bCDqMHCqoQDppL
         QfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080331; x=1741685131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Cj4Mr4frgnHfVo0V+RYccK4MiV1UgllCsbw+qa66U=;
        b=xR8tjGh06Aw8Ni2DyYiOUb6kCL9w7hdozajbR7UaKiLohs4hjK9bNgl1Xg5J7DCOht
         DkL3xhdwsAGaK1XdV6ErcKifXkWwY7L8O/TxKKvIg6PCfPZjLsyFUOZ9zpUJuG1EX68U
         xhEC8zz3VRc8UV0zd4cGj9f96XcS4SLBfsOO+5Sq5QqdOORF9T7WgKr+B20ieFCPJxex
         BcRtrf86V8TvyyAx0xtQYHqB85Gzm8H2Wx4xIJYBxqC+2cxdg6VC1ATQ5MPPl5KHhjlq
         CkMnx7oMhpcYWRWPE21rjxvsGMT1d3rFKitoklpuQYymE5KRaO3Lh5cBD37BuqZ/1rOs
         eDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWse9Z5WNATIJ6aHX/kS7AaJ3VWGRXRNqjPrtO+UovxW+BjKmRQRKntVzeU0qT18hfcYYATAbva47TLp5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyblUcx/4/Ja49DiLEIJD2gHH2cNHoGfgLTHz59ExtVVCsWGacj
	T1KCL7FenQRZKNsab7RCgaAhRd6VoV++Q/+tgomzF2vZq6PMhs8z895D5kfxHQKM4b6rIMyzKA=
	=
X-Google-Smtp-Source: AGHT+IHQbWJyFQ0C6C1mK2P03rC9H96qYVYwUBdsPTyym958FynWJNhHUNNysiX6I1GEsmf9CPyg23q+UA==
X-Received: from ejbps10.prod.google.com ([2002:a17:906:bf4a:b0:abf:4a05:fc97])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5203:b0:5e4:9348:72e3
 with SMTP id 4fb4d7f45d1cf-5e4d6b4c2f8mr42858591a12.21.1741080330671; Tue, 04
 Mar 2025 01:25:30 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:07 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-9-elver@google.com>
Subject: [PATCH v2 08/34] locking/rwlock, spinlock: Support Clang's capability analysis
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

Add support for Clang's capability analysis for raw_spinlock_t,
spinlock_t, and rwlock. This wholesale conversion is required because
all three of them are interdependent.

To avoid warnings in constructors, the initialization functions mark a
capability as acquired when initialized before guarded variables.

The test verifies that common patterns do not generate false positives.

Signed-off-by: Marco Elver <elver@google.com>
---
 .../dev-tools/capability-analysis.rst         |   3 +-
 include/linux/rwlock.h                        |  25 ++--
 include/linux/rwlock_api_smp.h                |  29 +++-
 include/linux/rwlock_rt.h                     |  35 +++--
 include/linux/rwlock_types.h                  |  10 +-
 include/linux/spinlock.h                      |  45 +++---
 include/linux/spinlock_api_smp.h              |  14 +-
 include/linux/spinlock_api_up.h               |  71 +++++-----
 include/linux/spinlock_rt.h                   |  21 +--
 include/linux/spinlock_types.h                |  10 +-
 include/linux/spinlock_types_raw.h            |   5 +-
 lib/test_capability-analysis.c                | 128 ++++++++++++++++++
 12 files changed, 299 insertions(+), 97 deletions(-)

diff --git a/Documentation/dev-tools/capability-analysis.rst b/Documentation/dev-tools/capability-analysis.rst
index 4b9c93cc8fcd..ddda3dc0d8d3 100644
--- a/Documentation/dev-tools/capability-analysis.rst
+++ b/Documentation/dev-tools/capability-analysis.rst
@@ -78,7 +78,8 @@ More details are also documented `here
 Supported Kernel Primitives
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. Currently the following synchronization primitives are supported:
+Currently the following synchronization primitives are supported:
+`raw_spinlock_t`, `spinlock_t`, `rwlock_t`.
 
 For capabilities with an initialization function (e.g., `spin_lock_init()`),
 calling this function on the capability instance before initializing any
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 5b87c6f4a243..3c8971201ec7 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -22,23 +22,24 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__rwlock_init((lock), #lock, &__key);			\
+	__assert_cap(lock);					\
 } while (0)
 #else
 # define rwlock_init(lock)					\
-	do { *(lock) = __RW_LOCK_UNLOCKED(lock); } while (0)
+	do { *(lock) = __RW_LOCK_UNLOCKED(lock); __assert_cap(lock); } while (0)
 #endif
 
 #ifdef CONFIG_DEBUG_SPINLOCK
- extern void do_raw_read_lock(rwlock_t *lock) __acquires(lock);
+ extern void do_raw_read_lock(rwlock_t *lock) __acquires_shared(lock);
  extern int do_raw_read_trylock(rwlock_t *lock);
- extern void do_raw_read_unlock(rwlock_t *lock) __releases(lock);
+ extern void do_raw_read_unlock(rwlock_t *lock) __releases_shared(lock);
  extern void do_raw_write_lock(rwlock_t *lock) __acquires(lock);
  extern int do_raw_write_trylock(rwlock_t *lock);
  extern void do_raw_write_unlock(rwlock_t *lock) __releases(lock);
 #else
-# define do_raw_read_lock(rwlock)	do {__acquire(lock); arch_read_lock(&(rwlock)->raw_lock); } while (0)
+# define do_raw_read_lock(rwlock)	do {__acquire_shared(lock); arch_read_lock(&(rwlock)->raw_lock); } while (0)
 # define do_raw_read_trylock(rwlock)	arch_read_trylock(&(rwlock)->raw_lock)
-# define do_raw_read_unlock(rwlock)	do {arch_read_unlock(&(rwlock)->raw_lock); __release(lock); } while (0)
+# define do_raw_read_unlock(rwlock)	do {arch_read_unlock(&(rwlock)->raw_lock); __release_shared(lock); } while (0)
 # define do_raw_write_lock(rwlock)	do {__acquire(lock); arch_write_lock(&(rwlock)->raw_lock); } while (0)
 # define do_raw_write_trylock(rwlock)	arch_write_trylock(&(rwlock)->raw_lock)
 # define do_raw_write_unlock(rwlock)	do {arch_write_unlock(&(rwlock)->raw_lock); __release(lock); } while (0)
@@ -49,7 +50,7 @@ do {								\
  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
  * methods are defined as nops in the case they are not required.
  */
-#define read_trylock(lock)	__cond_lock(lock, _raw_read_trylock(lock))
+#define read_trylock(lock)	__cond_lock_shared(lock, _raw_read_trylock(lock))
 #define write_trylock(lock)	__cond_lock(lock, _raw_write_trylock(lock))
 
 #define write_lock(lock)	_raw_write_lock(lock)
@@ -112,12 +113,12 @@ do {								\
 	} while (0)
 #define write_unlock_bh(lock)		_raw_write_unlock_bh(lock)
 
-#define write_trylock_irqsave(lock, flags) \
-({ \
-	local_irq_save(flags); \
-	write_trylock(lock) ? \
-	1 : ({ local_irq_restore(flags); 0; }); \
-})
+#define write_trylock_irqsave(lock, flags)		\
+	__cond_lock(lock, ({				\
+		local_irq_save(flags);			\
+		_raw_write_trylock(lock) ?		\
+		1 : ({ local_irq_restore(flags); 0; });	\
+	}))
 
 #ifdef arch_rwlock_is_contended
 #define rwlock_is_contended(lock) \
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index 31d3d1116323..3e975105a606 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -15,12 +15,12 @@
  * Released under the General Public License (GPL).
  */
 
-void __lockfunc _raw_read_lock(rwlock_t *lock)		__acquires(lock);
+void __lockfunc _raw_read_lock(rwlock_t *lock)		__acquires_shared(lock);
 void __lockfunc _raw_write_lock(rwlock_t *lock)		__acquires(lock);
 void __lockfunc _raw_write_lock_nested(rwlock_t *lock, int subclass)	__acquires(lock);
-void __lockfunc _raw_read_lock_bh(rwlock_t *lock)	__acquires(lock);
+void __lockfunc _raw_read_lock_bh(rwlock_t *lock)	__acquires_shared(lock);
 void __lockfunc _raw_write_lock_bh(rwlock_t *lock)	__acquires(lock);
-void __lockfunc _raw_read_lock_irq(rwlock_t *lock)	__acquires(lock);
+void __lockfunc _raw_read_lock_irq(rwlock_t *lock)	__acquires_shared(lock);
 void __lockfunc _raw_write_lock_irq(rwlock_t *lock)	__acquires(lock);
 unsigned long __lockfunc _raw_read_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
@@ -28,11 +28,11 @@ unsigned long __lockfunc _raw_write_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
 int __lockfunc _raw_read_trylock(rwlock_t *lock);
 int __lockfunc _raw_write_trylock(rwlock_t *lock);
-void __lockfunc _raw_read_unlock(rwlock_t *lock)	__releases(lock);
+void __lockfunc _raw_read_unlock(rwlock_t *lock)	__releases_shared(lock);
 void __lockfunc _raw_write_unlock(rwlock_t *lock)	__releases(lock);
-void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)	__releases(lock);
+void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)	__releases_shared(lock);
 void __lockfunc _raw_write_unlock_bh(rwlock_t *lock)	__releases(lock);
-void __lockfunc _raw_read_unlock_irq(rwlock_t *lock)	__releases(lock);
+void __lockfunc _raw_read_unlock_irq(rwlock_t *lock)	__releases_shared(lock);
 void __lockfunc _raw_write_unlock_irq(rwlock_t *lock)	__releases(lock);
 void __lockfunc
 _raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
@@ -145,6 +145,7 @@ static inline int __raw_write_trylock(rwlock_t *lock)
 #if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
 
 static inline void __raw_read_lock(rwlock_t *lock)
+	__acquires_shared(lock) __no_capability_analysis
 {
 	preempt_disable();
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
@@ -152,6 +153,7 @@ static inline void __raw_read_lock(rwlock_t *lock)
 }
 
 static inline unsigned long __raw_read_lock_irqsave(rwlock_t *lock)
+	__acquires_shared(lock) __no_capability_analysis
 {
 	unsigned long flags;
 
@@ -163,6 +165,7 @@ static inline unsigned long __raw_read_lock_irqsave(rwlock_t *lock)
 }
 
 static inline void __raw_read_lock_irq(rwlock_t *lock)
+	__acquires_shared(lock) __no_capability_analysis
 {
 	local_irq_disable();
 	preempt_disable();
@@ -171,6 +174,7 @@ static inline void __raw_read_lock_irq(rwlock_t *lock)
 }
 
 static inline void __raw_read_lock_bh(rwlock_t *lock)
+	__acquires_shared(lock) __no_capability_analysis
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
@@ -178,6 +182,7 @@ static inline void __raw_read_lock_bh(rwlock_t *lock)
 }
 
 static inline unsigned long __raw_write_lock_irqsave(rwlock_t *lock)
+	__acquires(lock) __no_capability_analysis
 {
 	unsigned long flags;
 
@@ -189,6 +194,7 @@ static inline unsigned long __raw_write_lock_irqsave(rwlock_t *lock)
 }
 
 static inline void __raw_write_lock_irq(rwlock_t *lock)
+	__acquires(lock) __no_capability_analysis
 {
 	local_irq_disable();
 	preempt_disable();
@@ -197,6 +203,7 @@ static inline void __raw_write_lock_irq(rwlock_t *lock)
 }
 
 static inline void __raw_write_lock_bh(rwlock_t *lock)
+	__acquires(lock) __no_capability_analysis
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
@@ -204,6 +211,7 @@ static inline void __raw_write_lock_bh(rwlock_t *lock)
 }
 
 static inline void __raw_write_lock(rwlock_t *lock)
+	__acquires(lock) __no_capability_analysis
 {
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
@@ -211,6 +219,7 @@ static inline void __raw_write_lock(rwlock_t *lock)
 }
 
 static inline void __raw_write_lock_nested(rwlock_t *lock, int subclass)
+	__acquires(lock) __no_capability_analysis
 {
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
@@ -220,6 +229,7 @@ static inline void __raw_write_lock_nested(rwlock_t *lock, int subclass)
 #endif /* !CONFIG_GENERIC_LOCKBREAK || CONFIG_DEBUG_LOCK_ALLOC */
 
 static inline void __raw_write_unlock(rwlock_t *lock)
+	__releases(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_write_unlock(lock);
@@ -227,6 +237,7 @@ static inline void __raw_write_unlock(rwlock_t *lock)
 }
 
 static inline void __raw_read_unlock(rwlock_t *lock)
+	__releases_shared(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
@@ -235,6 +246,7 @@ static inline void __raw_read_unlock(rwlock_t *lock)
 
 static inline void
 __raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+	__releases_shared(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
@@ -243,6 +255,7 @@ __raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 }
 
 static inline void __raw_read_unlock_irq(rwlock_t *lock)
+	__releases_shared(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
@@ -251,6 +264,7 @@ static inline void __raw_read_unlock_irq(rwlock_t *lock)
 }
 
 static inline void __raw_read_unlock_bh(rwlock_t *lock)
+	__releases_shared(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
@@ -259,6 +273,7 @@ static inline void __raw_read_unlock_bh(rwlock_t *lock)
 
 static inline void __raw_write_unlock_irqrestore(rwlock_t *lock,
 					     unsigned long flags)
+	__releases(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_write_unlock(lock);
@@ -267,6 +282,7 @@ static inline void __raw_write_unlock_irqrestore(rwlock_t *lock,
 }
 
 static inline void __raw_write_unlock_irq(rwlock_t *lock)
+	__releases(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_write_unlock(lock);
@@ -275,6 +291,7 @@ static inline void __raw_write_unlock_irq(rwlock_t *lock)
 }
 
 static inline void __raw_write_unlock_bh(rwlock_t *lock)
+	__releases(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_write_unlock(lock);
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 7d81fc6918ee..742172a06702 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -22,28 +22,32 @@ do {							\
 							\
 	init_rwbase_rt(&(rwl)->rwbase);			\
 	__rt_rwlock_init(rwl, #rwl, &__key);		\
+	__assert_cap(rwl);				\
 } while (0)
 
-extern void rt_read_lock(rwlock_t *rwlock)	__acquires(rwlock);
+extern void rt_read_lock(rwlock_t *rwlock)	__acquires_shared(rwlock);
 extern int rt_read_trylock(rwlock_t *rwlock);
-extern void rt_read_unlock(rwlock_t *rwlock)	__releases(rwlock);
+extern void rt_read_unlock(rwlock_t *rwlock)	__releases_shared(rwlock);
 extern void rt_write_lock(rwlock_t *rwlock)	__acquires(rwlock);
 extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass)	__acquires(rwlock);
 extern int rt_write_trylock(rwlock_t *rwlock);
 extern void rt_write_unlock(rwlock_t *rwlock)	__releases(rwlock);
 
 static __always_inline void read_lock(rwlock_t *rwlock)
+	__acquires_shared(rwlock)
 {
 	rt_read_lock(rwlock);
 }
 
 static __always_inline void read_lock_bh(rwlock_t *rwlock)
+	__acquires_shared(rwlock)
 {
 	local_bh_disable();
 	rt_read_lock(rwlock);
 }
 
 static __always_inline void read_lock_irq(rwlock_t *rwlock)
+	__acquires_shared(rwlock)
 {
 	rt_read_lock(rwlock);
 }
@@ -55,37 +59,43 @@ static __always_inline void read_lock_irq(rwlock_t *rwlock)
 		flags = 0;				\
 	} while (0)
 
-#define read_trylock(lock)	__cond_lock(lock, rt_read_trylock(lock))
+#define read_trylock(lock)	__cond_lock_shared(lock, rt_read_trylock(lock))
 
 static __always_inline void read_unlock(rwlock_t *rwlock)
+	__releases_shared(rwlock)
 {
 	rt_read_unlock(rwlock);
 }
 
 static __always_inline void read_unlock_bh(rwlock_t *rwlock)
+	__releases_shared(rwlock)
 {
 	rt_read_unlock(rwlock);
 	local_bh_enable();
 }
 
 static __always_inline void read_unlock_irq(rwlock_t *rwlock)
+	__releases_shared(rwlock)
 {
 	rt_read_unlock(rwlock);
 }
 
 static __always_inline void read_unlock_irqrestore(rwlock_t *rwlock,
 						   unsigned long flags)
+	__releases_shared(rwlock)
 {
 	rt_read_unlock(rwlock);
 }
 
 static __always_inline void write_lock(rwlock_t *rwlock)
+	__acquires(rwlock)
 {
 	rt_write_lock(rwlock);
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static __always_inline void write_lock_nested(rwlock_t *rwlock, int subclass)
+	__acquires(rwlock)
 {
 	rt_write_lock_nested(rwlock, subclass);
 }
@@ -94,12 +104,14 @@ static __always_inline void write_lock_nested(rwlock_t *rwlock, int subclass)
 #endif
 
 static __always_inline void write_lock_bh(rwlock_t *rwlock)
+	__acquires(rwlock)
 {
 	local_bh_disable();
 	rt_write_lock(rwlock);
 }
 
 static __always_inline void write_lock_irq(rwlock_t *rwlock)
+	__acquires(rwlock)
 {
 	rt_write_lock(rwlock);
 }
@@ -114,33 +126,34 @@ static __always_inline void write_lock_irq(rwlock_t *rwlock)
 #define write_trylock(lock)	__cond_lock(lock, rt_write_trylock(lock))
 
 #define write_trylock_irqsave(lock, flags)		\
-({							\
-	int __locked;					\
-							\
-	typecheck(unsigned long, flags);		\
-	flags = 0;					\
-	__locked = write_trylock(lock);			\
-	__locked;					\
-})
+	__cond_lock(lock, ({				\
+		typecheck(unsigned long, flags);	\
+		flags = 0;				\
+		rt_write_trylock(lock);			\
+	}))
 
 static __always_inline void write_unlock(rwlock_t *rwlock)
+	__releases(rwlock)
 {
 	rt_write_unlock(rwlock);
 }
 
 static __always_inline void write_unlock_bh(rwlock_t *rwlock)
+	__releases(rwlock)
 {
 	rt_write_unlock(rwlock);
 	local_bh_enable();
 }
 
 static __always_inline void write_unlock_irq(rwlock_t *rwlock)
+	__releases(rwlock)
 {
 	rt_write_unlock(rwlock);
 }
 
 static __always_inline void write_unlock_irqrestore(rwlock_t *rwlock,
 						    unsigned long flags)
+	__releases(rwlock)
 {
 	rt_write_unlock(rwlock);
 }
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 1948442e7750..231489cc30f2 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -22,7 +22,7 @@
  * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
  * Released under the General Public License (GPL).
  */
-typedef struct {
+struct_with_capability(rwlock) {
 	arch_rwlock_t raw_lock;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned int magic, owner_cpu;
@@ -31,7 +31,8 @@ typedef struct {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
-} rwlock_t;
+};
+typedef struct rwlock rwlock_t;
 
 #define RWLOCK_MAGIC		0xdeaf1eed
 
@@ -54,13 +55,14 @@ typedef struct {
 
 #include <linux/rwbase_rt.h>
 
-typedef struct {
+struct_with_capability(rwlock) {
 	struct rwbase_rt	rwbase;
 	atomic_t		readers;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
-} rwlock_t;
+};
+typedef struct rwlock rwlock_t;
 
 #define __RWLOCK_RT_INITIALIZER(name)					\
 {									\
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 63dd8cf3c3c2..09124713b115 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -106,11 +106,12 @@ do {									\
 	static struct lock_class_key __key;				\
 									\
 	__raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN);	\
+	__assert_cap(lock);						\
 } while (0)
 
 #else
 # define raw_spin_lock_init(lock)				\
-	do { *(lock) = __RAW_SPIN_LOCK_UNLOCKED(lock); } while (0)
+	do { *(lock) = __RAW_SPIN_LOCK_UNLOCKED(lock); __assert_cap(lock); } while (0)
 #endif
 
 #define raw_spin_is_locked(lock)	arch_spin_is_locked(&(lock)->raw_lock)
@@ -286,19 +287,19 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 #define raw_spin_trylock_bh(lock) \
 	__cond_lock(lock, _raw_spin_trylock_bh(lock))
 
-#define raw_spin_trylock_irq(lock) \
-({ \
-	local_irq_disable(); \
-	raw_spin_trylock(lock) ? \
-	1 : ({ local_irq_enable(); 0;  }); \
-})
+#define raw_spin_trylock_irq(lock)			\
+	__cond_lock(lock, ({				\
+		local_irq_disable();			\
+		_raw_spin_trylock(lock) ?		\
+		1 : ({ local_irq_enable(); 0;  });	\
+	}))
 
-#define raw_spin_trylock_irqsave(lock, flags) \
-({ \
-	local_irq_save(flags); \
-	raw_spin_trylock(lock) ? \
-	1 : ({ local_irq_restore(flags); 0; }); \
-})
+#define raw_spin_trylock_irqsave(lock, flags)		\
+	__cond_lock(lock, ({				\
+		local_irq_save(flags);			\
+		_raw_spin_trylock(lock) ?		\
+		1 : ({ local_irq_restore(flags); 0; }); \
+	}))
 
 #ifndef CONFIG_PREEMPT_RT
 /* Include rwlock functions for !RT */
@@ -334,6 +335,7 @@ do {								\
 								\
 	__raw_spin_lock_init(spinlock_check(lock),		\
 			     #lock, &__key, LD_WAIT_CONFIG);	\
+	__assert_cap(lock);					\
 } while (0)
 
 #else
@@ -342,21 +344,25 @@ do {								\
 do {						\
 	spinlock_check(_lock);			\
 	*(_lock) = __SPIN_LOCK_UNLOCKED(_lock);	\
+	__assert_cap(_lock);			\
 } while (0)
 
 #endif
 
 static __always_inline void spin_lock(spinlock_t *lock)
+	__acquires(lock) __no_capability_analysis
 {
 	raw_spin_lock(&lock->rlock);
 }
 
 static __always_inline void spin_lock_bh(spinlock_t *lock)
+	__acquires(lock) __no_capability_analysis
 {
 	raw_spin_lock_bh(&lock->rlock);
 }
 
 static __always_inline int spin_trylock(spinlock_t *lock)
+	__cond_acquires(lock) __no_capability_analysis
 {
 	return raw_spin_trylock(&lock->rlock);
 }
@@ -372,6 +378,7 @@ do {									\
 } while (0)
 
 static __always_inline void spin_lock_irq(spinlock_t *lock)
+	__acquires(lock) __no_capability_analysis
 {
 	raw_spin_lock_irq(&lock->rlock);
 }
@@ -379,47 +386,53 @@ static __always_inline void spin_lock_irq(spinlock_t *lock)
 #define spin_lock_irqsave(lock, flags)				\
 do {								\
 	raw_spin_lock_irqsave(spinlock_check(lock), flags);	\
+	__release(spinlock_check(lock)); __acquire(lock);	\
 } while (0)
 
 #define spin_lock_irqsave_nested(lock, flags, subclass)			\
 do {									\
 	raw_spin_lock_irqsave_nested(spinlock_check(lock), flags, subclass); \
+	__release(spinlock_check(lock)); __acquire(lock);		\
 } while (0)
 
 static __always_inline void spin_unlock(spinlock_t *lock)
+	__releases(lock) __no_capability_analysis
 {
 	raw_spin_unlock(&lock->rlock);
 }
 
 static __always_inline void spin_unlock_bh(spinlock_t *lock)
+	__releases(lock) __no_capability_analysis
 {
 	raw_spin_unlock_bh(&lock->rlock);
 }
 
 static __always_inline void spin_unlock_irq(spinlock_t *lock)
+	__releases(lock) __no_capability_analysis
 {
 	raw_spin_unlock_irq(&lock->rlock);
 }
 
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
+	__releases(lock) __no_capability_analysis
 {
 	raw_spin_unlock_irqrestore(&lock->rlock, flags);
 }
 
 static __always_inline int spin_trylock_bh(spinlock_t *lock)
+	__cond_acquires(lock) __no_capability_analysis
 {
 	return raw_spin_trylock_bh(&lock->rlock);
 }
 
 static __always_inline int spin_trylock_irq(spinlock_t *lock)
+	__cond_acquires(lock) __no_capability_analysis
 {
 	return raw_spin_trylock_irq(&lock->rlock);
 }
 
 #define spin_trylock_irqsave(lock, flags)			\
-({								\
-	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
-})
+	__cond_lock(lock, raw_spin_trylock_irqsave(spinlock_check(lock), flags))
 
 /**
  * spin_is_locked() - Check whether a spinlock is locked.
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 9ecb0ab504e3..fab02d8bf0c9 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -34,8 +34,8 @@ unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinlock_t *lock)
 unsigned long __lockfunc
 _raw_spin_lock_irqsave_nested(raw_spinlock_t *lock, int subclass)
 								__acquires(lock);
-int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock);
-int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock);
+int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock)		__cond_acquires(lock);
+int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)	__cond_acquires(lock);
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)		__releases(lock);
 void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)	__releases(lock);
 void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)	__releases(lock);
@@ -84,6 +84,7 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 #endif
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
+	__cond_acquires(lock)
 {
 	preempt_disable();
 	if (do_raw_spin_trylock(lock)) {
@@ -102,6 +103,7 @@ static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 #if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
 
 static inline unsigned long __raw_spin_lock_irqsave(raw_spinlock_t *lock)
+	__acquires(lock) __no_capability_analysis
 {
 	unsigned long flags;
 
@@ -113,6 +115,7 @@ static inline unsigned long __raw_spin_lock_irqsave(raw_spinlock_t *lock)
 }
 
 static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
+	__acquires(lock) __no_capability_analysis
 {
 	local_irq_disable();
 	preempt_disable();
@@ -121,6 +124,7 @@ static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
 }
 
 static inline void __raw_spin_lock_bh(raw_spinlock_t *lock)
+	__acquires(lock) __no_capability_analysis
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
@@ -128,6 +132,7 @@ static inline void __raw_spin_lock_bh(raw_spinlock_t *lock)
 }
 
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
+	__acquires(lock) __no_capability_analysis
 {
 	preempt_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
@@ -137,6 +142,7 @@ static inline void __raw_spin_lock(raw_spinlock_t *lock)
 #endif /* !CONFIG_GENERIC_LOCKBREAK || CONFIG_DEBUG_LOCK_ALLOC */
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
+	__releases(lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	do_raw_spin_unlock(lock);
@@ -145,6 +151,7 @@ static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 
 static inline void __raw_spin_unlock_irqrestore(raw_spinlock_t *lock,
 					    unsigned long flags)
+	__releases(lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	do_raw_spin_unlock(lock);
@@ -153,6 +160,7 @@ static inline void __raw_spin_unlock_irqrestore(raw_spinlock_t *lock,
 }
 
 static inline void __raw_spin_unlock_irq(raw_spinlock_t *lock)
+	__releases(lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	do_raw_spin_unlock(lock);
@@ -161,6 +169,7 @@ static inline void __raw_spin_unlock_irq(raw_spinlock_t *lock)
 }
 
 static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock)
+	__releases(lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	do_raw_spin_unlock(lock);
@@ -168,6 +177,7 @@ static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock)
 }
 
 static inline int __raw_spin_trylock_bh(raw_spinlock_t *lock)
+	__cond_acquires(lock)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	if (do_raw_spin_trylock(lock)) {
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index 819aeba1c87e..018f5aabc1be 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -24,68 +24,77 @@
  * flags straight, to suppress compiler warnings of unused lock
  * variables, and to add the proper checker annotations:
  */
-#define ___LOCK(lock) \
-  do { __acquire(lock); (void)(lock); } while (0)
+#define ___LOCK_void(lock) \
+  do { (void)(lock); } while (0)
 
-#define __LOCK(lock) \
-  do { preempt_disable(); ___LOCK(lock); } while (0)
+#define ___LOCK_(lock) \
+  do { __acquire(lock); ___LOCK_void(lock); } while (0)
 
-#define __LOCK_BH(lock) \
-  do { __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); ___LOCK(lock); } while (0)
+#define ___LOCK_shared(lock) \
+  do { __acquire_shared(lock); ___LOCK_void(lock); } while (0)
 
-#define __LOCK_IRQ(lock) \
-  do { local_irq_disable(); __LOCK(lock); } while (0)
+#define __LOCK(lock, ...) \
+  do { preempt_disable(); ___LOCK_##__VA_ARGS__(lock); } while (0)
 
-#define __LOCK_IRQSAVE(lock, flags) \
-  do { local_irq_save(flags); __LOCK(lock); } while (0)
+#define __LOCK_BH(lock, ...) \
+  do { __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); ___LOCK_##__VA_ARGS__(lock); } while (0)
 
-#define ___UNLOCK(lock) \
+#define __LOCK_IRQ(lock, ...) \
+  do { local_irq_disable(); __LOCK(lock, ##__VA_ARGS__); } while (0)
+
+#define __LOCK_IRQSAVE(lock, flags, ...) \
+  do { local_irq_save(flags); __LOCK(lock, ##__VA_ARGS__); } while (0)
+
+#define ___UNLOCK_(lock) \
   do { __release(lock); (void)(lock); } while (0)
 
-#define __UNLOCK(lock) \
-  do { preempt_enable(); ___UNLOCK(lock); } while (0)
+#define ___UNLOCK_shared(lock) \
+  do { __release_shared(lock); (void)(lock); } while (0)
 
-#define __UNLOCK_BH(lock) \
+#define __UNLOCK(lock, ...) \
+  do { preempt_enable(); ___UNLOCK_##__VA_ARGS__(lock); } while (0)
+
+#define __UNLOCK_BH(lock, ...) \
   do { __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); \
-       ___UNLOCK(lock); } while (0)
+       ___UNLOCK_##__VA_ARGS__(lock); } while (0)
 
-#define __UNLOCK_IRQ(lock) \
-  do { local_irq_enable(); __UNLOCK(lock); } while (0)
+#define __UNLOCK_IRQ(lock, ...) \
+  do { local_irq_enable(); __UNLOCK(lock, ##__VA_ARGS__); } while (0)
 
-#define __UNLOCK_IRQRESTORE(lock, flags) \
-  do { local_irq_restore(flags); __UNLOCK(lock); } while (0)
+#define __UNLOCK_IRQRESTORE(lock, flags, ...) \
+  do { local_irq_restore(flags); __UNLOCK(lock, ##__VA_ARGS__); } while (0)
 
 #define _raw_spin_lock(lock)			__LOCK(lock)
 #define _raw_spin_lock_nested(lock, subclass)	__LOCK(lock)
-#define _raw_read_lock(lock)			__LOCK(lock)
+#define _raw_read_lock(lock)			__LOCK(lock, shared)
 #define _raw_write_lock(lock)			__LOCK(lock)
 #define _raw_write_lock_nested(lock, subclass)	__LOCK(lock)
 #define _raw_spin_lock_bh(lock)			__LOCK_BH(lock)
-#define _raw_read_lock_bh(lock)			__LOCK_BH(lock)
+#define _raw_read_lock_bh(lock)			__LOCK_BH(lock, shared)
 #define _raw_write_lock_bh(lock)		__LOCK_BH(lock)
 #define _raw_spin_lock_irq(lock)		__LOCK_IRQ(lock)
-#define _raw_read_lock_irq(lock)		__LOCK_IRQ(lock)
+#define _raw_read_lock_irq(lock)		__LOCK_IRQ(lock, shared)
 #define _raw_write_lock_irq(lock)		__LOCK_IRQ(lock)
 #define _raw_spin_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
-#define _raw_read_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
+#define _raw_read_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags, shared)
 #define _raw_write_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
-#define _raw_spin_trylock(lock)			({ __LOCK(lock); 1; })
-#define _raw_read_trylock(lock)			({ __LOCK(lock); 1; })
-#define _raw_write_trylock(lock)			({ __LOCK(lock); 1; })
-#define _raw_spin_trylock_bh(lock)		({ __LOCK_BH(lock); 1; })
+#define _raw_spin_trylock(lock)			({ __LOCK(lock, void); 1; })
+#define _raw_read_trylock(lock)			({ __LOCK(lock, void); 1; })
+#define _raw_write_trylock(lock)			({ __LOCK(lock, void); 1; })
+#define _raw_spin_trylock_bh(lock)		({ __LOCK_BH(lock, void); 1; })
 #define _raw_spin_unlock(lock)			__UNLOCK(lock)
-#define _raw_read_unlock(lock)			__UNLOCK(lock)
+#define _raw_read_unlock(lock)			__UNLOCK(lock, shared)
 #define _raw_write_unlock(lock)			__UNLOCK(lock)
 #define _raw_spin_unlock_bh(lock)		__UNLOCK_BH(lock)
 #define _raw_write_unlock_bh(lock)		__UNLOCK_BH(lock)
-#define _raw_read_unlock_bh(lock)		__UNLOCK_BH(lock)
+#define _raw_read_unlock_bh(lock)		__UNLOCK_BH(lock, shared)
 #define _raw_spin_unlock_irq(lock)		__UNLOCK_IRQ(lock)
-#define _raw_read_unlock_irq(lock)		__UNLOCK_IRQ(lock)
+#define _raw_read_unlock_irq(lock)		__UNLOCK_IRQ(lock, shared)
 #define _raw_write_unlock_irq(lock)		__UNLOCK_IRQ(lock)
 #define _raw_spin_unlock_irqrestore(lock, flags) \
 					__UNLOCK_IRQRESTORE(lock, flags)
 #define _raw_read_unlock_irqrestore(lock, flags) \
-					__UNLOCK_IRQRESTORE(lock, flags)
+					__UNLOCK_IRQRESTORE(lock, flags, shared)
 #define _raw_write_unlock_irqrestore(lock, flags) \
 					__UNLOCK_IRQRESTORE(lock, flags)
 
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index f6499c37157d..1f55601e1321 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -20,6 +20,7 @@ static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
 do {								\
 	rt_mutex_base_init(&(slock)->lock);			\
 	__rt_spin_lock_init(slock, name, key, percpu);		\
+	__assert_cap(slock);					\
 } while (0)
 
 #define _spin_lock_init(slock, percpu)				\
@@ -40,6 +41,7 @@ extern int rt_spin_trylock_bh(spinlock_t *lock);
 extern int rt_spin_trylock(spinlock_t *lock);
 
 static __always_inline void spin_lock(spinlock_t *lock)
+	__acquires(lock)
 {
 	rt_spin_lock(lock);
 }
@@ -82,6 +84,7 @@ static __always_inline void spin_lock(spinlock_t *lock)
 	__spin_lock_irqsave_nested(lock, flags, subclass)
 
 static __always_inline void spin_lock_bh(spinlock_t *lock)
+	__acquires(lock)
 {
 	/* Investigate: Drop bh when blocking ? */
 	local_bh_disable();
@@ -89,6 +92,7 @@ static __always_inline void spin_lock_bh(spinlock_t *lock)
 }
 
 static __always_inline void spin_lock_irq(spinlock_t *lock)
+	__acquires(lock)
 {
 	rt_spin_lock(lock);
 }
@@ -101,23 +105,27 @@ static __always_inline void spin_lock_irq(spinlock_t *lock)
 	} while (0)
 
 static __always_inline void spin_unlock(spinlock_t *lock)
+	__releases(lock)
 {
 	rt_spin_unlock(lock);
 }
 
 static __always_inline void spin_unlock_bh(spinlock_t *lock)
+	__releases(lock)
 {
 	rt_spin_unlock(lock);
 	local_bh_enable();
 }
 
 static __always_inline void spin_unlock_irq(spinlock_t *lock)
+	__releases(lock)
 {
 	rt_spin_unlock(lock);
 }
 
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 						   unsigned long flags)
+	__releases(lock)
 {
 	rt_spin_unlock(lock);
 }
@@ -132,14 +140,11 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 	__cond_lock(lock, rt_spin_trylock(lock))
 
 #define spin_trylock_irqsave(lock, flags)		\
-({							\
-	int __locked;					\
-							\
-	typecheck(unsigned long, flags);		\
-	flags = 0;					\
-	__locked = spin_trylock(lock);			\
-	__locked;					\
-})
+	__cond_lock(lock, ({				\
+		typecheck(unsigned long, flags);	\
+		flags = 0;				\
+		rt_spin_trylock(lock);			\
+	}))
 
 #define spin_is_contended(lock)		(((void)(lock), 0))
 
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 2dfa35ffec76..2c5db5b5b990 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -14,7 +14,7 @@
 #ifndef CONFIG_PREEMPT_RT
 
 /* Non PREEMPT_RT kernels map spinlock to raw_spinlock */
-typedef struct spinlock {
+struct_with_capability(spinlock) {
 	union {
 		struct raw_spinlock rlock;
 
@@ -26,7 +26,8 @@ typedef struct spinlock {
 		};
 #endif
 	};
-} spinlock_t;
+};
+typedef struct spinlock spinlock_t;
 
 #define ___SPIN_LOCK_INITIALIZER(lockname)	\
 	{					\
@@ -47,12 +48,13 @@ typedef struct spinlock {
 /* PREEMPT_RT kernels map spinlock to rt_mutex */
 #include <linux/rtmutex.h>
 
-typedef struct spinlock {
+struct_with_capability(spinlock) {
 	struct rt_mutex_base	lock;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
-} spinlock_t;
+};
+typedef struct spinlock spinlock_t;
 
 #define __SPIN_LOCK_UNLOCKED(name)				\
 	{							\
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index 91cb36b65a17..07792ff2c2b5 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -11,7 +11,7 @@
 
 #include <linux/lockdep_types.h>
 
-typedef struct raw_spinlock {
+struct_with_capability(raw_spinlock) {
 	arch_spinlock_t raw_lock;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned int magic, owner_cpu;
@@ -20,7 +20,8 @@ typedef struct raw_spinlock {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
-} raw_spinlock_t;
+};
+typedef struct raw_spinlock raw_spinlock_t;
 
 #define SPINLOCK_MAGIC		0xdead4ead
 
diff --git a/lib/test_capability-analysis.c b/lib/test_capability-analysis.c
index a0adacce30ff..84060bace61d 100644
--- a/lib/test_capability-analysis.c
+++ b/lib/test_capability-analysis.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/build_bug.h>
+#include <linux/spinlock.h>
 
 /*
  * Test that helper macros work as expected.
@@ -16,3 +17,130 @@ static void __used test_common_helpers(void)
 	BUILD_BUG_ON(capability_unsafe((void)2, 3) != 3); /* does not swallow commas */
 	capability_unsafe(do { } while (0)); /* works with void statements */
 }
+
+#define TEST_SPINLOCK_COMMON(class, type, type_init, type_lock, type_unlock, type_trylock, op)	\
+	struct test_##class##_data {								\
+		type lock;									\
+		int counter __guarded_by(&lock);						\
+		int *pointer __pt_guarded_by(&lock);						\
+	};											\
+	static void __used test_##class##_init(struct test_##class##_data *d)			\
+	{											\
+		type_init(&d->lock);								\
+		d->counter = 0;									\
+	}											\
+	static void __used test_##class(struct test_##class##_data *d)				\
+	{											\
+		unsigned long flags;								\
+		d->pointer++;									\
+		type_lock(&d->lock);								\
+		op(d->counter);									\
+		op(*d->pointer);								\
+		type_unlock(&d->lock);								\
+		type_lock##_irq(&d->lock);							\
+		op(d->counter);									\
+		op(*d->pointer);								\
+		type_unlock##_irq(&d->lock);							\
+		type_lock##_bh(&d->lock);							\
+		op(d->counter);									\
+		op(*d->pointer);								\
+		type_unlock##_bh(&d->lock);							\
+		type_lock##_irqsave(&d->lock, flags);						\
+		op(d->counter);									\
+		op(*d->pointer);								\
+		type_unlock##_irqrestore(&d->lock, flags);					\
+	}											\
+	static void __used test_##class##_trylock(struct test_##class##_data *d)		\
+	{											\
+		if (type_trylock(&d->lock)) {							\
+			op(d->counter);								\
+			type_unlock(&d->lock);							\
+		}										\
+	}											\
+	static void __used test_##class##_assert(struct test_##class##_data *d)			\
+	{											\
+		lockdep_assert_held(&d->lock);							\
+		op(d->counter);									\
+	}											\
+	static void __used test_##class##_guard(struct test_##class##_data *d)			\
+	{											\
+		{ guard(class)(&d->lock);		op(d->counter); }			\
+		{ guard(class##_irq)(&d->lock);		op(d->counter); }			\
+		{ guard(class##_irqsave)(&d->lock);	op(d->counter); }			\
+	}
+
+#define TEST_OP_RW(x) (x)++
+#define TEST_OP_RO(x) ((void)(x))
+
+TEST_SPINLOCK_COMMON(raw_spinlock,
+		     raw_spinlock_t,
+		     raw_spin_lock_init,
+		     raw_spin_lock,
+		     raw_spin_unlock,
+		     raw_spin_trylock,
+		     TEST_OP_RW);
+static void __used test_raw_spinlock_trylock_extra(struct test_raw_spinlock_data *d)
+{
+	unsigned long flags;
+
+	if (raw_spin_trylock_irq(&d->lock)) {
+		d->counter++;
+		raw_spin_unlock_irq(&d->lock);
+	}
+	if (raw_spin_trylock_irqsave(&d->lock, flags)) {
+		d->counter++;
+		raw_spin_unlock_irqrestore(&d->lock, flags);
+	}
+	scoped_cond_guard(raw_spinlock_try, return, &d->lock) {
+		d->counter++;
+	}
+}
+
+TEST_SPINLOCK_COMMON(spinlock,
+		     spinlock_t,
+		     spin_lock_init,
+		     spin_lock,
+		     spin_unlock,
+		     spin_trylock,
+		     TEST_OP_RW);
+static void __used test_spinlock_trylock_extra(struct test_spinlock_data *d)
+{
+	unsigned long flags;
+
+	if (spin_trylock_irq(&d->lock)) {
+		d->counter++;
+		spin_unlock_irq(&d->lock);
+	}
+	if (spin_trylock_irqsave(&d->lock, flags)) {
+		d->counter++;
+		spin_unlock_irqrestore(&d->lock, flags);
+	}
+	scoped_cond_guard(spinlock_try, return, &d->lock) {
+		d->counter++;
+	}
+}
+
+TEST_SPINLOCK_COMMON(write_lock,
+		     rwlock_t,
+		     rwlock_init,
+		     write_lock,
+		     write_unlock,
+		     write_trylock,
+		     TEST_OP_RW);
+static void __used test_write_trylock_extra(struct test_write_lock_data *d)
+{
+	unsigned long flags;
+
+	if (write_trylock_irqsave(&d->lock, flags)) {
+		d->counter++;
+		write_unlock_irqrestore(&d->lock, flags);
+	}
+}
+
+TEST_SPINLOCK_COMMON(read_lock,
+		     rwlock_t,
+		     rwlock_init,
+		     read_lock,
+		     read_unlock,
+		     read_trylock,
+		     TEST_OP_RO);
-- 
2.48.1.711.g2feabab25a-goog


