Return-Path: <linux-serial+bounces-8208-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2B5A4D832
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 10:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9D516E404
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 09:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069AB1FF610;
	Tue,  4 Mar 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wwmCoPb3"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFC31FF1D6
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080328; cv=none; b=a1nr6JT6yxwb5VX9Y7IX9TQVdMOqhVT2X9QZi0kuo3oaWLezzC8a8Z/MoKdK/qnv1qQwk9XJS6Q8avxQyRTmoUKv/u3iGrM9IDeTbV6mo9ZNZtpOA/jMLnzoNNCyKrZRxmP573PIyZXZGHu22UkoNLYst6x0WjxcqRq7iCILiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080328; c=relaxed/simple;
	bh=c8IW28x9pVJ3uD+41rCTL2BIJUzCYO63UJBK2wSfgWE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k77hb8Zwkqo3OsDu7mJCgmd1kCo9oOaSRG5JbSP2Z9+3ENvrp+9I1Cnkf6EqvZYlMoZZn8HKBZHaoXJsugEv7z4+7EUV51j+05u8GKayABoyAGEZqeQX0vZpIawZX3M9gQvZ/zcbsR/Uhoo/Rwju/yoV6CsZ4MdBUZfeo2+9GmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wwmCoPb3; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e4b6eba254so6168812a12.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 01:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080325; x=1741685125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=07Wov0mqGRdlTFI57GwZAG7K2eg+AiDKRE973TUpU6Y=;
        b=wwmCoPb3qLLTEYW/WcADCR3xvRECMJ9cOezsDVAeenYh9GN/cSmysNRy53gcYBJWC2
         DU9pRWn2oETv/8OMUw9Ik7kPCkZjLSmmbEYbWB9RddeXh+b6GctlXzW+/oxzJTMxRF3W
         LU6wS25irtT2044gfoAJoHLKBQcbAdfXjVL0RE/kgIWx5EZTFkDokfZDjGEhY6BBzU43
         Gn8DiRFoiuX003/Hnsuuu9ELZQQmNN9Nm5xnbhheXEbWOPeHbrGlDGWW9xyghJJTrOZl
         c1l1cU+njNMlUPVLZieIBIQVylT0VsMc+hINqS1TKw12NRDtdmtg3UJ11ESJ7NZtgOK5
         bAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080325; x=1741685125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07Wov0mqGRdlTFI57GwZAG7K2eg+AiDKRE973TUpU6Y=;
        b=imY/u4bExXeNA7Rn49gng1HLQQSrrUnJpK4vsuXxkIYQtSpC4107GEllzGSG5Bq7Lm
         Of+F0uk1JolzPapE10IJ49DL2s4mrNLaKcpaIXzR+FzcARJYTl00FTCVTJK9gRGC7riJ
         mHpfZuoZZvI12+ZsBFuxn28D0MCSr3NbIGeWYVGILT0wJZu8JXsX7QTGsLyUUkmIhy8r
         9SgBQcQ213QA4ISzflr6GabhvqcxzE8tRwutmr5kqWosImdUKSb4E5a455ruSTpUN4KE
         CNwP+++2a2uGYcGW6GRlo3rtYTZtTEWWUBN5RkxWE9xtMFc3GEXwJ1U9qayUw+6Wv0Uj
         mUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPrusg8wYKRWUD4m4IYjTkruMcLLFJCOc9GqUYgzEZQbGf0dVhTL/FTtEwkSBP6CLV9Wd7OFmcpl71txA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Paplj3XJleAzZNp6EGMDy7CwZs37cUY9Uou08l43quwZJJiG
	cCOih4uaYke0Ya7hFqMzrlddmePXPeH4lLN/EJc00zlJa1IRoUPsh7PzMG5/9EnEUADiEczMBg=
	=
X-Google-Smtp-Source: AGHT+IEBgXpXhg9C+r+XZJg0OX31obTvbu83kkqSV+WpLbyK2OQUzgWPpBMR/CJkehpBgNUdfJdDgye1dw==
X-Received: from ejcvg16.prod.google.com ([2002:a17:907:d310:b0:abf:62a3:633f])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:2801:b0:abf:4647:a8cb
 with SMTP id a640c23a62f3a-abf4647a9d8mr1347716166b.44.1741080325134; Tue, 04
 Mar 2025 01:25:25 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:05 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-7-elver@google.com>
