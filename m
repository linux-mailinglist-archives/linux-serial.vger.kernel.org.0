Return-Path: <linux-serial+bounces-2589-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C01870E8B
	for <lists+linux-serial@lfdr.de>; Mon,  4 Mar 2024 22:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5891F20F93
	for <lists+linux-serial@lfdr.de>; Mon,  4 Mar 2024 21:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B381EB5A;
	Mon,  4 Mar 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06TDOK99"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9E8F58
	for <linux-serial@vger.kernel.org>; Mon,  4 Mar 2024 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588695; cv=none; b=ivPM9/oj9WfHWdMqwrhe3BltS0/iMwevb4084E4hN66utbItpa4TCsj5LoleKM7QWSGnDxmBPPfmOaoD6NAhS3gNdMLM6SxJiP/YjRXpwK7u81MLjqV9JfoUT8DEO4tMmrsOVM1sQeQy5cRzAVA7NtZaWWaK8ApT8OwNoaNiEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588695; c=relaxed/simple;
	bh=vnQfVPDee5TR5DXFXuoCLyv9CL2z+tYkFjRkKfEijPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMolIwLU+kf3Ai72nb88tX4nCBk/4ht+aU+Cvefy0O9nztf7Wz1RRmwNHYuGvIzTr+GWXoCf5KqZ5U5zzjfCz5ECojEFgvi0SO+MMfgYwce3dFkee8v49WYEp6YXjO6y283TSc9QMCGMcQw7H3oStuJBtbvokT/tfLe9du0N52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=06TDOK99; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dbe7e51f91so13495ad.1
        for <linux-serial@vger.kernel.org>; Mon, 04 Mar 2024 13:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709588693; x=1710193493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdHn4GZb8mS5r9CCbE9G4dliiSwjFnsZ8iNZM0tpqSw=;
        b=06TDOK990+J2RWFomRj/GQySLoXhpD7RTIt7xnrmTNK6J4uRhHKa8Cxdf4gz4Qtoyk
         jcJnblnSu3edy8+G15UWUwOl/Ssp5q+zvPGxtUHHL0/nRAi/hKhqRiDuyE5tG6f489/o
         b+UUaDA7yLlRt+tsP3pwNF5/ft0snAca1KXVHSE3NtDMK78agKdZTs2z95MrIx+Vs6Q9
         u9I8X+W+OrOQTNxelFMLtgH9fmXDN7DmgdGpdSt3MldwLYgCbuh0l9jOwG6w+wk9unri
         edqZNXCGrhIG1IFHtfAUg6qm1G2UetVnbF7yUYYABl/8Ix84iPH2rRJnh+5KSq04Hxnt
         YkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709588693; x=1710193493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdHn4GZb8mS5r9CCbE9G4dliiSwjFnsZ8iNZM0tpqSw=;
        b=EcjAl9aE/ubnNgAe9uD0ogEUJ0C48OUYmYW2nlYRJYXvzlfxBz8ci1aBJEp/OUSf68
         z88yzXq1r/O83BLmnqJW9arpWG3VskQoTwryHqNUXw9DQjD9xB5F38wZ0ECyoQS6IO2I
         HCuSQ6TXC1pcFWITymhM5dZeHXQmTphwgEby95DxBnunEAgvY10U+X9aThChCD2ARs1D
         m/vvOgDtwiSmiRnAew4C38NAtH1jzDpasjZID/zW1rXR5+hhSN0VAHoFcX5ikmZitCHu
         gkM7p258lA+b8vVNgYapVurkSMTLzfUTvFgK+NCnWv4CWHJrSwj6h94D9GOUwUp2yvjZ
         EOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCRPh4BPWzPvFPQ0OHYR/cZMp0O2v1edWQV/gOLeGbJJz2hhpQwruIpTgE08sO1RyLeTJT6N2wA0uvKkCVdK/p13WraHE5uRMZu9vf
X-Gm-Message-State: AOJu0Yw18edH4HuLN694OgrumuLTTfI1+8f4Jm8lYkLnRfan6ph/lWB7
	3QdZWm4fNHqeYlXsYUbGkjP2O8YcYn0oKGig3T/3OUAdN4Dyswu5QCf0za+Pa7A5sFAmFxsPi71
	Hv2Fa0KK2CbsqITw2okduYvSjzO0h04Ujz2Pe
