Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8323C7E5432
	for <lists+linux-serial@lfdr.de>; Wed,  8 Nov 2023 11:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbjKHKqd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 8 Nov 2023 05:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344543AbjKHKpq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Nov 2023 05:45:46 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95803270D
        for <linux-serial@vger.kernel.org>; Wed,  8 Nov 2023 02:44:41 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c515527310so92225441fa.2
        for <linux-serial@vger.kernel.org>; Wed, 08 Nov 2023 02:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699440280; x=1700045080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLncO1ADQq/KYbPV1LBS+813XGTk7ajEpj3gEwbCXmE=;
        b=at7bnm2pLlm5m3ryH1cZRMIBYRJsXleRtjdxXHIuAoQQ4dLJMJvD7NzdTRUY4tsE7P
         b+rsF1rKqsOmcbxiKTQgRSxqh4PwTSfeTPWRRbZL6gxV/MwgKGDh4NGoC5OqgQdZtYU6
         bOQv7yHWOf826XXuROFe+hP7HQUf+1QhB9L80g0bMtp0xjc1IvALy1LcqedRaNfYSJnM
         OUqLAGa2A5tylU7m4VGED8i/3qOooqLzxE9u6UpT/g6le91eMNypn+VKp0DxiC4cCJS7
         X+rjmE8yFtGnid92WZ6xFN7i/3jv5IyEf/aMQ0/yHDxRxJy56+KAtHOm0X56PdKSgXFT
         EGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440280; x=1700045080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLncO1ADQq/KYbPV1LBS+813XGTk7ajEpj3gEwbCXmE=;
        b=IqvgllD7pokApPb+AswLGhEJ3jWagFv5cAXhG+STRIyKtenXtZ6a0aYdzQFDwosvTM
         M8Q5lK/FQ0frnFDKV+EYawDTqyjOG/HCxfTnx3mHJuOKo/LfQ3OZRxZD6T65OC1uzLoz
         gmdZvdBwfV66RMV6JXLy4BlSMPrrIfoZPL1QELf9t2p3+MWBE0XWBcTWbfJoGistDvws
         Pu0dFixHa1bQ9OW+cEfbkb1Y/b8gmUsuGPyJ39ULSgoygeuXrACxnRZPn1qii9bfqji2
         pMRXDg0ZsHVN+GkWNeCHban0SOMfo3LFkz/w5spLsHU6XhGhV/DrTRSw29GD8jNILpfD
         GMRg==
X-Gm-Message-State: AOJu0Yww9BnSkUlb49RG///6OH4dLEIaa/5Gi8ABaG28JpTv/3SsS2Pz
        +PqcUyMf8MuYzQU2wwMAUPomvQ==
X-Google-Smtp-Source: AGHT+IE9e7WdZJcWzB5Gf22P43YL/3qsWhZ9UWDtVmtmQ2zCC7QEZqOnQRFgEbbvc33FYHTz/Q1w1g==
X-Received: by 2002:a2e:81a:0:b0:2c5:7afd:75a1 with SMTP id 26-20020a2e081a000000b002c57afd75a1mr1229802lji.44.1699440279685;
        Wed, 08 Nov 2023 02:44:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b004094c5d92bdsm19377377wmb.31.2023.11.08.02.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:44:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 12/17] dt-bindings: pwm: samsung: add specific compatibles for existing SoC
Date:   Wed,  8 Nov 2023 11:43:38 +0100
Message-Id: <20231108104343.24192-13-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Samsung Exynos SoC reuses several devices from older designs, thus
historically we kept the old (block's) compatible only.  This works fine
and there is no bug here, however guidelines expressed in
Documentation/devicetree/bindings/writing-bindings.rst state that:
1. Compatibles should be specific.
2. We should add new compatibles in case of bugs or features.

Add compatibles specific to each SoC in front of all old-SoC-like
compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I propose to take the patch through Samsung SoC (me). See cover letter
for explanation.
---
 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
index 2162f661ed5a..89a3875cb50a 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -29,6 +29,8 @@ properties:
           - samsung,exynos4210-pwm          # 32-bit, Exynos
       - items:
           - enum:
+              - samsung,exynos5433-pwm
+              - samsung,exynos7-pwm
               - samsung,exynosautov9-pwm
           - const: samsung,exynos4210-pwm
 
-- 
2.34.1

