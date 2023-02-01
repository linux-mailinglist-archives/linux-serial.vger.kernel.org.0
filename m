Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988E56793F4
	for <lists+linux-serial@lfdr.de>; Tue, 24 Jan 2023 10:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjAXJUW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 24 Jan 2023 04:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjAXJUM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 04:20:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC433FF35
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:20:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k16so10906485wms.2
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iisYcPXooI57UtkAF+HOVcsh+51Ufy433rxJDACay30=;
        b=QIK45URkusdjjJyIz28i81nYHz/bPWip0DX2PvrCQnN65/DuO7w68GyeUkuXNIKNsi
         xs/1Vj/8ytAp3/zQx6EAL9f9lMjpqjQMr2D6A57bkBfcQuqWvaPZ1xR2yt43BYBpaGMx
         VgESHMdfMFchyGnRbxszQ3RlARP5wVOjSJz7IFde+G+7FvaAGhJHz0TNkWNAfkbwMwa6
         JM6RrxW67FgZHlwp9ePpPQLJdxKKyy+zfijtg8Hx+v8EogkhvtE5DPWZ46MJhlpsHUal
         KLUOITI571JUoZ4F5YpYZN2pGyrntmAj6GwTh/SKIi0DAZdNfbnxcpZ1dB7MbB2hT2hx
         vA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iisYcPXooI57UtkAF+HOVcsh+51Ufy433rxJDACay30=;
        b=yInEN7/WXgaen1FfPmLxVjoACdmGZh9j7ZJQ/HWDElfAdg1XpDYM6ZATfvVt4lwcMk
         zRXs8XdEjIWuP+LriTbIhf6NVUHgfsY/WPmKh/fypbXP3aOPwK9XD68QAltk0v/z8ph5
         jjMFiOfnEiNrt2j3aRAFPL0hthkGEOhwgKMqOhOHVSJvayolkHTcMIwNmJlz79ian9Ub
         d2mJ6j8AslOOfn1H9JbUFsLafbUPWPCmbS1r91ZbwT+qckV9oUTf5uLffDnsEWwr7zKJ
         xPkZQrIMbyWLXjTwZ/klBrXwwf+cB+2j1K4/46N9ilRoN3YceEisRRbVujQNTr80wV+v
         iOBg==
X-Gm-Message-State: AFqh2koNeKpN+DIUQ7jNM1f5C78PI9J64KKUkgZGLCbpKLUf83JOLyg4
        r0UBFMqx93PcblIb0kQqFP1Icw==
X-Google-Smtp-Source: AMrXdXs8JG3T2Xep07y1ru/0yEt0ZLj+5ZJcdU+kq6WsnkoPtozPtAB9ElLE+hLK/vU0BiZFCOSAQA==
X-Received: by 2002:a7b:ca52:0:b0:3da:f4f5:ad0f with SMTP id m18-20020a7bca52000000b003daf4f5ad0fmr27205002wml.10.1674551998415;
        Tue, 24 Jan 2023 01:19:58 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003a84375d0d1sm13672242wmq.44.2023.01.24.01.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:19:57 -0800 (PST)
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
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 08/12] dt-bindings: serial: fsl-lpuart: drop rs485 properties
Date:   Tue, 24 Jan 2023 10:19:12 +0100
Message-Id: <20230124091916.45054-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
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

The binding references rs485 schema, so there is no need to list its
properties.  Simplify a bit by removing unneeded entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 74f75f669e77..b1e81a6451a6 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -64,9 +64,6 @@ properties:
       - const: rx
       - const: tx
 
-  rs485-rts-active-low: true
-  linux,rs485-enabled-at-boot-time: true
-
 required:
   - compatible
   - reg
-- 
2.34.1

