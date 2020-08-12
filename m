Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3A3242C2B
	for <lists+linux-serial@lfdr.de>; Wed, 12 Aug 2020 17:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgHLP1T (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 12 Aug 2020 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgHLP1T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 11:27:19 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C1C061383
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 08:27:18 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b26so1269640vsa.13
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jr6fmB1bCqolizwxBYidbm0DK7lilrbAIzTvtSAUPwc=;
        b=OD+PPyXQihFrcz74PmOCztCBdly6lDfViBfUJ8bCYSihAf+NTeDjNlW27957oiYU2y
         vaECRi/hoMtqa6dmNzCM0lUUK9dKf9YF1RJK40M+BIu3PCmhMkCgJp4KkehnGF4pFDDc
         FtsT8LlG/wJQeKainLa9Xcab8pOVK4bYOAb1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jr6fmB1bCqolizwxBYidbm0DK7lilrbAIzTvtSAUPwc=;
        b=Wq7+fR8VYl4OasZBUIuqEW7N2sWm2y/NBoNxP+fTgXI4n5LgLXb5ZTOKDbDv709v7F
         aKA7He0V1+9fJEsYPln82kpL1mXlL11PCeenruemboA5sk6hru2H5EAP8nOjuzR46Mzf
         imf8SWOrZxZ0eiYrPfeyx1OeTlVPtG15qOWPAq7gYBBy71JiXYWB9zlWmFiW7PFNkryv
         NDIRoISI5A8bnlMNcvcWGpIKnapABdZVWDQl3IspQ2Dv4YLtzjsBr23jZCRfCLPNBo7p
         Xpj9ALLavF1IQSc+gHPteSNSrgzCSepBON3gIJlQloDsD6MkCXS0cMMOZ7X5Y/ECZsvT
         HlyA==
X-Gm-Message-State: AOAM533hSdMsnxU+pX5hRApJRUPH/YJjuXjwcP40XX3wIwxv9hAQzUkP
        djDC5LYbRVMYDysh3853hwQib50FvSM=
X-Google-Smtp-Source: ABdhPJx8E9EjB462zbOAk8PB79UYBfQFQ/62WZOVYGG7MGft28DXaGgUE/kLjNhiJxz7nTXv/LAx1w==
X-Received: by 2002:a67:68d2:: with SMTP id d201mr600862vsc.186.1597246037579;
        Wed, 12 Aug 2020 08:27:17 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id u82sm269694vsc.1.2020.08.12.08.27.16
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 08:27:16 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id e20so723055uav.3
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 08:27:16 -0700 (PDT)
X-Received: by 2002:ab0:623:: with SMTP id f32mr12995280uaf.121.1597246036006;
 Wed, 12 Aug 2020 08:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
 <20200811135801.GA416071@kroah.com> <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
 <20200811145816.GA424033@kroah.com> <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
 <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
In-Reply-To: <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 12 Aug 2020 08:27:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
Message-ID: <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Wed, Aug 12, 2020 at 7:53 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Doug,
>
> On Tue, 11 Aug 2020 at 22:46, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Aug 11, 2020 at 7:58 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Aug 11, 2020 at 07:59:24PM +0530, Sumit Garg wrote:
> > > > Hi Greg,
> > > >
> > > > Thanks for your comments.
> > > >
> > > > On Tue, 11 Aug 2020 at 19:27, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Aug 11, 2020 at 07:20:26PM +0530, Sumit Garg wrote:
> > > > > > On Tue, 21 Jul 2020 at 17:40, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > > > >
> > > > > > > Make it possible for UARTs to trigger magic sysrq from an NMI. With the
> > > > > > > advent of pseudo NMIs on arm64 it became quite generic to request serial
> > > > > > > device interrupt as an NMI rather than IRQ. And having NMI driven serial
> > > > > > > RX will allow us to trigger magic sysrq as an NMI and hence drop into
> > > > > > > kernel debugger in NMI context.
> > > > > > >
> > > > > > > The major use-case is to add NMI debugging capabilities to the kernel
> > > > > > > in order to debug scenarios such as:
> > > > > > > - Primary CPU is stuck in deadlock with interrupts disabled and hence
> > > > > > >   doesn't honor serial device interrupt. So having magic sysrq triggered
> > > > > > >   as an NMI is helpful for debugging.
> > > > > > > - Always enabled NMI based magic sysrq irrespective of whether the serial
> > > > > > >   TTY port is active or not.
> > > > > > >
> > > > > > > Currently there is an existing kgdb NMI serial driver which provides
> > > > > > > partial implementation in upstream to have a separate ttyNMI0 port but
> > > > > > > that remained in silos with the serial core/drivers which made it a bit
> > > > > > > odd to enable using serial device interrupt and hence remained unused. It
> > > > > > > seems to be clearly intended to avoid almost all custom NMI changes to
> > > > > > > the UART driver.
> > > > > > >
> > > > > > > But this patch-set allows the serial core/drivers to be NMI aware which
> > > > > > > in turn provides NMI debugging capabilities via magic sysrq and hence
> > > > > > > there is no specific reason to keep this special driver. So remove it
> > > > > > > instead.
> > > > > > >
> > > > > > > Approach:
> > > > > > > ---------
> > > > > > >
> > > > > > > The overall idea is to intercept serial RX characters in NMI context, if
> > > > > > > those are specific to magic sysrq then allow corresponding handler to run
> > > > > > > in NMI context. Otherwise, defer all other RX and TX operations onto IRQ
> > > > > > > work queue in order to run those in normal interrupt context.
> > > > > > >
> > > > > > > This approach is demonstrated using amba-pl011 driver.
> > > > > > >
> > > > > > > Patch-wise description:
> > > > > > > -----------------------
> > > > > > >
> > > > > > > Patch #1 prepares magic sysrq handler to be NMI aware.
> > > > > > > Patch #2 adds NMI framework to serial core.
> > > > > > > Patch #3 and #4 demonstrates NMI aware uart port using amba-pl011 driver.
> > > > > > > Patch #5 removes kgdb NMI serial driver.
> > > > > > >
> > > > > > > Goal of this RFC:
> > > > > > > -----------------
> > > > > > >
> > > > > > > My main reason for sharing this as an RFC is to help decide whether or
> > > > > > > not to continue with this approach. The next step for me would to port
> > > > > > > the work to a system with an 8250 UART.
> > > > > > >
> > > > > >
> > > > > > A gentle reminder to seek feedback on this series.
> >
> > It's been on my list for a while.  I started it Friday but ran out of
> > time.  This week hasn't been going as smoothly as I hoped but I'll
> > prioritize this since it's been too long.
> >
>
> No worries and thanks for your feedback.
>
> >
> > > > > It's the middle of the merge window, and I can't do anything.
> > > > >
> > > > > Also, I almost never review RFC patches as I have have way too many
> > > > > patches that people think are "right" to review first...
> > > > >
> > > >
> > > > Okay, I understand and I can definitely wait for your feedback.
> > >
> > > My feedback here is this:
> > >
> > > > > I suggest you work to flesh this out first and submit something that you
> > > > > feels works properly.
> > >
> > > :)
> > >
> > > > IIUC, in order to make this approach substantial I need to make it
> > > > work with 8250 UART (major serial driver), correct? As currently it
> > > > works properly for amba-pl011 driver.
> > >
> > > Yes, try to do that, or better yet, make it work with all serial drivers
> > > automatically.
> >
> > A bit of early feedback...
> >
> > Although I'm not sure we can do Greg's "make it work everywhere
> > automatically", it's possible you could get half of your patch done
> > automatically.  Specifically, your patch really does two things:
> >
> > a) It leaves the serial port "active" all the time to look for sysrq.
> > In other words even if there is no serial client it's always reading
> > the port looking for characters.  IMO this concept should be separated
> > out from the NMI concept and _could_ automatically work for all serial
> > drivers.  You'd just need something in the serial core that acted like
> > a default client if nobody else opened the serial port.  The nice
> > thing here is that we go through all the normal code paths and don't
> > need special cases in the driver.
>
> Okay, will try to explore this option to have default serial port
> client. Would this client be active in normal serial operation or only
> active when we have kgdb active? One drawback I see for normal
> operation could be power management as if user is not using serial
> port and would like to disable corresponding clock in order to reduce
> power consumption.

