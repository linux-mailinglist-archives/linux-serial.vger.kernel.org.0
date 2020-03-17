Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD06B187972
	for <lists+linux-serial@lfdr.de>; Tue, 17 Mar 2020 07:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgCQGLR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 17 Mar 2020 02:11:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43151 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgCQGLR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 02:11:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id l13so16468503qtv.10;
        Mon, 16 Mar 2020 23:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6SkNgwCqAebbVAJl9bv5UZ5dPdxtFlnAG+5KSP4gmc=;
        b=HJOLD/KR0NV1PK5vKFzUbC0V69Lat/hEYtpWxcWyQowmO5NjNuQqxI/5hTQyHDCwkq
         JkO5R2lzr4Zj5nr6H3VhAGCcx3hC95rLpMDrOGCr1YAg473eRopUL6J/5e7qoPx1hTT9
         EGY6EI2prQpvQzckca4m00LX6ADOIgASgEYrKmXWVVIwy0T0gSx0bMfmbDhTGg6g6x52
         vWq5/R+Q3yLMjma9h/MDrukbgILdnO+K4N+MTtoe8IuAXEeyw00qr84nZgqzmzOTiMYC
         4MwHmdKbupz62qV7JRUqWr7PtoODs60LsBubN2r6JcjHzado6Ok/zqEG3r64S/OKKJKK
         pyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6SkNgwCqAebbVAJl9bv5UZ5dPdxtFlnAG+5KSP4gmc=;
        b=qbo7LqKnF37Fann7H2raZtfQlirhJM4ImHElfsEAwh8f+uksgwPWrcIFuLQfNiTuCZ
         xJ0rPxTuTiscr/DfiHInF0n+h2RvBXMJN/3CQbOANe3qaRI5EBGUDYZK+5W3FCG4u5vw
         dL5eyqbBeNkoMh+LUtrIRGgnWFODOM/ZwiuLcYv+qLXjQg/jTTJdZEYQL9JrOBkIr49P
         hWwASpqTUj1tfYPOhVhCJeHVykvKIhD+RReTN1Tkg4HKq3IDP0nepEX7LPdf8EmxcxTl
         OPqWyrGphyMkf4tDucze7PssLYQ1qViEgxR0dGSSSHx90O6agknzsEyM/AUC43mI4FrM
         SQSA==
X-Gm-Message-State: ANhLgQ0JeYRx2leu6jvmU1j7j+R5J1jZQu2d80PRaY0U9T3E++kyhPwe
        C+/SGUgHburwBWgic5CqFeNeD6YcZqYWxeHCOcU=
X-Google-Smtp-Source: ADFU+vu734UsKfrlZtvNx9WZNtBag5nkD4Wt7Wxt0yNwRS6VaVfMTI/QK2hFS3pMWY8POw3iAO1L3nHeM5fBeMuzCG8=
X-Received: by 2002:aed:2625:: with SMTP id z34mr3912809qtc.276.1584425476726;
 Mon, 16 Mar 2020 23:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200316101930.9962-1-zhang.lyra@gmail.com> <20200316101930.9962-3-zhang.lyra@gmail.com>
In-Reply-To: <20200316101930.9962-3-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 17 Mar 2020 14:11:05 +0800
Message-ID: <CADBw62oErEWn_67ZXj9z0sV8XKSrC3EfD6dnE3paJt=od4-yPg@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: sprd: remove __init from sprd_console_setup
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 16, 2020 at 6:19 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> The function sprd_console_setup() would be called from .probe() which can
> be called after freeing __init functions, for example the .probe() would
> return -EPROBE_DEFER since it depends on clock modules.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 18706333f146..914862844790 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1013,7 +1013,7 @@ static void sprd_console_write(struct console *co, const char *s,
>                 spin_unlock_irqrestore(&port->lock, flags);
>  }
>
> -static int __init sprd_console_setup(struct console *co, char *options)
> +static int sprd_console_setup(struct console *co, char *options)
>  {
>         struct sprd_uart_port *sprd_uart_port;
>         int baud = 115200;
> --
> 2.20.1
>


-- 
Baolin Wang
