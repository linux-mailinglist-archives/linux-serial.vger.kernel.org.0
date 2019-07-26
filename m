Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3340976EC4
	for <lists+linux-serial@lfdr.de>; Fri, 26 Jul 2019 18:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfGZQTg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 26 Jul 2019 12:19:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33380 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfGZQTg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jul 2019 12:19:36 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so106007392iog.0
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2019 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqERv8DKz+oP8owpdP7PzdiwI3xbOV3Kj5XS3CmvVfM=;
        b=h/5Uz9dXIC/L69HRyfY+zKXCM1SWZ3EC3foYWgxL4aKfrrUtCL4G+KLWOfPBQGV2OA
         0Q0qyWEMnlTrNKBGf6pTQYwUAJSfJx9xa9xNuHTQey4jy6pM786XbsE4qy52oyVrYcHW
         dSpSPcxVgvlhC0b1gSTjcOE0fRv7wEImoj25Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqERv8DKz+oP8owpdP7PzdiwI3xbOV3Kj5XS3CmvVfM=;
        b=Ov58nUKAjScoAaPilOtY+8fbykYHxY2hwLh4dOC/6QohHWei6GNspIkqtumiNLcww1
         K9JmgZlzxLcdQ0b1x6acA7ebQQOxjk73SSPgEFV4U3RZkLk7Vvf8G5TVO5pJxRApS0Id
         sDTd8qx0rG/muG2seOrz81rfSkV51BeSUOL+Dp6hpIa3SyMKoteFaHDP0nArgLKJqGpi
         /kq9uswvGzja29RBm8CUVOL3woisVa9TDGftI0iB60vp0almXbS6gSXXHOvaNYXhq4rh
         SE6CBdHTFEKPQv/AjCNmVLRiSsnIypH7nt2MNYvOUgaD/QkvHe2cwtvEebCl6pdh7DsI
         MPCA==
X-Gm-Message-State: APjAAAU9XMUPgaA8sdH4y+s6+KjQZ+Tho7Es+bEaWdkpwbhm13XpS7ry
        NesXmboQvfVj23ltt8E/ecJDUxY2NB4=
X-Google-Smtp-Source: APXvYqwKpDpLtO/NOtVh16Mj9NPmJh9536MdC8lUHjEF7kqOSKMwpv3dUC5no0JMo1zSfLoj7QOQdg==
X-Received: by 2002:a5d:8759:: with SMTP id k25mr20617758iol.307.1564157975054;
        Fri, 26 Jul 2019 09:19:35 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id h19sm36443188iol.65.2019.07.26.09.19.34
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 09:19:34 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id z3so106007151iog.0
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2019 09:19:34 -0700 (PDT)
X-Received: by 2002:a5e:c241:: with SMTP id w1mr83037431iop.58.1564157973635;
 Fri, 26 Jul 2019 09:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190725183551.169208-1-dianders@chromium.org> <20190726091630.GA20016@kroah.com>
