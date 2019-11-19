Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D125D102BC6
	for <lists+linux-serial@lfdr.de>; Tue, 19 Nov 2019 19:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfKSShN (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 19 Nov 2019 13:37:13 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44932 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfKSShM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Nov 2019 13:37:12 -0500
Received: by mail-io1-f66.google.com with SMTP id j20so13348280ioo.11
        for <linux-serial@vger.kernel.org>; Tue, 19 Nov 2019 10:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48NxQ9DqPXE8NNblSh0ekMtCcPv6pfnlvSzVAtj6Tnc=;
        b=RMXEHvj3EoauWpOTHC9DGe2xoQbch3nIQRppx+5a165AAFr2pXgjUUUcZOaEHUPwVO
         EbptRRN5y8bbR5Tg/n04tP0tF49AfrZSxvH38R5PT69YyQHS9ID7YHSRFS9g7N8k6cIl
         mnyyWcmiq7sek6yIXKi7adOO9vcgTB0Aer4/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48NxQ9DqPXE8NNblSh0ekMtCcPv6pfnlvSzVAtj6Tnc=;
        b=q2uYQJeOQGNtcEj1YjCTioq7NnuvWGD+RV+TIT6oFXSCr6lOEHOpAH6ln2bpVKGsKn
         2J/jSXBinFuttgF1iQej4Wo8FoMfhMBefsm+EYyFjPfHuIFMqJGZ55jFUv0TQXceT8jV
         4ihnd1V0MBu7CGM3L2lBayqCjOmgLoL3L72mfvi4XbfxokLRrBRJ5BuGzNdMGR3+has/
         H41FXev4HQsXelA1V+2q3b8JaVt0mzd51UWmoER3SFNfa4IuuKVnucf12ievhvIbEshx
         0nGg/oqa17uMElAXsmr4LFHiSINl7xg3E9br3YlW/M2+g62OnfB5EV5zbzEaE4iIesZD
         V/8w==
X-Gm-Message-State: APjAAAXagpq/SfWGekCu1TzyWr0No4HTDikRiOz+fhTE2MvQY30YZ0DH
        v0OxSTt4CDStf8s2t65/HpdIF5vC4DYV08c/0kBpWA==
X-Google-Smtp-Source: APXvYqwYaIa41MQNB9e1+xoq9LMSDYgTQd8k/iRldb6PKHtKb3zsRsZfVSlY4FuBFaJw+EBwP4jzXXipsmNnY6w6UBQ=
X-Received: by 2002:a6b:7307:: with SMTP id e7mr3495492ioh.218.1574188630704;
 Tue, 19 Nov 2019 10:37:10 -0800 (PST)
MIME-Version: 1.0
References: <CAHrpVsUHgJA3wjh4fDg43y5OFCCvQb-HSRpyGyhFEKXcWw8WnQ@mail.gmail.com>
 <CAHrpVsW6jRUYK_mu+dLaBvucAAtUPQ0zcH6_NxsUsTrPewiY_w@mail.gmail.com>
 <20191114095737.wl5nvxu3w6p5thfc@pathway.suse.cz> <20191115043356.GA220831@google.com>
 <CAHrpVsWu54rKg3bGhY6WVj5d-myYxGSEkxGhOJKTyyc1EH4qOA@mail.gmail.com> <20191119113027.74lp3dsg5ftvylp4@pathway.suse.cz>
In-Reply-To: <20191119113027.74lp3dsg5ftvylp4@pathway.suse.cz>
From:   Jonathan Richardson <jonathan.richardson@broadcom.com>
Date:   Tue, 19 Nov 2019 10:36:59 -0800
Message-ID: <CAHrpVsXvENe_0-iQOsbopmNrqDnqNE72JKTdZ8qhQWi5575qJQ@mail.gmail.com>
Subject: Re: console output duplicated when registering additional consoles
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        sergey.senozhatsky@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 19, 2019 at 3:30 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2019-11-18 13:38:04, Jonathan Richardson wrote:
> > On Thu, Nov 14, 2019 at 8:33 PM Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com> wrote:
> > >
> > > Gosh, that part of printk is really complex.
> > >
> > > On (19/11/14 10:57), Petr Mladek wrote:
> > > > For a proper solution we would need to match boot and real
> > > > consoles that write messages into the physical device.
> > > > But I am afraid that there is no support for this.
> > >
> > > Wouldn't those have same tty driver?
>
> Interesting idea. Well, do early consoles have tty driver?
>
> > > ---
> > >
> > >  kernel/printk/printk.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index f1b08015d3fa..a84cb20acf42 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2690,6 +2690,19 @@ static int __init keep_bootcon_setup(char *str)
> > >
> > >  early_param("keep_bootcon", keep_bootcon_setup);
> > >
> > > +static bool known_console_driver(struct console *newcon)
> > > +{
> > > +       struct console *con;
> > > +
> > > +       for_each_console(con) {
> > > +               if (!(con->flags & CON_ENABLED))
> > > +                       continue;
> > > +               if (con->device && con->device == newcon->device)
> > > +                       return true;
> > > +       }
> > > +       return false;
> > > +}
> > > +
> > >  /*
> > >   * The console driver calls this routine during kernel initialization
> > >   * to register the console printing procedure with printk() and to
> > > @@ -2828,6 +2841,9 @@ void register_console(struct console *newcon)
> > >         if (newcon->flags & CON_EXTENDED)
> > >                 nr_ext_console_drivers++;
> > >
> > > +       if (known_console_driver(newcon))
> > > +               newcon->flags &= ~CON_PRINTBUFFER;
> > > +
> > >         if (newcon->flags & CON_PRINTBUFFER) {
> > >                 /*
> > >                  * console_unlock(); will print out the buffered messages
> >
> > Thanks.
>
> Jonathan, have you tried this patch, please?
> Does it solve your problem?

I've tried it and it doesn't solve the problem. newcon is not a known
console at the time I register my second console. The only thing I can
do is not replay the log by not setting CON_PRINTBUFFER and I
shouldn't have to do that after reading Sergey's last response.
