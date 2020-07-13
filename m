Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB0421BC67
	for <lists+linux-serial@lfdr.de>; Fri, 10 Jul 2020 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGJRjd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 10 Jul 2020 13:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJRjb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 13:39:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1322AC08C5DC
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 10:39:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so7387249ljn.4
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXuUczWFNlwPKehZIWXn30gRWiLBJgbemeVZ6SnUAcc=;
        b=H+fQVchtOQTAtj7qP/IRP93a2MdhdzCX+kqk9bAncYdhLuiymqoDTbVFJDni8bdQpW
         bnkmCwDyWeEU0Op/y1KIcZ2rsMu0mVcT3G48Ow4qQw8E9PMNaJYfexIG1RlD8Tpvf9VU
         MfU7LXYx4m5hygDtLlzwEm+bMw8uFlgaP7fOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXuUczWFNlwPKehZIWXn30gRWiLBJgbemeVZ6SnUAcc=;
        b=U5GZmNFsCuiDyypfORJWjwfBJ/26b1FnysTpAtHw2Bi3uyxPHwS1zrJpad7gqJMr1G
         6j/U8V4dCLTFLSm/KL+4J7TQtcuLR3GesWKxo4lLDcj3Yj4SAeTmKJ8qrw0M8a8YU+8w
         OorSt/eYjiXibm2tU8ilJIwDYbJzPqgKjVXP6dOQDPFjXo0ySeLNjL0XwiEjGl/8WmZN
         T/SYzswIyoYHQ+WhX421uvTpD4Y3QCalxlBBbAbg+ZINxZ7ckhSaRX2o8QfTYpD/LlZ8
         iYuE7i6XPJJ0GGOImM8kjs6rG57z0aR1Akve+3DjGLv0CGDtQSBh5Y+JwQGCL8f7FGOG
         fL2g==
X-Gm-Message-State: AOAM533awSUwzySd8TVxCX6CMYRKAq5d9oMIt/pY/yPCJvWKDEPCk0dp
        MvS4PopyTRAJwhzlL/qOYYj+WjYKxtw=
X-Google-Smtp-Source: ABdhPJyfI26WMO44gBZ/0ohQGI4uV+OeabuhPv/2R2D3/CDb0FeBQ5smj1Rl4w/j/S6DxzPuK5yOBA==
X-Received: by 2002:a05:651c:3d1:: with SMTP id f17mr13051731ljp.203.1594402769013;
        Fri, 10 Jul 2020 10:39:29 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 83sm2113199ljj.51.2020.07.10.10.39.26
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:39:27 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id d17so7391812ljl.3
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 10:39:26 -0700 (PDT)
X-Received: by 2002:a2e:b0ed:: with SMTP id h13mr30489580ljl.250.1594402765997;
 Fri, 10 Jul 2020 10:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200626200033.1528052-1-dianders@chromium.org> <20200626125844.1.I8546ecb6c5beb054f70c5302d1a7293484212cd1@changeid>
In-Reply-To: <20200626125844.1.I8546ecb6c5beb054f70c5302d1a7293484212cd1@changeid>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 10 Jul 2020 10:38:44 -0700
X-Gmail-Original-Message-ID: <CAE=gft7Q-KC2+9kGVT1k3BaAHZv61iWaeEODZEf7FnXX6i=1LA@mail.gmail.com>
Message-ID: <CAE=gft7Q-KC2+9kGVT1k3BaAHZv61iWaeEODZEf7FnXX6i=1LA@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: qcom_geni_serial: Make kgdb work even if UART
 isn't console
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        daniel.thompson@linaro.org,
        Akash Asthana <akashast@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        sumit.garg@linaro.org, Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 26, 2020 at 1:01 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> The geni serial driver had the rather sketchy hack in it where it
