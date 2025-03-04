Return-Path: <linux-serial+bounces-8206-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D03A4D829
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 10:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D111889AED
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68301FECD3;
	Tue,  4 Mar 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3u9RpHWN"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E481FE463
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080323; cv=none; b=qc9ENf4xSzIOmGhwLBVNBLO18cQYxqX70Trs8VFzKMzuLPDAfsp9pzi6i+rLdRiILfbbQh0TOvGa9sgCNljF861goti4ues7yO2ebStdcaPruOsqvPpDAmJb4IMdR/8aQvhRYXCXPaim9DK/6k1jQciYQyAk4ybMuZ/Hv0vnM10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080323; c=relaxed/simple;
	bh=L0OuX4zhmaM9o60FzP1sUh13J+x81eZXc+z1+4sEu8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tKVQOkJWc1ReTlPeY0D6rOGDt3OGIMs+bj/xrx9oF1as+iU1BSUn732YBuPDYi69GOecQNm6dHG2fVG1WrEHUOaapNPnX2BUxV5YKqfvYHlKomqbobEzkasaWWrrUo/g5FuH7VuR/EO9sC/2JuawJdp6F6eZ8cvYcW9EO/nHzjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3u9RpHWN; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ac1e109f006so182936066b.2
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 01:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080320; x=1741685120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dE96AlLyXfE4zcTJ3mSZ7GpwRWlrYm2AzYTGYdTipys=;
        b=3u9RpHWNJVC4bujyG0x5symrpir4WGvkxxJFEURU98IJwPWUCEL4tCt3vMWwRHO9nR
         +T9joHTUNAoTaJpA7RfMqvMRjsED63vyY/49glLKweDl6ig85bzn28wrMQHRfYfu5lY5
         CkW7CXe2cxIXEjO8JDij2VWMBZkaymaOUAJ0JfxTZiRShFzAgZfag+ZbZdfJyYF2ZGjU
         YkbjRy0RexytNYf2ZMMjQBxXP7RAx2L3p93P9VdLedYCgHamg4HOb99L/Mx/IQdQ9Chy
         5yuF20tQpLYM/uzjeT8Q4E5SLro6XBT4JWI9uvnfFRkii88YC5ElwATpMHs2j8q2qUxN
         q3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080320; x=1741685120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dE96AlLyXfE4zcTJ3mSZ7GpwRWlrYm2AzYTGYdTipys=;
        b=xJNidvADyaibyUK6tnl+XWGIFoP8GJiSRnIQZENPkpu2tNKJm6YN3xuES/rzFGNUk2
         yWEipMf46npK9DiFMCblKPgddlq/JcfKtI51EoJtUnWxbL/662rQDKTCPf1jCRuewIHF
         +MOvOqVP7LV2eXWdG3WYghBSsp87zpi5Oe/laYVaSUEi4h/cWn2diooKc0EAd/OK1Uyh
         zmP/wnTCdOo2wO0o11u8CyTuK0Qdm02fDntoyn8JrY+c2fmVHmNTcJTPxD2cTlESIScP
         zVgQHBo63y2iqUbmPUUZXVrlW1vzCczuN9I1Tgmbu7BGkqa3wKy0ZaV+fFMqstJ/YyJT
         X0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2tEySPvrQcnLJUA5NGebsXyBJRTkgCcgSwh8ppMuvtWDpzaDDxqXwNeL0SDkkMTBaZZDgD0g3RgiXeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThmQz7Pui2i16dT1INMJAI0DRC+0x+aarJol0E6+yXfUZ1qqY
	y/LE90SXImph7pTBkgr3kGVL5onlqlK0KdqIvNMflfAWvDXECucHZMacPB+AOSucSO7i4Tl9IA=
	=
X-Google-Smtp-Source: AGHT+IFuP8M1dqAoGU6qLKH3+wWDWdvdL8t6wTEGZDy32MKEUcqZYenf1bVQSLxNtJzzOQKE63o3FVdKMg==
X-Received: from ejcti14.prod.google.com ([2002:a17:907:c20e:b0:abf:6ebf:550f])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:6d0f:b0:abf:7a26:c47c
 with SMTP id a640c23a62f3a-abf7a26c669mr613682066b.47.1741080319651; Tue, 04
 Mar 2025 01:25:19 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:03 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-5-elver@google.com>
Subject: [PATCH v2 04/34] Documentation: Add documentation for Compiler-Based
 Capability Analysis
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

Adds documentation in Documentation/dev-tools/capability-analysis.rst,
and adds it to the index and cross-references from Sparse's document.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Remove cross-reference to Sparse, since we plan to remove Sparse
  support anyway.
* Mention __no_capability_analysis should be avoided.
---
 .../dev-tools/capability-analysis.rst         | 145 ++++++++++++++++++
 Documentation/dev-tools/index.rst             |   1 +
 2 files changed, 146 insertions(+)
 create mode 100644 Documentation/dev-tools/capability-analysis.rst