If I could pick the ideal, I'd say we'd do it any time the console is
configured for that port and magic sysrq is enabled.  Presumably if
they're already choosing to output kernel log messages to the serial
port and they've enabled magic sysrq they're in a state where they'd
be OK with the extra power of also listening for characters?


> > b) It enables NMI for your particular serial driver.  This seems like
> > it'd be hard to do automatically because you can't do the same things
> > at NMI that you could do in a normal interrupt handler.
>
> Agree.
>
> >
> > NOTE: to me, a) is more important than b) (though it'd be nice to have
> > both).  This would be especially true the earlier you could make a)
> > work since the main time when an "agetty" isn't running on my serial
> > port to read characters is during bootup.
> >
> > Why is b) less important to me? Sure, it would let you drop into the
> > debugger in the case where the CPU handling serial port interrupts is
> > hung with IRQs disabled, but it _woudln't_ let you drop into the
> > debugger in the case where a different CPU is hung with IRQs disabled.
> > To get that we need NMI roundup (which, I know, you are also working
> > on for arm64).  ...and, if we've got NMI roundup, presumably we can
> > find our way into the debugger by either moving the serial interrupt
> > to a different CPU ahead of time or using some type of lockup detector
> > (which I know you are also working on for arm64).
> >
>
> Thanks for sharing your preferences. I will try to get a) sorted out first.
>
> Overall I agree with your approaches to debug hard-lockup scenarios
> but they might not be so trivial for kernel engineers who doesn't
> posses kernel debugging experience as you do. :)
>
> And I still think NMI aware magic sysrq is useful for scenarios such as:
> - Try to get system information during hard-lockup rather than just
> panic via hard-lockup detection.
> - Do normal start/stop debugger activity on a core which was stuck in
> hard-lockup.
> - Random boot freezes which are not easily reproducible.

