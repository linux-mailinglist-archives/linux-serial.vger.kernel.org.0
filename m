Return-Path: <linux-serial+bounces-2909-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5269F88A179
	for <lists+linux-serial@lfdr.de>; Mon, 25 Mar 2024 14:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A1F1F39B57
	for <lists+linux-serial@lfdr.de>; Mon, 25 Mar 2024 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCB11B5311;
	Mon, 25 Mar 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tH2dQjst"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297813BAC5
	for <linux-serial@vger.kernel.org>; Mon, 25 Mar 2024 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353251; cv=none; b=EtcpVZ5+ycwwD/cnslzD67q+HiFFq1l9eEE4EIyfQF1FHsaHtcRnbzNX6zyldHXG/Gy9D4rdMeDadtT3F7TAIIcDxuhxV1WzMg1RIV7AhbTtu6Nn9cB7gZqH9kJLfwFjuTXEI4uKfzesvUPEIzGMZ28FfM5m+YpMGzQF1M+UQkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353251; c=relaxed/simple;
	bh=SiL2cOC4UkSRN6To77htH0u+bIRbM+hM0ShWsbSjA9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4ZcXnpVRF0ui8tm4YNh2SgVNa3viafZNt9SZERx30T2oR6BU2jlFP/9doKa08NPGBMswsG9NKetCCS1/pla/6GRJveqLvkDExtISwMfgBifMx+JbsRaB4y3MCI2nR8izqNiaAhg/UJfBt3EmPkYITKMPixj0sPfSBxNc0DG1/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tH2dQjst; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4749eecff7so145856166b.2
        for <linux-serial@vger.kernel.org>; Mon, 25 Mar 2024 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711353248; x=1711958048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l+j9XIstmyfOIFs/mzBgM74Il3hTkmShlFDV4fvnnUk=;
        b=tH2dQjstL+yG94YwPQ47h6jcggl6EtzsTmP4OtVTHiGeWVFUFiIuCieF2Z7Mi8tWB8
         5fJlmkNO5QVzgFifFmxpOTlRHabC8e/heUq9NKsRAISDbEXA8QHE4joqTN78rJ3TkHiZ
         nxsS+liJ6mtLBM2M4JzrD37fQ+BOxjDZPwwKEN7riYkCuZI5qafs9oAcTUkkrLZm+WNz
         nQvNckqx2eJPoDnAhsBUlx3xNSCJsnfaba2EI5SFKwrSyLxYz834MkF8NdV3wSqHbTMh
         I5XMc2blo6z5ZvsUZ0LButdKq3P1Yp83b1xz8k/1Wirf2DD9O45BltNnVnITEY78RBDx
         BHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711353248; x=1711958048;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+j9XIstmyfOIFs/mzBgM74Il3hTkmShlFDV4fvnnUk=;
        b=eLQ+fsLODEidUua18hzjLuPTcbguYkyuhZMZul7bM5rqurabY4jl7/U/BBTGMfUjru
         BOmaymUDIepam1OB1UCbTUUFEcSc9xWgt9g4MAB1ZrbCv6pkHeZrvmDduAGNuCy0J+Z/
         pZu8c24hnduPzcI+0guLwmN/zklI8O3m438otmHiyxgXxutS/zJCfRSgXFFponkpwldi
         xIeRLsc4JF0N0vktvdPyZOw0hNT8wpz0A2IujOHKq+Rs6KlZUPUD1IKv81K0O8ScoYGP
         GIvYmmjiYvkwHcnmaqGEWvbnCCQONMHsKyRW/P57FSOEFAa56u8ufKbt8EDnaDzT+MpX
         st4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUShKGskCImlneDa3z/xfZ/Crj/bT1i+d8Gr2oHHm5s8In6KIGygDjfMLGj8Gtsg15Ww5W/BxcrQ+e00/KCGMN5uTzml6tY8wJjtTpk
X-Gm-Message-State: AOJu0YxQQqYwxiDu8PLDfQz+zKmnTmt4xBbiizbwBjkjjdKMvPmLCt4R
	XBmWnjM/+oouIzM+PDDo5MzIu1Y4vkbPMUgqkr/t/VkJBF7YgQfpRl/QNFCWNEI=
X-Google-Smtp-Source: AGHT+IFZHvVGYfpWttbeE5p951o+nMovN19l6HSah8/Q61kmIJu/8BNnZVhXy//VLT9+ryj4GU9sRg==
X-Received: by 2002:a17:906:7215:b0:a46:614f:f2be with SMTP id m21-20020a170906721500b00a46614ff2bemr4253911ejk.28.1711353248531;
        Mon, 25 Mar 2024 00:54:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906389000b00a46a643b6fbsm2813202ejd.15.2024.03.25.00.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 00:54:07 -0700 (PDT)
Message-ID: <5feee389-a88f-4204-a72a-78b53a9dfb55@linaro.org>
Date: Mon, 25 Mar 2024 08:54:05 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3
 support
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chester Lin <chester62515@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Marek Vasut <marex@denx.de>, Marco Felsch <m.felsch@pengutronix.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Yannic Moog <y.moog@phytec.de>,
 Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <20240324214329.29988-1-wafgo01@gmail.com>
 <20240324214329.29988-4-wafgo01@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240324214329.29988-4-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/03/2024 22:43, Wadim Mueller wrote:
> Add a compatible string for the SDHC binding of NXP S32G3 platforms. Here
> we use "nxp,s32g2-usdhc" as fallback since the s32g2-usdhc
> driver works also on S32G3 platforms.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


