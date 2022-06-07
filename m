Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7BA53A0B2
	for <lists+linux-serial@lfdr.de>; Wed,  1 Jun 2022 11:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351236AbiFAJgx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 1 Jun 2022 05:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351141AbiFAJfE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 05:35:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B498FD78
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 02:34:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z7so1330918edm.13
        for <linux-serial@vger.kernel.org>; Wed, 01 Jun 2022 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1np58l0Ga8gAPyEnQM7qbTnnn39ozk3WmSTf/pHhsMA=;
        b=FxTMvGpBCFeg1BoYbwmxDdCMOXat0Dl6sDzqkF2MpWnJq2pZtTCNhwmj6W3PeB75qP
         rcPx+5D0Z3FQ8MKmJFh/4q9tShdIZea0l5zEmH43NfBWqwvsk6nv0b014UeFfKZuOIJM
         7M6cZtmof8mF6X4ZH6LWCm95ou26ImCaBaNzOi46ZR1WrbeDHmwdISTvPIMCZ+QsDJVR
         uH4HT1Lkl+X2M7UexFy4Duv1Fo88VNVCnN9YDMcqSCBEKdUv05UNVIBxHxknJwA6DqC1
         c4qXXwjka6hHBGl8n5xtVoZrADjT5c1LU9AIHJO+9vwtz1FHXKKeq1M2uC0Ws2BGju+k
         uZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1np58l0Ga8gAPyEnQM7qbTnnn39ozk3WmSTf/pHhsMA=;
        b=A6ar7dyVuHgT5elQDz79nJRQ9FR/aa8xw3T/PlgzsbqRB+d6LEmwO0o5IgOQQpfFZe
         pw1HTo1Fw9k9cAQXKhd8aX73BWrLTjBTNT3cM5ujVuGBQUzj9JbW5secmbK4D97ra9RI
         Vpur3SHoARl9aDNUr3AOCy0p48VbfUADcNgwKJRDqfgibRXrlDcdStVnUHPbOzCMRBI/
         aTxDh2dEgcSulPKXVHOv5maZGwg1xPagPZgLdkkogj1sTFPyK5aYfuZ/ZTdPWqt1eC6H
         9rHzxQDqpAdsh0+JRXpvhp2GF5yC8itiwPDQiq++h6KyGcnwj2SykZhiINFVVN9dO5Fp
         y3zA==
X-Gm-Message-State: AOAM532rvpwcr3b7tyQZM75aOlISPwmHSo/h5d4mfaP/yP40dao2A4z5
        ItyV0eXeA+kU+jnfU4U5yRep3A==
X-Google-Smtp-Source: ABdhPJxEdF+CfXbx7tU2wd905loniQlDvsO66TbxWB3RqmGrBCz/WUwZDXZTrxvdJ4CljmwLTrODcA==
X-Received: by 2002:a05:6402:1941:b0:413:2555:53e3 with SMTP id f1-20020a056402194100b00413255553e3mr69664287edz.164.1654076097997;
        Wed, 01 Jun 2022 02:34:57 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s9-20020a056402164900b0042ddfbea36asm709513edx.62.2022.06.01.02.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:34:57 -0700 (PDT)
Message-ID: <eab5fecb-8e75-06d5-d598-ff0221406252@linaro.org>
Date:   Wed, 1 Jun 2022 11:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/17] dt-bindings: i2c: i2c-mt65xx: add binding for
 MT8365 SoC
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-2-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-2-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation for the MT8365 I2C controllers.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
> index 16a1a3118204..a6fe0d8b0cbe 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
> @@ -43,6 +43,10 @@ properties:
>            - enum:
>                - mediatek,mt8195-i2c
>            - const: mediatek,mt8192-i2c
> +      - items:
> +          - enum:
> +              - mediatek,mt8365-i2c
> +          - const: mediatek,mt8168-i2c

Order entries by last item, so this goes before mt8192

>  
>    reg:
>      items:


Best regards,
Krzysztof