Don't get me wrong.  Having sysrq from NMI seems like a good feature
to me.  That being said, it will require non-trivial changes to each
serial driver to support it and that means that not all serial drivers
will support it.  It also starts requiring knowledge of how NMIs work
(what's allowed in NMI mode / not allowed / how to avoid races) for
authors of serial drivers.  I have a bit of a worry that the benefit
won't outweigh the extra complexity, but I guess time will tell.  One
last worry is that I assume that most people testing (and even
automated testing labs) will either always enable NMI or won't enable
NMI.  That means that everyone will be only testing one codepath or
the other and (given the complexity) the non-tested codepath will
break.

Hrm.  Along the lines of the above, though: almost no modern systems
are uniprocessor.  That means that even if one CPU is stuck with IRQs
off it's fairly likely that some other CPU is OK.  Presumably you'd
get almost as much benefit as your patch but with more done
automatically if you could figure out how to detect that the serial
interrupt isn't being serviced and re-route it to a different CPU.
...or possibly you could use some variant of the hard lockup detector
and move all interrupts off a locked up CPU?  You could make this an
option that's "default Y" when kgdb is turned on or something?


> > One last bit of feedback is that I noticed that you didn't try to
> > implement the old "knock" functionality of the old NMI driver that's
> > being deleted.  That is: your new patches don't provide an alternate
> > way to drop into the debugger for systems where BREAK isn't hooked up.
> > That's not a hard requirement, but I was kinda hoping for it since I
> > have some systems that haven't routed BREAK properly.  ;-)
> >
>
> Yeah, this is on my TODO list to have a kgdb "knock" functionality to
> be implemented via a common hook in serial core.
>
> >
> > I'll try to get some more detailed feedback in the next few days.
>
> Thanks. I do look forward to your feedback.
>
> -Sumit
>
> >
> > -Doug
