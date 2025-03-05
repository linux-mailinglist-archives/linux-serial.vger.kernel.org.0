Return-Path: <linux-serial+bounces-8274-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E8EA4F9F9
	for <lists+linux-serial@lfdr.de>; Wed,  5 Mar 2025 10:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A41216DBF8
	for <lists+linux-serial@lfdr.de>; Wed,  5 Mar 2025 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B674204F75;
	Wed,  5 Mar 2025 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1M46Al9j"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1222046AD
	for <linux-serial@vger.kernel.org>; Wed,  5 Mar 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166835; cv=none; b=hJeKX4rOct3FgTDamR8BEwUfeUcc/ReRXwkkbSpmp8290vV5YcqTs5gdZ+YtMKAVbcJlvwGI9V+uRDlIhW9Ewv0gdq8sygYCzuL/Cs6eJUtqrdhz4vmQWeRnadCJZiInL/bKe0LwJ7eQ8E25cC83Wpt93ym6S3Rj+qTXerjOusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166835; c=relaxed/simple;
	bh=5Ga7iKQfQ2dUZKR68jj1o/tjquCGwPv16PHkL0PNKgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/Zci49QfUQqce9s9kL4LaMOpHKydoLreu3L5MVgUQbSx+OlXtNGFvz6coFg9q0mKFGlxqi6/ehwzv1bdfQaxsEj5Xr2/A8/CFJVLiyM+YyozNOTF2hZWvfeguo6zusm5V+m0zJypX/aq/RJEX0EF6lz97mlcqgN5mHp7cdixeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1M46Al9j; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fecba90cc3so9314217a91.2
        for <linux-serial@vger.kernel.org>; Wed, 05 Mar 2025 01:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741166831; x=1741771631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/K733SUjRr/UJmKpRHEDrbtF8c66tB7gTHAMMFw3t0g=;
        b=1M46Al9jO1A1unUoZMiROxDpoHhPkdtM4V6AMuoSp6170ZPBIwF8HTEXOy5/f1ji4G
         loQRt2pLUXnx4p3Sm2I6gHNPQgh3KOBaE1qIIh5ws/+B6cKfjWP3JJNU6wBKoFPvaQMe
         nMGKnNp8/4ltI+7ZOngXr9g3HuvWfy32UPsy6mriU+BuHBb4ntJW/MgqUrhEipWKV8p4
         ybgQCY+MbY2DqPdK1/kehc65BEHh6bJn/WrV+jXYD/4GNhar88avzJzb3q6aKZgpBIhC
         iA30BigDIl+7i8ivWyoPe1cSG55znfGnC8B10EANY1hPayY2GEPCS+FSWFg7yeIOWobK
         y9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741166831; x=1741771631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/K733SUjRr/UJmKpRHEDrbtF8c66tB7gTHAMMFw3t0g=;
        b=AJN0pkqowykVS+CMzCsL5XOzQUuyYGWcoFme5sNjc1UoTKQ2UDKS57wZKb6RwkIrTE
         73CiY677oDRRetWhiDaKHN5CMHQnFg0YjSawLBvEoVFDu3s83eTGnBN4u0oxxiNW6eer
         igeTsi5eCKX2bsKmdu+VbX1ciynhGWtKPAr5i//KpB17kcNDxPrB7y/TyLBHFtm8zpGe
         tqK14cgtDn95x2pz+/WKVAeUzgSmMOe+n9Z1rge7rtLcdVzDQBLQY1vzX54IPQGe3wMo
         XjVYdS7N86xOgV3nbR6Jcou/6e5NuU0O2CNz78KgyKzQFn7f/VKB7ERMyHpIPg2BheWY
         IrOA==
X-Forwarded-Encrypted: i=1; AJvYcCUh4pNUzUD3SzzyVR8brqR312cdwxux97oodxjkzIL9JZgrJ+i/b0hdKbX+qhn5Zy35yjctmhpv0YA1cKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYYSBAacGLTzAe8CZ5wZFBya1Jnek0igr3rJLp/wyePyQqlxl
	tsV+w8SDvy9bvncqHoNa05GH8NxjcpOyomavZ0BlTEE9Cslo7jYgdJU89tlVotIUlbfL239pShq
	cZQEM5AL/YU1pCrTG3db1+M7HJk/XA8bLekpc
X-Gm-Gg: ASbGncvrAab82/KmwnJuGZKBCB1IIgAT0ivUWyhHdCUd0WEHMLdl1NJwJ0UD5vfWNPl
	yYtqvITA/mTXhdNNUOvnml2XkA3GoRPODmPjGHu44injM5+mmsAyCKxvZmbPEyeD2zlLPgasRyb
	A8k0yxIppODaAKYlly+LcIe5q7f8KbPzcSGYl3wb7RzXnqnumhWS0C1xBN