> would adjust the number of bytes per RX FIFO word from 4 down to 1 if
> it detected that CONFIG_CONSOLE_POLL was enabled (for kgdb) and this
> was a console port (defined by the kernel directing output to this
> port via the "console=" command line argument).
>
> The problem with that sketchy hack is that it's possible to run kgdb
> over a serial port even if it isn't used for console.
>
> Let's avoid the hack by simply handling the 4-bytes-per-FIFO word case
> for kdb.  We'll have to have a (very small) cache but that should be
> fine.
>
> A nice side effect of this patch is that an agetty (or similar)
> running on this port is less likely to drop characters.  We'll
> have roughly 4 times the RX FIFO depth than we used to now.
>
> NOTE: the character cache here isn't shared between the polling API
> and the non-polling API.  That means that, technically, the polling
> API could eat a few extra bytes.  This doesn't seem to pose a huge
> problem in reality because we'll only get several characters per FIFO
> word if those characters are all received at nearly the same time and
> we don't really expect non-kgdb characters to be sent to the same port
> as kgdb at the exact same time we're exiting kgdb.
>
> ALSO NOTE: we still have the sketchy hack for setting the number of
> bytes per TX FIFO word in place, but that one is less bad.  kgdb
> doesn't have any problem with this because it always just sends 1 byte
> at a time and waits for it to finish.  The TX FIFO hack is only really
> needed for console output.  In any case, a future patch will remove
> that hack, too.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 80 ++++++++++++++++++---------
>  1 file changed, 55 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 0300867eab7a..4610e391e886 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -103,11 +103,13 @@
>  #define DEFAULT_IO_MACRO_IO2_IO3_MASK          GENMASK(15, 4)
>  #define IO_MACRO_IO2_IO3_SWAP          0x4640
>
> -#ifdef CONFIG_CONSOLE_POLL
> -#define CONSOLE_RX_BYTES_PW 1
> -#else
> -#define CONSOLE_RX_BYTES_PW 4
> -#endif
> +struct qcom_geni_private_data {
> +       /* NOTE: earlycon port will have NULL here */
> +       struct uart_driver *drv;
> +
> +       u32 poll_cached_bytes;
> +       unsigned int poll_cached_bytes_cnt;
> +};
>
>  struct qcom_geni_serial_port {
>         struct uart_port uport;
> @@ -129,6 +131,8 @@ struct qcom_geni_serial_port {
>         int wakeup_irq;
>         bool rx_tx_swap;
>         bool cts_rts_swap;
> +
> +       struct qcom_geni_private_data private_data;
>  };
>
>  static const struct uart_ops qcom_geni_console_pops;
> @@ -264,8 +268,9 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
>         unsigned int baud;
>         unsigned int fifo_bits;
>         unsigned long timeout_us = 20000;
> +       struct qcom_geni_private_data *private_data = uport->private_data;
>
> -       if (uport->private_data) {
> +       if (private_data->drv) {
>                 port = to_dev_port(uport, uport);
>                 baud = port->baud;
>                 if (!baud)
> @@ -331,23 +336,42 @@ static void qcom_geni_serial_abort_rx(struct uart_port *uport)
>  }
>
>  #ifdef CONFIG_CONSOLE_POLL
> +
>  static int qcom_geni_serial_get_char(struct uart_port *uport)
>  {
> -       u32 rx_fifo;
> +       struct qcom_geni_private_data *private_data = uport->private_data;
>         u32 status;
> +       u32 word_cnt;
> +       int ret;
> +
> +       if (!private_data->poll_cached_bytes_cnt) {
> +               status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
> +               writel(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
>
> -       status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
> -       writel(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +               status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> +               writel(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
>
> -       status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> -       writel(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
> +               status = readl(uport->membase + SE_GENI_RX_FIFO_STATUS);
> +               word_cnt = status & RX_FIFO_WC_MSK;
> +               if (!word_cnt)
> +                       return NO_POLL_CHAR;
>
> -       status = readl(uport->membase + SE_GENI_RX_FIFO_STATUS);
> -       if (!(status & RX_FIFO_WC_MSK))
> -               return NO_POLL_CHAR;
> +               if (word_cnt == 1 && (status & RX_LAST))

I forget how the partial word snapping works. Are you sure you want
word_cnt == 1? I see qcom_geni_serial_handle_rx() looks at RX_LAST
independently as long as word_cnt != 0. I'm worried the hardware
allows one FIFO entry with say 2 bytes in it and RX_LAST set, but then
also piles new stuff in the FIFO behind it, so that word_cnt can be
>1.

Also I mostly reviewed the change on Gerrit, they seemed to be the
same. In this case it was easier to understand the indentation
changes. If there were gotchas between the Gerrit version and this
patch, let me know.
-Evan
