Return-Path: <linux-serial+bounces-4791-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4BD91B52C
	for <lists+linux-serial@lfdr.de>; Fri, 28 Jun 2024 04:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685B61C21BBF
	for <lists+linux-serial@lfdr.de>; Fri, 28 Jun 2024 02:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AA418633;
	Fri, 28 Jun 2024 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="VrcU1cKb"
X-Original-To: linux-serial@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77589125DB
	for <linux-serial@vger.kernel.org>; Fri, 28 Jun 2024 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719543100; cv=none; b=f1pK1Wot363neaulT+yOyjtfeCUESMxdKldc13VsGKo+sCEYYh/ADKHWI+A+zkPXAPkXJg66SaWbop4DC3oXqxq06ctBmOmFf46GpBgtn8nWoEGD34sx6eIZNcX/0IfeLPCE0TKHOz5P2uCgjaRXxxwaFS4nYZDbxRph+53Iw4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719543100; c=relaxed/simple;
	bh=khjubVaOAxvuDngZUIjd9rj1xxZGvg6ZvVt20JfCRyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYePun5zFKs0XycOyrB222Uzl5osVZ7f6dFJy++FCtJ3HmWUFGzbc298zFSLN93X2OU7H8kU3ftVauYaSu76ICgjwP87YtJkjv79Q+Ha3VQed1LRdaPK/OOQefqvlzkqie6uTmKBW2npjA+7frHH5o0mSAicKyEWZVYwhvxI1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=VrcU1cKb; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id Mx23s6dhKxs4FN1hyshr7L; Fri, 28 Jun 2024 02:51:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id N1hwsGMO2sT9BN1hwsjJ2h; Fri, 28 Jun 2024 02:51:28 +0000
X-Authority-Analysis: v=2.4 cv=LIutQ4W9 c=1 sm=1 tr=0 ts=667e2531
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=_Wotqz80AAAA:8 a=ijWZ9xZranq7hUifA4EA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rKRBHzZAJa8Y5uaYN9KzLXlsQxprz1t3tpmpYAAPIhA=; b=VrcU1cKb+9PGWke1O9Eg07jCns
	cEqyuC544UwG5leDIPUCgceMBYSUMRHn9IY1WY5WRoINOFKk0ysi/r30O9AZSsZidOw5RZiGijYJx
	UuxpvyG4Rx4IBZHnm+Axp5mHRB+6KrIWIrv4uQL3Ti++VdCLPxs9XtRdRleTYZFoVAQHaS++tysuP
	lm+mHRqfVMrfp6PQac+PwDQlp4cIniJFazfMlVbg9vsHkhOL+zsUaOr9K1WzDQz9ZB2hHMU47r7W0
	6a4vvOmWKNa2K2CekofNvgNM7wDZvLU6PHbi5zjp/47osjSB0fLMDRNIb/1iWNCoD0UpbmdQCUF7p
	PlGiuv4Q==;
Received: from [201.172.173.139] (port=40218 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sN1hv-003DhV-1b;
	Thu, 27 Jun 2024 21:51:27 -0500
Message-ID: <4c347ab7-97f6-4e18-9aca-dcb48e8fc75a@embeddedor.com>
Date: Thu, 27 Jun 2024 20:51:23 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: mxser: Remove __counted_by from mxser_board.ports[]
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-serial@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
References: <20240529-drop-counted-by-ports-mxser-board-v1-1-0ab217f4da6d@kernel.org>
 <202406271009.4E90DF8@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202406271009.4E90DF8@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sN1hv-003DhV-1b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:40218
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMuSyLcRSXjWd+BXZa3uxiWdkfFycGTgCQFOnx8yJJMold46poGNvzVCcmczslbGdhqMfuUGhMdu3/1WGM6Akn7DOzTdJN1yDYD02qPGwYUPp2j7Xgth
 u1KdcHEPmpIPr/N63sJ+0xRj7pbZOl4gWmBdN+zuWvHhMjkzh+1xVQSoeEeIRBLsOfjkU+5CFI99dJ4Y7fO1LO5AJj+2u3aC40eHu7bRBaGUkEUzOhpp3U5/



On 27/06/24 11:14, Kees Cook wrote:
> On Wed, May 29, 2024 at 02:29:42PM -0700, Nathan Chancellor wrote:
>> Work for __counted_by on generic pointers in structures (not just
>> flexible array members) has started landing in Clang 19 (current tip of
>> tree). During the development of this feature, a restriction was added
>> to __counted_by to prevent the flexible array member's element type from
>> including a flexible array member itself such as:
>>
>>    struct foo {
>>      int count;
>>      char buf[];
>>    };
>>
>>    struct bar {
>>      int count;
>>      struct foo data[] __counted_by(count);
>>    };
>>
>> because the size of data cannot be calculated with the standard array
>> size formula:
>>
>>    sizeof(struct foo) * count
>>
>> This restriction was downgraded to a warning but due to CONFIG_WERROR,
>> it can still break the build. The application of __counted_by on the
>> ports member of 'struct mxser_board' triggers this restriction,
>> resulting in:
>>
>>    drivers/tty/mxser.c:291:2: error: 'counted_by' should not be applied to an array with element of unknown size because 'struct mxser_port' is a struct type with a flexible array member. This will be an error in a future compiler version [-Werror,-Wbounds-safety-counted-by-elt-type-unknown-size]
>>      291 |         struct mxser_port ports[] __counted_by(nports);
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>>    1 error generated.
>>
>> Remove this use of __counted_by to fix the warning/error. However,
>> rather than remove it altogether, leave it commented, as it may be
>> possible to support this in future compiler releases.
>>
>> Cc: stable@vger.kernel.org
>> Closes: https://github.com/ClangBuiltLinux/linux/issues/2026
>> Fixes: f34907ecca71 ("mxser: Annotate struct mxser_board with __counted_by")
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Since this fixes a build issue under Clang, can we please land this so
> v6.7 and later will build again? Gustavo is still working on the more
> complete fix (which was already on his radar, so it won't be lost).
> 
> If it's easier/helpful, I can land this via the hardening tree? I was
> the one who sent the bad patch originally. :)

+1 (It'd be great if you take it.)

Also, it'd be great if somebody can confirm this is an acceptable fix
for the issue:

https://lore.kernel.org/linux-hardening/c80e41e6-793e-4311-8e15-f5eda91e723e@embeddedor.com/

Thanks
--
Gustavo

