Return-Path: <linux-serial+bounces-1250-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44E5824529
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jan 2024 16:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396A01F21B0D
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jan 2024 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B02420D;
	Thu,  4 Jan 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sczJVuWo"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64E241F4
	for <linux-serial@vger.kernel.org>; Thu,  4 Jan 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso819981a12.2
        for <linux-serial@vger.kernel.org>; Thu, 04 Jan 2024 07:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704382891; x=1704987691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7/ShbpEf54yAHHl4FpslzJHf7YewK4v2kQSkVZU+B4=;
        b=sczJVuWo22scTW0OzGAoAX0PBt16+MkVIMR4nN3OaE3+AoSnpO4HKdFpGWINe13jrK
         ziYPu4yBpgnEV0QLX8sjyXVW1det+AGO6K8TWccQNL50A+ySoRpEui9bmUf/g3UB+3WS
         9HJY2gHtJdEqZoW/FNMZTqetYt2Fq8TdOVHdMff1Xm8vhelUAW6kVIVChhJHdDKo4xgp
         W9OREhYs7SIoQw7N3yEBMkuliQArACRKbdjuutr5dPDyzk4J0DKOZcELOdx2TDAhsSCh
         nr9khGz5XoXwf0TOyoycQP3WVLKv6AvYsS6VopvonvWdN0oysriAdPOhlAiJu3zyF4Fv
         b8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704382891; x=1704987691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7/ShbpEf54yAHHl4FpslzJHf7YewK4v2kQSkVZU+B4=;
        b=U9K7hmz/GWLb5MhsnU53fNi0SrMBLjtc86gKsmBT/wr7gnKAqNh7waZERPtm/uAa5t
         PrBJJcCcgpp45vfxOlPEWWQwVdlsXk/YXN0aPzhz0f/X3Ow9Vb5Tojq2A69BTOrMmJ0G
         IxcWzyrw7iD1K8e1YU7ilyIhLP62wi4CyNv8BJt7XKxSR2YaKqUC83IHrYuqMC8ML/Pp
         pPtHW6yKZ4yFLPyJnde6AzBWFH2zaorHILLzna5epMQzY9fxvcLtMe4CG8RiSUgPDtu/
         8/7bBrE0ZhicvfY4oCbaDDkl4mNBQTE3r9OEX2E2m3mJtDRLxg7yg9/Hh6oGgLjcq5Ab
         rpvA==
X-Gm-Message-State: AOJu0YzQYkt3FNJLIqg7SrkLj0TNSj4rzZnNtCtwmKwVe1XQ3tXC+Kt9
	CSIz7ZE0IMTtaliWqNtKSoymLgq+0tDpqw==
X-Google-Smtp-Source: AGHT+IEah0e7M2KrNungIWa3+GEmC8D68fB1t4UAkc0BcqWffzA+XwCkKbcFVX1Hg/VoQkLod6TmbQ==
X-Received: by 2002:a17:906:3a09:b0:a26:a245:9cef with SMTP id z9-20020a1709063a0900b00a26a2459cefmr351361eje.64.1704382891320;
        Thu, 04 Jan 2024 07:41:31 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906d18f00b00a28ba0c3821sm1132678ejz.101.2024.01.04.07.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 07:41:30 -0800 (PST)
Message-ID: <a3a9df6a-4270-4076-9e9b-ce2fc7284d54@linaro.org>
Date: Thu, 4 Jan 2024 15:41:28 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] tty: serial: samsung: prepare for different IO
 types
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
 alim.akhtar@samsung.com, jirislaby@kernel.org, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com, arnd@arndb.de,
 semen.protsenko@linaro.org, andre.draszik@linaro.org, saravanak@google.com,
 willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
 kernel-team@android.com
References: <20231228125805.661725-1-tudor.ambarus@linaro.org>
 <20231228125805.661725-5-tudor.ambarus@linaro.org>
 <2024010432-taco-moneyless-53e2@gregkh>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <2024010432-taco-moneyless-53e2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/4/24 15:32, Greg KH wrote:
> On Thu, Dec 28, 2023 at 12:57:57PM +0000, Tudor Ambarus wrote:
>> GS101's Connectivity Peripheral blocks (peric0/1 blocks) which
>> include the I3C and USI (I2C, SPI, UART) only allow 32-bit
>> register accesses. If using 8-bit register accesses, a SError
>> Interrupt is raised causing the system unusable.
>>
>> Instead of specifying the reg-io-width = 4 everywhere, for each node,
>> the requirement should be deduced from the compatible.
>>
>> Prepare the samsung tty driver to allow IO types different than
>> UPIO_MEM. ``struct uart_port::iotype`` is an unsigned char where all
>> its 8 bits are exposed to uapi. We can't make NULL checks on it to
>> verify if it's set, thus always set it from the driver's data.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>> v2: new patch
>>
>>  drivers/tty/serial/samsung_tty.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index 66bd6c090ace..97ce4b2424af 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -72,6 +72,7 @@ struct s3c24xx_uart_info {
>>  	const char		*name;
>>  	enum s3c24xx_port_type	type;
>>  	unsigned int		port_type;
>> +	unsigned char		iotype;
>>  	unsigned int		fifosize;
>>  	unsigned long		rx_fifomask;
>>  	unsigned long		rx_fifoshift;
> 
> Is there a reason you are trying to add unused memory spaces to this
> structure for no valid reason?  I don't think you could have picked a
> more incorrect place in there to add this :)
> 
> Please fix.
> 

Will put it after "const char *name".
Thanks,
ta

