Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97289677F1B
	for <lists+linux-serial@lfdr.de>; Mon, 23 Jan 2023 16:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjAWPOX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 23 Jan 2023 10:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjAWPOB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 10:14:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1401D29437
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:35 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d2so11108062wrp.8
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0imGc0Sj0+U1qO38/MoeN3izcir/X2ZEBTXpN0rl4g=;
        b=Mi72DTL6tAALC6SIna/EYeljNK+x72L1fQHn0b1YEpyxHOIwdo7XpXHQYH1v8pFPYx
         fmUE0AaGMQXJ1+36vD3ni3uf1224xM1WNmz+i4XR8e4pGQU3IJlFT/KKLHBQ/2HlYrNs
         jmhPytIJPCOE0D8UMjqY79KK5b+OCVoCoNT52ocRcj9Px5K4Enl/91hVP2hkBtz0GW0w
         VsK3JW9EqX4DrlURobQ3JwR/uIlfGAYWgRx+1xfPEkoSh0iFHIfr5nLHKhjReObKDoqk
         7Tf9YV/GjMPb51Wqn9yooA01rZZhY7mE8t+kA5amjH5PDNJonj9rRt5aQuAhPwkKstUs
         y5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0imGc0Sj0+U1qO38/MoeN3izcir/X2ZEBTXpN0rl4g=;
        b=PGOQImaZZ6XtPo1vqspVOrTWHORdn214ggxcSvRjMkxNJfSUij3V16pwt3nIJTXwS+
         gCw6FlxlQJX4auMkNU2OouVJfqqqHDI0nxV8zqWBqgS/2G7hiOPRy9u5GxShtgju6ctn
         yLDkcEW15gLYdbCana2xG5j5E6nw32zAayiZV4qthxBp1o7ga5TjXw0uIyYTWpqbVh/2
         GbdHuVPQZ+lq47rxAdRGSM3cLLdeEgggLhsTEKcDEJugiW10Ch+6roaTY2yhiSDt0Fdw
         7VwV1o0nw14wxaQ/M2EH3ndkRW4viZVxN7tfWnbTCHhfTlhe6+e+76RmL1yhUbKfj+iE
         8nvw==
X-Gm-Message-State: AFqh2kqf9rGJn5BSuUTXBUm7JcdHsHzcdTt8hKP6PI+TkOyzh5Y9Dxn2
        wfHqt6p1gPn2wKRYhHxFIqVNjA==
X-Google-Smtp-Source: AMrXdXvJabtie04RRzjvIRinzzoYqsygtV5Ygf34wHors5C0a5stz1Lsh6Pfo6+L2PQMDAPhE/FPew==
X-Received: by 2002:a05:6000:1d92:b0:2be:3ccd:7f37 with SMTP id bk18-20020a0560001d9200b002be3ccd7f37mr14760288wrb.52.1674486812732;
        Mon, 23 Jan 2023 07:13:32 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/13] dt-bindings: serial: st,stm32-uart: drop common properties
Date:   Mon, 23 Jan 2023 16:12:59 +0100
Message-Id: <20230123151302.368277-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The binding references serial and rs485 schemas, so there is no need to
list their properties.  Simplify a bit by removing unneeded entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/serial/st,stm32-uart.yaml          | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 85876c668f6d..1df8ffe95fc6 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -35,8 +35,6 @@ properties:
     description: enable hardware flow control (deprecated)
     $ref: /schemas/types.yaml#/definitions/flag
 
-  uart-has-rtscts: true
-
   rx-tx-swap: true
 
   dmas:
@@ -60,11 +58,6 @@ properties:
 
   wakeup-source: true
 
-  rs485-rts-delay: true
-  rs485-rts-active-low: true
-  linux,rs485-enabled-at-boot-time: true
-  rs485-rx-during-tx: true
-
   rx-threshold:
     description:
       If value is set to 1, RX FIFO threshold is disabled.
-- 
2.34.1