Subject: [PATCH v2 06/34] cleanup: Basic compatibility with capability analysis
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

Due to the scoped cleanup helpers used for lock guards wrapping
acquire/release around their own constructors/destructors that store
pointers to the passed locks in a separate struct, we currently cannot
accurately annotate *destructors* which lock was released. While it's
possible to annotate the constructor to say which lock was acquired,
that alone would result in false positives claiming the lock was not
released on function return.

Instead, to avoid false positives, we can claim that the constructor
"asserts" that the taken lock is held. This will ensure we can still
benefit from the analysis where scoped guards are used to protect access
to guarded variables, while avoiding false positives. The only downside
are false negatives where we might accidentally lock the same lock
again:

	raw_spin_lock(&my_lock);
	...
	guard(raw_spinlock)(&my_lock);  // no warning

Arguably, lockdep will immediately catch issues like this.

While Clang's analysis supports scoped guards in C++ [1], there's no way
to apply this to C right now. Better support for Linux's scoped guard
design could be added in future if deemed critical.

[1] https://clang.llvm.org/docs/ThreadSafetyAnalysis.html#scoped-capability

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/cleanup.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index ec00e3f7af2b..93a166549add 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -223,7 +223,7 @@ const volatile void * __must_check_fn(const volatile void *val)
  *	@exit is an expression using '_T' -- similar to FREE above.
  *	@init is an expression in @init_args resulting in @type
  *
- * EXTEND_CLASS(name, ext, init, init_args...):
+ * EXTEND_CLASS(name, ext, ctor_attrs, init, init_args...):
  *	extends class @name to @name@ext with the new constructor
  *
  * CLASS(name, var)(args...):
@@ -243,15 +243,18 @@ const volatile void * __must_check_fn(const volatile void *val)
 #define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
 typedef _type class_##_name##_t;					\
 static inline void class_##_name##_destructor(_type *p)			\
+	__no_capability_analysis					\
 { _type _T = *p; _exit; }						\
 static inline _type class_##_name##_constructor(_init_args)		\
+	__no_capability_analysis					\
 { _type t = _init; return t; }
 
-#define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
+#define EXTEND_CLASS(_name, ext, ctor_attrs, _init, _init_args...)		\
 typedef class_##_name##_t class_##_name##ext##_t;			\
 static inline void class_##_name##ext##_destructor(class_##_name##_t *p)\
 { class_##_name##_destructor(p); }					\
 static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
+	__no_capability_analysis ctor_attrs					\
 { class_##_name##_t t = _init; return t; }
 
 #define CLASS(_name, var)						\
@@ -299,7 +302,7 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
-	EXTEND_CLASS(_name, _ext, \
+	EXTEND_CLASS(_name, _ext,, \
 		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
 		     class_##_name##_t _T) \
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
@@ -371,6 +374,7 @@ typedef struct {							\
 } class_##_name##_t;							\
 									\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
+	__no_capability_analysis					\
 {									\
 	if (_T->lock) { _unlock; }					\
 }									\
@@ -383,6 +387,7 @@ static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
 
 #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
 static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
+	__no_capability_analysis __asserts_cap(l)			\
 {									\
 	class_##_name##_t _t = { .lock = l }, *_T = &_t;		\
 	_lock;								\
@@ -391,6 +396,7 @@ static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
 
 #define __DEFINE_LOCK_GUARD_0(_name, _lock)				\
 static inline class_##_name##_t class_##_name##_constructor(void)	\
+	__no_capability_analysis					\
 {									\
 	class_##_name##_t _t = { .lock = (void*)1 },			\
 			 *_T __maybe_unused = &_t;			\
@@ -410,7 +416,7 @@ __DEFINE_LOCK_GUARD_0(_name, _lock)
 
 #define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true);		\
-	EXTEND_CLASS(_name, _ext,					\
+	EXTEND_CLASS(_name, _ext, __asserts_cap(l),			\
 		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
 		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\
 			_t; }),						\
-- 
2.48.1.711.g2feabab25a-goog


