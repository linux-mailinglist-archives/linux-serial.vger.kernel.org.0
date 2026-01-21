Return-Path: <linux-serial+bounces-12490-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC0BG9AacWmodQAAu9opvQ
	(envelope-from <linux-serial+bounces-12490-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Wed, 21 Jan 2026 19:28:32 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C98465B42C
	for <lists+linux-serial@lfdr.de>; Wed, 21 Jan 2026 19:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E53D378FDE9
	for <lists+linux-serial@lfdr.de>; Wed, 21 Jan 2026 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720613A4F51;
	Wed, 21 Jan 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UU9XQWgY"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F099314A95;
	Wed, 21 Jan 2026 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013423; cv=none; b=OYd1vW4hYsVStQkBuBoq+NCqPFm4BTo5CS+fEpUeqvZvvR8fcoaF13zZekBffYw9j8qyoOsbsqu36JQvImf7fQDEZxtJaSWgj+BdSellJS/tYNUmd1tfkIpmmfQ8XxtFFYixZtzu/u9sUb3w90lljRsjcvuVgFdI/kI7xSXBbjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013423; c=relaxed/simple;
	bh=BlgvMHdIs1V5VvsXd9mUfHZtl+giZM+wPS1IbtOIqiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSNgvUtc0heIK7W5LCM/6H/b3YC5uibSsgnlz0+jFWNBeyZc3dZ5oLToUtr7w+L57w/ZjPfh0QXE8E6dk6NLG4mVNX/RhTHDYXAIr+1domRt1Tbcyp2PQDn43OroBRFYxxSfoj0UZ2TiEH+qUusWs8wuEr6+brQaOX4GwTI8qK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UU9XQWgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485B4C4CEF1;
	Wed, 21 Jan 2026 16:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769013422;
	bh=BlgvMHdIs1V5VvsXd9mUfHZtl+giZM+wPS1IbtOIqiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UU9XQWgYQoNlum11DdCrLZbsGsI8NtWQ+I0jxP+KddAgoDLIoCoQsGDAqlP2Kus+u
	 kIaSQeiVgUmlmn5N89OIOpqsvXxceZ9LwEj9CQUP0AxcXZ6G7Gh7gFWTNdYSqMDHf1
	 mIk3WVJoMnMKQdkAcVj5VA7EuZq1DHGIpWk13gFI=
Date: Wed, 21 Jan 2026 17:36:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lee Yongjun <jun85566@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_pci: Fix uninitialized variable use in
 pci_oxsemi_tornado_get_divisor
Message-ID: <2026012141-arrival-mounted-0d49@gregkh>
References: <20260121155352.52489-1-jun85566@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121155352.52489-1-jun85566@gmail.com>
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12490-lists,linux-serial=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-serial];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C98465B42C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Jan 22, 2026 at 12:53:52AM +0900, Lee Yongjun wrote:
> Smatch reports the following errors:
> 
>   drivers/tty/serial/8250/8250_pci.c:1246 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'tcr'.
>   drivers/tty/serial/8250/8250_pci.c:1247 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'quot'.
>   drivers/tty/serial/8250/8250_pci.c:1251 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'quot'.
>   drivers/tty/serial/8250/8250_pci.c:1255 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'cpr'.
>   drivers/tty/serial/8250/8250_pci.c:1265 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'cpr'.
> 
> These variables are initialized in the if branch or inside the loop in
> the else branch. However, if the loop finishes without finding a suitable
> divisor, they remain uninitialized.

But can that ever really happen?  Please step through it all with the
values that the hardware provides to see this.

> Initialize 'quot', 'cpr', and 'tcr' to 0 to prevent undefined behavior.

Why haven't we seen any real problems with this?  I think this is ok
as-is.  Maybe a little bit complex and non-intutive, but ok.

thanks,

greg k-h

