Return-Path: <linux-serial+bounces-355-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC69800F0C
	for <lists+linux-serial@lfdr.de>; Fri,  1 Dec 2023 17:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0490281BA1
	for <lists+linux-serial@lfdr.de>; Fri,  1 Dec 2023 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E109D4BABA;
	Fri,  1 Dec 2023 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JarhZEjf"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893DA1700
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 08:10:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-332fd78fa9dso1654744f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 01 Dec 2023 08:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701447050; x=1702051850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ywdUZXMyLf6C9Ys3Kgiwpz0dOO3A0ZXqyMleZjsaYg=;
        b=JarhZEjf4cNxikdu0feE6XqwtTjtLhYyRTYXiXykYNQA7Kw1I3FI+6Ms76EKkWgAJ+
         ZY4zX2RBD8KKcdIbGb8h1+521G+JKK0OOvcyVth0kiDiXCArUq0D152eW6W5BimGAOkW
         9M5BE34sY4tCv0vGwsYSsyI2J/MuFsqquDmCGCtUQsawe0/NRs8vW8gQebifwb6r/ZlG
         bavTE0P+Wm1ZTQegZRNnifOeH78ZWWKPomeNSPotbaw7EzB9UnfhQsSu3OzLDOKCNrge
         kJFJjg8nIyo3j/inTwlS7XlSOiiOImwgfAyc9U41oA9BnCuatwnB487UEuhOESQJg91W
         i13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447050; x=1702051850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ywdUZXMyLf6C9Ys3Kgiwpz0dOO3A0ZXqyMleZjsaYg=;
        b=f+cK6/6ICav2zykRbn1oPkmOJRGmuclj5tf3bUyeAK22wdlt5yIe0XwDLRHpBGYvHW
         f/TtbLD3BcXXxWtgdJzAho+fZnaRSVL/jwkL/SM+YIFnf5D9Ink7bJyKPIgezJUDxN8j
         +O7hU8Lyw782IM3F8qvGKwqpdkJoRWTqDnpa93LWO8oaupj2pK1xmM34Q1FX5WoyLIx2
         N7h2Hve/NfznRI357ZrLG37nVv/lH7v0O/F+3aIUdpG1H8avUerzs/82TG5acjWcSDD5
         6wbx5am/saa/n1+rHD1LxjITiQgr1Hw1KJpluya9KTv09PUntKG4miMEioDUkM8hP3g1
         1jlQ==
X-Gm-Message-State: AOJu0YzWuoz6bl/OgKe8OEyCSdSPqoYH85cF3mN9dcvH4swknynFeXlg
	O3ZrWMmMIs7RC907uuZ8e1CLiw==
X-Google-Smtp-Source: AGHT+IG7OOrnhouiLBwZm+VnT6C5HGH4CpJmfnG5KQGGluemLDGUdIgkXzi8CNGO3fHX+180nLdF9Q==
X-Received: by 2002:a5d:4402:0:b0:333:2e28:46f5 with SMTP id z2-20020a5d4402000000b003332e2846f5mr450720wrq.1.1701447049944;
        Fri, 01 Dec 2023 08:10:49 -0800 (PST)
Received: from gpeter-l.lan (host-92-29-24-243.as13285.net. [92.29.24.243])
        by smtp.gmail.com with ESMTPSA id cg16-20020a5d5cd0000000b003332656cd73sm3907386wrb.105.2023.12.01.08.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:10:49 -0800 (PST)
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
Subject: [PATCH v5 01/20] dt-bindings: soc: samsung: exynos-pmu: Add gs101 compatible
Date: Fri,  1 Dec 2023 16:09:06 +0000
Message-ID: <20231201160925.3136868-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231201160925.3136868-1-peter.griffin@linaro.org>
References: <20231201160925.3136868-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add gs101-pmu compatible to the bindings documentation.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index 28e2cb50d85e..ce1bba980961 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -15,6 +15,7 @@ select:
     compatible:
       contains:
         enum:
+          - google,gs101-pmu
           - samsung,exynos3250-pmu
           - samsung,exynos4210-pmu
           - samsung,exynos4212-pmu
@@ -35,6 +36,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - google,gs101-pmu
               - samsung,exynos3250-pmu
               - samsung,exynos4210-pmu
               - samsung,exynos4212-pmu
-- 
2.43.0.rc2.451.g8631bc7472-goog


