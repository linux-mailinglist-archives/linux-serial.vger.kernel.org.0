Return-Path: <linux-serial+bounces-889-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6865811E85
	for <lists+linux-serial@lfdr.de>; Wed, 13 Dec 2023 20:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497A61F21730
	for <lists+linux-serial@lfdr.de>; Wed, 13 Dec 2023 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F2B68262;
	Wed, 13 Dec 2023 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pggn+kD2"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E8610D
	for <linux-serial@vger.kernel.org>; Wed, 13 Dec 2023 11:16:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso44200015e9.1
        for <linux-serial@vger.kernel.org>; Wed, 13 Dec 2023 11:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702494981; x=1703099781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCCBoGTTagMUmsTWYC8ydPGVizeqgOl7xeRy20+SMfY=;
        b=pggn+kD2+bwXKPVY+g+RgQ4GRfpVSxPuHvZsFgAsP+0tSvi8lVfQDMyiZZ5M3Zgflu
         KzRqQxcoVuYMiZPG48a4KCV1IlXF0xs49clQQfG3u4SFD1pk8losJ4sLfupWfGR9vJDO
         EWzUnbMRgp5OFuN9Kma4Qx6YgSZH+JMuU/TyHFrQ6kixKjaQZnvAbQNCKE87S4nzMk2m
         wE71DWIKxDO0gMx+dfHSrQ0rKNlZjARBctZVAFZRe04z8GqID9xOvlthKjHQxCkGO3et
         s2xGVfEFhVest5m2oZf4dNE1kUmP8wIX8gQjs0eedNR2oJkOzdISEp9RWsOm3WTd9o0/
         6ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494981; x=1703099781;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCCBoGTTagMUmsTWYC8ydPGVizeqgOl7xeRy20+SMfY=;
        b=TAH0m2usX+G8DOPN7kW2T6TcqaBhN3bQ6NRJCV4SYfkAzWt0OfYqdew2gQ5qNmHqYn
         SVXcPDznHxjEVPvNbV127MqlvQjlupFOh0X1UhPwHzUSbWJ2NkHUP0qt2XbCBy1TmwBi
         +qFGyEmf0Hc5Wj/jW9YppxhPrs/uI37pXGmHBkciRlgQ0Z4bqhNKgMdBhy2hBtHNCL2g
         nwGH+alxBRa50mNAqv1kDVBojnmWc8VUDAPn1+BHb34e0Z0rb+KWicy2kWeRcqumHtDa
         1lJ5ctoxQJ702U2EQAGAQA7LlCBiveTceMqg8QNCzkJCOLeu+pLrAHM2FtNVeYu7iFdk
         UTAQ==
X-Gm-Message-State: AOJu0YyuUzq029B2TSsO34BOjyLy00aLLoSmwG/PC0IfeQz0AVNxgYCb
	RAf9vMvH6kmSHf4O8+1aAClr0Q==
X-Google-Smtp-Source: AGHT+IE3AK9RG0WLGmInBceE9RcD51sWdzqOKgsz6eeydNkXttfe5yCZB5W1ZQUwSLroFIMEtnPKSg==
X-Received: by 2002:a05:600c:3ba6:b0:40c:909:fdb4 with SMTP id n38-20020a05600c3ba600b0040c0909fdb4mr5169234wms.90.1702494980824;
        Wed, 13 Dec 2023 11:16:20 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b0040b37f107c4sm20190085wmo.16.2023.12.13.11.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:16:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org, 
 tomasz.figa@gmail.com, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
 wim@linux-watchdog.org, linux@roeck-us.net, catalin.marinas@arm.com, 
 will@kernel.org, arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
 semen.protsenko@linaro.org, saravanak@google.com, willmcvicker@google.com, 
 soc@kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, kernel-team@android.com, 
 linux-serial@vger.kernel.org
In-Reply-To: <20231211162331.435900-11-peter.griffin@linaro.org>
References: <20231211162331.435900-1-peter.griffin@linaro.org>
 <20231211162331.435900-11-peter.griffin@linaro.org>
Subject: Re: (subset) [PATCH v7 10/16] watchdog: s3c2410_wdt: Add support
 for WTCON register DBGACK_MASK bit
Message-Id: <170249497853.308886.14491280069451216694.b4-ty@linaro.org>
Date: Wed, 13 Dec 2023 20:16:18 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 11 Dec 2023 16:23:25 +0000, Peter Griffin wrote:
> The WDT uses the CPU core signal DBGACK to determine whether the SoC
> is running in debug mode or not. If the DBGACK signal is asserted and
> DBGACK_MASK bit is enabled, then WDT output and interrupt is masked
> (disabled).
> 
> Presence of the DBGACK_MASK bit is determined by adding a new
> QUIRK_HAS_DBGACK_BIT quirk. Also update to use BIT macro to avoid
> checkpatch --strict warnings.
> 
> [...]

Applied, thanks!

[10/16] watchdog: s3c2410_wdt: Add support for WTCON register DBGACK_MASK bit
        https://git.kernel.org/krzk/linux/c/6584cd34901056bc12e015781e4adf03b44ba485

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


