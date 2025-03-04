Return-Path: <linux-serial+bounces-8235-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC5AA4D8A2
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 10:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70C73A5858
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062612063E7;
	Tue,  4 Mar 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dn3EzAlo"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C091FC7F2
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080401; cv=none; b=ObVQrUoWFgBnzErFbtY/jLHdZG31SKVDxQ5Jhbsk1Ju/XIME2XCa+KwaCOBIv9gGlyWefFbu1JieGM5VNf4d39FPm91bDJzFot7q+/YF5sfgi5x0DMDG64+IaA9+2Lj0Te02YO+HdbdgS0gdKkdGIDmZkKRfalNE5sa+2Xm99gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080401; c=relaxed/simple;
	bh=Mh+9JdRk90KetkZXttq6SxfLAoOSSno0nfwH9pudmzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eUPPatJYT4z/7SsCAgNVq+SPZfmBAZcZZvaFu0lm/h666WFUiimC2H2EHRSp04974UPrKHlkhmQ1hKKZ7jNQaJpUCOGIEavvv1innadRkwzUnlQAyENIBUgXFHxjYmZc6/cNDjWhevs6hxfwUFd+XXZ+E96NRtNu9DHlGFe45z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dn3EzAlo; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-abb9b2831b7so708209966b.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 01:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080398; x=1741685198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N6cosU/aHEF331Tgbf58Vi03lqVulZKFB2l/GT8tm7Y=;
        b=dn3EzAlosTzHbBvhgMn3ZvES4EtnSHEKhfOwLRu5lIbUArNhBz7KIywGzdE3pv0s4u
         ShNskvRe5wx7fVAhiutKXrQUIhgxqumCsHibrqodQuNH0OHx2DeswLUfg8i+dSSqZtrP
         lYGf3qVd3KGIYBQx/gyRcQT0049KKpUEMdBwGhiPrFerPbUEVBqiszqqf1yMdEXZc5tu
         tf3vBDcxTaiMOCKVC+dcks+P+d60cCDfJEqxDK59mQ61pekGsmjmaW2inVuxzVYSpvIy
         tEVJ36XQOonqVLy6Dkd+hKazxt0+LJIOibW/wfBY4gfKqnkZWoO7Uk8XyJMRtG1F5f/a
         GJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080398; x=1741685198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6cosU/aHEF331Tgbf58Vi03lqVulZKFB2l/GT8tm7Y=;
        b=IqjXy2boBhDI7kAjQHEU4iBbXriWpUXbnVrL5TFGbskOXxz98MSZe85onjxqePrrBd
         D1J7rZt/FVwyquck1EL9QV5ktUqRljiOvRzII3D64L6ZfmfRX7DgYlfGWp/qgix8TQHR
         YSu2EpELrfWPuoratfhGEy3NBHjcIIEg2KsFgC06880r1L8JB38Zn46SkuRGpRxp6kOG
         5gqrl1tDKx8wPmGRFFUnLLprLD7+JF73wsRQXcyEPLGB7CAVChLT6fzpe9fYiZgu4AsK
         76GKTOHirCoP5p+2M5bBHbmaJYh4VCxJPUr3KsL5m3ALaagBUenujI3wVCL7PfHhcajw
         o1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOs6bzy52KlYD0+gAYjYLwnuDzUKAuanxMGbu3eBR+wvHEwyzy6+HhAoaS/Xxp7lLYjT+UN2n8rt1KHxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwknjpIcUbYtR23zRTYhBMc8Syk95yIXRv3bKcNRJj1kNnzfwHl
	I2YA5PLjneLWUbN3ub6pkI5c+icLwioALrEWdSUv8tJLEXKTiXffZ/N8VHFpyOX2Pqw7U0SKKg=
	=
X-Google-Smtp-Source: AGHT+IFpyuhMExDXeCwmdXSX22gTbHPs/JgCeV/PZoB6R3/aCXNcolqtoeQq/ql3Ce1MbHxHrlos3aOHkA==
X-Received: from ejcvx9.prod.google.com ([2002:a17:907:a789:b0:ac1:fb2a:4a70])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3da3:b0:ac1:edc5:d73b
 with SMTP id a640c23a62f3a-ac1f0edc8c7mr225816966b.8.1741080398288; Tue, 04
 Mar 2025 01:26:38 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:32 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-34-elver@google.com>
