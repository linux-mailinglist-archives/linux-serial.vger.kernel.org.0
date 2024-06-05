Return-Path: <linux-serial+bounces-4486-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF64D8FC8BD
	for <lists+linux-serial@lfdr.de>; Wed,  5 Jun 2024 12:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0D21F23AB8
	for <lists+linux-serial@lfdr.de>; Wed,  5 Jun 2024 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623DE190069;
	Wed,  5 Jun 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VfRHUZaA"
X-Original-To: linux-serial@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42E18FC98
	for <linux-serial@vger.kernel.org>; Wed,  5 Jun 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582478; cv=none; b=azQot4XGIyu8KTL0quBvuyuuwP/YfjpHXskU5cnUsHS03gA86touoGkg3NXtDlkj0Z6hN81s9H+X4u1X+3nNUeH3E9m/PVGI9EA10oPoddvi3BEwF7HR8WDtPAQoNMvxxmBwWHiZ6yabpAoiqvewQ91MmBIZo0jUvOIBJeTZ/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582478; c=relaxed/simple;
	bh=dyiu2jygZrrqEGYMOcxmE3p7uU2WBH9y3OBKX+yK/FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeBYf8OzVYVzti0R5FdLnl7xsdVh77RdJhVrlS3WsEYcGDk37nKeVSBl3rIFg5t8qG9aUGFqthDIm6MhRsl5r3eaBuIdgl8eWMgFx1vLEFR9CgMegAVJPS1dBKn0/VuZw01cglDcvwy0EUiIDK6bs85Vi3bIifqWMx1lPQR9G5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VfRHUZaA; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: gregkh@linuxfoundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717582473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYrcYoOYU12n4o4UT6LL7Mri1GOEVpQDhK2VAJFdRGc=;
	b=VfRHUZaABjFjbKbu6DW7PkvNCIy6N3DtqJ/UesXHbQvFpcpTxDfTdwyFm1UUQfyKY9IEx0
	vm+RelIu7XbPpg7rnxWCghbXXPERBPC6gOr27Odf00MCQRYaLz8bO3+JoEr+Pbh3MkWNzE
	EaFujBC1eq6Kv0MyX2Bk5fEJ5hUZEkg=
X-Envelope-To: kuba@kernel.org
X-Envelope-To: jirislaby@kernel.org
X-Envelope-To: jonathan.lemon@gmail.com
X-Envelope-To: linux-serial@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <cbcf7cbb-809f-47f8-bd98-e140875bc2d1@linux.dev>
Date: Wed, 5 Jun 2024 11:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
 <2024051046-decimeter-devotee-076a@gregkh>
 <cf74065c-7b68-48d8-b1af-b18ab413f732@linux.dev>
 <2024060428-childcare-clunky-067c@gregkh>
 <d59e00e1-d390-4140-b34f-58eaf13baee7@linux.dev>
 <2024060505-expose-crouch-00b1@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <2024060505-expose-crouch-00b1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/06/2024 11:05, Greg Kroah-Hartman wrote:
> On Wed, Jun 05, 2024 at 12:53:13AM +0100, Vadim Fedorenko wrote:
>> On 04/06/2024 12:50, Greg Kroah-Hartman wrote:
>>> On Wed, May 22, 2024 at 01:39:21PM +0100, Vadim Fedorenko wrote:
>>>> On 10/05/2024 12:13, Greg Kroah-Hartman wrote:
>>>>> On Fri, May 10, 2024 at 11:04:05AM +0000, Vadim Fedorenko wrote:
>>>>>> The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
>>>>>> of serial core port device") changed the hierarchy of serial port devices
>>>>>> and device_find_child_by_name cannot find ttyS* devices because they are
>>>>>> no longer directly attached. Add some logic to restore symlinks creation
>>>>>> to the driver for OCP TimeCard.
>>>>>>
>>>>>> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
>>>>>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>>> ---
>>>>>> v2:
>>>>>>     add serial/8250 maintainers
>>>>>> ---
>>>>>>     drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
>>>>>>     1 file changed, 21 insertions(+), 9 deletions(-)
>>>>>
>>>>> Hi,
>>>>>
>>>>> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
>>>>> a patch that has triggered this response.  He used to manually respond
>>>>> to these common problems, but in order to save his sanity (he kept
>>>>> writing the same thing over and over, yet to different people), I was
>>>>> created.  Hopefully you will not take offence and will fix the problem
>>>>> in your patch and resubmit it so that it can be accepted into the Linux
>>>>> kernel tree.
>>>>>
>>>>> You are receiving this message because of the following common error(s)
>>>>> as indicated below:
>>>>>
>>>>> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>>>>>      older released kernel, yet you do not have a cc: stable line in the
>>>>>      signed-off-by area at all, which means that the patch will not be
>>>>>      applied to any older kernel releases.  To properly fix this, please
>>>>>      follow the documented rules in the
>>>>>      Documentation/process/stable-kernel-rules.rst file for how to resolve
>>>>>      this.
>>>>>
>>>>> If you wish to discuss this problem further, or you have questions about
>>>>> how to resolve this issue, please feel free to respond to this email and
>>>>> Greg will reply once he has dug out from the pending patches received
>>>>> from other developers.
>>>>
>>>> Hi Greg!
>>>>
>>>> Just gentle ping, I'm still looking for better solution for serial
>>>> device lookup in TimeCard driver.
>>>
>>> See my comment on the other patch in this thread.
>>>
>>> In short, you shouldn't need to do any of this.
>>
>> Got it, thanks. I'll try to find another way.
> 
> Wait, no, please just remove all that, it should not be needed at all.

Do you mean remove symlinks from the driver? We have open-source
user-space software which relies on them to discover proper devices. If
I remove symlinks it will break the software.


