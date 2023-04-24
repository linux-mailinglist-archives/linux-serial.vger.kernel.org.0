Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619776DD215
	for <lists+linux-serial@lfdr.de>; Tue, 11 Apr 2023 07:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjDKFtA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Apr 2023 01:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjDKFsp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Apr 2023 01:48:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3087273C
        for <linux-serial@vger.kernel.org>; Mon, 10 Apr 2023 22:48:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id xi5so17443919ejb.13
        for <linux-serial@vger.kernel.org>; Mon, 10 Apr 2023 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681192086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKyTkKx/Pdu1EWbCPSTT+2QzhVLCfP4CgxSI4AwVzug=;
        b=LaY6lJoVaISAEhrl0jkh8B0UQoGv/9VX+s3CiP0PdffntWZMjZYmBQkqgAM/2PwTsd
         v/1OY8+YRXjuKKYYH+Uz/QiTcCD5K+yk+BnfqCZgOl49refSXvAuws28pbKY1ooGCmwd
         kbx8w2cYLYELhH4ROznsrDRT6eBQkXE7MpFvSZHToBY64NKXZ4lkOiTkMsjqxawhp0ol
         JVQB/e/QA4NSBJvpO5V+RdtOPsHUsS2r+1u9vC/OGHNbmaCNFtLY38dAAlikRRTQKmzt
         sohrfkAxdvaniAQvfrODCQDhBGixyJgj99KHKzw56hvXf3Y9cRnyr+TDEBG8HhSl5Vuk
         gJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681192086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKyTkKx/Pdu1EWbCPSTT+2QzhVLCfP4CgxSI4AwVzug=;
        b=saJkWlLeUJdh13yo5YjbmZMSU6zJ9GD5PvGfEEzSM4+U5F3qkNzGNoJA8jc07KbG2S
         y/+AtnIapo6rajtTQw0Ru8Pqp3yO0nuLFCgLJj/AdhVbZa6ZP1N+zpb61KBeDaeTks8T
         D5oBzUMghUpp6ijpujvar1PTXKVZu4q43y3NMm9um4SB7o9QlG1a3PiPiWnxLk9STJsl
         tc/Jdfgikk+VxtxEalB61OrCczKVqHOpfLQH0cRVMseFzkc+T3fFgu9O42K2t2m0okFF
         CMUsxPJlRfJ/5h976JRw3/m7gCBRFMgbzG9W4+wH0ydjMenutGMgGkkGrkEBdeIHN5df
         NJ4Q==
X-Gm-Message-State: AAQBX9cLY6MWmU+q7vdZQbLe/EYqMzzHopoUqiWM6TCcCF5enbu7QcQa
        f3qQMm8cLCP90K3hI3d0zyRTCg==
X-Google-Smtp-Source: AKy350biNPfenXSztI0xSOcWHuEry7OjPgnxeO4EilfTtNC8jliNoZlIZ+yXGM5RXFz5sKPy1k1ovQ==
X-Received: by 2002:a17:907:c20a:b0:94a:9abf:c3b with SMTP id ti10-20020a170907c20a00b0094a9abf0c3bmr3897080ejc.75.1681192086066;
        Mon, 10 Apr 2023 22:48:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id mp36-20020a1709071b2400b0094a511b9e6csm2824691ejc.139.2023.04.10.22.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 22:48:05 -0700 (PDT)
Message-ID: <eb9d5fe0-a8fb-e8ee-d13c-357ea408e2d1@linaro.org>
Date:   Tue, 11 Apr 2023 07:48:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 4/6] dt-bindings: imxgpt: add imx6ul compatible
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
 <20230410205803.45853-5-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410205803.45853-5-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/04/2023 22:58, Stefan Wahren wrote:
> Currently the dtbs_check for imx6ul generates warnings like this:
> 
> ['fsl,imx6ul-gpt', 'fsl,imx6sx-gpt'] is too long
> 
> According to the timer-imx-gpt driver all imx6 use the same imx6dl data,
> but according to the existing DTS files the imx6ul GPT IP is derived from
> imx6sx. So better follow the DTS files here and make the imx6ul GPT
> compatible to the imx6sl one to fix the warning.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