X-Google-Smtp-Source: AGHT+IHlEWxNWj8V83mY5ZmLmkghujebTbg0B6Nro3nsSPpkjeBaoeQHElazVKIVEcj04AksfzxuyiaGBQcjIBmQBC0=
X-Received: by 2002:a17:90b:1d49:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-2ff497a91d9mr5296650a91.12.1741166831231; Wed, 05 Mar 2025
 01:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com> <20250304092417.2873893-32-elver@google.com>
 <569186c5-8663-43df-a01c-d543f57ce5ca@kernel.org>
In-Reply-To: <569186c5-8663-43df-a01c-d543f57ce5ca@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 5 Mar 2025 10:26:33 +0100
X-Gm-Features: AQ5f1JrzAOwhwvy95MFPvjsEXdGkKN5XEE-rlSH22cDbqIsJIlrP0-RVGS5P53c
Message-ID: <CANpmjNM+0xWRUmeyQ0hb6k5zHakw=KAaQN7VZ=yMyz0eyBa4xQ@mail.gmail.com>
Subject: Re: [PATCH v2 31/34] drivers/tty: Enable capability analysis for core files
To: Jiri Slaby <jirislaby@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 10:15, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 04. 03. 25, 10:21, Marco Elver wrote:
> > Enable capability analysis for drivers/tty/*.
> >
> > This demonstrates a larger conversion to use Clang's capability
> > analysis. The benefit is additional static checking of locking rules,
> > along with better documentation.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> ...
> > --- a/drivers/tty/tty_buffer.c
> > +++ b/drivers/tty/tty_buffer.c
> > @@ -52,10 +52,8 @@
> >    */
> >   void tty_buffer_lock_exclusive(struct tty_port *port)
> >   {
> > -     struct tty_bufhead *buf = &port->buf;
> > -
> > -     atomic_inc(&buf->priority);
> > -     mutex_lock(&buf->lock);
> > +     atomic_inc(&port->buf.priority);
> > +     mutex_lock(&port->buf.lock);
>
> Here and:
>
> > @@ -73,7 +71,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
> >       bool restart = buf->head->commit != buf->head->read;
> >
> >       atomic_dec(&buf->priority);
> > -     mutex_unlock(&buf->lock);
> > +     mutex_unlock(&port->buf.lock);
>
> here, this appears excessive. You are changing code to adapt to one kind
> of static analysis. Adding function annotations is mostly fine, but
> changing code is too much. We don't do that. Fix the analyzer instead.

Right. So the analysis doesn't do alias analysis.

> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -167,6 +167,7 @@ static void release_tty(struct tty_struct *tty, int idx);
> >    * Locking: none. Must be called after tty is definitely unused
> >    */
> >   static void free_tty_struct(struct tty_struct *tty)
> > +     __capability_unsafe(/* destructor */)
> >   {
> >       tty_ldisc_deinit(tty);
> >       put_device(tty->dev);
> > @@ -965,7 +966,7 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
> >       ssize_t ret, written = 0;
> >
> >       ret = tty_write_lock(tty, file->f_flags & O_NDELAY);
> > -     if (ret < 0)
> > +     if (ret)
>
> This change is not documented.

Fair point. This is because the analysis can only deal with
conditional locking when fed into zero/non-zero condition checks.

> > @@ -1154,7 +1155,7 @@ int tty_send_xchar(struct tty_struct *tty, u8 ch)
> >               return 0;
> >       }
> >
> > -     if (tty_write_lock(tty, false) < 0)
> > +     if (tty_write_lock(tty, false))
>
> And this one. And more times later.
>
> > --- a/drivers/tty/tty_ldisc.c
> > +++ b/drivers/tty/tty_ldisc.c
> ...
> > +/*
> > + * Note: Capability analysis does not like asymmetric interfaces (above types
> > + * for ref and deref are tty_struct and tty_ldisc respectively -- which are
> > + * dependent, but the compiler cannot figure that out); in this case, work
> > + * around that with this helper which takes an unused @tty argument but tells
> > + * the analysis which lock is released.
> > + */
> > +static inline void __tty_ldisc_deref(struct tty_struct *tty, struct tty_ldisc *ld)
> > +     __releases_shared(&tty->ldisc_sem)
> > +     __capability_unsafe(/* matches released with tty_ldisc_ref() */)
> > +{
> > +     tty_ldisc_deref(ld);
> > +}
>
> You want to invert the __ prefix for these two. tty_ldisc_deref() should
> be kept as the one to be called by everybody.

Ack.

I think in the near term the alias analysis issues + conditional check
of < 0 aren't solvable. Alias analysis being the bigger issue.
Two options:
1. Adding __capability_unsafe to the few functions that you weren't
happy with above.
2. Dropping the whole patch.

I'm inclined to drop the whole patch.

Thanks,
-- Marco

