Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33733326E7
	for <lists+linux-serial@lfdr.de>; Mon,  3 Jun 2019 05:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFCDbh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 2 Jun 2019 23:31:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36652 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFCDbh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Jun 2019 23:31:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so10191668qkl.3
        for <linux-serial@vger.kernel.org>; Sun, 02 Jun 2019 20:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M2pM/nkf1A1euBtVWZMDLIqDbLGr66zihKn/vdYTjTQ=;
        b=UlW2uTB2hMdPcjBNNW5Lbo14ZXuAeoI4n/h8qMjd1qHsaoDYKe66yYTvfIWtY0fJHK
         dkvvwaUCGt5is3ltB0Srvsr2kbg+aKKvVqSifbv/YEeWZQmtb9fTzWAmfJqm82UinXGi
         RAb6CzCifI/b/d1BqBqQp8Iax55LjNHqbZkcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2pM/nkf1A1euBtVWZMDLIqDbLGr66zihKn/vdYTjTQ=;
        b=mjDc7kT8Qh5RvkmSTmraJhDXnY67md/SjAnWHi2BhQ4RggOX+8HJGUdBsR7nwEV12h
         HiFHbq0uDBEJ+BDdteXwMYMfxt4skhuzr6FlA97LhV/XQ0olQtzjRhEzceL6f4en2D4O
         umPaxr5YmOm4Y3pEuWil/vdXkIwbr8U3+4wttINmbvczcVQBCMUV3gHSFFVqn4rgrbgL
         E/pWjpfzYPyAQGP1ikQPdehY5cV5Jmx+NRyg3JWtHcIpSXMzU/jR/j3adbso//DL2ZoL
         RGbmfuT+5p4bnhZnR5MkiquJAN+5SEa91bS8mB/NZJcwv0QqTSwcc+c1jxTNHsJHdrYc
         QzEQ==
X-Gm-Message-State: APjAAAWgfW+wwFMuqtLgsI6A7vNBYD9iU6ARjieqmpZpVOUxOGZvziJM
        eSrbtNyn0k1KkQDhpsbthXkdDGiKT69C24Rkkj7Exw==
X-Google-Smtp-Source: APXvYqymK56mIsfk25HR9DGgVNvsNl7A358Z+rnD4UFU4EfXzBDVvfpl0srlguV90A6phujqMAsvuDwUioifOaAf590=
X-Received: by 2002:a37:4c04:: with SMTP id z4mr20217027qka.195.1559532696386;
 Sun, 02 Jun 2019 20:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190527083150.220194-1-tientzu@chromium.org> <20190527083150.220194-3-tientzu@chromium.org>
In-Reply-To: <20190527083150.220194-3-tientzu@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 3 Jun 2019 11:31:25 +0800
Message-ID: <CANMq1KAym_cp8vCJ0+OtxAMJmsFp1LXM15rcZdKEM+w6f92=aA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] uart: mediatek: support Rx in-band wakeup
To:     Claire Chang <tientzu@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 27, 2019 at 4:32 PM Claire Chang <tientzu@chromium.org> wrote:
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

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/tty/serial/8250/8250_mtk.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 417c7c810df9..5b94b853387d 100644
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
> @@ -572,15 +576,35 @@ static int mtk8250_remove(struct platform_device *pdev)
>  static int __maybe_unused mtk8250_suspend(struct device *dev)
>  {
>         struct mtk8250_data *data = dev_get_drvdata(dev);
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
> +
> +       if (irq >= 0)
> +               disable_irq_wake(irq);
> +       pinctrl_pm_select_default_state(dev);
>
>         serial8250_resume_port(data->line);
>
> --
> 2.22.0.rc1.257.g3120a18244-goog
>
