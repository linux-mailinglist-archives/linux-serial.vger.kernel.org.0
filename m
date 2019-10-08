Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F93CFC2F
	for <lists+linux-serial@lfdr.de>; Tue,  8 Oct 2019 16:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfJHORa (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 8 Oct 2019 10:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfJHOR3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Oct 2019 10:17:29 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B0121835;
        Tue,  8 Oct 2019 14:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570544249;
        bh=k4z9UTPnrwAqsKFn+N7lEY6KbuTPenqCQZ8tcmJoBhg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UTZUXZWmKAZ+ukH2V5cR5yyrA+9EdRZtK3FpVZAV4WniOq8YQvCkqeVoAdDyf69Qc
         o9g71ju8By4N/y/+jdb/34FLQN3VUYdRqi5Nl06xPEZK+r667vLIJj/NALBGqpqFwC
         gMpYCctOvHKsCCJqxdhpxMOA2H6//QkiJwPLHgZk=
Received: by mail-qk1-f171.google.com with SMTP id f16so16879541qkl.9;
        Tue, 08 Oct 2019 07:17:28 -0700 (PDT)
X-Gm-Message-State: APjAAAUsY3hcLhsxMJNs3s20aDl1GcLv7xgAaTEdaE5CgbarzKOS0AEQ
        ki6efhefY+pYjZ3fyrQP9iIZvO1oO/ZjtFU3Vg==
X-Google-Smtp-Source: APXvYqyTPIbp6uB/NbQrlXR7mbW5oj8qd3GbQh+SZbdKWrINRREVDB6tFYwAesJBD5TWAI4QGnzN+RkckREb5FLBngg=
X-Received: by 2002:a05:620a:7da:: with SMTP id 26mr27191277qkb.119.1570544248015;
 Tue, 08 Oct 2019 07:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191004151414.8458-1-krzk@kernel.org> <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
 <20191008125038.GA2550@pi3> <CAL_Jsq+GcsUWN6kjBLkyr1rHGh6_4=w6JL6+k7DBXkBcvHcSBw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+GcsUWN6kjBLkyr1rHGh6_4=w6JL6+k7DBXkBcvHcSBw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Oct 2019 09:17:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKBzZCShxx99aB4z15XYNbUionVicmfNNXEfq=iohWLCA@mail.gmail.com>
Message-ID: <CAL_JsqKBzZCShxx99aB4z15XYNbUionVicmfNNXEfq=iohWLCA@mail.gmail.com>
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

On Tue, Oct 8, 2019 at 9:05 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Oct 8, 2019 at 7:50 AM Krzysztof Kozlowski <krzk@kernel.org> wrot=
e:
> >
> > On Tue, Oct 08, 2019 at 07:38:14AM -0500, Rob Herring wrote:
> > > On Fri, Oct 4, 2019 at 10:14 AM Krzysztof Kozlowski <krzk@kernel.org>=
 wrote:
> > > >
> > > > The clkoutN names of clocks must be unique because they represent
> > > > unique inputs of clock multiplexer.
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml=
 b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > > index 73b56fc5bf58..d8e03716f5d2 100644
> > > > --- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > > @@ -53,8 +53,10 @@ properties:
> > > >        List of clock names for particular CLKOUT mux inputs
> > > >      minItems: 1
> > > >      maxItems: 32
> > > > -    items:
> > > > -      pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > > > +    allOf:
> > > > +      - items:
> > > > +          pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > > > +      - uniqueItems: true
> > >
> > > You shouldn't need the 'allOf', just add uniqueItems at the same leve=
l as items.
> >
> > If you mean something like:
> >   56     uniqueItems: true
> >   57     items:
> >   58       pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> >
> > Then the dt_binding_check fails:
> >
> > dev/linux/Documentation/devicetree/bindings/arm/samsung/pmu.yaml: prope=
rties:clock-names:
> > 'uniqueItems' is not one of ['$ref', 'additionalItems', 'additionalProp=
erties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', =
'deprecated', 'description', 'else', 'enum', 'items', 'if', 'minItems', 'mi=
nimum', 'maxItems', 'maximum', 'not', 'oneOf', 'pattern', 'patternPropertie=
s', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedPrope=
rties']
>
> I can add it.
>
> The other option is to fix this in the clock schema. I'm not sure if
> there's a need for duplicate clock-names. Seems unlikely. I'll test
> that.

Actually, clock-names is already set to be unique. Did you see otherwise?

Rob
