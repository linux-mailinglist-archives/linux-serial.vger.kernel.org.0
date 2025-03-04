Return-Path: <linux-serial+bounces-8227-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7919A4D86F
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 10:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE621772CF
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71BF204F74;
	Tue,  4 Mar 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zv51J4Ls"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78FC2046B5
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080380; cv=none; b=ssh27odkBy8AOAgL4nQdajBmwhcoclf6cx54PKYHs2iKL6OG7/dnQFhS16uSyd2qa6aCsdt1IsgE1F0td4eTqZmmnBulzN2uW2avXDaertAErWF0w4GNzp3cXjh8VRyofPjnrm6VcWl2LfFb/V47oDdjh1JrIjima38n5oQ7B8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080380; c=relaxed/simple;
	bh=CbP/cw7Z2VthdUDfVeh49Wsig/SnKaWHlLpS8bXMfTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UZIIoXrVPGGZr6KDFqiDHVDAW/cAeLEL4QOtbuwxYGXgadEu2ZelrmXsmfoje6R1WWdSUHMingHHOAFeQE+Y+trPXKaTHIeniRWgMmZS3i72v/z67x2Irtbccc3DMgMDCXADC3A4N0ZXmQYJIzgHd7QUAa3O/7BYXQBt12N9/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zv51J4Ls; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e067bbd3baso4673818a12.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 01:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080377; x=1741685177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FyNUfkRqmSD94utdQtDIE/VXIceiBYCUysEEfDdchTw=;
        b=Zv51J4LsdO/UrZRTAqOhUu3Chnv0Xg5cTBfuVhoJ5ndv3cpB9RQE3gUiuOQW42Epb7
         HFE+5Wjl6ByldrP5CZxWHEyBAPAUoXBBtwmXQHBH1c98/r5bR4R3+Ax3ROiHtiKZ+AUO
         Cw5jz7kJfdZxVWHhcprbJg/smUePni1hrp2MU34B/Vb8djrEjhCLu89WFT7IPJt1Ngbh
         BvKpKE/Hc9srnoFt9NHka7ih1Vm0XPUQNA0zA18hNOBvMW2qMlCx1t+PV47SW3AhU1lZ
         IjsBCCbXBFUobDOFk5dL2kpZ6wMpl6kSZBFgfn8peBxTpwZTK7lmuu6UGkC5dWcO2brA
         IOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080377; x=1741685177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyNUfkRqmSD94utdQtDIE/VXIceiBYCUysEEfDdchTw=;
        b=SO9o2dFoUWHxgezYWghTCuEPC5d9NvImIst9xq4pv8D1j+9ETaAf9KCkjcpDYFwLYu
         EMUUvYlsex4R/z+TA8L+0dLjA+x0f+oRU6zNhV9HhJuuhrugCPg0ZClOPHlHlbyYB74R
         3lWjJQXNigqA8VFHWjYAaCHX3sKeuekQn/eEzW9g9qCu9qWEmOWXj2w9jc5UEzyK5lGY
         fK4a4RFZCZ58PcawXYajSgw3SxecSmYlrbKxfHY1j77Tsf45dCoyNX4w+EPKaIHaFRPd
         98v7of2k1niiLFyzMheOXnEZDOdKUIze6BUHVNsOqc6uoewbXTxsyyWs3+uN0vpeoD1M
         wcgg==
X-Forwarded-Encrypted: i=1; AJvYcCW2BhdNIMxRcJWYbXfxkF/TPNk55K6/dv24aFVEYxA68gD1b68Y652MKzowfA3Xfetsu7BG6gj15fqDtLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2GuwiIdt1Rdu7Eg9yno8tVUku/2Hi1CVq9o00wUsrtPjWceG
	3K7wVHXJozVsA3q20X16em1yjqC6vHIAM38g6oBaldd4XkB8UZo5NsnGUhtyRIcbv4b6JhYpGw=
	=
X-Google-Smtp-Source: AGHT+IEAtq0ynXlYVUKm7b+YYT0hATsqTi0dybAMTX9SWVkp0JEzQx1oEJXq2DXO8kDu8FGhuer7181naA==
X-Received: from edb11.prod.google.com ([2002:a05:6402:238b:b0:5e5:339d:60ab])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:274a:b0:5e4:c235:de10
 with SMTP id 4fb4d7f45d1cf-5e4d6b7b21fmr14799795a12.32.1741080377028; Tue, 04
 Mar 2025 01:26:17 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:24 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-26-elver@google.com>
Subject: [PATCH v2 25/34] compiler: Let data_race() imply disabled capability analysis
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

Many patterns that involve data-racy accesses often deliberately ignore
normal synchronization rules to avoid taking a lock.

If we have a lock-guarded variable on which we do a lock-less data-racy
access, rather than having to write capability_unsafe(data_race(..)),
simply make the data_race(..) macro imply capability-unsafety. The
data_race() macro already denotes the intent that something subtly
unsafe is about to happen, so it should be clear enough as-is.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 include/linux/compiler.h       | 2 ++
 lib/test_capability-analysis.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 155385754824..c837464369df 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -186,7 +186,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define data_race(expr)							\
 ({									\
 	__kcsan_disable_current();					\
+	disable_capability_analysis();					\
 	__auto_type __v = (expr);					\
+	enable_capability_analysis();					\
 	__kcsan_enable_current();					\
 	__v;								\
 })
diff --git a/lib/test_capability-analysis.c b/lib/test_capability-analysis.c
index 853fdc53840f..13e7732c38a2 100644
--- a/lib/test_capability-analysis.c
+++ b/lib/test_capability-analysis.c
@@ -92,6 +92,8 @@ static void __used test_raw_spinlock_trylock_extra(struct test_raw_spinlock_data
 {
 	unsigned long flags;
 
+	data_race(d->counter++); /* no warning */
+
 	if (raw_spin_trylock_irq(&d->lock)) {
 		d->counter++;
 		raw_spin_unlock_irq(&d->lock);
-- 
2.48.1.711.g2feabab25a-goog


