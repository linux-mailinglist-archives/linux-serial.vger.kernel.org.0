Return-Path: <linux-serial+bounces-8209-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23595A4D836
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 10:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED7F18891B2
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4DE1FF7BF;
	Tue,  4 Mar 2025 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Thrf+cOt"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46A1FCFD2
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080331; cv=none; b=BYTQ+zDhdHvKHXCuQR/YmNpdjC50ooN3OuuqMGo6qxQ0hZzjxOm4Ta/2bfQ/w22ThkQ+4k1EWFfNqZbYkGzQ0O7+0LUIPGJuAeQgpYKssIHTYXXMr3n8wpZ8mfkbt4LBOr/GbI/hxQyXzPCIltV3IQ5FWyK79LNCJzXdwQNvjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080331; c=relaxed/simple;
	bh=JTYS1SwFh7lVbtLZ9XjE7s+Wpaj5PCO/80LIOe8cNq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n1BGikpSJXJ+MJRreQkgNZmC0C3zR31T3KbiTaSqkE9ZTBPo00QcS4QcBLzRnDKLZmJxwW1GENUjsHgsEnvw4CNvgLftgNyurLvtQuVL4KIKbpDjGMQU0MEp7ke/UH2c2rcG6FvBWY8uuDfB2yNmejQ2AszY/vY7e+br9wiykK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Thrf+cOt; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-abf5bf52939so28449666b.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080328; x=1741685128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvm+2kORFqwesy5wYS8KGKPET1JeCxDND2kfg3G9ty8=;
        b=Thrf+cOt4yD3t7IuGDdnAoKCfa+jTwi7ZNa+b1ouWFnpMd1DiiIQKtxNikQ7MCbXdN
         XyuQOgoH/ubYonca3m4hfniY1E5bvcjjcqGhtzc0o7kA4l3DZaEgV7RjI96IKCmZX0RC
         OTQGTdH3b28Wc04rKYA752c/jlWNQ4I58oVg5V5YTHDzCRtKX8NOLtsjpvVYWkz+KscK
         mdF8TdUlC5uMCRfb9dS/EoDi/l131zhonJREOhzxIhatXNvBUj44AQjcN9QO1e266qsi
         hwaYfoweXVunVGWmX11YL10wusS13jk8rc4Pi/UIAb/LBX4hVb5gikePwgQg1z9uXP/v
         WRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080328; x=1741685128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvm+2kORFqwesy5wYS8KGKPET1JeCxDND2kfg3G9ty8=;
        b=Dt4oBiPvs4Z0GCbfMhNS9TACMzBPJ96BMENcOuPa+oj2+y7QH4kc+1JvIEgIhhAGRd
         01weSVUCopZCslCcjdtNwjxkxw2Pd7qtmyUoxlH8U/mF4V1APckZmCRvG2WmGFmlJaDC
         YR/BxNBt+6k1Jp25lOqBU7Ogh49dibBMGN7AUgy4tM5jFWpzy9e8jhKlgOVvxe205fZz
         w1opbHwdZjuHJ4rxK4eZDuFt1QkC8MgiAUFAV6RNC/2Lrb/xYUb+ClDMD5sv7c996xeO
         EHDfV7KNQp+/RtBcmmCpMKTsIzpQhQIQhKGCbNSyNc/ihDRH+rtoSMFf/VeoHeveH7PK
         fGXg==
X-Forwarded-Encrypted: i=1; AJvYcCX38Nl8m0mJuvKbEzGJDUwWWZ/Uu9IxKYnVJ9XENEM2/kQNMt1p+aaEHYyQXx1ItmzirpfMUZxfx9v2Ss4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrROzyjGI42SGYcze0Jq4CntCpsUN653P7ZQHwuvXtb81ugabd
	isiuisvUWi8rfBuNAGidpIIrSdHJboZ7oOGaAfqRvEW37e2Nblg3LFUKZNVLjr0ripfnkcuYmA=
	=
X-Google-Smtp-Source: AGHT+IFvA+/G/Do4B2YEZ6UDOEYzOzvbOome5BWE9wuc2tz5n6hXXyO5SQ6HDKTmum5Vyn1BFOAEC7kT8w==
X-Received: from ejctn9.prod.google.com ([2002:a17:907:c409:b0:abf:6374:f45c])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:72c2:b0:ab7:cf4d:9b2d
 with SMTP id a640c23a62f3a-abf261f9df4mr2143998366b.30.1741080327941; Tue, 04
 Mar 2025 01:25:27 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:06 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-8-elver@google.com>
Subject: [PATCH v2 07/34] lockdep: Annotate lockdep assertions for capability analysis
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

Clang's capability analysis can be made aware of functions that assert
that capabilities/locks are held.

Presence of these annotations causes the analysis to assume the
capability is held after calls to the annotated function, and avoid
false positives with complex control-flow; for example, where not all
control-flow paths in a function require a held lock, and therefore
marking the function with __must_hold(..) is inappropriate.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/lockdep.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 67964dc4db95..5cea929b2219 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -282,16 +282,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 	do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
 
 #define lockdep_assert_held(l)		\
-	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
+	do { lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD); __assert_cap(l); } while (0)
 
 #define lockdep_assert_not_held(l)	\
 	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_HELD)
 
 #define lockdep_assert_held_write(l)	\
-	lockdep_assert(lockdep_is_held_type(l, 0))
+	do { lockdep_assert(lockdep_is_held_type(l, 0)); __assert_cap(l); } while (0)
 
 #define lockdep_assert_held_read(l)	\
-	lockdep_assert(lockdep_is_held_type(l, 1))
+	do { lockdep_assert(lockdep_is_held_type(l, 1)); __assert_shared_cap(l); } while (0)
 
 #define lockdep_assert_held_once(l)		\
 	lockdep_assert_once(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
@@ -389,10 +389,10 @@ extern int lockdep_is_held(const void *);
 #define lockdep_assert(c)			do { } while (0)
 #define lockdep_assert_once(c)			do { } while (0)
 
-#define lockdep_assert_held(l)			do { (void)(l); } while (0)
+#define lockdep_assert_held(l)			__assert_cap(l)
 #define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
-#define lockdep_assert_held_write(l)		do { (void)(l); } while (0)
-#define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
+#define lockdep_assert_held_write(l)		__assert_cap(l)
+#define lockdep_assert_held_read(l)		__assert_shared_cap(l)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
 #define lockdep_assert_none_held_once()	do { } while (0)
 
-- 
2.48.1.711.g2feabab25a-goog


