Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF6E12A7DA
	for <lists+linux-serial@lfdr.de>; Wed, 25 Dec 2019 13:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfLYMxL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 25 Dec 2019 07:53:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46801 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfLYMxL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Dec 2019 07:53:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id k8so12108879otl.13;
        Wed, 25 Dec 2019 04:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFjlEPTID7+wvGwi4O8XdLzo/j62NZIF2USQQuU9w9M=;
        b=Sc2pcOF3376eDsOqdpUZbNhwMHJsdgAMfozUlSuD6ku9yG13IU7vB9T4F17TxAr+jU
         sM4c1XJutX/HfdzNb6hZngn6BUv8N6t0MbC4zZDYBWHicMXSh0t3H2Us2M584PKQ6KYz
         Ihjky+LaFbgI1PoXYsmAC2EIcuTefPzWuqtKroZkgxf5qyyb6YwRgjVAsKxywY5frAW1
         DoYhEgrx1U6FkRHwrLqR5/rAGnL6tj7FwqS465r6uczIeLbn++cqF/XOCYiiZcUa4afI
         JzDd88jutE7hMVOtNV7dvd1KrDdk0gsQ/IEqCLQhaFSnweFG2IqR63DiBOGWgRNvjL2z
         yHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFjlEPTID7+wvGwi4O8XdLzo/j62NZIF2USQQuU9w9M=;
        b=Lj9UMKbUriqrEo2D2x8Gt0LF1zzf+8r1QKScknlLMOAHKLVbhA9zzKbnY5kDkILYJU
         narKR/S/1cLp0nX2B3TWHkkzkzucbCi1Et4zFM6aaA71R5ubwE8HbE2C7Ue8WZMgiAOO
         Xw0VKRvCItgtR+bwNOy09/30RNj+bWbOS+uM9dCYyM27At1It+LFstSDG+xAaMXibj9R
         e/UK8has4/Rk40lMNzdlmJ68ZVztUYCbPEhkJpOg5kREEjcWZMjsMCU847WUNO7UOoUL
         0eTSzP++HahkayHmH21iiU40Wy2F1PIh2LWyNu7qBW9Vmv+f1tJcJ8SSwLXTYbfxB2S8
         Bgxw==
X-Gm-Message-State: APjAAAXn64TUUWAShcdt1+wKX8KfJliFLEwRAmpfjpFg3TH9bRtltwQ/
        zHDuEXzTXZ8sQvcNjZQLXAA88J6ljvXhIYSteyA1wXRA6II=
X-Google-Smtp-Source: APXvYqz835znKdLdeEWba5fSr4HZoY649al6kisLYRQz09swIr5xk2ZSY1c0KFjwM7tIWRyIihSVPBSspeBWhs6w2oE=
X-Received: by 2002:a9d:3f61:: with SMTP id m88mr28771702otc.56.1577278390716;
 Wed, 25 Dec 2019 04:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20191220070747.GA2190169@kroah.com> <CAHk-=whcLH7EXVZbD0g1Bw7McrofQ-7vwiL2GAeMn=z9PP4VEQ@mail.gmail.com>
 <20191223120651.GC114474@kroah.com>
In-Reply-To: <20191223120651.GC114474@kroah.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 25 Dec 2019 12:52:34 +0000
Message-ID: <CADVatmPA-eYzzTQoOkgVSyi0D0PQo78oQjWJFmWMuMJ4HeU_qg@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.5-rc3
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 23, 2019 at 12:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Dec 20, 2019 at 10:08:03AM -0800, Linus Torvalds wrote:
> > On Thu, Dec 19, 2019 at 11:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > The last tty core fix should resolve a long-standing bug with a race
> > > at port creation time that some people would see, and Sudip finally
> > > tracked down.
> >
> > Hmm, looks good. But it makes me wonder if we should now try to remove
> > the second call to tty_port_link_device()?
> >
> > Now we have a number of helpers that do that tty_port_link_device()
> > call for the driver (eg tty_port_register_device_attr_serdev(),
> > tty_port_register_device_attr(), and the just added
> > uart_add_one_port()).
> >
> > But we also have drivers doing it by hand, and presumably we now have
> > drivers that do it through multiple paths? I guess it's harmless, but
> > it feels a bit odd. No?
>
> It does.  I'll try to look at this after the holidays unless Sudip beats
> me to it.

A regression reported by Kenny for this change. I have sent him a patch to test.
I think that has to go in rc4. Will remove the second call after he has tested.


--
Regards
Sudip