In-Reply-To: <20190726091630.GA20016@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Jul 2019 09:19:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WVaksqBE4HBTMZwV1hv6_FJMmAqF+kWBpdfvsHQyRkSA@mail.gmail.com>
Message-ID: <CAD=FV=WVaksqBE4HBTMZwV1hv6_FJMmAqF+kWBpdfvsHQyRkSA@mail.gmail.com>
Subject: Re: [PATCH] kgdboc: disable the console lock when in kgdb
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>, Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Fri, Jul 26, 2019 at 2:16 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 25, 2019 at 11:35:51AM -0700, Douglas Anderson wrote:
> > After commit ddde3c18b700 ("vt: More locking checks") kdb / kgdb has
> > become useless because my console is filled with spews of:
> >
> > WARNING: CPU: 0 PID: 0 at .../drivers/tty/vt/vt.c:3846 con_is_visible+0x50/0x74
> > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc1+ #48
> > Hardware name: Rockchip (Device Tree)
> > Backtrace:
> > [<c020ce9c>] (dump_backtrace) from [<c020d188>] (show_stack+0x20/0x24)
> > [<c020d168>] (show_stack) from [<c0a8fc14>] (dump_stack+0xb0/0xd0)
> > [<c0a8fb64>] (dump_stack) from [<c0232c58>] (__warn+0xec/0x11c)
> > [<c0232b6c>] (__warn) from [<c0232dc4>] (warn_slowpath_null+0x4c/0x58)
> > [<c0232d78>] (warn_slowpath_null) from [<c06338a0>] (con_is_visible+0x50/0x74)
> > [<c0633850>] (con_is_visible) from [<c0634078>] (con_scroll+0x108/0x1ac)
> > [<c0633f70>] (con_scroll) from [<c0634160>] (lf+0x44/0x88)
> > [<c063411c>] (lf) from [<c06363ec>] (vt_console_print+0x1a4/0x2bc)
> > [<c0636248>] (vt_console_print) from [<c02f628c>] (vkdb_printf+0x420/0x8a4)
> > [<c02f5e6c>] (vkdb_printf) from [<c02f6754>] (kdb_printf+0x44/0x60)
> > [<c02f6714>] (kdb_printf) from [<c02fa6f4>] (kdb_main_loop+0xf4/0x6e0)
> > [<c02fa600>] (kdb_main_loop) from [<c02fd5f0>] (kdb_stub+0x268/0x398)
> > [<c02fd388>] (kdb_stub) from [<c02f3ba0>] (kgdb_cpu_enter+0x1f8/0x674)
> > [<c02f39a8>] (kgdb_cpu_enter) from [<c02f4330>] (kgdb_handle_exception+0x1c4/0x1fc)
> > [<c02f416c>] (kgdb_handle_exception) from [<c0210fe0>] (kgdb_compiled_brk_fn+0x30/0x3c)
> > [<c0210fb0>] (kgdb_compiled_brk_fn) from [<c020d7ac>] (do_undefinstr+0x180/0x1a0)
> > [<c020d62c>] (do_undefinstr) from [<c0201b44>] (__und_svc_finish+0x0/0x3c)
> > ...
> > [<c02f3224>] (kgdb_breakpoint) from [<c02f3310>] (sysrq_handle_dbg+0x58/0x6c)
> > [<c02f32b8>] (sysrq_handle_dbg) from [<c062abf0>] (__handle_sysrq+0xac/0x154)
> >
> > Let's disable this warning when we're in kgdb to avoid the spew.  The
> > whole system is stopped when we're in kgdb so we can't exactly wait
> > for someone else to drop the lock.  Presumably the best we can do is
> > to disable the warning and hope for the best.
> >
> > Fixes: ddde3c18b700 ("vt: More locking checks")
> > Cc: Daniel Vetter <daniel.vetter@intel.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/tty/serial/kgdboc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > index bfe5e9e034ec..c7d51b51898f 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -277,10 +277,14 @@ static void kgdboc_pre_exp_handler(void)
> >       /* Increment the module count when the debugger is active */
> >       if (!kgdb_connected)
> >               try_module_get(THIS_MODULE);
> > +
> > +     atomic_inc(&ignore_console_lock_warning);
> >  }
> >
> >  static void kgdboc_post_exp_handler(void)
> >  {
> > +     atomic_dec(&ignore_console_lock_warning);
> > +
> >       /* decrement the module count when the debugger detaches */
> >       if (!kgdb_connected)
> >               module_put(THIS_MODULE);
> > --
> > 2.22.0.709.g102302147b-goog
>
> I have the following patch in my tree to go to Linus that I think might
> fix this issue for you.  Can you test it instead?
>
> thanks,
>
> greg k-h
>
> -----------------
>
>
> From 61d51456f35760a09e8aa1e6ddd247f1547015d3 Mon Sep 17 00:00:00 2001
> From: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date: Thu, 18 Jul 2019 10:09:03 +0200
> Subject: [PATCH] vt: Grab console_lock around con_is_bound in show_bind
>
> Not really harmful not to, but also not harm in grabbing the lock. And
> this shuts up a new WARNING I introduced in commit ddde3c18b700 ("vt:
> More locking checks").
>
> Reported-by: Jens Remus <jremus@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Martin Hostettler <textshell@uchuujin.de>
> Cc: Adam Borowski <kilobyte@angband.pl>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Fixes: ddde3c18b700 ("vt: More locking checks")
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Tested-by: Jens Remus <jremus@linux.ibm.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Link: https://lore.kernel.org/r/20190718080903.22622-1-daniel.vetter@ffwll.ch
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/vt/vt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index ec92f36ab5c4..34aa39d1aed9 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3771,7 +3771,11 @@ static ssize_t show_bind(struct device *dev, struct device_attribute *attr,
>                          char *buf)
>  {
>         struct con_driver *con = dev_get_drvdata(dev);
> -       int bind = con_is_bound(con->con);
> +       int bind;
> +
> +       console_lock();
> +       bind = con_is_bound(con->con);
> +       console_unlock();
>
>         return snprintf(buf, PAGE_SIZE, "%i\n", bind);
>  }

Thanks for checking.  I had actually noticed that patch (I searched
the mailing lists for the short git hash of the commit that broke me
and found it) and had decided it wouldn't fix my problems.
Specifically I think it could only possibly fix things if the function
show_bind() was somewhere in my stack trace.  ...and it isn't.

...but after your message I decided to be extra super sure.  I tried:

1. Going back to mainline commit 6789f873ed37 ("Merge tag 'pm-5.3-rc2'
of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm") and
picking commit 61d51456f357 ("vt: Grab console_lock around
con_is_bound in show_bind") from linuxnext.  It didn't fix my problem.

2. Going to next-20190726.  It didn't fix my problem.

...so indeed my patch addresses a different issue than the one you
pointed to, even if both fix problems introduced by the same commit.


Thanks!

-Doug
