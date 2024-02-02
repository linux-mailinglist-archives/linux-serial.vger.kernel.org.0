Return-Path: <linux-serial+bounces-2041-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EE28469CB
	for <lists+linux-serial@lfdr.de>; Fri,  2 Feb 2024 08:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DAA1F22745
	for <lists+linux-serial@lfdr.de>; Fri,  2 Feb 2024 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29742179A6;
	Fri,  2 Feb 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jH+RmLng"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7117C6A
	for <linux-serial@vger.kernel.org>; Fri,  2 Feb 2024 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860201; cv=none; b=KW18586UVqUaDKtFGon2MAYAxOnfX4RVyG6oOLYDyVNg3HlL9z6EJsQol0R5z9XIrJ69OkLlE044zTXoSzFXFz87u/yzQEpw+LeAT8Zz2CI0GojjEUbmhZXhgqiQh107RTKqirksbEgGZtu7rfTTAr6pRdu+lMBSpoS+WY6FEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860201; c=relaxed/simple;
	bh=jF9Z/L0GrnrQhus28eWVYlzVgYe2cujrFKKfN39QOIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpBdFPbOB6wzxumamDjMp7yvH2W8BCIS164CLz52aJwW8Og7R7s8aKWVwosaQCMax6Sx4/t1KIf0hypSXsGCvfc8Dz1de3POzgjxZPllGst1fLWY83j+DdvSxpcX/619E6VnNXbw8TDxFuRit2QNxoqKWWrNIm+9rC/3HmE/iQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jH+RmLng; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fb94d42e4so13948255e9.2
        for <linux-serial@vger.kernel.org>; Thu, 01 Feb 2024 23:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706860198; x=1707464998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1KYL4v/BseIDWOK1Ox6I9qnlKESe6QQSN5i4McXAWM=;
        b=jH+RmLngUoP6DF2XGttJYusRlBqylYylMVwv8x3jkyohJ0yeOuZXz9Ogzs+LPMJy4g
         KbDB7X28A8TT+f8SWh8IXpSpymXzP3d9Wa+pV31xOy8TwF+mDZjq3dHJy9MoP82mgZ3z
         o0NbIxP5tj3T4uo4TlLlS7+68VP7VLjRWsTtBi2vUDq9YzjBaBnD+MbRVFaSCGqvKb/6
         tBuSAslvE0tGO6ELHjSCjzqQ/xmULkT4uy++7oQrLxTQjhHL2jyGc8ix2iSEocGANAfw
         KqgDOqBeuMgN8NRUzsfsZvDgI9ZY08++ZwrUEEnXEcyXmxqlUDoWjfb4flxIM33TtcpX
         UwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860198; x=1707464998;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1KYL4v/BseIDWOK1Ox6I9qnlKESe6QQSN5i4McXAWM=;
        b=CXC2N1s4mz7dq95/L0dEqNrYDNLcrM2Sy4C99S6lsr9ZXhj3+opA2ymvdTD6Y0zKfb
         gWBdi4cZi5RThP7sUs3YUnFFf7TrHQoQ62kWqUWTVD2og17Qk+QoLo1gtaG59mcIzVJP
         r5L80+68+6+Zoo8msgtYzXi53JGR/Xjwkcd4a33mvXySmd+SyoNnDRCQw98AIM0LhpHm
         RCpJ7w4VeTNOjo5KsIm7ZCl6Id3RoFe/Lg59mDk0JHI4xkUOZfPwN7/hxwGsU51f5jI0
         qEKzTXigJSbGZIovBWmU7foICnuxPYW/MVNf0gIAgIcc5qP63c6d+4cfcZxmlRw9TrMH
         ywTA==
X-Gm-Message-State: AOJu0YwRZXF0u5g0kmA69Z1X7XUNdQgDLsaBSmFtmoVjz/AbVFNfLhCH
	bKI7lWt9FImvgiirA2HeW2y03BehXpP+M+r+mVBsG0547MwAx8xDP5PJVG5GBR8=
X-Google-Smtp-Source: AGHT+IHgiZNEJmswrZIFAei83dk3wcNEBLMSW9u/5Y+SVExdG015GfMRUFUt8IrQAK45hMnoH3u8MA==
X-Received: by 2002:a05:600c:154d:b0:40e:fb93:96a8 with SMTP id f13-20020a05600c154d00b0040efb9396a8mr3652699wmg.34.1706860197470;
        Thu, 01 Feb 2024 23:49:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXgks9Wqt+/rwdqaGRvkmaLkQssPSFDhOZI+FPnIg6wSEPuK1BGkza3AseCmLJZ4W6z9tuzBn3mAtGq5ViwTgBf21K5YHKA91OU1q1kthsnckCeAv4pwH6wejVXAM0GM8XroeTslCYWov4+6KeMNEFCx+wt4RnFYUGLX+K89qD3qHMuQykQMrIgrkJ+p4WwkPX+rbfQdyWejgQKfQxkj4QSw0F0QimtJX3iMme6jrwY2ta0O6qHNbxtG92YWfCxrZiToPUHWAHGOHo3gOdVk2U0Mdx3EQlfDuHCH7iCRqVrKVwmAlnt
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c420c00b0040ef9ffd3c1sm6473587wmh.19.2024.02.01.23.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 23:49:57 -0800 (PST)
Message-ID: <bed3d775-2d80-445f-bf28-b28a17a6370c@linaro.org>
Date: Fri, 2 Feb 2024 08:49:55 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: samsung: Remove superfluous braces in macro
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20240202010507.22638-1-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240202010507.22638-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 02:05, Sam Protsenko wrote:
> Commit 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
> removes parameters from EXYNOS_COMMON_SERIAL_DRV_DATA() macro, but
> leaves unnecessary empty braces. Remove those to fix the style. No
> functional change.
> 
> Fixes: 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 8 ++++----

I am pretty sure you did the patch on some old tree, not mainline rc1.
Please work on maintainers tree (or linux-next).

Best regards,
Krzysztof


