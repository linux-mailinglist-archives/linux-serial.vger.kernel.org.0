Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2160E255D10
	for <lists+linux-serial@lfdr.de>; Fri, 28 Aug 2020 16:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgH1Ovk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 28 Aug 2020 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgH1Ovf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Aug 2020 10:51:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6687DC061232
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2020 07:51:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v12so1600105ljc.10
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2020 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImiWhFwiMiRaDILGK2vYxwtK6H1QbPrDWNEB8Fo5yp0=;
        b=m3SH83JhPp5zysOZ8UGaOASaGvHwyBdy+dMZYhDz9IjeZrOUNDL7DGC2IYkYpae6UT
         FpGAiEisi2hdICi2QBwVlxCRBlQYajQ6kIl3apwv6Zd5zwaMsm+woTJe0VxhXsJCBmVB
         /Krz+up/rlea+pltJEx57NrY0mSwXBmgaoM8eBGVocnnO/EabniaNW7LYGT8om9EynVv
         CIC9WHLTJ4TqH3GGF/DLZDlPvjr7OZ+u5Gmua0OvS7bbxfJ/KVP9l6u2f80iB9oWA4S5
         XcREjqO8mQbwzNglMH6NjTAUpG2SBhzd1ox2KvfQMgaZMf3Rcty3gxm60W7RrjIkgx2T
         DCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImiWhFwiMiRaDILGK2vYxwtK6H1QbPrDWNEB8Fo5yp0=;
        b=t4hqZ9B+Gfw0EXgEb0if+JMrE0wYEH+ULNO9JCYoiMH9nh+/0tDt6kmiHVNZ7VDcFz
         OPg00T9DxRoc/Sw9smhRhMoxWwp7Jq3WJQxi0QkFE+d+W7HsJmFtvIvd2J14lP5HN7Z6
         aybx2BlJcCsuYN2ClSOz5CdDc/fDPUr0w+U5+NaTdSJtY7kYlgfp8ADVf9w3fsUBYUS9
         qWkFaKR30pBAe0PEsh9b4AYCVwFPsNBgDQieOsNk8fMpWfEYu0oUES8wxPf0VaRKGvKT
         K+95KAQfE9l0Nqr36Gn6ji+CkWm4sp2xW9bF43NkAPo3DYWWmBi+1vK1DXn5MF5yEDRY
         OlpA==
X-Gm-Message-State: AOAM5331+6endLr5VgsauPvF+4dwyuwEyBUecIaIEUctj0U81DGhipow
        yGVUxC3ubMd9x6/RF+j+zaBS/yicOMXfs2n0n1pm7A==
X-Google-Smtp-Source: ABdhPJz7nqwPZB2YVbmFth99db1dEuQGwLTN+Hy4/7RmCxHXULzHeBqpJLldBTh4ZZ0VSRoDavwoeUh9uKGkK6yVJPw=
X-Received: by 2002:a2e:9dd0:: with SMTP id x16mr1026817ljj.144.1598626291535;
 Fri, 28 Aug 2020 07:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200825193536.7332-1-krzk@kernel.org> <CACRpkdb4j2kJvpY23G-os9gTktZW5HT287MsvMZxC=ovgn_9LQ@mail.gmail.com>
 <20200828130837.GA14163@kozik-lap>
In-Reply-To: <20200828130837.GA14163@kozik-lap>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:51:20 +0200
Message-ID: <CACRpkdaWAzJQz_Z1zsRbyVQNPO2wUogH8U_mDNV2fSkW22zmtQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] dt-bindings / arm64: Cleanup of i.MX 8 bindings
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 28, 2020 at 3:08 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, Aug 28, 2020 at 02:51:20PM +0200, Linus Walleij wrote:
> > On Tue, Aug 25, 2020 at 9:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > > This is a v3 of cleanup of i.XM 8 bindings and DTSes.
> >
> > If you are going to be working a lot on Freescale SoC code going forward
> > I wouldn't mind if you could add yourself as maintainer for the
> > Freescale pin controller and GPIO at least, I already have high trust
> > in you in general so if the Freescale maintainers also have that I think you
> > should just sign up as maintainer. This makes it easier to do pull requests
> > and things like that.
>
> Thanks for encouragement.  Indeed I am planning to do more work around
> i.MX 8M platforms from NXP/Freescale. However there are already four
> maintainers for Freescale pin controller drivers so I doubt there is
> need for fifth entry :).

I beg to differ. As subsystem maintainer it has happened to me more
than once that the i.MX pin control patches went unreviewed for weeks.
Everyone listed for this driver is a kitchen sink maintainer that get
way too much traffic and things fall over the edge.

> Different question is the GPIO driver which apparently lacks entry in
> Maintainers file.

That's probably just an oversight. Feel free to add it!

Yours,
Linus Walleij
