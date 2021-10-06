Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B51E42387F
	for <lists+linux-serial@lfdr.de>; Wed,  6 Oct 2021 09:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJFHHd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 6 Oct 2021 03:07:33 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34822
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230227AbhJFHHc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Oct 2021 03:07:32 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6F52E3FFE6
        for <linux-serial@vger.kernel.org>; Wed,  6 Oct 2021 07:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633503940;
        bh=nAaopoD7THJlOCA5cGnPBgaBffQraHOd+wkpq9Lg/oo=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=lE2IzW6Iq7psO+FwFOug6v7GLD4DmMxtU3TMcX+zDnXQCV+oUslzTPYUvd5Upj+/N
         135Sl2nfqhE1F89FNEA1qzDL64qP3HvNDJtvy+Q/JvKUnUJ2SBUQv754yEYEmGvtTL
         mr3/bEMzPCNDIuA4hBh1Ie2uEu3H8049JPV1V8PC9Fo0LHUZrNsi6WgWIURZRhfxQQ
         /T5nN8rJJGyfoUffGguEa/vphijPjHCI5a+c/MHA0h4jvlQeHlSzBLBEdZFedRclIA
         lXTaiYv2OP1DZje+9KbR/nW17dhyzazKWYawpIi1MSrCRVs6EjnLvieCa5BkeQKIXD
         YOZjrL7O4BK6A==
Received: by mail-lf1-f72.google.com with SMTP id c6-20020a05651200c600b003fc6d39efa4so1214901lfp.12
        for <linux-serial@vger.kernel.org>; Wed, 06 Oct 2021 00:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nAaopoD7THJlOCA5cGnPBgaBffQraHOd+wkpq9Lg/oo=;
        b=aBl2BPLr0ybITploSNwd12/UqfpZxE2F78t4nPBWgGyGwVpXVUaThOFmaw/XLY29jB
         5WA8cK6nr/d85mAR0w45S5NzxUAMEeRIHFNY92tLOCEWipnue1naOBgpMLL3VK3ZvMnV
         mWvj3NiXwpe6fedYPw7CXlGARsiG+lVIjU9u8wpD4r6ZEkel5mlxcaxROKjvyzHzKNXi
         IB6Lc0hzhy3VKsUMM+06Hg8Ww3BprIl3IF92Z6hZd91cLL/WVg+JrpPOhv4Xwg1KN7DG
         vl4RHWl0ARV3Uvazf+4hY+Z5IhU0C8g7OEeCZutWyF8UPVqrUbIF5SOgxy38VDhKHYbJ
         pFgQ==
X-Gm-Message-State: AOAM53171vk3VXoVT5CZ9d9HWCgoCFHIbjz/BqFSCywi8O6nElPycw69
        ySYU8vRa1MMlHL/KXO7JE9Tta95/nxIEH4nQl2luciAqZ2STZAsgowp6irAPzAHJ/9sPZje6iUe
        jJ+QfG8JNw0rI/avAIdhkpuCfe3I2fOnsUxO8kCaTRg==
X-Received: by 2002:a05:651c:3c2:: with SMTP id f2mr27464287ljp.282.1633503939368;
        Wed, 06 Oct 2021 00:05:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqjP/ZlfCNmIjtfZP8v/DwYAmTZBGOomHxxpnyH8hP9lZlzbI9SDqyzFFWwnJY47k/i6lNzA==
X-Received: by 2002:a05:651c:3c2:: with SMTP id f2mr27464269ljp.282.1633503939160;
        Wed, 06 Oct 2021 00:05:39 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y3sm2177779lfh.132.2021.10.06.00.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 00:05:38 -0700 (PDT)
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-3-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
Message-ID: <b5b3fcb4-077b-d33d-03cc-ac0611cb56a1@canonical.com>
Date:   Wed, 6 Oct 2021 09:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005155923.173399-3-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05/10/2021 17:59, Hector Martin wrote:
> This syscon child node represents a single SoC device controlled by the
> PMGR block. This layout allows us to declare all device power state
> controls (power/clock gating and reset) in the device tree, including
> dependencies, instead of hardcoding it into the driver. The register
> layout is uniform.
> 
> Each pmgr-pwrstate node provides genpd and reset features, to be
> consumed by downstream device nodes.
> 
> Future SoCs are expected to use backwards compatible registers, and the
> "apple,pmgr-pwrstate" represents any such interfaces (possibly with
> additional features gated by the more specific compatible), allowing
> them to be bound without driver updates. If a backwards incompatible
> change is introduced in future SoCs, it will require a new compatible,
> such as "apple,pmgr-pwrstate-v2".
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/power/apple,pmgr-pwrstate.yaml   | 117 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> new file mode 100644
> index 000000000000..a14bf5f30ff0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/apple,pmgr-pwrstate.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC PMGR Power States
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +allOf:
> +  - $ref: "power-domain.yaml#"
> +
> +description: |
> +  Apple SoCs include a PMGR block responsible for power management,
> +  which can control various clocks, resets, power states, and
> +  performance features. This binding describes the device power
> +  state registers, which control power states and resets.
> +
> +  Each instance of a power controller within the PMGR syscon node
> +  represents a generic power domain provider, as documented in
> +  Documentation/devicetree/bindings/power/power-domain.yaml.
> +  The provider controls a single SoC block. The power hierarchy is
> +  represented via power-domains relationships between these nodes.
> +
> +  See Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> +  for the top-level PMGR node documentation.
> +
> +  IP cores belonging to a power domain should contain a
> +  "power-domains" property that is a phandle for the
> +  power domain node representing the domain.

Skip this last paragraph - it is obvious in usage of power domains.
Specific bindings should not duplicate generic knowledge.

> +
> +properties:
> +  $nodename:
> +    pattern: "^power-controller@[0-9a-f]+$"

Usually we call nodes as power-domain.

> +
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-pmgr-pwrstate
> +      - const: apple,pmgr-pwrstate
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#power-domain-cells":
> +    const: 0
> +
> +  "#reset-cells":
> +    const: 0
> +
> +  power-domains:
> +    description:
> +      Reference to parent power domains. A domain may have multiple parents,
> +      and all will be powered up when it is powered.

How many items?

> +
> +  apple,domain-name:

Use existing binding "label".

> +    description: |
> +      Specifies the name of the SoC device being controlled. This is used to
> +      name the power/reset domains.
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  apple,always-on:
> +    description: |
> +      Forces this power domain to always be powered up.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#power-domain-cells"
> +  - "#reset-cells"
> +  - "apple,domain-name"
> +
> +additionalProperties: false

Your parent schema should include this one for evaluating children.



Best regards,
Krzysztof
