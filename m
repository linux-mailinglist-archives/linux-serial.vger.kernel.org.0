Return-Path: <linux-serial+bounces-8218-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FB1A4D853
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 10:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BB816F3BA
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D3202C50;
	Tue,  4 Mar 2025 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xseS9zns"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613E20298B
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080355; cv=none; b=p81ewU7GD7yRfEYIw6yfWs8HmgYP2NYya87ERgbzyxF295nXuUk7gQTGCKxQ80pQ6WBAjQQD+mu3rkOb2Xz/0ROaMQ5V3rhi6NUfHvVwwcmXrjVJBa/mNEudK7zd8/p1Z0u4PMjfn12t+zgtCtZOelDPWYIVV6S69KIiXUm9LTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080355; c=relaxed/simple;
	bh=PiALtBw0DYxsKuBO8J1H1AaY1cU3EmQ3QqFWUaJ2ULI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=frkJgB2+mr6Ox7/K6HAwRquKTbYueI+XjUdUXfy2jexhTzEpIUVjFZfsT3Rf0Hnhgv+q2f5FSd6pSdtOp74HaZOeyyZqRsA6yKQ7Lr8+MJALqPdrhGPQdLqNvAy6r4I4WYDpv3ze6ZnsXtm8OLuQ/SoTmW8YFRBgsKWCLdAgIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xseS9zns; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43947979ce8so21212085e9.0
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 01:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080352; x=1741685152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDlOE/N8Ae1M5H+4yLEwuBDz/LRLExYZEp/cosJZ8Bg=;
        b=xseS9znsQ87t34sYX/gUp0g2hQZ/UNonxdPqn5B7LJMZ2/n7mRqN7ey1N4I8/VvGVt
         wcqf61xpLrOaUgfB5G5XrT8rOSZRNnLb2FSitfzM+H6koewUYHd0S6p6SgDDtZFjjw2v
         ga4SWEVQifSr2qCCjU0KUdxhurb8xDPE+OxbN7/QDf4dVDhNGp6o7JXxe8nDqH0SGobz
         lNlVgFk5sBuAoTqrKl1j8X+4hLptwTCAuGatsEJ28qbXzZ9wbk1D4H56dU0F19rDETHD
         8tyMll8rxrEUkc51aH24J2tE+Ah6qHHSVyCVRdLZXRhZsxTzKw3L2W5RpkrxNf8Tprgs
         WjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080352; x=1741685152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDlOE/N8Ae1M5H+4yLEwuBDz/LRLExYZEp/cosJZ8Bg=;
        b=pmRzVpqOPrLya1m7p6w4fHqonkGKUlUj6W4KW8IJTNfdZtX7M8B0Y9HOO+0Mvlsb1B
         x4sFIcycUneIvZeNOYVlb3lTZ2S0bRe0wdASQvmZZJ1RrG0326R0lhfWWtPStIRiwquV
         u+/Mkw8X++bQ91Sp4+OFZwaucsLdhmT3Xx6WZNWFndGB4nvVasXmAyOc7+V5HGY2EjLg
         UqxqYEH2V6rgVR2JvY/adcJA/MFLWgIH+0rODNuWCvydEq2+dJMKZcBabTOvfQv7bTHv
         +puz+G+YVgw/Sr72bPwje9LJamJstrd9MQK28mOKS1LBWJgl9H+2mXCqaRLhqBYXjVDi
         n4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCV8nHRfebjt4XNy9MFpwuGUXMxhJD/0Yj+9b2qSdEznHcaaWVASwUpsGnaU3fa0eGt1F88r0qoy5UYylCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwToFpm4N0UJ17zc/yQ9dOGI/LjTA8r+ga3tCa6xTOwql41u5sk
	M2XG75R2ZynXXpyiyAjwN0LoWDP5TwF8/hTL0LdKhKm8a+CCysKwU3B+yLjUMGFZil1gPYtzog=
	=
X-Google-Smtp-Source: AGHT+IHedqiVSmrcvr28lGY8V3DB1o4f03/YwjOgy/3VYsVwJNq1WARMZql7ViymW31VHT1lz95raXYaUw==
X-Received: from wmqa13.prod.google.com ([2002:a05:600c:348d:b0:439:64f9:d801])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:190a:b0:434:a4b3:5ebe
 with SMTP id 5b1f17b1804b1-43ba675830emr110121215e9.24.1741080352374; Tue, 04
 Mar 2025 01:25:52 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:15 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-17-elver@google.com>
Subject: [PATCH v2 16/34] kref: Add capability-analysis annotations
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

Mark functions that conditionally acquire the passed lock.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kref.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kref.h b/include/linux/kref.h
index 88e82ab1367c..9bc6abe57572 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -81,6 +81,7 @@ static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref)
 static inline int kref_put_mutex(struct kref *kref,
 				 void (*release)(struct kref *kref),
 				 struct mutex *mutex)
+	__cond_acquires(true, mutex)
 {
 	if (refcount_dec_and_mutex_lock(&kref->refcount, mutex)) {
 		release(kref);
@@ -102,6 +103,7 @@ static inline int kref_put_mutex(struct kref *kref,
 static inline int kref_put_lock(struct kref *kref,
 				void (*release)(struct kref *kref),
 				spinlock_t *lock)
+	__cond_acquires(true, lock)
 {
 	if (refcount_dec_and_lock(&kref->refcount, lock)) {
 		release(kref);
-- 
2.48.1.711.g2feabab25a-goog


