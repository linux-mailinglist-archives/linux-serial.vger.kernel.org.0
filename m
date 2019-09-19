Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FCAB71DC
	for <lists+linux-serial@lfdr.de>; Thu, 19 Sep 2019 05:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfISDV0 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 18 Sep 2019 23:21:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41195 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbfISDVZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Sep 2019 23:21:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so1998510ljg.8
        for <linux-serial@vger.kernel.org>; Wed, 18 Sep 2019 20:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SheHqmoXK4AdV5+vGmfATk2h64jzJnZ57gWh81c0NIc=;
        b=gCrPP6Fi5BklCd9AKcjCVM7EBrpNx5SlsnmQGIp1P5koL0rb9UcNwK95nWP1y0/6Oe
         qCcJr79PsfvUx5xaitoNXSEKiHAATB1qAh0Gc4uJokW5rTvyUoZO9P4GawTXM/hZfLaq
         ZQc8Nj0W01J1XuW8r3GTpNuzaCvW9bHbIxJUla/9EiXQcRAR+Icg6269/UNb867+Yh/Y
         UXaesxXt5gVDY1UlscuveA7VExQGe+zCSXkhWe89LsHIvffVmklgoi6VS7MG5yHgzgJ4
         fk3l6hG5SwOIixgVGxxZleSPcMiAJTMFwQgYlXVYl4OS7ZeURWZFXKcS7Hy0mBxxfYzN
         FooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SheHqmoXK4AdV5+vGmfATk2h64jzJnZ57gWh81c0NIc=;
        b=YqIXfgErLr4ZbSeJgNUk2Zu0dtG0RLo6XZ04QDKY+pKoPDG6IagZxTfYZNnVO36I6F
         LarxJ+QuO/f72HM+tmOFNTD1Y1mXlvhtvaXdtD+vZ8zt38IVZ3XrpCScBd7CgX9XTRzJ
         hpi5GQ/dzCymVXW7wm915FdJcLNokp0eTKpczRFuIIyLZAY3mEtezFJ98+DjDLANaKgp
         cjW1f4Tbn97facM+jzmfRMr6Q4agrIAVfGHLTuL8d8QaBdH30Cvdp8E6P/Vo8ja2tbz0
         x7bBvrvIMdIPD3Guza2M+rJNGTMFbpJ/xgbzszXgNA2TQwuz7G92N3yy4jbAuNLIm/De
         vtrw==
X-Gm-Message-State: APjAAAVw2+pyxVpjc7J1t91Q8GYbMXiwzze4zhNy2AphoC0v/hvquwVe
        2t4HktEV92vQZHvjETqj3RBzurPCNE8Ko4Dd6k/HGPpaV0QknQ==
X-Google-Smtp-Source: APXvYqwWowghwYhIrQ1FL9lka2e20bcYcODgGLF0/fNEgTO9LPyh72qtAP4i4AVtgXcoxa+OQYS206XvZvV/c7fwuHk=
X-Received: by 2002:a2e:9b4f:: with SMTP id o15mr4034070ljj.142.1568863282258;
 Wed, 18 Sep 2019 20:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <f112a741c053ac5fb0637e2f058be81e17f78ccc.1568862391.git.liuhhome@gmail.com>
In-Reply-To: <f112a741c053ac5fb0637e2f058be81e17f78ccc.1568862391.git.liuhhome@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 19 Sep 2019 11:21:07 +0800
Message-ID: <CAMz4kuJzYa_4TsvgdWo4nZ9ReroEf9+LCqQh4DD5jO8jfSnf3w@mail.gmail.com>
Subject: Re: [PATCH v2] serial: sprd: Add polling IO support
To:     Lanqing Liu <liuhhome@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
        =?UTF-8?B?5YiY5bKa5riFIChMYW5xaW5nIExpdSk=?= 
        <lanqing.liu@unisoc.com>, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Thu, 19 Sep 2019 at 11:10, Lanqing Liu <liuhhome@gmail.com> wrote:
>
> In order to access the UART without the interrupts, the kernel uses
> the basic polling methods for IO with the device. With these methods
> implemented, it is now possible to enable kgdb during early boot over serial.
>
> Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
> ---
> Change from v1:
>  - Add poll_init() support.

Looks good to me and the KGDB can work well on my board, so feel free
to add my tags:
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/tty/serial/sprd_serial.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 73d71a4..d833160 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -911,6 +911,34 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
>         }
>  }
>
> +#ifdef CONFIG_CONSOLE_POLL
> +static int sprd_poll_init(struct uart_port *port)
> +{
> +       if (port->state->pm_state != UART_PM_STATE_ON) {
> +               sprd_pm(port, UART_PM_STATE_ON, 0);
> +               port->state->pm_state = UART_PM_STATE_ON;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sprd_poll_get_char(struct uart_port *port)
> +{
> +       while (!(serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK))
> +               cpu_relax();
> +
> +       return serial_in(port, SPRD_RXD);
> +}
> +
> +static void sprd_poll_put_char(struct uart_port *port, unsigned char ch)
> +{
> +       while (serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
> +               cpu_relax();
> +
> +       serial_out(port, SPRD_TXD, ch);
> +}
> +#endif
> +
>  static const struct uart_ops serial_sprd_ops = {
>         .tx_empty = sprd_tx_empty,
>         .get_mctrl = sprd_get_mctrl,
> @@ -928,6 +956,11 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
>         .config_port = sprd_config_port,
>         .verify_port = sprd_verify_port,
>         .pm = sprd_pm,
> +#ifdef CONFIG_CONSOLE_POLL
> +       .poll_init      = sprd_poll_init,
> +       .poll_get_char  = sprd_poll_get_char,
> +       .poll_put_char  = sprd_poll_put_char,
> +#endif
>  };
>
>  #ifdef CONFIG_SERIAL_SPRD_CONSOLE
> --
> 1.9.1
>


-- 
Baolin Wang
Best Regards
