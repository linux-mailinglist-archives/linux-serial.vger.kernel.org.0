Return-Path: <linux-serial+bounces-7602-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92777A160DB
	for <lists+linux-serial@lfdr.de>; Sun, 19 Jan 2025 09:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4D31647FC
	for <lists+linux-serial@lfdr.de>; Sun, 19 Jan 2025 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4118CBEC;
	Sun, 19 Jan 2025 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQeScjpB"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE584A2B;
	Sun, 19 Jan 2025 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737273660; cv=none; b=jEkrW3GlNPcOlBRKHqcgIEnSdLgiyGKpNO8s/3iBIQaR7ciG9v5PpDCsq/Y/Hcpo+MRz4tX3tzijl6P1GdMcuPFaBJjAobdfbWJX/ceDBlYjwDntTdgN4UJu7EwKn6bZXFMw7b4A2Zt4rzkoEX8jxu8X7+e9v/yu2vtNY/IY/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737273660; c=relaxed/simple;
	bh=Exaq905HrcprxKc1KAvY91bVYocDmSRdGAvgWZDLYOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3ucK/6x0xzCM9DLwP6sda91zRXg7YtldpqAbPb0PB/5Y64iVKz6TIvlofjS0AYvrM+pSMGw9DdfWb9Y2sOoOzs+mVQBB/DVuGSkIgP00aw/M0CmMIhsNMkHy86s6UTvVHfCA6lYrdSJ5+9OdwTtA8mJVRkONkaxBRKKwctEeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQeScjpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A11C4CED6;
	Sun, 19 Jan 2025 08:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737273660;
	bh=Exaq905HrcprxKc1KAvY91bVYocDmSRdGAvgWZDLYOQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RQeScjpBSevg6mKdjlpwQ2pNbD2TKw/4d/BbvuvyXtBEdAdNWSK3+x2XXaHmAGaCD
	 8iyeLv8tBXehbkx3ehBTRROm5vgXPv7Rp6kf0rlabbBXYuYpOLbPCQrDHV/+arKwRx
	 67sqS+Zv87XUS7m1+z5IQEuwyAj3b5mwL1riitioXB4B4gfbRE56Lp2fizgJkDVR7N
	 3n8iJkcx7CotFyEuwwuX7RRU1E2sWWmmktIYr7aAk2GKu9r1eEQQv3/bzrd4ocI0Cn
	 YDozwoD+C4erlcvP/fLhxFAZaQXy09ufKay56QIkpFgKvN1o9U3RlZUVn316L2c+z8
	 jF+7tBETjWfvQ==
Message-ID: <20211059-ec50-4b9a-9625-e69d9971cb68@kernel.org>
Date: Sun, 19 Jan 2025 09:00:55 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External Email] RE: [PATCH v2] serial: sc16is7xx: Extend IRQ
 check for negative values
To: Andre Werner <andre.werner@systec-electronic.com>,
 Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
 "andy@kernel.org" <andy@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
References: <20250117171822.775876-1-andre.werner@systec-electronic.com>
 <AS8PR05MB9810FA4CE091AD28EEE9B73683E52@AS8PR05MB9810.eurprd05.prod.outlook.com>
 <23799bf9-c61b-f528-e0e5-03a96d232ecc@systec-electronic.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <23799bf9-c61b-f528-e0e5-03a96d232ecc@systec-electronic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 01. 25, 18:20, Andre Werner wrote:
> Dear Maarten,
> 
>>> -----Original Message-----
>>> Fix the IRQ check to treat the negative values as No IRQ.
>>
>> It seems to me that this is a real fix and needs a Fixes tag.
>> See below.
>>
>>> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
>>> ---
>>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
>>> index 7b51cdc274fd..560f45ed19ae 100644
>>> --- a/drivers/tty/serial/sc16is7xx.c
>>> +++ b/drivers/tty/serial/sc16is7xx.c
>>> @@ -1561,7 +1561,7 @@ int sc16is7xx_probe(struct device *dev, const struct
>>> sc16is7xx_devtype *devtype,
>>>   	/* Always ask for fixed clock rate from a property. */
>>>   	device_property_read_u32(dev, "clock-frequency", &uartclk);
>>>
>>> -	s->polling = !!irq;
>>> +	s->polling = (irq <= 0);
>>
>> When irq>=0 these two lines above have a different outcome!
>> irq==0   =>   !!irq==false   <=>   (irq<=0)==true
>> irq==1   =>   !!irq==true   <=>   (irq<=0)==false
> 
> Thanks for the advice. I have not seen this all the time I looked at the
> code. I accidentally forget to delete the second '!' as I did with the code
> tested at the embedded device. Thanks for the advice.
> 
> Should I need to submit this patch again with a Fixup prefix or what needs
> to be done?

Resubmit with complete description on what is broken and when. Incl. the 
Fixes: tag. The comment from Maarten suggests that it is broken in a 
completely different way than you describe in the commit log.

thanks,
-- 
js
suse labs