Subject: [PATCH v2 33/34] crypto: Enable capability analysis
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

Enable capability analysis for crypto subsystem.

This demonstrates a larger conversion to use Clang's capability
analysis. The benefit is additional static checking of locking rules,
along with better documentation.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
v2:
* New patch.
---
 crypto/Makefile                  | 2 ++
 crypto/algapi.c                  | 2 ++
 crypto/api.c                     | 1 +
 crypto/crypto_engine.c           | 2 +-
 crypto/drbg.c                    | 5 +++++
 crypto/internal.h                | 2 +-
 crypto/proc.c                    | 3 +++
 crypto/scompress.c               | 8 +++++---
 include/crypto/internal/engine.h | 2 +-
 9 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/crypto/Makefile b/crypto/Makefile
index f67e853c4690..b7fa58ab8783 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -3,6 +3,8 @@
 # Cryptographic API
 #
 
+CAPABILITY_ANALYSIS := y
+
 obj-$(CONFIG_CRYPTO) += crypto.o
 crypto-y := api.o cipher.o compress.o
 
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 5318c214debb..c2bafcde6f64 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -230,6 +230,7 @@ EXPORT_SYMBOL_GPL(crypto_remove_spawns);
 
 static void crypto_alg_finish_registration(struct crypto_alg *alg,
 					   struct list_head *algs_to_put)
