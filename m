Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E57D24BEA
	for <lists+linux-serial@lfdr.de>; Tue, 21 May 2019 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfEUJoW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 May 2019 05:44:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37762 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUJoW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 May 2019 05:44:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id d10so10647208qko.4
        for <linux-serial@vger.kernel.org>; Tue, 21 May 2019 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijroMiTrkHXqlMfhn9SztkG7X6uOQ25XEQdTn0jnBnY=;
        b=oBKmmDSv00sKW7IyLYp9aV+eXwzB1AcB3oLXoQb04qQNrJpKL6G3m4XjLmqxzHzKOn
         pOq0CYNLqyuSfHmo0PEeaxQGPd11BZ472oJAL1G9Wp8yrbpJR85UDo2tBzPrgonP3Z4/
         drvT5ig+crfNE/69ftEi8C4DMbrEj+f0oQmoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijroMiTrkHXqlMfhn9SztkG7X6uOQ25XEQdTn0jnBnY=;
        b=g6yPrwVO9Nn0FPemC8N+badogk4iEFKa8LQEw6PgAZhJ+udNAQ3F+q6bWbHx2TcCW7
         qiVAp6WZQUl2e62PXzW99du5zvlo5HYh1pdmer7LtvS5TYxfAKjRsaYoWu5kbcEAvsYu
         ION7FCYeqtmquSpaMiHpjH56LGNhYSkjila3qlZ/l5llIHdfyQYXU7rUvfPOuQL6DXrg
         Cv2IOpMj9dXxzH957kQjfpAGcfmnVKJf9pWvRw7kfdDYidALcRxcGrtfC4i+RqyszoMl
         gwgXHK1dDR/X45V5vES/cYH38cPOcKLjX6THnj0ZIIU0HXSGYxra3dHcYYmqc5hWDyby
         52sw==
X-Gm-Message-State: APjAAAVlgt7k7Ul7mfRA0YHHnY9zwk/a7vXlo6YfDCxUj0Q02Jn5cy3D
        Uxes7KIs8tLL5uTX4HvansMfINMoWwJZ0ZTaes0xuA==
X-Google-Smtp-Source: APXvYqxJHoRHsB+jmV/hKJW19VMYhjx1IQg9Q7eOkF2Is+aUmsmuEFTIGhRYezCAUHfu9/0HEyav4atEdfXTYpBZJSs=
X-Received: by 2002:a37:af03:: with SMTP id y3mr3391061qke.296.1558431861328;
 Tue, 21 May 2019 02:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190521084701.100179-1-tientzu@chromium.org> <20190521084701.100179-3-tientzu@chromium.org>
In-Reply-To: <20190521084701.100179-3-tientzu@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 21 May 2019 17:44:10 +0800
Message-ID: <CANMq1KAa6mOFJdhdXjV73wE8et8Cj+W-b73w=1kPaxmS6iimow@mail.gmail.com>
Subject: Re: [PATCH 2/2] uart: mediatek: support Rx in-band wakeup
To:     Claire Chang <tientzu@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-serial@vger.kernel.org,
        changqi.hu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 21, 2019 at 4:47 PM Claire Chang <tientzu@chromium.org> wrote:
>
> In order to support Rx in-band wakeup, we need to enable irq wake on an
> edge sensitive interrupt of Rx pin before suspend and disable it when
> resuming.
>
> This interrupt is used only as wake source to resume the system when
> suspended. Note that the sent character will be lost as the controller is
> actually suspended.
>
> We use this to support wakeup on bluetooth. Bluetooth will repeatedly send
> 0xFD to wakeup host. Once host detects Rx falling, an interrupt is
> triggered, and the system leaves sleep state. Then, the bluetooth driver
> will send 0xFC to bluetooth and bluetooth can start to send normal HCI
> packets.
>
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 33 ++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 417c7c810df9..61892abf707d 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/serial_8250.h>
> @@ -70,6 +71,7 @@ struct mtk8250_data {
>  #ifdef CONFIG_SERIAL_8250_DMA
>         enum dma_rx_status      rx_status;
>  #endif
> +       int                     rx_wakeup_irq;
>  };
>
>  /* flow control mode */
> @@ -551,6 +553,8 @@ static int mtk8250_probe(struct platform_device *pdev)
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);
>
> +       data->rx_wakeup_irq = platform_get_irq(pdev, 1);
> +
>         return 0;
>  }
>
> @@ -572,15 +576,44 @@ static int mtk8250_remove(struct platform_device *pdev)
>  static int __maybe_unused mtk8250_suspend(struct device *dev)
>  {
>         struct mtk8250_data *data = dev_get_drvdata(dev);
> +       struct uart_8250_port *up = serial8250_get_port(data->line);
> +       int irq = data->rx_wakeup_irq;
> +       int err;
>
>         serial8250_suspend_port(data->line);
>
> +       pinctrl_pm_select_sleep_state(dev);
> +       if (irq >= 0) {
> +               err = enable_irq_wake(irq);
> +               if (err) {
> +                       dev_err(dev,
> +                               "failed to enable irq wake on IRQ %d: %d\n",
> +                               irq, err);
> +                       pinctrl_pm_select_default_state(dev);
> +                       serial8250_resume_port(data->line);
> +                       return err;
> +               }
> +       }
> +
>         return 0;
>  }
>
>  static int __maybe_unused mtk8250_resume(struct device *dev)
>  {
>         struct mtk8250_data *data = dev_get_drvdata(dev);
> +       int irq = data->rx_wakeup_irq;
> +       int err;
> +
> +       if (irq >= 0) {
> +               err = disable_irq_wake(irq);
> +               if (err) {
> +                       dev_err(dev,
> +                               "failed to disable irq wake on IRQ %d: %d\n",
> +                               irq, err);
> +                       return err;

I'd drop this return err in the resume path, still better to restore
the pinctrl and resume the port, even if we can't disable the irq_wake
(which, really, shouldn't happen if we could enable it earlier...).

Also, many other callers of disable_irq_wake just ignore the return
value, so maybe it's ok to do the same, but I'll let other people
comment.

> +               }
> +       }
> +       pinctrl_pm_select_default_state(dev);
>
>         serial8250_resume_port(data->line);
>
> --
> 2.21.0.1020.gf2820cf01a-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
