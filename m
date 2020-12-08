Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1925B2D2925
	for <lists+linux-serial@lfdr.de>; Tue,  8 Dec 2020 11:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgLHKq0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Tue, 8 Dec 2020 05:46:26 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40367 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgLHKq0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Dec 2020 05:46:26 -0500
Received: by mail-oi1-f195.google.com with SMTP id p126so18933916oif.7
        for <linux-serial@vger.kernel.org>; Tue, 08 Dec 2020 02:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TRSPxWwnawG7bt2DFsAqoAu1vhCNVXsWyCn6zN0iZg4=;
        b=AFaz5MIVxD6kLd2sWocO2n89ZwtgBSmORL9rdozK/DJubfG14b6byVvHMEtzMAFC8f
         HuqtRlIsH9bXXjxjZ7j/EUxmlCx0xzX3TCUIa/D0jPShJ3s7M/Iw8OqiEjqTygYEgPkG
         8vJwCFmwigIT9uqdIQsFTeLitrdDKuvrQT/enHEQlO67h7QiQH/IWNYBvxWczsufB6J5
         9aaxRitCmfwzTcwkc3rgF8ZrAAn9Pqklivz3iqf9AbBl5fOp2YO0VWf6I8WI9TF+8QDM
         MfHP4yeHWetREJAR0TOBuwcVRxGI5iuPUqVmdv9bMDWZ5ZibeNJxVItqBeDkWQ7eh8lL
         EYSg==
X-Gm-Message-State: AOAM531cYGYKEQ5/J3KZN1oP247Zp2DzR1rFUDTqLt111d4VU+SAToiU
        alWrIGwVIIFhWTXPrmBSkh/heXY/PjU7huXmwxs=
X-Google-Smtp-Source: ABdhPJwN8beRlN4LeWBfQZLfUNyLzDBsNEstJlqC12RuVz7YyScNeljVh/fTjzzBW5DkDmJ6EKBc7gHgUj7gm+l4N8o=
X-Received: by 2002:aca:ec09:: with SMTP id k9mr2125690oih.153.1607424344963;
 Tue, 08 Dec 2020 02:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20201125081352.25409-1-zajec5@gmail.com> <X74Uanu26sx4Hait@kroah.com>
 <6b107933-9ab1-7c46-c383-ed39b71b4ecb@gmail.com> <X74bxfji0uTZV8y9@kroah.com>
In-Reply-To: <X74bxfji0uTZV8y9@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Dec 2020 11:45:33 +0100
Message-ID: <CAMuHMdXA+B_=abXAzCt5m3djjhLpzuDEtEhF_8UYkm95hu_4PA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: bcm63xx: allow building on ARM64
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

On Wed, Nov 25, 2020 at 9:53 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Nov 25, 2020 at 09:38:50AM +0100, Rafał Miłecki wrote:
> > On 25.11.2020 09:23, Greg Kroah-Hartman wrote:
> > > On Wed, Nov 25, 2020 at 09:13:52AM +0100, Rafał Miłecki wrote:
> > > > From: Rafał Miłecki <rafal@milecki.pl>
> > > >
> > > > Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
> > > > is ARM64.
> > > >
> > > > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > > > ---
> > > >   drivers/tty/serial/Kconfig | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > > index 28f22e58639c..6907c5b17a0e 100644
> > > > --- a/drivers/tty/serial/Kconfig
> > > > +++ b/drivers/tty/serial/Kconfig
> > > > @@ -1133,7 +1133,8 @@ config SERIAL_TIMBERDALE
> > > >   config SERIAL_BCM63XX
> > > >           tristate "Broadcom BCM63xx/BCM33xx UART support"
> > > >           select SERIAL_CORE
> > > > - depends on MIPS || ARM || COMPILE_TEST
> > > > + depends on MIPS || ARM || ARM64 || COMPILE_TEST

Why not s/ARM64/ARCH_BCM4908/?

> > >
> > > Why do we have an arch dependancy at all now?
> >
> > From my experience "depends" is often used to limit symbol visibility to
> > applicable platforms only. I don't think Broadcom has any x86, risc, etc.
> > platforms so it's useless there.
> >
> > As for testing driver compilation on unused arch-s I thought that's what
> > COMPILE_TEST is for.
> >
> > Am I wrong there? I'm afraid we don't have clear Documentation on that.
> > Please kindly point me to some info if I'm wrong.
>
> If COMPILE_TEST is working for this driver, then trying to restrict it
> to a specific arch is usually pointless and the arch dependency can be
> removed, keeping patches like this from having to be made over time to
> add it to new arches :)
>
> > > > + default ARCH_BCM4908
> > >
> > > Really?  I thought we were getting rid of these "ARCH_platform_type" of

No we are not.

> > > things.  That's what a defconfig file is for, right?

FWIW, the arm64 defconfig file enables about everything, for all arm64
platforms.

> > I had to miss something, last time I checked Linus called defconfigs a
> > garbage and wanted to get rid of them:
> > https://lwn.net/Articles/391372/
> >
> > There are also no platform defconfigs in arch/arm64/ at all. Should I
> > handle it with arch/arm64/Kconfig.platforms and "select SERIAL_BCM63XX"?
>
> I thought we were trying to get rid of arm64 "platforms" as well.  My
> point being, why is this needed at all?

To prevent asking the user about a driver that is completely useless for
the system(s) the user is compiling a kernel for.

Do you want to let distros compile all arm/arm64-only SoC drivers for x86, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