+	__must_hold(&crypto_alg_sem)
 {
 	struct crypto_alg *q;
 
@@ -286,6 +287,7 @@ static struct crypto_larval *crypto_alloc_test_larval(struct crypto_alg *alg)
 
 static struct crypto_larval *
 __crypto_register_alg(struct crypto_alg *alg, struct list_head *algs_to_put)
+	__must_hold(&crypto_alg_sem)
 {
 	struct crypto_alg *q;
 	struct crypto_larval *larval;
diff --git a/crypto/api.c b/crypto/api.c
index bfd177a4313a..def3430ab332 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -57,6 +57,7 @@ EXPORT_SYMBOL_GPL(crypto_mod_put);
 
 static struct crypto_alg *__crypto_alg_lookup(const char *name, u32 type,
 					      u32 mask)
+	__must_hold_shared(&crypto_alg_sem)
 {
 	struct crypto_alg *q, *alg = NULL;
 	int best = -2;
diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index c7c16da5e649..4ab0bbc4c7ce 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -514,8 +514,8 @@ struct crypto_engine *crypto_engine_alloc_init_and_set(struct device *dev,
 	snprintf(engine->name, sizeof(engine->name),
 		 "%s-engine", dev_name(dev));
 
-	crypto_init_queue(&engine->queue, qlen);
 	spin_lock_init(&engine->queue_lock);
+	crypto_init_queue(&engine->queue, qlen);
 
 	engine->kworker = kthread_run_worker(0, "%s", engine->name);
 	if (IS_ERR(engine->kworker)) {
diff --git a/crypto/drbg.c b/crypto/drbg.c
index f28dfc2511a2..881579afa160 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -231,6 +231,7 @@ static inline unsigned short drbg_sec_strength(drbg_flag_t flags)
  */
 static int drbg_fips_continuous_test(struct drbg_state *drbg,
 				     const unsigned char *entropy)
+	__must_hold(&drbg->drbg_mutex)
 {
 	unsigned short entropylen = drbg_sec_strength(drbg->core->flags);
 	int ret = 0;
@@ -1061,6 +1062,7 @@ static inline int __drbg_seed(struct drbg_state *drbg, struct list_head *seed,
 static inline int drbg_get_random_bytes(struct drbg_state *drbg,
 					unsigned char *entropy,
 					unsigned int entropylen)
+	__must_hold(&drbg->drbg_mutex)
 {
 	int ret;
 
@@ -1075,6 +1077,7 @@ static inline int drbg_get_random_bytes(struct drbg_state *drbg,
 }
 
 static int drbg_seed_from_random(struct drbg_state *drbg)
+	__must_hold(&drbg->drbg_mutex)
 {
 	struct drbg_string data;
 	LIST_HEAD(seedlist);
@@ -1132,6 +1135,7 @@ static bool drbg_nopr_reseed_interval_elapsed(struct drbg_state *drbg)
  */
 static int drbg_seed(struct drbg_state *drbg, struct drbg_string *pers,
 		     bool reseed)
+	__must_hold(&drbg->drbg_mutex)
 {
 	int ret;
 	unsigned char entropy[((32 + 16) * 2)];
@@ -1368,6 +1372,7 @@ static inline int drbg_alloc_state(struct drbg_state *drbg)
 static int drbg_generate(struct drbg_state *drbg,
 			 unsigned char *buf, unsigned int buflen,
 			 struct drbg_string *addtl)
+	__must_hold(&drbg->drbg_mutex)
 {
 	int len = 0;
 	LIST_HEAD(addtllist);
diff --git a/crypto/internal.h b/crypto/internal.h
index 46b661be0f90..3ac76faf228b 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -45,8 +45,8 @@ enum {
 /* Maximum number of (rtattr) parameters for each template. */
 #define CRYPTO_MAX_ATTRS 32
 
-extern struct list_head crypto_alg_list;
 extern struct rw_semaphore crypto_alg_sem;
+extern struct list_head crypto_alg_list __guarded_by(&crypto_alg_sem);
 extern struct blocking_notifier_head crypto_chain;
 
 int alg_test(const char *driver, const char *alg, u32 type, u32 mask);
diff --git a/crypto/proc.c b/crypto/proc.c
index 522b27d90d29..4679eb6b81c9 100644
--- a/crypto/proc.c
+++ b/crypto/proc.c
@@ -19,17 +19,20 @@
 #include "internal.h"
 
 static void *c_start(struct seq_file *m, loff_t *pos)
+	__acquires_shared(&crypto_alg_sem)
 {
 	down_read(&crypto_alg_sem);
 	return seq_list_start(&crypto_alg_list, *pos);
 }
 
 static void *c_next(struct seq_file *m, void *p, loff_t *pos)
+	__must_hold_shared(&crypto_alg_sem)
 {
 	return seq_list_next(p, &crypto_alg_list, pos);
 }
 
 static void c_stop(struct seq_file *m, void *p)
+	__releases_shared(&crypto_alg_sem)
 {
 	up_read(&crypto_alg_sem);
 }
diff --git a/crypto/scompress.c b/crypto/scompress.c
index 1cef6bb06a81..0f24c84cc550 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -25,8 +25,8 @@
 
 struct scomp_scratch {
 	spinlock_t	lock;
-	void		*src;
-	void		*dst;
+	void		*src __guarded_by(&lock);
+	void		*dst __guarded_by(&lock);
 };
 
 static DEFINE_PER_CPU(struct scomp_scratch, scomp_scratch) = {
@@ -34,8 +34,8 @@ static DEFINE_PER_CPU(struct scomp_scratch, scomp_scratch) = {
 };
 
 static const struct crypto_type crypto_scomp_type;
-static int scomp_scratch_users;
 static DEFINE_MUTEX(scomp_lock);
+static int scomp_scratch_users __guarded_by(&scomp_lock);
 
 static int __maybe_unused crypto_scomp_report(
 	struct sk_buff *skb, struct crypto_alg *alg)
@@ -59,6 +59,7 @@ static void crypto_scomp_show(struct seq_file *m, struct crypto_alg *alg)
 }
 
 static void crypto_scomp_free_scratches(void)
+	__capability_unsafe(/* frees @scratch */)
 {
 	struct scomp_scratch *scratch;
 	int i;
@@ -74,6 +75,7 @@ static void crypto_scomp_free_scratches(void)
 }
 
 static int crypto_scomp_alloc_scratches(void)
+	__capability_unsafe(/* allocates @scratch */)
 {
 	struct scomp_scratch *scratch;
 	int i;
diff --git a/include/crypto/internal/engine.h b/include/crypto/internal/engine.h
index fbf4be56cf12..10edbb451f1c 100644
--- a/include/crypto/internal/engine.h
+++ b/include/crypto/internal/engine.h
@@ -54,7 +54,7 @@ struct crypto_engine {
 
 	struct list_head	list;
 	spinlock_t		queue_lock;
-	struct crypto_queue	queue;
+	struct crypto_queue	queue __guarded_by(&queue_lock);
 	struct device		*dev;
 
 	bool			rt;
-- 
2.48.1.711.g2feabab25a-goog


