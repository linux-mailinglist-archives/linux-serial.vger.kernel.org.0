Return-Path: <linux-serial+bounces-858-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCBB80F701
	for <lists+linux-serial@lfdr.de>; Tue, 12 Dec 2023 20:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E4BB20F97
	for <lists+linux-serial@lfdr.de>; Tue, 12 Dec 2023 19:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49EA63592;
	Tue, 12 Dec 2023 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQlyHxYf"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53212A6
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 11:39:44 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso30127605e9.0
        for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 11:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702409983; x=1703014783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU5RbQo6yU19wzCnPIdhHQhCfrzZV9IA9nmUM54hRn4=;
        b=HQlyHxYfqYCBAdv2zlps6HS1rwDkrDp8jJZh/rC7aetTGk5pS3PG7m2GK0AU2VE1UY
         LWsJLMm4Do8IM/3cd1nyIUn6s49TBjFxaj1dDDHdpjH10LxiBKinH1ahcCSCYAlR3yi1
         9Ig5TBEFIEtWmDdz+iVyiJ7HSYWZAcEK/HeKzzAtuvrPVLWYN9QO+gd3dLMUHug8Cfsr
         kR5p71O/mtKGSJCu5b2L43PVUoOVKeg6TKhEv0E5+11sSS7Mn5/aa7N8c+2ZRHDhTpnN
         y2Dp08ZI27f9LSHpav0hNMVw6v4U4CMuuF27DawQ9d05IFhxARhPzWv18EE08iRm1zzn
         VMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409983; x=1703014783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HU5RbQo6yU19wzCnPIdhHQhCfrzZV9IA9nmUM54hRn4=;
        b=OJ2lZK/rWv9c4gxkF26NH6ZEf0E63vaNRbJJ0QHUTYujc2HLctTR6stR3X1cUPpr5L
         /AuFeLkzMGoLxa9yG0m0Aai/h5mHBb0cCRLErGjfigN4Fq6c7FQuOgrzvMSJo0nl5I2p
         G3ekheKeTb4nRmhGPIY+xrgO2Zi7X9utyjsNLVayJaEWRjLKGRG1n6WfciILyGAMj5NP
         POj9F4hxfBeqWzWp/7aJeq7/LobLOrNOMglofr3vczV7HYfRdQjba9kIbs7eQsf8O1GX
         62jD7veuyAjMQEzNtWuK5l2pEFmfbu9ZhY5eRAAn8mFL31x8Y7xDHsvqyxNCoEyfIt4A
         k5Mg==
X-Gm-Message-State: AOJu0YzRetCSOo7JPQAHTPJxw4QO0OkGNEX1RKDj1VqpCjCbV+k72Nm1
	DbjS+2PPXEBLNRQWZmsgf+fi/w==
X-Google-Smtp-Source: AGHT+IGPurVjTAMMlyJVVpPYaeBs9uu+XLoCG94/B3i6Isrtg80koLVV4yN6mfxoVxf49RaSEPKFpQ==
X-Received: by 2002:a05:600c:4f41:b0:40c:2d74:b9b with SMTP id m1-20020a05600c4f4100b0040c2d740b9bmr3324675wmq.24.1702409982887;
        Tue, 12 Dec 2023 11:39:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b003fee6e170f9sm17345530wmq.45.2023.12.12.11.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:39:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
	alim.akhtar@samsung.com,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Subject: Re: (subset) [PATCH v7 13/16] tty: serial: samsung: Add gs101 compatible and common fifoszdt_serial_drv_data
Date: Tue, 12 Dec 2023 20:39:18 +0100
Message-Id: <170240988144.242356.2200926663420450424.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211162331.435900-14-peter.griffin@linaro.org>
References: <20231211162331.435900-1-peter.griffin@linaro.org> <20231211162331.435900-14-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Dec 2023 16:23:28 +0000, Peter Griffin wrote:
> Add serial driver data for Google Tensor gs101 SoC and a common
> fifoszdt_serial_drv_data that can be used by platforms that specify the
> samsung,uart-fifosize DT property.
> 
> A corresponding dt-bindings patch updates the yaml to ensure
> samsung,uart-fifosize is a required property.
> 
> [...]

Applied, thanks!

[13/16] tty: serial: samsung: Add gs101 compatible and common fifoszdt_serial_drv_data
        https://git.kernel.org/krzk/linux/c/c95f5b21a0eaa4a2701c28e2b209f9a7e09cd4f0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

