Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8887BCFBE2
	for <lists+linux-serial@lfdr.de>; Tue,  8 Oct 2019 16:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfJHOFr (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 8 Oct 2019 10:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfJHOFr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Oct 2019 10:05:47 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A4D21835;
        Tue,  8 Oct 2019 14:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570543545;
        bh=BSS0pP5TSRCvXx2PTe+19CYaQtXYwyol55cIo7m2kK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kew6HNvNZ6MlVZWAgDPneJGj58ojWZM9y1SNfNv2eqWdvrpd39CXDtv/nOjRtLDTn
         LXMWxGOtUr6RzWSRbP6C/c7tYxmpnY1iWy38I5FhwsOEecriIePU2URkPu38dZLjKK
         U8f9EO4J9PpFswvfVGwK3aBM5g1z582U/JNJ652A=
Received: by mail-qk1-f175.google.com with SMTP id z67so16822526qkb.12;
        Tue, 08 Oct 2019 07:05:45 -0700 (PDT)
X-Gm-Message-State: APjAAAVBzQgXdDemSni4DIsI/PRSJlx4Yl2TmqJD1kHHli8dfMhTZ/uJ
        +aK9lmFkLzoWLgW/MZ+GPQWLGkmU80scqA2x3w==
X-Google-Smtp-Source: APXvYqzmV2QKGWccGoICKAMKFwzAvk3BDhnCzy9bG1IFslKWjFwHSNzobfLRiSO2TBvO8XDayAdctf68UpVEJjgX+fE=
X-Received: by 2002:a05:620a:7da:: with SMTP id 26mr27130717qkb.119.1570543544639;
 Tue, 08 Oct 2019 07:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191004151414.8458-1-krzk@kernel.org> <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
 <20191008125038.GA2550@pi3>
In-Reply-To: <20191008125038.GA2550@pi3>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Oct 2019 09:05:32 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+GcsUWN6kjBLkyr1rHGh6_4=w6JL6+k7DBXkBcvHcSBw@mail.gmail.com>
Message-ID: <CAL_Jsq+GcsUWN6kjBLkyr1rHGh6_4=w6JL6+k7DBXkBcvHcSBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: samsung: Force clkoutN names to be
 unique in PMU
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 8, 2019 at 7:50 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Oct 08, 2019 at 07:38:14AM -0500, Rob Herring wrote:
> > On Fri, Oct 4, 2019 at 10:14 AM Krzysztof Kozlowski <krzk@kernel.org> w=
rote:
> > >
> > > The clkoutN names of clocks must be unique because they represent
> > > unique inputs of clock multiplexer.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b=
/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > index 73b56fc5bf58..d8e03716f5d2 100644
> > > --- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > @@ -53,8 +53,10 @@ properties:
> > >        List of clock names for particular CLKOUT mux inputs
> > >      minItems: 1
> > >      maxItems: 32
> > > -    items:
> > > -      pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > > +    allOf:
> > > +      - items:
> > > +          pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > > +      - uniqueItems: true
> >
> > You shouldn't need the 'allOf', just add uniqueItems at the same level =
as items.
>
> If you mean something like:
>   56     uniqueItems: true
>   57     items:
>   58       pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
>
> Then the dt_binding_check fails:
>
> dev/linux/Documentation/devicetree/bindings/arm/samsung/pmu.yaml: propert=
ies:clock-names:
> 'uniqueItems' is not one of ['$ref', 'additionalItems', 'additionalProper=
ties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'd=
eprecated', 'description', 'else', 'enum', 'items', 'if', 'minItems', 'mini=
mum', 'maxItems', 'maximum', 'not', 'oneOf', 'pattern', 'patternProperties'=
, 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedPropert=
ies']

I can add it.

The other option is to fix this in the clock schema. I'm not sure if
there's a need for duplicate clock-names. Seems unlikely. I'll test
that.

Rob
