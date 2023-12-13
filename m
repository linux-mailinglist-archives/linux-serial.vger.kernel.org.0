Return-Path: <linux-serial+bounces-776-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85C380D13D
	for <lists+linux-serial@lfdr.de>; Mon, 11 Dec 2023 17:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819311F215E5
	for <lists+linux-serial@lfdr.de>; Mon, 11 Dec 2023 16:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDAF4CE12;
	Mon, 11 Dec 2023 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfeyCP/N"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A09C11D
	for <linux-serial@vger.kernel.org>; Mon, 11 Dec 2023 08:24:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2a444311so45345505e9.2
        for <linux-serial@vger.kernel.org>; Mon, 11 Dec 2023 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702311860; x=1702916660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FX/ZkRugEaGVg54hHyt+iiLk3yKyizfbOZydwXqa8g=;
        b=YfeyCP/Nwf3l5vmfHFVNwzIDtiXZUwKpoHgezRyMLrbrd7LEJPGInwQsCx7vPJcx6v
         5t3uFT9eLHg+B46/OyCD3sEiLW04RGKhjEqmIlc6aDelFleyBLBcXKDX4JV2hiajkauA
         k+T2F9spbvqXz28LST6jUHiRAsilnfP1fBG6x9gM4RzXr33aVYvSoDRL0Cx/qM+fJ3Qt
         9bOKBaUEhWFRrQomDqMPR3S1ij/HUIVqEY9e3jiFQ6z4m1GoFMnZGc8v9E4TAmKv0DMS
         sTankKy8HV1IMd8ZZ8xVB+cHOed8PQxaE69T8AZhF2/yAyWUY6CwJpS3Twma5b34BJiD
         oEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311860; x=1702916660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FX/ZkRugEaGVg54hHyt+iiLk3yKyizfbOZydwXqa8g=;
        b=EeYyHK6/CCgdYt+QYOYr5zq5tLLRa7m9pmngZtE9PKA2N1jL6GwqhDwtNQfxptDq/q
         iG3yomAqs87o1WTx5mGzIUqMiSWq7VG7Ooa+rrdbH2eG+M2H89E1wyCMuUlmbVdmi+3R
         868Hq0MdqoLvmkLQr3oBBvUxCwqCX1kMQweYZ1GTDfJtM0l87jkUdz1J9IFH5d2ARVvu
         GfS1379NemMez6ZkC4XKyZKgRIOiTsaOm2ilLl0jb325JHINdk9Z1bcO92Gi9+r5O2A4
         yDXl3QnWnYEaPbY/UoPj41DhDWZBLunxwsHKFVjOJ04+3O+y5iC4pHWlQkayVqDLa+eW
         YsRA==
X-Gm-Message-State: AOJu0YwVNhbRF0CduepfsShhOm64OX1FfMnqpDMLK5DAMbTZpPJawvxU
	POePttn8HbBZoXm5QBXL6ovphQ==
X-Google-Smtp-Source: AGHT+IEWk99CesWrbIhJv/TMHvU3scawI1bC4MdB9Hvo/AKqhelXc7h4rpDh1YlRVT5zfro/RsxL+Q==
X-Received: by 2002:a05:600c:1f1a:b0:40c:3221:f3cf with SMTP id bd26-20020a05600c1f1a00b0040c3221f3cfmr1154939wmb.359.1702311860620;
        Mon, 11 Dec 2023 08:24:20 -0800 (PST)
Received: from gpeter-l.lan (host-92-29-28-58.as13285.net. [92.29.28.58])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d58c4000000b0033333bee379sm8923103wrf.107.2023.12.11.08.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:24:20 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	conor+dt@kernel.org,
	sboyd@kernel.org,
	tomasz.figa@gmail.com,
	s.nawrocki@samsung.com,
	linus.walleij@linaro.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	olof@lixom.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cw00.choi@samsung.com,
	alim.akhtar@samsung.com
Cc: peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	semen.protsenko@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	soc@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	kernel-team@android.com,
	linux-serial@vger.kernel.org
Subject: [PATCH v7 05/16] dt-bindings: soc: samsung: usi: add google,gs101-usi compatible
Date: Mon, 11 Dec 2023 16:23:20 +0000
Message-ID: <20231211162331.435900-6-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231211162331.435900-1-peter.griffin@linaro.org>
References: <20231211162331.435900-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tudor Ambarus <tudor.ambarus@linaro.org>

Add google,gs101-usi dedicated compatible for representing USI of Google
GS101 SoC.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
index 61be1f2ddbe7..8b478d6cdc30 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
@@ -25,6 +25,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - google,gs101-usi
               - samsung,exynosautov9-usi
               - samsung,exynosautov920-usi
           - const: samsung,exynos850-usi
-- 
2.43.0.472.g3155946c3a-goog