diff --git a/Documentation/dev-tools/capability-analysis.rst b/Documentation/dev-tools/capability-analysis.rst
new file mode 100644
index 000000000000..4b9c93cc8fcd
--- /dev/null
+++ b/Documentation/dev-tools/capability-analysis.rst
@@ -0,0 +1,145 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright (C) 2025, Google LLC.
+
+.. _capability-analysis:
+
+Compiler-Based Capability Analysis
+==================================
+
+Capability analysis is a C language extension, which enables statically
+checking that user-definable "capabilities" are acquired and released where
+required. An obvious application is lock-safety checking for the kernel's
+various synchronization primitives (each of which represents a "capability"),
+and checking that locking rules are not violated.
+
+The Clang compiler currently supports the full set of capability analysis
+features. To enable for Clang, configure the kernel with::
+
+    CONFIG_WARN_CAPABILITY_ANALYSIS=y
+
+The analysis is *opt-in by default*, and requires declaring which modules and
+subsystems should be analyzed in the respective `Makefile`::
+
+    CAPABILITY_ANALYSIS_mymodule.o := y
+
+Or for all translation units in the directory::
+
+    CAPABILITY_ANALYSIS := y
+
+It is possible to enable the analysis tree-wide, however, which will result in
+numerous false positive warnings currently and is *not* generally recommended::
+
+    CONFIG_WARN_CAPABILITY_ANALYSIS_ALL=y
+
+Programming Model
+-----------------
+
+The below describes the programming model around using capability-enabled
+types.
+
+.. note::
+   Enabling capability analysis can be seen as enabling a dialect of Linux C with
+   a Capability System. Some valid patterns involving complex control-flow are
+   constrained (such as conditional acquisition and later conditional release
+   in the same function, or returning pointers to capabilities from functions.
+
+Capability analysis is a way to specify permissibility of operations to depend
+on capabilities being held (or not held). Typically we are interested in
+protecting data and code by requiring some capability to be held, for example a
+specific lock. The analysis ensures that the caller cannot perform the
+operation without holding the appropriate capability.
+
+Capabilities are associated with named structs, along with functions that
+operate on capability-enabled struct instances to acquire and release the
+associated capability.
+
+Capabilities can be held either exclusively or shared. This mechanism allows
+assign more precise privileges when holding a capability, typically to
+distinguish where a thread may only read (shared) or also write (exclusive) to
+guarded data.
+
+The set of capabilities that are actually held by a given thread at a given
+point in program execution is a run-time concept. The static analysis works by
+calculating an approximation of that set, called the capability environment.
+The capability environment is calculated for every program point, and describes
+the set of capabilities that are statically known to be held, or not held, at
+that particular point. This environment is a conservative approximation of the
+full set of capabilities that will actually held by a thread at run-time.
+
+More details are also documented `here
+<https://clang.llvm.org/docs/ThreadSafetyAnalysis.html>`_.
+
+.. note::
+   Clang's analysis explicitly does not infer capabilities acquired or released
+   by inline functions. It requires explicit annotations to (a) assert that
+   it's not a bug if a capability is released or acquired, and (b) to retain
+   consistency between inline and non-inline function declarations.
+
+Supported Kernel Primitives
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. Currently the following synchronization primitives are supported:
+
+For capabilities with an initialization function (e.g., `spin_lock_init()`),
+calling this function on the capability instance before initializing any
+guarded members or globals prevents the compiler from issuing warnings about
+unguarded initialization.
+
+Lockdep assertions, such as `lockdep_assert_held()`, inform the compiler's
+capability analysis that the associated synchronization primitive is held after
+the assertion. This avoids false positives in complex control-flow scenarios
+and encourages the use of Lockdep where static analysis is limited. For
+example, this is useful when a function doesn't *always* require a lock, making
+`__must_hold()` inappropriate.
+
+Keywords
+~~~~~~~~
+
+.. kernel-doc:: include/linux/compiler-capability-analysis.h
+   :identifiers: struct_with_capability
+                 token_capability token_capability_instance
+                 __guarded_by __pt_guarded_by
+                 __must_hold
+                 __must_not_hold
+                 __acquires
+                 __cond_acquires
+                 __releases
+                 __must_hold_shared
+                 __acquires_shared
+                 __cond_acquires_shared
+                 __releases_shared
+                 __acquire
+                 __release
+                 __cond_lock
+                 __acquire_shared
+                 __release_shared
+                 __cond_lock_shared
+                 capability_unsafe
+                 __capability_unsafe
+                 disable_capability_analysis enable_capability_analysis
+
+.. note::
+   The function attribute `__no_capability_analysis` is reserved for internal
+   implementation of capability-enabled primitives, and should be avoided in
+   normal code.
+
+Background
+----------
+
+Clang originally called the feature `Thread Safety Analysis
+<https://clang.llvm.org/docs/ThreadSafetyAnalysis.html>`_, with some
+terminology still using the thread-safety-analysis-only names. This was later
+changed and the feature became more flexible, gaining the ability to define
+custom "capabilities".
+
+Indeed, its foundations can be found in `capability systems
+<https://www.cs.cornell.edu/talc/papers/capabilities.pdf>`_, used to specify
+the permissibility of operations to depend on some capability being held (or
+not held).
+
+Because the feature is not just able to express capabilities related to
+synchronization primitives, the naming chosen for the kernel departs from
+Clang's initial "Thread Safety" nomenclature and refers to the feature as
+"Capability Analysis" to avoid confusion. The implementation still makes
+references to the older terminology in some places, such as `-Wthread-safety`
+being the warning option that also still appears in diagnostic messages.
diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 65c54b27a60b..62ac23f797cd 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -18,6 +18,7 @@ Documentation/process/debugging/index.rst
    :maxdepth: 2
 
    testing-overview
+   capability-analysis
    checkpatch
    clang-format
    coccinelle
-- 
2.48.1.711.g2feabab25a-goog


