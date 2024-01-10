Return-Path: <linux-serial+bounces-1354-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1FC82859B
	for <lists+linux-serial@lfdr.de>; Tue,  9 Jan 2024 12:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD0C288AB4
	for <lists+linux-serial@lfdr.de>; Tue,  9 Jan 2024 11:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9357F374DE;
	Tue,  9 Jan 2024 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOJ5hNV3"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA05374F5
	for <linux-serial@vger.kernel.org>; Tue,  9 Jan 2024 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e4d64a431so7663885e9.0
        for <linux-serial@vger.kernel.org>; Tue, 09 Jan 2024 03:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704801494; x=1705406294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDqHqkYWCvXcpyV9Kf2FI0tycX3cK2Ybt1CYEwNoFFU=;
        b=LOJ5hNV3TCDSATXaG9YO10Nqmi5PVa/CYqAvYC7/CHL4ZvXIBQJkJyAsnr+O9KzGzE
         mOZYFi659zT2hU6wtdWGQ6ryBeIMv0XXO7g96i29nGJI23AlL2H+Xg+S/AL4S7Ytqd5h
         KKPgrkNYSvi8OyJgZAMEH34QnkpNiAbRKIxzGOQW7KOFVZzDEUuD2aUY1ZWRY01FF6ca
         VgVnyhxJTzm+XOKxKUqJnqPJoqJ5tDNiWOkIl5LXmZ2r7SBQdFkSr4+RePaxtTpAChxx
         eq+4uwZLAR5R1onej5BmjUq5+tWpSVfkBpruK1aOhpUUvYi+m6xTz5EUdbAsj4wb3fG1
         Khzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704801494; x=1705406294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDqHqkYWCvXcpyV9Kf2FI0tycX3cK2Ybt1CYEwNoFFU=;
        b=h8dmqjNmH6UE85QcL/0Tk6tsK19gsGs5beW63YtWx2bpC91R4rv+CsTlbGqFP/qhU1
         e1Nt4o1kw3byN8ALRPx7/T5n7c+LtjcaNik3MK2RSMHz2vPGEUOZSwVGvE3t++B7WvX9
         I43laQgDDGZLJw943tAMHQIwUvu3Gfecz9ayB0x2CKtHb5ZGRB8feb7RrnJIYerp236J
         BDiKTkVocQbqoxbKU0SwQH2ucAlDVL4Bdrp4pIoxYswGx4SNt3DbQxi7ocF22LFzLAd5
         N4qpHHLPERJ+A63pypyb0UTrVKByaIQ6bfi6fcJBYN78zAVK0cWuvBoBSZ55y7ZgsDNI
         u06A==
X-Gm-Message-State: AOJu0YxYZK7tupOM9/IX5KFmu9UTPghRmp/0UBzOsL8HWO+DVN/wfAzK
	2gX4OB21RBYcxVpZpL8Lt4b7SJf2UPkoJA==
X-Google-Smtp-Source: AGHT+IGwQMwWl3QXQnxhw1gxOyXaO9axzsxS2FGRFYoTx/J99yyyVOFhY+bi6PDQfHiyjIPTO1B/UA==
X-Received: by 2002:a05:600c:458d:b0:40d:5b7b:8f18 with SMTP id r13-20020a05600c458d00b0040d5b7b8f18mr2812086wmo.81.1704801494275;
        Tue, 09 Jan 2024 03:58:14 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c314400b0040d7c3d5454sm14454520wmo.3.2024.01.09.03.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 03:58:13 -0800 (PST)
Message-ID: <8a55e1d9-c102-4cdf-8f23-edc40889cf6d@linaro.org>
Date: Tue, 9 Jan 2024 11:58:11 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: clock: google,gs101-clock: add
 PERIC0 clock management unit
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: peter.griffin@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
 andi.shyti@kernel.org, alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com,
 cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org,
 andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, kernel-team@android.com
References: <20231228125805.661725-1-tudor.ambarus@linaro.org>
 <20231228125805.661725-2-tudor.ambarus@linaro.org>
 <20240109040315.GA2619804-robh@kernel.org>
 <f695f2c0-2d4e-484c-9faa-7d8b28362541@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <f695f2c0-2d4e-484c-9faa-7d8b28362541@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/24 11:09, Krzysztof Kozlowski wrote:
> On 09/01/2024 05:03, Rob Herring wrote:
>> On Thu, Dec 28, 2023 at 12:57:54PM +0000, Tudor Ambarus wrote:
>>> Add dt-schema documentation for the Connectivity Peripheral 0 (PERIC0)
>>> clock management unit.
>>>
>>> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>> ---
>>> v2:
>>> - fix comments as per Sam's suggestion and collect his R-b tag
>>> - Rob's suggestion of renaming the clock-names to just "bus" and "ip"
>>>   was not implemented as I felt it affects readability in the driver
>>>   and consistency with other exynos clock drivers. I will happily update
>>>   the names in the -rc phase if someone else has a stronger opinion than
>>>   mine. 
>>
>> I'll defer to Krzysztof.
> 
> I miss the point why clock-names cannot be fixed now. This is the name
> of property, not the input clock name.

They can be fixed now. I've just aired the fixes at:
https://lore.kernel.org/linux-arm-kernel/20240109114908.3623645-1-tudor.ambarus@linaro.org/

Preparing v3 for this patch set to include the updated names here too.

Thanks,
ta

