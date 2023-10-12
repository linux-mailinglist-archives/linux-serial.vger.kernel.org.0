Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1147C6C28
	for <lists+linux-serial@lfdr.de>; Thu, 12 Oct 2023 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbjJLLT4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Oct 2023 07:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347161AbjJLLTz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Oct 2023 07:19:55 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3246BC9
        for <linux-serial@vger.kernel.org>; Thu, 12 Oct 2023 04:19:54 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d122f6294so4946326d6.0
        for <linux-serial@vger.kernel.org>; Thu, 12 Oct 2023 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697109593; x=1697714393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNHmIfPj5WqNXPVt4ki8AWS+T3aJ218ouKELPyitkbw=;
        b=JphU1rxJHP/VNxswTXRm85oyTdRr0gGM6uwoAolfHLpGt/IhyLVX2gvzpzoGS1oCg4
         RfEBylw12KD4KbrBi+HNE3pXZZiJ6fbTf/4AVMuiuL5PaVO20l6XECTJZfhXaH+qenSm
         w6hZ4aN5n3+o7qio8nYDakyEWGUgagCQ9WPdoNOlDcoAnpKuuIY7MuoS7QxgqFHNcD0P
         zvVEX51ZiMM8MPDI0FrTL6qBVG8wU/TimS3UNu45kIr1saPRq2uQTesQYIhvmfDG2hSf
         Jx2gy8mOvpOu1NeMf6NCtj3OlVFRd2bSwXJ6XbLFJxKxzkh/LPbMymme4cA1XyfoIITu
         iq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697109593; x=1697714393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNHmIfPj5WqNXPVt4ki8AWS+T3aJ218ouKELPyitkbw=;
        b=Ju/nshM0kPl1NtLp/x4qmGJIHuH2oy8moeO5Z6n7EOnbRDAaLl8d/S6UPmoYLDErFC
         KSSdfRRxsZ4RkqECfuVum3UjwT3ybptYw7xqPe6N6ytUYlUnmXCV95/DyH3mstF9gSPO
         QN0KtNcFybG3bQlrDo8hsixSubRCxhzik3kzJuPsfahMks8NNFxnJJy2FiGsZFW9ErE5
         0M8NvGBhmjn0fFqWk6vbj17zPm8pWClvEgvVTR0TdGCNAFWEvqgs0D1AXVyScs5J2nK8
         O/YI2Nys6R7bw+8bzCyKwBlJRNX+WjsE7wUIYhpQ7m+UW2zXyjom+OLslDRxh5QnTUw/
         Cuhg==
X-Gm-Message-State: AOJu0Yz8p8hEUKzPa6h98a1eplAVTfOba23Zv+LiqT1y+worSOsm0fw4
        YVU8FFOqKMcySSPx/xyU8CrtC0XoQF2U7IOxAJLeNQ==
X-Google-Smtp-Source: AGHT+IGHlD2Lg3LFEDnxkXR7a8pgs/reNT+udP2T2si5zTff92WNhLXapfeVmVbapsPEpQqTLDasQ78TvPGrzcPB10s=
X-Received: by 2002:a0c:e042:0:b0:66d:daf:32f with SMTP id y2-20020a0ce042000000b0066d0daf032fmr3117885qvk.21.1697109593194;
 Thu, 12 Oct 2023 04:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231011184823.443959-1-peter.griffin@linaro.org>
 <20231011184823.443959-6-peter.griffin@linaro.org> <CAPLW+4kK_hhkht7OPgyUCinwaEPMyVq3DJ4mnbRVkGXJvPWbwg@mail.gmail.com>
In-Reply-To: <CAPLW+4kK_hhkht7OPgyUCinwaEPMyVq3DJ4mnbRVkGXJvPWbwg@mail.gmail.com>
From:   Peter Griffin <peter.griffin@linaro.org>
Date:   Thu, 12 Oct 2023 12:19:41 +0100
Message-ID: <CADrjBPpDvfyZCyCpXqDALLbe5POaBnKbzyyrEEfB2QmpChY7ug@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] dt-bindings: arm: google: Add bindings for
 Google ARM platforms
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org,
        cw00.choi@samsung.com, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sam,

Thanks for the review.

On Thu, 12 Oct 2023 at 00:06, Sam Protsenko <semen.protsenko@linaro.org> wr=
ote:
>
> On Wed, Oct 11, 2023 at 1:49=E2=80=AFPM Peter Griffin <peter.griffin@lina=
ro.org> wrote:
> >
> > This introduces bindings and dt-schema for the Google tensor SoCs.
> > Currently just gs101 and pixel 6 are supported.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/google.yaml       | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/google.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/google.yaml b/Docume=
ntation/devicetree/bindings/arm/google.yaml
> > new file mode 100644
> > index 000000000000..167945e4d5ee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/google.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/google.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Google Tensor platforms
> > +
> > +maintainers:
> > +  - Peter Griffin <peter.griffin@linaro.org>
> > +
> > +description: |
> > +  ARM platforms using SoCs designed by Google branded "Tensor" used in=
 Pixel
> > +  devices.
> > +
> > +  Currently upstream this is devices using "gs101" SoC which is found =
in Pixel
> > +  6, Pixel 6 Pro and Pixel 6a.
> > +
> > +  Google have a few different names for the SoC.
> > +  - Marketing name ("Tensor")
> > +  - Codename ("Whitechapel")
> > +  - SoC ID ("gs101")
> > +  - Die ID ("S5P9845");
> > +
> > +  Likewise there are a couple of names for the actual device
> > +  - Marketing name ("Pixel 6")
> > +  - Codename ("Oriole")
> > +
> > +  Devicetrees should use the lowercased SoC ID and lowercased board co=
dename.
> > +  e.g. gs101 and gs101-oriole
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +
>
> Is that empty line is actually needed here?

Will fix in v4.

Peter
