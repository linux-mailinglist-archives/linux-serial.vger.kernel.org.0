Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1D86F650D
	for <lists+linux-serial@lfdr.de>; Thu,  4 May 2023 08:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjEDGbK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 May 2023 02:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjEDGbJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 May 2023 02:31:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F34C2703
        for <linux-serial@vger.kernel.org>; Wed,  3 May 2023 23:30:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so3154a12.3
        for <linux-serial@vger.kernel.org>; Wed, 03 May 2023 23:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683181857; x=1685773857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ebgEagdbLvw8JiIkyMu+Kvj49caVzL1eFfSb+2cj4c=;
        b=ir0arSP2uyG4zmJbl4X4tOqRxmlX/VaxRZDv9b+ySUttvHL424BOlabkODqAzkspHq
         b4rA9CNO3fJbMpol07tQ0Oobfi1YEPH8DtvJOOLNIa38qbYuf2SvAfE/yQV3yuQ5JB+P
         MPNazFExIRQiRHiEhTPwgy8zUv6mw5E+MuSlfGJjswbd4JAQRKl/PIVITt70kX2cF5RT
         RXi5TEePUZvRSI++rHfaQhG29MbtNMnwjBzAv/RzVyjSTe40PgZFLJQRXAaWiBB2Wq2f
         9knUy14zIoH0AlK/DAx/W3qXbkGYQFj9eE/8jhZvHGVK/D/J1hqLln7M0DW6tEYiw1yX
         spvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181857; x=1685773857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ebgEagdbLvw8JiIkyMu+Kvj49caVzL1eFfSb+2cj4c=;
        b=WFhrYbZ8ofjDlBrM2fF6GlhW1Ocua3/zaXvQGFWiwUxMqEpcfY3GV9731ntUwE7L/O
         PIoORYz0ptsnEHaq6nDd8GNmTQy5DbM7YLR0eE3pSVVi7xE1zQVzpE/ENL1VAywtqajx
         Vmn7yPJj/qJqWU+l8cim4V30dG6HpfXi74A8IrdEXvu7cAa7gYhOwYhqm13tg0zwxvgr
         vI30Ufn4rQzDUBj/lmJ5a4ij04eNMzLrtpNFSzDgoykSSiMbdZW1l/krrH2g4HQSabv0
         CJ6kBhg0WfK5yeVmbAMf7rU33Dl6Kea2YfChRd7FsRaQbcv98jnEb7weEkDfeqXI+BPP
         l3Zw==
X-Gm-Message-State: AC+VfDzS+lEnSIv0yb6IjwEqKtXpEyqumPmRgIgNR2E1gg+PVhLbHljj
        ylzj7oDV4rcOedZqAq6c/w1kIv298HyP5Qph5AhVI7yV
X-Google-Smtp-Source: ACHHUZ74haS5/ntUyjYBA6onMa+wvPx9zG937Wn1k3MUsJ6LcDD/cvjrBsnzNtFXg7BSghNEUZQ1Fg==
X-Received: by 2002:a05:6402:138d:b0:504:94b9:f21 with SMTP id b13-20020a056402138d00b0050494b90f21mr604533edv.27.1683181856698;
        Wed, 03 May 2023 23:30:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7c402000000b00501c96564b5sm1491183edq.93.2023.05.03.23.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:30:56 -0700 (PDT)
Message-ID: <958cca71-b2f2-80af-541c-d1e84b151d3c@linaro.org>
Date:   Thu, 4 May 2023 08:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v9 08/10] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230504033726.93-1-ychuang570808@gmail.com>
 <20230504033726.93-9-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504033726.93-9-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04/05/2023 05:37, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> The clock controller generates clocks for the whole chip, including
> system clocks and all peripheral clocks. This driver support ma35d1
> clock gating, divider, and individual PLL configuration.
> 
> There are 6 PLLs in ma35d1 SoC:
>   - CA-PLL for the two Cortex-A35 CPU clock
>   - SYS-PLL for system bus, which comes from the companion MCU
>     and cannot be programmed by clock controller.
>   - DDR-PLL for DDR
>   - EPLL for GMAC and GFX, Display, and VDEC IPs.
>   - VPLL for video output pixel clock
>   - APLL for SDHC, I2S audio, and other IPs.
> CA-PLL has only one operation mode.
> DDR-PLL, EPLL, VPLL, and APLL are advanced PLLs which have 3
> operation modes: integer mode, fraction mode, and spread specturm mode.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/clk/Makefile                     |   1 +
>  drivers/clk/nuvoton/Kconfig              |  19 +
>  drivers/clk/nuvoton/Makefile             |   4 +
>  drivers/clk/nuvoton/clk-ma35d1-divider.c | 140 ++++
>  drivers/clk/nuvoton/clk-ma35d1-pll.c     | 365 +++++++++
>  drivers/clk/nuvoton/clk-ma35d1.c         | 948 +++++++++++++++++++++++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

