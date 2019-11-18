Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42F9100DD7
	for <lists+linux-serial@lfdr.de>; Mon, 18 Nov 2019 22:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKRViR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 18 Nov 2019 16:38:17 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40860 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRViQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Nov 2019 16:38:16 -0500
Received: by mail-io1-f66.google.com with SMTP id p6so20571070iod.7
        for <linux-serial@vger.kernel.org>; Mon, 18 Nov 2019 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0l4HZKdtgXTRgqqDAlM3aIr0uwN5tbm3lAzGjvXOfU=;
        b=NypYyAXB48zj08S50RkTJaeZR3Xncpt6tIq+Kb/4Djegu9xgaoJKzsPa+MXaM8u6ie
         SSN73YK14XqKud+G+h7aCUnb9RS90oywdqpT7kDtyIw3NJXL+U9sjltlpeUVZs+VwSJD
         RlOJUTPJG1sQdOPfojNzDmPLO+HINTMODCsl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0l4HZKdtgXTRgqqDAlM3aIr0uwN5tbm3lAzGjvXOfU=;
        b=BIl7nRTGOenmXhxllJ4EyV83EaT7+P+wDBk5z/wRAS4RhgJwadhi4Z86AJX1A3Py85
         OhHLL55hmy1A5YoOPVl0cxsERCYWJdwgRbcIV7q1OXNoXUTabZWvn37QRp91pw0zFrd6
         HuCZcEk0jhB6SDplrVTZEVkpal/2RX58qmsFRJWPdx7AfaZfxOAqd/8Pv9KSxivshL7u
         L/RrqRcuy5YMghev3akVyTqxqARd6FRW0vLASDhenN6BxpLuWVFSauFth+XSGCBPfVF8
         zTDAYVOW38kTdaCefFCWPr61t33Y8+3A6XqWA/Jyywe8iAcI78koYJeGYpFbWuyLtm6a
         25jQ==
X-Gm-Message-State: APjAAAU0W/2yUjav2tsdsiMmA1EjSpDfcjnF4JNcdXmpIfIF9ulZVNHv
        4sojmHfdGF5yv164jVIdOzjlxr+oGqMY/2cfj3t0Wg==
X-Google-Smtp-Source: APXvYqxf9SXzdHA0asg8wxWMr4ymfFv3a2UwU9eZoumz/2tmxPZzqUOj9OT1SU9J52fkjxeMDd3pzwdgx8tsavlQlxM=
X-Received: by 2002:a02:ca57:: with SMTP id i23mr15043918jal.36.1574113095689;
 Mon, 18 Nov 2019 13:38:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHrpVsUHgJA3wjh4fDg43y5OFCCvQb-HSRpyGyhFEKXcWw8WnQ@mail.gmail.com>
 <CAHrpVsW6jRUYK_mu+dLaBvucAAtUPQ0zcH6_NxsUsTrPewiY_w@mail.gmail.com>
 <20191114095737.wl5nvxu3w6p5thfc@pathway.suse.cz> <20191115043356.GA220831@google.com>
In-Reply-To: <20191115043356.GA220831@google.com>
From:   Jonathan Richardson <jonathan.richardson@broadcom.com>
Date:   Mon, 18 Nov 2019 13:38:04 -0800
Message-ID: <CAHrpVsWu54rKg3bGhY6WVj5d-myYxGSEkxGhOJKTyyc1EH4qOA@mail.gmail.com>
Subject: Re: console output duplicated when registering additional consoles
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, sergey.senozhatsky@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 14, 2019 at 8:33 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> Gosh, that part of printk is really complex.
>
> On (19/11/14 10:57), Petr Mladek wrote:
> > For a proper solution we would need to match boot and real
> > consoles that write messages into the physical device.
> > But I am afraid that there is no support for this.
>
> Wouldn't those have same tty driver?
>
> ---
>
>  kernel/printk/printk.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index f1b08015d3fa..a84cb20acf42 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2690,6 +2690,19 @@ static int __init keep_bootcon_setup(char *str)
>
>  early_param("keep_bootcon", keep_bootcon_setup);
>
> +static bool known_console_driver(struct console *newcon)
> +{
> +       struct console *con;
> +
> +       for_each_console(con) {
> +               if (!(con->flags & CON_ENABLED))
> +                       continue;
> +               if (con->device && con->device == newcon->device)
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  /*
>   * The console driver calls this routine during kernel initialization
>   * to register the console printing procedure with printk() and to
> @@ -2828,6 +2841,9 @@ void register_console(struct console *newcon)
>         if (newcon->flags & CON_EXTENDED)
>                 nr_ext_console_drivers++;
>
> +       if (known_console_driver(newcon))
> +               newcon->flags &= ~CON_PRINTBUFFER;
> +
>         if (newcon->flags & CON_PRINTBUFFER) {
>                 /*
>                  * console_unlock(); will print out the buffered messages

Thanks. It also needs to be cleared when the second console driver is
registered (of the same type, boot or normal), not just when a normal
con replaces a bootconsole. A simple way of avoiding the problem I'm
seeing is to not even set the CON_PRINTBUFFER flag on my consoles. It
skips the replay and the output on all consoles looks fine. The flag
is only used by register_console(), although I don't think that is the
intended usage? There are no console drivers that do this.
