Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C552AF3E
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 09:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfE0HLy (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 03:11:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34887 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0HLy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 03:11:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so3586435qke.2
        for <linux-serial@vger.kernel.org>; Mon, 27 May 2019 00:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnAu7DMD33AWKWB4uXYa0NnuCZ18wB104ARVW507wCE=;
        b=AxrZ5wLCH1sL3HpIjPj0sFn4bZH73XLfgHEwkSGiELuA/Rm7aEMlgMOGs7rDwEwPZO
         jcsp2jq1T5QAAfWJ/cDYrDsf67zirWwNSPL+Z6LbkwoVwl+Sj2Ex4w4oEfbXi4gZ2Qyq
         B6QNFkk78c0ohTOGI/C6SK47GkbLNzy/IQk2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnAu7DMD33AWKWB4uXYa0NnuCZ18wB104ARVW507wCE=;
        b=g0LeaLTm85wza8T6RnRE5R1EezgL8+eHGZzTNrsSVawymS8fpZUP6BqodoeQ6XksV4
         3swy5Q+pt/d5ocj2NovuXkaVnwBazMlhEw64cJsIAKp6O2JjkBjSb00LwXZ9irS6gvWR
         Db/28ellu0/Gq+rm8yV+3SLXXmTw/H2NzldsP4FhXo3Z4zAVErj2PLvlLKD85fWA88t2
         hV13Q9mr0KXatXQlRSajWTgg/kKhU3JY2gJQ0vA6izN0VVJ2gB3H4GZC4HpDULCP2L7p
         iC7zmlyAZHR5HkxRNKpA0uiSuj8wsGPSK84fGfWzUAFnKpoza1A5dUKz1/2jwljiTvvr
         WIuQ==
X-Gm-Message-State: APjAAAU+jV0m9VXnhGntQ5KkOCubHa3nob3fwaULOT7THqujO/ZaJ8Lj
        dHiPvHSU74AfJHVJqyJW6yd3+X/icV4=
X-Google-Smtp-Source: APXvYqyNljbnJot6rQYOzUPXQ0qzwu38c4cwm8iPXNpENCb3vgTDFv/S3kUrFtP9vEJ7qenXuuh0Qw==
X-Received: by 2002:a0c:d04a:: with SMTP id d10mr20478512qvh.189.1558941112600;
        Mon, 27 May 2019 00:11:52 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id g15sm3438040qkl.2.2019.05.27.00.11.51
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 00:11:52 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id p18so16378902qkk.0
        for <linux-serial@vger.kernel.org>; Mon, 27 May 2019 00:11:51 -0700 (PDT)
X-Received: by 2002:ac8:1a9d:: with SMTP id x29mr1304701qtj.128.1558941111275;
 Mon, 27 May 2019 00:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190527065559.66056-1-tientzu@chromium.org> <20190527065559.66056-3-tientzu@chromium.org>
In-Reply-To: <20190527065559.66056-3-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Mon, 27 May 2019 15:11:40 +0800
X-Gmail-Original-Message-ID: <CALiNf2-Z+xnz4PB1jRbzWmG_EApOXbbAGBb53Rw==B-=fv25Gg@mail.gmail.com>
Message-ID: <CALiNf2-Z+xnz4PB1jRbzWmG_EApOXbbAGBb53Rw==B-=fv25Gg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] uart: mediatek: support Rx in-band wakeup
To:     gregkh@linuxfoundation.org
Cc:     changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> @@ -572,15 +576,36 @@ static int mtk8250_remove(struct platform_device *pdev)
>  static int __maybe_unused mtk8250_suspend(struct device *dev)
>  {
>         struct mtk8250_data *data = dev_get_drvdata(dev);
> +       struct uart_8250_port *up = serial8250_get_port(data->line);
Sorry. This line doesn't belong to this patch. I'll send a v3.

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
