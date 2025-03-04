Return-Path: <linux-serial+bounces-8226-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7D7A4D881
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 10:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EE13B2005
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB93204C3F;
	Tue,  4 Mar 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GW7XU3T+"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4361204C18
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080378; cv=none; b=lDMUWq5dr23bnKZlFQIjft+fWz6tv8eEzmojyxqCgnf1kVIAd8g4Wl7+/vtuaoAsTJ4T4Tun2eDtJXdxxSfnAZ6WHLnJMuNnedPEfzvn6mi7Wjab5a22bTfMM3XeWNF2Pn457UIOpa4N6XAU/AB08HUA0OpOdAByz0LtxusRzE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080378; c=relaxed/simple;
	bh=ErRP0TLkHTSoiO9G/KD7SlUWq7CmBmFj0LpWE3kApQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LuBgMrGv7vUEVKiJjMVGxEr3PSWbOT5JsziCOC7CK7vmSLP4j2kqVviP5wC1T2OX/6+HIeFQfWAl/HsVPX1fF2sRrsiPeM03+KhUWOjmZJ0mtLFPToIh61Uxfh3SvsG23TKsoqH+eYSpTGEcqGP5NZiQPqBrI0zI6swb1+vpleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GW7XU3T+; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-abb8f65af3dso528826066b.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 01:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080374; x=1741685174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSVagzG7gv+v/g8zzR4ILNSARzsQANzMJVGDI4EywE8=;
        b=GW7XU3T+X2Xp7LEgzH1U3qI9ZjywWJ3zpeAmHijuD+TIuQ1bOTIATIC9yOpFKPQLCw
         wWk4KV0o6pqRuSfL0KsoR5r6gx2Wobw2gH2lu3+pAezhvGJkbAcMn4AS2In1YC1L/0Gg
         HaZbwLExngOtwLQU90RevUsmACy0LvWIGSn945PxWYLrkOHDt55z9N6rMNuhLu5YIVoO
         1IIW38Diggwct0P0VYwIOp+R9GHD7YazBO7iWu2HpeeN60RsoydhDpQdrag9nc4Izuu9
         lZjnxriN521TKqw5KB/wAxIrMva8xWjrUdzrMuuMojYRUrb8cooJAvqyWzTH6zNPDvGN
         Rjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080374; x=1741685174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSVagzG7gv+v/g8zzR4ILNSARzsQANzMJVGDI4EywE8=;
        b=mWtqO78OzfWdkAFrNVZ9R3nbVDxqYXNnKZnxoLigQeixu1O+Ou4iSLtcBjALtgWguO
         UF6pH/WBNWTNhW/Qi8Li2FMvaEhBzxpTc5uP3uyYEXTh0YVtec1Qtvw4dQ5LespkJL7a
         S7Ao2/4PCvAdMSkwvGvvSKGRGG/0ALpI+9hysrfxMf/XK/G2FeRsCZknWj0/t7EIxRRL
         8ZCWmBpuuoTJ2scAEtu39sV8NXXD28LXLWIpEG/U4n4SouiPDRIfXWBa/A9YtBGVNgvB
         C+0WiH/yx428yO4WkOCZZE8PmQxzLnptlOHBkmg+yTIIWUI/CCgldDSfLWwWy9B8pREe
         tSww==
X-Forwarded-Encrypted: i=1; AJvYcCXWYaNEqodANr6FlYZ42HLBmdVvwq7gFvc4WMtSGoUTUuraK60j4Ox4WLiyhsrFavLvF5IGoLR0+512tyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgkLqOJguTpBtfppsHf0mcRnZhJbvf8rOL3ji4/EV4snIrXqg
	G3GD5Niz4wMT+1vVPPdx2fpmHTW+N0KrupFrgfS7Lpkb++3iSORj+hi3meOeN2H/fbYgtYdDMQ=
	=
X-Google-Smtp-Source: AGHT+IFJBP4Tcx72apFD1gIfXnldoSVXluGG30wLL1iAY+mX9Im8gCUaP5MoJwpojqCBSSTJQMcMwqY6Fw==
X-Received: from ejcvb9.prod.google.com ([2002:a17:907:d049:b0:ac1:f9fe:d27b])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:880e:b0:abf:4521:eb2a
 with SMTP id a640c23a62f3a-abf4521edabmr1374674266b.49.1741080374222; Tue, 04
 Mar 2025 01:26:14 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:23 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-25-elver@google.com>
Subject: [PATCH v2 24/34] compiler-capability-analysis: Introduce header suppressions
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

While we can opt in individual subsystems which add the required
annotations, such subsystems inevitably include headers from other
subsystems which may not yet have the right annotations, which then
result in false positive warnings.

Making compatible by adding annotations across all common headers
currently requires an excessive number of __no_capability_analysis
annotations, or carefully analyzing non-trivial cases to add the correct
annotations. While this is desirable long-term, providing an incremental
path causes less churn and headaches for maintainers not yet interested
in dealing with such warnings.