X-Google-Smtp-Source: AGHT+IGlRiqVF/I1pYpE4NUWd1ZLLQYcAq+ButRY/vOupZ8HBlb/kszZVF6akgIHib/kDQTm8OC6kJzLCWjs2sgY+6s=
X-Received: by 2002:a17:903:1c2:b0:1db:7057:24df with SMTP id
 e2-20020a17090301c200b001db705724dfmr2059plh.14.1709588692886; Mon, 04 Mar
 2024 13:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226192329.3281301-1-pcc@google.com> <2024030214-buffing-obtuse-8dc8@gregkh>
In-Reply-To: <2024030214-buffing-obtuse-8dc8@gregkh>
From: Peter Collingbourne <pcc@google.com>
Date: Mon, 4 Mar 2024 13:44:39 -0800
Message-ID: <CAMn1gO4V2ehZ8JN_+vz1B8xrpTdvHAbQ_G4-y4yAAzST=PUnuw@mail.gmail.com>
Subject: Re: [PATCH v2] serial: Lock console when calling into driver before registration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 12:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 26, 2024 at 11:23:26AM -0800, Peter Collingbourne wrote:
> > During the handoff from earlycon to the real console driver, we have
> > two separate drivers operating on the same device concurrently. In the
> > case of the 8250 driver these concurrent accesses cause problems due
> > to the driver's use of banked registers, controlled by LCR.DLAB. It is
> > possible for the setup(), config_port(), pm() and set_mctrl() callbacks
> > to set DLAB, which can cause the earlycon code that intends to access
> > TX to instead access DLL, leading to missed output and corruption on
> > the serial line due to unintended modifications to the baud rate.
> >
> > In particular, for setup() we have:
> >
> > univ8250_console_setup()
> > -> serial8250_console_setup()
> > -> uart_set_options()
> > -> serial8250_set_termios()
> > -> serial8250_do_set_termios()
> > -> serial8250_do_set_divisor()
> >
> > For config_port() we have:
> >
> > serial8250_config_port()
> > -> autoconfig()
> >
> > For pm() we have:
> >
> > serial8250_pm()
> > -> serial8250_do_pm()
> > -> serial8250_set_sleep()
> >
> > For set_mctrl() we have (for some devices):
> >
> > serial8250_set_mctrl()
> > -> omap8250_set_mctrl()
> > -> __omap8250_set_mctrl()
> >
> > To avoid such problems, let's make it so that the console is locked
> > during pre-registration calls to these callbacks, which will prevent
> > the earlycon driver from running concurrently.
> >
> > Remove the partial solution to this problem in the 8250 driver
> > that locked the console only during autoconfig_irq(), as this would
> > result in a deadlock with the new approach. The console continues
> > to be locked during autoconfig_irq() because it can only be called
> > through uart_configure_port().
> >
> > Although this patch introduces more locking than strictly necessary
> > (and in particular it also locks during the call to rs485_config()
> > which is not affected by this issue as far as I can tell), it follows
> > the principle that it is the responsibility of the generic console
> > code to manage the earlycon handoff by ensuring that earlycon and real
> > console driver code cannot run concurrently, and not the individual
> > drivers.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> > Link: https://linux-review.googlesource.com/id/I7cf8124dcebf8618e6b2ee5=
43fa5b25532de55d8
>
> Why is a link to a gerrit review with no context other than this same
> commit needed here?

I usually add that to my patches so that the progression of the patch
can be tracked. See:
https://lore.kernel.org/all/CAMn1gO53G6-sZE8RiLAD2uERbW1XtvyZbRonNGbHonzD05=
8yAA@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=3DwhFbgy4RXG11c_=3DS7O-248oWmwB_aZOcWzWMV=
h3w7=3DRCw@mail.gmail.com/

> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/tty/serial/8250/8250_port.c |  6 ------
> >  drivers/tty/serial/serial_core.c    | 12 ++++++++++++
> >  kernel/printk/printk.c              | 21 ++++++++++++++++++---
> >  3 files changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 8ca061d3bbb9..1d65055dde27 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1329,9 +1329,6 @@ static void autoconfig_irq(struct uart_8250_port =
*up)
> >               inb_p(ICP);
> >       }
> >
> > -     if (uart_console(port))
> > -             console_lock();
> > -
> >       /* forget possible initially masked and pending IRQ */
> >       probe_irq_off(probe_irq_on());
> >       save_mcr =3D serial8250_in_MCR(up);
> > @@ -1371,9 +1368,6 @@ static void autoconfig_irq(struct uart_8250_port =
*up)
> >       if (port->flags & UPF_FOURPORT)
> >               outb_p(save_ICP, ICP);
> >
> > -     if (uart_console(port))
> > -             console_unlock();
> > -
> >       port->irq =3D (irq > 0) ? irq : 0;
> >  }
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index d6a58a9e072a..ff85ebd3a007 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2608,7 +2608,12 @@ uart_configure_port(struct uart_driver *drv, str=
uct uart_state *state,
> >                       port->type =3D PORT_UNKNOWN;
> >                       flags |=3D UART_CONFIG_TYPE;
> >               }
> > +             /* Synchronize with possible boot console. */
> > +             if (uart_console(port))
> > +                     console_lock();
> >               port->ops->config_port(port, flags);
> > +             if (uart_console(port))
> > +                     console_unlock();
> >       }
> >
> >       if (port->type !=3D PORT_UNKNOWN) {
> > @@ -2616,6 +2621,10 @@ uart_configure_port(struct uart_driver *drv, str=
uct uart_state *state,
> >
> >               uart_report_port(drv, port);
> >
> > +             /* Synchronize with possible boot console. */
> > +             if (uart_console(port))
> > +                     console_lock();
> > +
> >               /* Power up port for set_mctrl() */
> >               uart_change_pm(state, UART_PM_STATE_ON);
> >
> > @@ -2632,6 +2641,9 @@ uart_configure_port(struct uart_driver *drv, stru=
ct uart_state *state,
> >
> >               uart_rs485_config(port);
> >
> > +             if (uart_console(port))
> > +                     console_unlock();
> > +
> >               /*
> >                * If this driver supports console, and it hasn't been
> >                * successfully registered yet, try to re-register it.
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index f2444b581e16..f51e4e5a869d 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3263,6 +3263,21 @@ static int __init keep_bootcon_setup(char *str)
> >
> >  early_param("keep_bootcon", keep_bootcon_setup);
> >
> > +static int console_call_setup(struct console *newcon, char *options)
> > +{
> > +     int err;
> > +
> > +     if (!newcon->setup)
> > +             return 0;
> > +
> > +     /* Synchronize with possible boot console. */
> > +     console_lock();
> > +     err =3D newcon->setup(newcon, options);
> > +     console_unlock();
> > +
> > +     return err;
> > +}
> > +
> >  /*
> >   * This is called by register_console() to try to match
> >   * the newly registered console with any of the ones selected
> > @@ -3298,8 +3313,8 @@ static int try_enable_preferred_console(struct co=
nsole *newcon,
> >                       if (_braille_register_console(newcon, c))
> >                               return 0;
> >
> > -                     if (newcon->setup &&
> > -                         (err =3D newcon->setup(newcon, c->options)) !=
=3D 0)
> > +                     err =3D console_call_setup(newcon, c->options);
> > +                     if (err !=3D 0)
>
> Didn't checkpatch complain about this?  It should be:
>                         if (err)
> right?

No, it didn't complain. (It complained about the pre-existing
assignment within an if, which is why I moved it out, but not about
that.) Looks like if (err) is more popular, so I changed it in v3.

> >                               return err;
> >               }
> >               newcon->flags |=3D CON_ENABLED;
> > @@ -3325,7 +3340,7 @@ static void try_enable_default_console(struct con=
sole *newcon)
> >       if (newcon->index < 0)
> >               newcon->index =3D 0;
> >
> > -     if (newcon->setup && newcon->setup(newcon, NULL) !=3D 0)
> > +     if (console_call_setup(newcon, NULL) !=3D 0)
> >               return;
>
> No way to pass an error back here?

The only caller, register_console(), ignores errors from this
function. Arguably it shouldn't, but that's a pre-existing issue.

Peter

