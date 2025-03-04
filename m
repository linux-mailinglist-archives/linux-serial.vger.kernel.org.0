Return-Path: <linux-serial+bounces-8251-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621DA4E5AB
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 17:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E2F7A4017
	for <lists+linux-serial@lfdr.de>; Tue,  4 Mar 2025 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AEA27605F;
	Tue,  4 Mar 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9HOCrOx"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE220A5D9
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104373; cv=none; b=l8LcQoAV3E+kIdJye5k5l/h6rCyDDoHaDTnZqHxLGumFkfls5QT0IPXkoePKWJK8jCXV24a4r3ZARvKQetVId/xnKPPtbjFn50AZTQuzOGlY2q6Ep38nvsmDugdutoMrp5Ua5pRLtJDj4bWuJQ//3Qs1mT8UiKr7481R5Q3Xyeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104373; c=relaxed/simple;
	bh=WWkPvNPAsAK/o9BV1/7oCW3olPK1i28GTmpPd97Esgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfDjzc3Hpgg1oeDEULX9Zk5H+ks3JExjGJ1FjvB9+mQAa6dMwhwoDSJEuR6BeEl26xENC+BSo8rOafuH1uPGf/rjFqQXrrCDTQGCZC/nybXndKUqsEJHvg0DXGd+gMizM2SZTBIWBKKVCPAbOnosOBwB5BkuhVQwUY6YAUlQpSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z9HOCrOx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2feaca4e99cso8554937a91.0
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741104371; x=1741709171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1t6ivLIoIuftK2f6E0pPM+6bkcWx6f6OEyc75s3kSwQ=;
        b=Z9HOCrOxgbWushjjjNNkwcx9LKZumjOrDWDWYrSFZVwByCC3MPD1pvISqu/wDAtyuc
         YMBhbv2R70SVZXOnu0MOtBL7Og0Z6dSY6mY5QaE1TjYTghl3t2/dcgtWi07T677SBW6y
         F++hDWUDhN1nYsEmn/8vGVpeNrT3JT7aG6de1v2wxpVL8Qm9MCWfZf7Wp6dcqdEUUFNZ
         zlvekDTGvU+NRADexTCVCpEpKjLhuXeXSkjFKtzq2oS/M5hovCbfMqHd19CCWAkR3lzX
         XUl22CFKGBH0G2aZKmOAxQWQdcT8KLcHcahH7sgWn0gvzlODtN896EyrQCvU9Cj/bTW9
         q3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741104371; x=1741709171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1t6ivLIoIuftK2f6E0pPM+6bkcWx6f6OEyc75s3kSwQ=;
        b=ADjzMJ+aF9QZvApHfTvj9RgHdfzdkNS07GnPMmk2jRVhmKoOqe1cH4b3Dre09KXYqP
         o/fOKAsVME/KfW72OpfSonnrpihtwxgSFMXwGy9aaOuoAxDK0ZF7PPa4ibR6zhoOrmiE
         WKTAbRBXgUQawfmyKGHDqT5pCur2q/4qiAimKQWHfWd44r+4+pdtDlX7ItDnIHKBHpaS
         dF34RmWRizIZ6Abf6syPw2YFu8aO6lXtWLLh6i3avLGJFg7X8dRESN/5R/G6GJ5+0tfP
         uaDlw0YiZEGub4d4pjTQpopDvCCbejAEw/YbKCHNOMjTN9cDQnYu0A8GWF4D8zti1dWd
         JGPw==
X-Forwarded-Encrypted: i=1; AJvYcCUyOLM2pxJssEP602NO7Ks8mcCw15aZA6mEGdhopPQZGVyYYmGNThQvf251YsTAhkFyD8Q7NuVSJNBBp4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1e8QYYiwUOHPu4srABrfaWWIAk4v1aC4abWZ4NjxGzoG1P/V7
	i7HwMxqSnz2PK4+5p79tWcq3t9fz4UhEk2AfBTJbHscO0EBdWg3OPfQWDO5eTD9JLMcv/jBf61V
	sLwI3zdl9gxPbzAdRR/0hKLwjt82NpeRz/F85
X-Gm-Gg: ASbGncvEShyVZmWlzq1HeMd6H+SRJx+j4B3pzE7TWz6APVPRQozfC5F6OpZ/IHrmME8
	OhWq19/XObqFG3Vkwb25qjLjGcWoetSHyYS+lwE8fLXtuVC897Kr2xjmQp0d0fcsXhOsIMrMXHQ
	Y8DVpZe8WnfyhPRTrgoAE0SkIo0vJZI99mORsrRuMbreJdO1Lelnpb5Lwn
X-Google-Smtp-Source: AGHT+IGC++S0t8n6ETtzwl720fo704PFOyUfTbjjLTjxsG9B6ISbxU7AjY+lsYqZ8bJrf6DliVj8kaBM3qPLyBgfJME=
X-Received: by 2002:a17:90b:1ccd:b0:2ee:c918:cd60 with SMTP id
 98e67ed59e1d1-2febab78da2mr27444913a91.20.1741104371050; Tue, 04 Mar 2025
 08:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com> <20250304092417.2873893-3-elver@google.com>
 <20250304152909.GH11590@noisy.programming.kicks-ass.net>
In-Reply-To: <20250304152909.GH11590@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Tue, 4 Mar 2025 17:05:34 +0100
X-Gm-Features: AQ5f1JrbHN1FRthi_aRGgJ-kY7WYoWmU4g-pqTmD_Y1oCMFum9IakZQE8Yg9HXM
Message-ID: <CANpmjNOR=EaPPhnkj+WwV8mDYNuM7fY2r_xdjORv2MGGxxH_0g@mail.gmail.com>
Subject: Re: [PATCH v2 02/34] compiler-capability-analysis: Add infrastructure
 for Clang's capability analysis
To: Peter Zijlstra <peterz@infradead.org>
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
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 16:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 04, 2025 at 10:21:01AM +0100, Marco Elver wrote:
>
> > +# define __asserts_cap(var)                  __attribute__((assert_capability(var)))
> > +# define __asserts_shared_cap(var)           __attribute__((assert_shared_capability(var)))
>
> > +     static __always_inline void __assert_cap(const struct name *var)                                \
> > +             __attribute__((overloadable)) __asserts_cap(var) { }                                    \
> > +     static __always_inline void __assert_shared_cap(const struct name *var)                         \
> > +             __attribute__((overloadable)) __asserts_shared_cap(var) { }                             \
>
> Since this does not in fact check -- that's __must_hold(), I would
> suggest renaming these like s/assert/assume/.

Yeah, that's better.

FTR - the "asserts_capability" attribute was originally meant to be
used on runtime functions that check that a lock is held at runtime;
what Clang does underneath is simply adding the given capability/lock
to the held lockset, so no real checking is enforced. In this series
it's used for a lot more than just our lockdep_assert*() helpers, so
the "assert" naming is indeed confusing.

Thanks!

