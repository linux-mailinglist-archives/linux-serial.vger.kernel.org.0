Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AB96BD1D0
	for <lists+linux-serial@lfdr.de>; Thu, 16 Mar 2023 15:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjCPOKQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 16 Mar 2023 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjCPOKO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Mar 2023 10:10:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8883B0C7
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 07:09:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so8118845edb.11
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678975794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSYTF1gzbLXc9mIXUhT70b2BxBvwCOTXpLGkfOxxmec=;
        b=cM9RxICbPcmQVtqktPjzYGl3wLcA0d85RKIFxu5WIB1G56o138Z0qHPLPAVC1XHruZ
         iXb3ZTIONF92viWgBDIOHftD0wR9nFVXzvH38ZH8fSHonstccxExM8A9d4KtRATZ4jds
         JL3LUxYNtIWgjRRKDSagN2kSnv3uHsfks3szO+w/etoxhOjRNQMt9/NB7V8xIxnnvmA1
         P6uX2gdN0x9faCQpQ3uPXOQyU7uJT4mr8RKgaUbD3gC1vMaOdesfNIu33lrF7xfCHIXb
         I1KYXTQq1fLjJFSrgpLjJODCSTlmeFEk++eFjWKU2fONeUKe+Bc251xEcTyfPm+ym8xq
         aPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678975794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSYTF1gzbLXc9mIXUhT70b2BxBvwCOTXpLGkfOxxmec=;
        b=z0ddteoS6FbeEHdwURSyQsx8hSDCzkWd+OYIOsb4cY/9dL1d6PB7WGqkC7QGcC4AG2
         x2kFef1et9ddexh0PjXrsm/84vXacyOWOA+EQm7xCD7NzB7h+TGqFANRWTc1QrC9AKhO
         XXztZJfDN5AuV/MiPCHI7L1CaF2rTuVUcOxmzyI7jd1MkJ6AHWI9SX/UhAafaRLQHds4
         t/6ris09xtZQ7E+0lIMNs0ZwWduDlgXK1jcffcXTo0kN/XF63lrX/j+uPlCipfHGWQ5i
         5xN3xz/8mFRirw8q51r26fNxXhrD4UiaE+ZrW/QriLKjxB/WOF5m6QHW+FF9qbyIAYVB
         WNPA==
X-Gm-Message-State: AO0yUKW5vhQqu4q8P+yBuUmI4SuPB0MHw5Y/ShzaWTZ3bb4doZbZFV1V
        lD4rO9v0mBiDslXrw4a59sz+6g==
X-Google-Smtp-Source: AK7set/lq61jyQAMsfgKe5eGKonfgJx8sh6sYalKy1N1OZp2WLwyjzWvUd/2MxH1VCw2f7GRuoFwHA==
X-Received: by 2002:a17:907:8d1b:b0:889:1eb1:7517 with SMTP id tc27-20020a1709078d1b00b008891eb17517mr11048600ejc.30.1678975794656;
        Thu, 16 Mar 2023 07:09:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id si16-20020a170906ced000b008e1509dde19sm3866687ejb.205.2023.03.16.07.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 07:09:54 -0700 (PDT)
Message-ID: <ac27570c-73ab-ff58-d8f8-c6c5d0fa751b@linaro.org>
Date:   Thu, 16 Mar 2023 15:09:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 04/15] dt-bindings: clock: nuvoton: add binding for ma35d1
 clock controller
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-5-ychuang570808@gmail.com>
 <a64bbd77-cd5c-8149-51e6-262122fe954e@linaro.org>
 <fd60a5af-8831-3d58-41b0-b220130c9e05@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fd60a5af-8831-3d58-41b0-b220130c9e05@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 16/03/2023 14:35, Jacky Huang wrote:
> 
> Dear Krzysztof,
> 
> 
> 
> On 2023/3/16 下午 03:31, Krzysztof Kozlowski wrote:
>> On 15/03/2023 08:28, Jacky Huang wrote:
>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>
>>> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
>>> between the clock controller and clock references in the dts.
>> I don't see the device binding. They come together.
> 
> I should move 
> Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> into this patch, right?

Yes.



Best regards,
Krzysztof

