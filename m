Return-Path: <linux-serial+bounces-12865-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A2BSOu4vq2n2agEAu9opvQ
	(envelope-from <linux-serial+bounces-12865-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Fri, 06 Mar 2026 20:50:06 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B95E227387
	for <lists+linux-serial@lfdr.de>; Fri, 06 Mar 2026 20:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04A40304C7C8
	for <lists+linux-serial@lfdr.de>; Fri,  6 Mar 2026 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1121542F56E;
	Fri,  6 Mar 2026 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/fEYVgb"
X-Original-To: linux-serial@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838FC202C29;
	Fri,  6 Mar 2026 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826603; cv=none; b=pFShTLXJ6NAq1YgGvTGhiA+WBu652p5qL0AlW7+gosZw8RFQAt32A1VyA/DerqzaiCvno4vbtvRuJlu4wq59J+HwfZ2S8pD42DhzDwBhw466PCbJghS2P4xRHSdm0ekkoihBxG5g3knHmzIAnjWpa3BrGUtN/dkVu2UuYtNV7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826603; c=relaxed/simple;
	bh=qEC3d26M345uE6JM1i9big7iGpyiCRc94YB/FPYP8pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfdYBK9uczwgkAyynNfrgv+xVXf8uRt9FVtEcN/QUXzYtQboaC75iBp1zgTQ1QhNKakj37n2FqmmNCsV0cvxmwKGe28pxBE1nsCA/KyEi0eAIa2hG9txCgW1E5N8/LfRLHAMgkDwJl6hI1vM1F9NYHyO1fdzkDtzCL/e2qvJZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I/fEYVgb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0qO9+QY++umfUmJGfFEVkr4r1pi/XXeRYwIJwqEAYoQ=; b=I/fEYVgbEogCcZuuWCTLQ5PMc7
	i9pIR7xPwEF5nv2+y7U3q7WsPpRQjwGiiuK+pdSx07OScwZtxXyVTaPHPySpQrVF7RKdeUkaLZR6v
	70jHUVL7P9AaJ2FHi9gWdaLZ0vIIgT5f07r3qQyHfcASOh5GRH1hNf3AYhdn0AQhQMw3sXp7EC3h5
	8GQAKsgEvOPGrTIOmZBUkkMeLYWvlAlbrj9uBI3MFzMAyeGBHiI3noab4LMVhZHZdGm7zwWvtNwV8
	YPsj2GbFXpbp8XiQSHx6VGipFCK/EIwMQRuFQsds9mQzDd2wa2DOurMLD/FWtZe5rEWSOPmGBb5aV
	NKatr0lw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vybBK-00000004QLS-20Q4;
	Fri, 06 Mar 2026 19:49:54 +0000
Message-ID: <934ca1e6-dfee-411e-890a-083dcfc9f6b1@infradead.org>
Date: Fri, 6 Mar 2026 11:49:53 -0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] serdev: add private data to serdev_device
To: Markus Probst <markus.probst@posteo.de>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Kari Argillander <kari.argillander@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260306-rust_serdev-v2-0-e9b23b42b255@posteo.de>
 <20260306-rust_serdev-v2-2-e9b23b42b255@posteo.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260306-rust_serdev-v2-2-e9b23b42b255@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4B95E227387
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12865-lists,linux-serial=lfdr.de];
	FREEMAIL_TO(0.00)[posteo.de,kernel.org,linuxfoundation.org,garyguo.net,protonmail.com,google.com,umich.edu,gmail.com,linaro.org,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-serial];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[posteo.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi--

On 3/6/26 11:35 AM, Markus Probst wrote:
> Add private data to `struct serdev_device`, as it is required by the
> rust abstraction added in the following commit
> (rust: add basic serial device bus abstractions).
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  include/linux/serdev.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 5654c58eb73c..b591af23faf0 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -33,12 +33,13 @@ struct serdev_device_ops {
>  
>  /**
>   * struct serdev_device - Basic representation of an serdev device
> - * @dev:	Driver model representation of the device.
> - * @nr:		Device number on serdev bus.
> - * @ctrl:	serdev controller managing this device.
> - * @ops:	Device operations.
> - * @write_comp	Completion used by serdev_device_write() internally
> - * @write_lock	Lock to serialize access when writing data
> + * @dev:	 Driver model representation of the device.
> + * @nr:		 Device number on serdev bus.
> + * @ctrl:	 serdev controller managing this device.
> + * @ops:	 Device operations.
> + * @write_comp	 Completion used by serdev_device_write() internally
> + * @write_lock	 Lock to serialize access when writing data
> + * @private_data Private data for the device driver.
>   */

I don't quite get why each changed line has an extra tab added to it. ?
Also, struct member names in kernel-doc should with a colon  (':'), e.g.,

 * @private_data: Private data for the device driver.

Please correct that and the 2 lines above it also.
And maybe test it to check for warnings.

>  struct serdev_device {
>  	struct device dev;
> @@ -47,6 +48,7 @@ struct serdev_device {
>  	const struct serdev_device_ops *ops;
>  	struct completion write_comp;
>  	struct mutex write_lock;
> +	void *private_data;
>  };
>  
>  static inline struct serdev_device *to_serdev_device(struct device *d)
> 

thanks.
-- 
~Randy


