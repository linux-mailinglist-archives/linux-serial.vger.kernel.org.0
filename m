Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223B1468477
	for <lists+linux-serial@lfdr.de>; Sat,  4 Dec 2021 12:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbhLDLbn (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 4 Dec 2021 06:31:43 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42324
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229806AbhLDLbn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 4 Dec 2021 06:31:43 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2E31F3F1BC
        for <linux-serial@vger.kernel.org>; Sat,  4 Dec 2021 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638617297;
        bh=cDMOprbCNmVrnhTq2DA/P4ce01dr6plcdtHOsOupZhI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=oVfZYn4yHd5QdQFQM6BfJ6fjo0SlkmZDtBWGvueAR9EiiHxOEDYe616hPBiPkCSnF
         GH4dHihdzUuS6AymrEJtMdZxEB1jBTHRGq7Wvn1rVSSul0QM4ACeOh2cXIsWedEAd4
         y8k2X6rTRXt+9tjSFeYuHC/VFOtYYlRE+gmvhQ/JmZFbd4S95rapr3aQJUuYJrvDv1
         Nsg5UIuPLp+RotsafmA/jiBMMC/VwJX3Sbyd9Jr0nPwd5TjkkBjRjCUynhngbcqcOB
         Z/UyrIRQle2/HwGyU4XAN0nRoEB7CxUqw7N+2rx1IMkefyce6D7tGgq8jnkfcA9XYC
         nHIE4+4Onc8Sw==
Received: by mail-lj1-f200.google.com with SMTP id b14-20020a05651c0b0e00b0021a1a39c481so2144905ljr.3
        for <linux-serial@vger.kernel.org>; Sat, 04 Dec 2021 03:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cDMOprbCNmVrnhTq2DA/P4ce01dr6plcdtHOsOupZhI=;
        b=dE8e7TBivrFXlDpXZbVsAJzw7jlh1saTAmIlK3E4McGWE5RtDs+rp7MKmQXApGiTP8
         UDHiuKsJ4gz6s4N00ZOhec1TlyVXaupt1JAMO0DteCvlTIAyr3vgpJxxxg+16+NYpAgL
         /DaFr0y7jEmDO8HDwRMauMqkkPMVSVCpewEsz7VoGTEImFJPAf1AhxMRDuQbYou7GWKk
         avwFbf5f85kqSsy5a3d3CZPnEDpixaZhCaH7wgBKNquaZzzrfDmnhCz/IEbdB6F+qko9
         cA9l6QvQhoX4z9AkP/9DkoFoW+iB4R9RZzYBrpy/6AjqwNmKmHRNpgrWrg6gU3ipA1Kd
         Tygg==
X-Gm-Message-State: AOAM532cvdL/OcWfvdCg8XUkZ2oT1ttHWy79JcZre2eqwX5qLeju3Lcv
        +6qdUQ+I3JHBhoEig4fVGggV8jJKV2aHDfH2qK2EGwRQAXU44kftMgEaX3s5H+HEwzRYd9RtZXN
        EobAU5dXxOzUNokIL+irQ9cPtRpI78u5clZ9YVGjWWw==
X-Received: by 2002:a2e:3304:: with SMTP id d4mr23451845ljc.377.1638617296357;
        Sat, 04 Dec 2021 03:28:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhvd6fygIOdZn6G780jNIdTGMMEUfzDuyEWxxWX82QhGFjy1oOU5we3bEx/4VWOfGcbNpMyg==
X-Received: by 2002:a2e:3304:: with SMTP id d4mr23451815ljc.377.1638617296080;
        Sat, 04 Dec 2021 03:28:16 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d15sm730421lfq.38.2021.12.04.03.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 03:28:15 -0800 (PST)
Message-ID: <8460edd6-efaf-3ae7-594c-0d1495d57abf@canonical.com>
Date:   Sat, 4 Dec 2021 12:28:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 RESEND 1/5] dt-bindings: soc: samsung: Add Exynos USI
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
 <20211130111325.29328-2-semen.protsenko@linaro.org>
 <YaZ8BpUaaC+sJYqx@robh.at.kernel.org>
 <CAPLW+4kGGk+umKTVRPNM7R=GaUQa31Uid=K+9ofq8w2mqzGAEA@mail.gmail.com>
 <CAL_JsqLopqkOEWmnvMDWr2rBa5Dm3jf17soqVA=Jx5Hn9BDS_g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAL_JsqLopqkOEWmnvMDWr2rBa5Dm3jf17soqVA=Jx5Hn9BDS_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 03/12/2021 21:40, Rob Herring wrote:
> On Fri, Dec 3, 2021 at 1:36 PM Sam Protsenko <semen.protsenko@linaro.org> wrote:
>>
>> On Tue, 30 Nov 2021 at 21:31, Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Tue, Nov 30, 2021 at 01:13:21PM +0200, Sam Protsenko wrote:
>>>> Add constants for choosing USIv2 configuration mode in device tree.
>>>> Those are further used in USI driver to figure out which value to write
>>>> into SW_CONF register. Also document USIv2 IP-core bindings.
>>>>
>>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>>>> ---
>>>> Changes in v2:
>>>>   - Combined dt-bindings doc and dt-bindings header patches
>>>>   - Added i2c node to example in bindings doc
>>>>   - Added mentioning of shared internal circuits
>>>>   - Added USI_V2_NONE value to bindings header
>>>>
>>>>  .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
>>>>  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
>>>>  2 files changed, 152 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
>>>>  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
>>>> new file mode 100644
>>>> index 000000000000..a822bc62b3cd
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
>>>> @@ -0,0 +1,135 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/soc/samsung/exynos-usi.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Samsung's Exynos USI (Universal Serial Interface) binding
>>>> +
>>>> +maintainers:
>>>> +  - Sam Protsenko <semen.protsenko@linaro.org>
>>>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> +
>>>> +description: |
>>>> +  USI IP-core provides selectable serial protocol (UART, SPI or High-Speed I2C).
>>>> +  USI shares almost all internal circuits within each protocol, so only one
>>>> +  protocol can be chosen at a time. USI is modeled as a node with zero or more
>>>> +  child nodes, each representing a serial sub-node device. The mode setting
>>>> +  selects which particular function will be used.
>>>> +
>>>> +  Refer to next bindings documentation for information on protocol subnodes that
>>>> +  can exist under USI node:
>>>> +
>>>> +  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
>>>> +  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
>>>> +  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    pattern: "^usi@[0-9a-f]+$"
>>>> +
>>>> +  compatible:
>>>> +    const: samsung,exynos-usi-v2
>>>
>>> Use SoC based compatibles.
>>>
>>
>> In this particular case, I'd really prefer to have it like this. Most
>> likely we'll only have USIv1 and USIv1 in the end, and I think that
>> would be more clear to have USI version in compatible, rather than SoC
>> name. Please let me know if you have a strong opinion on this one --
>> if so I'll re-send.
> 
> Fine if you have some evidence the ratio of versions to SoC are much
> more than 1:1 and the versions correspond to something (IOW, you
> aren't making them up).
> 
> We went down the version # path with QCom and in the end about every
> SoC had a different version.

I am against v1/v2 versions. The documentation in Samsung was always
poor in that matter. There were mistakes or confusions so it wasn't
always obvious which IP-block version comes with which SoC. Not
mentioning that several contributors do not have access to Samsung
datasheets and they submit code based on GPL compliance packages, so
they won't know which version they have for given SoC.

OTOH there is no single benefit of using USI v1/v2, except "liking".

Best regards,
Krzysztof
