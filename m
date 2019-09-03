Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40514A6509
	for <lists+linux-serial@lfdr.de>; Tue,  3 Sep 2019 11:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfICJVG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 3 Sep 2019 05:21:06 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44007 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfICJVG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Sep 2019 05:21:06 -0400
Received: by mail-oi1-f194.google.com with SMTP id t84so2453838oih.10
        for <linux-serial@vger.kernel.org>; Tue, 03 Sep 2019 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glcXCjwyqn+HnwC7gVzkRUcxL2AdvVixrYcSTi4w1PU=;
        b=mcK3nweohShcW2LEUMICZbVwxHtOCjxDYckZO4FfQk37KTz/3nkpuLr77dDXYzZxz4
         or6nYv7Vg04A1VkSOntYcSGuOqoqBc18fkMHF5EOKyAIqXvwp60PwkudRRdzqpEHTOFk
         JLUS6thW/ybzyOX6jTAyx3Unl97exqbMOO6GeRaRFWf1SY5GCKm30eGiO8rfMkr3asm9
         n9ZKT/aUSiJNjGdOwETM2FY7y6I/HELN4jGiEPOdSvReA9SfLXUItg4zcRumbYr8rFLS
         AISiYddP9X8DEDcdhNBOCX3wfjYOsXuM5YhVNqcg7RQCwdHTaQXTkVVoWXBZTuA8RhFS
         X7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glcXCjwyqn+HnwC7gVzkRUcxL2AdvVixrYcSTi4w1PU=;
        b=ddt/d8xssBT5qycMDKgFuLexUV5IVuEullco2nRZSIUnVjfRGWK9l1W5n5E0htmQD1
         f0vp8fQv5wiP5F+9wjWA0bLM0sxPb2+HkmI0pDvqO1iPkDHmvObWNp9k3Jb0+e7R6ZbB
         WS+FPsxELpZfHN39s5VaFzBO/xv3/TaHXKuoRQxTMrtKfXPDqnzJBjg1T2hCfDT+ph0f
         3WE7iS3YU7EwTmwk5b2szIJQ2vGAj38s1xj18vlcsyk24QWeaDddE/u6xww+dnkLwzz8
         28Jbn+IDaYG8S/nDtDva4aSjCILP427diu8xzkjaFeZZEv/V90G2jtp9vE4hAOgvXQ8J
         fFUA==
X-Gm-Message-State: APjAAAWk+xArp1B1VOKw7BzOxtexJXYNCaRw+nQ2MtedX7iNGY98FZWM
        +TVjk29pyiAlslmSN4uGmARY1BWQjxMLRFtdYmmOXA==
X-Google-Smtp-Source: APXvYqzo2nUjiHesbwnB0H1Z1h3L+spUHg2mts+oMbRKV6XXnJiqEYS55mFoFRlt4i5wbRS3LbqfxQhk9ndU172nJWQ=
X-Received: by 2002:aca:e183:: with SMTP id y125mr14148339oig.27.1567502465778;
 Tue, 03 Sep 2019 02:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190826072929.7696-1-zhang.lyra@gmail.com>
In-Reply-To: <20190826072929.7696-1-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 3 Sep 2019 17:20:54 +0800
Message-ID: <CAMz4ku+j-pSnfp1SJ4WN5seYe=vXxLGH+khaGNrseXi8+WKkoA@mail.gmail.com>
Subject: Re: [PATCH 0/3] keep console alive even if missing the 'enable' clock
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 26 Aug 2019 at 15:29, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> After the commit 4007098f4ce4 (serial: sprd: Add power management for the Spreadtrum serial controller),
> the 'enable' clock was forced to be configured in device tree, otherwise the uart devices couldn't be
> probed successfully.
>
> With this patch-set, the uart device which is used as console would be allowed to register even without
> any clock configured in device tree, this will make debug easier.

Tested on my board, works well and looks good to me. So for the whole series:
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>

>
> Chunyan Zhang (3):
>   serial: sprd: check the right port and membase
>   serial: sprd: add console_initcall in sprd's uart driver
>   serial: sprd: keep console alive even if missing the 'enable' clock
>
>  drivers/tty/serial/sprd_serial.c | 42 ++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> --
> 2.20.1
>


-- 
Baolin Wang
Best Regards
