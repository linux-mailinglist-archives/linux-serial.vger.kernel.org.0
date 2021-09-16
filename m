Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909D740D714
	for <lists+linux-serial@lfdr.de>; Thu, 16 Sep 2021 12:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbhIPKJM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 16 Sep 2021 06:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbhIPKJL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Sep 2021 06:09:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8458C061766
        for <linux-serial@vger.kernel.org>; Thu, 16 Sep 2021 03:07:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p29so16315691lfa.11
        for <linux-serial@vger.kernel.org>; Thu, 16 Sep 2021 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUO5tSYLVRile5AWlAafA8DmhpHLLp7fGg/YtJNAKkA=;
        b=kb18yEmDjFeTISL5Cj3f+OE1reEAL0nH5XmyNUxp+vvOyzUcj+l9m5OworF15vyOXF
         b8YVBrLmGwq/u0XPPb8fk3JaoNhQe+7Ho6ZKojUxfMsvVZB1S+AXaj2bjkGQpTH2BDMF
         RFKGzdZkL5STdbXuztAsLUi82lROJaEFce1QQBJQFnJ6BNDzh73ydU6twoHnOf/LFIT6
         m36gdukOrXppQsBrmuso+yADYfJZDVaWVxIsFzYI2GyA9+KlNEDbRQnmoxutZH37cusb
         kMvPFWujPGOtbzPt0qbQ8UKq9xhYrz+jKKgOqdrQtVAmzqRwqbisq3ed603uxeTFFJJ1
         7TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUO5tSYLVRile5AWlAafA8DmhpHLLp7fGg/YtJNAKkA=;
        b=qcYrCz6FosyYcESGw0SZ7GpKwa7KHO3BK2kfDgevcMy9G7orgvYwFf0SGI/gjrkmeN
         egWq0m7dZL5XrjMHPndqUX8Y46jC5mD1yVJVRm9RgMsOEtnaqkN2jCyxVPL4XlMQ49RS
         rqKyhMU6zYoMq9WlN00XvPl98qY+ST/SPX1uVXD8uv4pAsSXkF7oKdddVFMKgV9O98DI
         ZxFFgEWXrhMCuSDZxA79Jw1FcfyDMV4tol5WhSh3xHQPzZLt5Z4JEsJMI3FI91zmqnLx
         OKsz+OXMdoM2fik8SQK/5C4DSl7G418mB0smVs1y5dARJL9c6n8Evy9KOdP6rvWzkS09
         dTgw==
X-Gm-Message-State: AOAM530tIWDlJ0MErIPJKKd2uZYdAvGzX8quAz3aCw8QsnbW9M3WrfZN
        InUrD4X50Z6NElXN8W2IigVtYWInt8RyQjD6h2pNWQ==
X-Google-Smtp-Source: ABdhPJytweAIsY0sxsinkWN7FPbeTdhVCteGXtpk0WGBS/7V1nIDt7Ry+vbrBBnhe783d+4wyWb3AQdWBV5/FDYn/9Q=
X-Received: by 2002:a05:6512:3096:: with SMTP id z22mr3486963lfd.584.1631786869054;
 Thu, 16 Sep 2021 03:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210914085137.31761-1-sam.shih@mediatek.com> <20210914085137.31761-5-sam.shih@mediatek.com>
In-Reply-To: <20210914085137.31761-5-sam.shih@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Sep 2021 12:07:38 +0200
Message-ID: <CACRpkdYkvBS5+MHSGBDhNQtvCxRquef1kPHmCSfzruz2N=VCyw@mail.gmail.com>
Subject: Re: [RESEND,v3,4/9] pinctrl: mediatek: moore: check if pin_desc is
 valid before use
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 14, 2021 at 10:52 AM Sam Shih <sam.shih@mediatek.com> wrote:

> Certain SoC are missing the middle part gpios in consecutive pins,
> it's better to check if mtk_pin_desc is a valid pin for the extensibility
>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Acked-by: Sean Wang <sean.wang@mediatek.com>

This patch applied for v5.16 so we get some stuff merged.

Yours,
Linus Walleij