Rather than clutter headers unnecessary and mandate all subsystem
maintainers to keep their headers working with capability analysis,
suppress all -Wthread-safety warnings in headers. Explicitly opt in
headers with capability-enabled primitives.

This bumps the required Clang version to version 20+.

With this in place, we can start enabling the analysis on more complex
subsystems in subsequent changes.

Signed-off-by: Marco Elver <elver@google.com>
---
 .../dev-tools/capability-analysis.rst         |  2 ++
 lib/Kconfig.debug                             |  4 ++-
 scripts/Makefile.capability-analysis          |  4 +++
 scripts/capability-analysis-suppression.txt   | 32 +++++++++++++++++++
 4 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 scripts/capability-analysis-suppression.txt

diff --git a/Documentation/dev-tools/capability-analysis.rst b/Documentation/dev-tools/capability-analysis.rst
index d11e88ab9882..5c87d7659995 100644
--- a/Documentation/dev-tools/capability-analysis.rst
+++ b/Documentation/dev-tools/capability-analysis.rst
@@ -17,6 +17,8 @@ features. To enable for Clang, configure the kernel with::
 
     CONFIG_WARN_CAPABILITY_ANALYSIS=y
 
+The feature requires Clang 20 or later.
+
 The analysis is *opt-in by default*, and requires declaring which modules and
 subsystems should be analyzed in the respective `Makefile`::
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8abaf7dab3f8..8b13353517a9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -605,7 +605,7 @@ config DEBUG_FORCE_WEAK_PER_CPU
 
 config WARN_CAPABILITY_ANALYSIS
 	bool "Compiler capability-analysis warnings"
-	depends on CC_IS_CLANG && $(cc-option,-Wthread-safety -fexperimental-late-parse-attributes)
+	depends on CC_IS_CLANG && $(cc-option,-Wthread-safety -fexperimental-late-parse-attributes --warning-suppression-mappings=/dev/null)
 	# Branch profiling re-defines "if", which messes with the compiler's
 	# ability to analyze __cond_acquires(..), resulting in false positives.
 	depends on !TRACE_BRANCH_PROFILING
@@ -619,6 +619,8 @@ config WARN_CAPABILITY_ANALYSIS
 	  the original name of the feature; it was later expanded to be a
 	  generic "Capability Analysis" framework.
 
+	  Requires Clang 20 or later.
+
 	  Produces warnings by default. Select CONFIG_WERROR if you wish to
 	  turn these warnings into errors.
 
diff --git a/scripts/Makefile.capability-analysis b/scripts/Makefile.capability-analysis
index b7b36cca47f4..2a3e493a9d06 100644
--- a/scripts/Makefile.capability-analysis
+++ b/scripts/Makefile.capability-analysis
@@ -4,4 +4,8 @@ capability-analysis-cflags := -DWARN_CAPABILITY_ANALYSIS	\
 	-fexperimental-late-parse-attributes -Wthread-safety	\
 	$(call cc-option,-Wthread-safety-pointer)
 
+ifndef CONFIG_WARN_CAPABILITY_ANALYSIS_ALL
+capability-analysis-cflags += --warning-suppression-mappings=$(srctree)/scripts/capability-analysis-suppression.txt
+endif
+
 export CFLAGS_CAPABILITY_ANALYSIS := $(capability-analysis-cflags)
diff --git a/scripts/capability-analysis-suppression.txt b/scripts/capability-analysis-suppression.txt
new file mode 100644
index 000000000000..0a5392fee710
--- /dev/null
+++ b/scripts/capability-analysis-suppression.txt
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# The suppressions file should only match common paths such as header files.
+# For individual subsytems use Makefile directive CAPABILITY_ANALYSIS := [yn].
+#
+# The suppressions are ignored when CONFIG_WARN_CAPABILITY_ANALYSIS_ALL is
+# selected.
+
+[thread-safety]
+src:*arch/*/include/*
+src:*include/acpi/*
+src:*include/asm-generic/*
+src:*include/linux/*
+src:*include/net/*
+
+# Opt-in headers:
+src:*include/linux/bit_spinlock.h=emit
+src:*include/linux/cleanup.h=emit
+src:*include/linux/kref.h=emit
+src:*include/linux/list*.h=emit
+src:*include/linux/local_lock*.h=emit
+src:*include/linux/lockdep.h=emit
+src:*include/linux/mutex*.h=emit
+src:*include/linux/rcupdate.h=emit
+src:*include/linux/refcount.h=emit
+src:*include/linux/rhashtable.h=emit
+src:*include/linux/rwlock*.h=emit
+src:*include/linux/rwsem.h=emit
+src:*include/linux/seqlock*.h=emit
+src:*include/linux/spinlock*.h=emit
+src:*include/linux/srcu.h=emit
+src:*include/linux/ww_mutex.h=emit
-- 
2.48.1.711.g2feabab25a-goog


