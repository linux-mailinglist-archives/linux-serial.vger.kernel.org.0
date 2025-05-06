Return-Path: <linux-serial+bounces-9282-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A8CAABBAE
	for <lists+linux-serial@lfdr.de>; Tue,  6 May 2025 09:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89BA3B3036
	for <lists+linux-serial@lfdr.de>; Tue,  6 May 2025 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1031E22068B;
	Tue,  6 May 2025 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+xlbhQ5"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761721B9C4;
	Tue,  6 May 2025 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746511606; cv=none; b=HaSKosKgerhIP4cEPS07Rfy/0dpFeoExllLPuApi/kv3BAO7TZZTKVtiNa0mosdtEZMGzBshNUvOMgfUAefShKAX7tHBW1hpvLwLDt24poNdZfaCSgT7H0Jftenp2XUJAsEo2wCVF259IsZLFytZnDd5B3qH6/rN6nftHRN74NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746511606; c=relaxed/simple;
	bh=t0esOVO5bIt6WvoJRwMbPq0dSQ5GoPADIvxR9YsuShI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRHqIi+PuRlVAx71rm1zWDtX9RbYvk3QEQ+YAyMzFM7XccTkUJC4rPVv5aDddoWMhFwf3F1DhfS6QvoRrpMeJKcZm8qNe4rQB99uGjHBe/Nj6ErdVz0YBcce/6Mkis2KiHhrFgrWGmp40hyhaxh3Qfp3O9s4zhHnwHyOcSmE0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+xlbhQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BAAC4CEE4;
	Tue,  6 May 2025 06:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746511606;
	bh=t0esOVO5bIt6WvoJRwMbPq0dSQ5GoPADIvxR9YsuShI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n+xlbhQ5g2IEcc2CRUDUA4YDnMWYZFYHrmQIwgvXSJx4B4XEkyYDP8FABEsKqhScg
	 xw8loxDFcPQ6/w4yY5Seqvm5ZVdlnunNbId+wpaDfkHXV+2tTb1zHyTRTBW6D9/K+U
	 NmJtrdSmtCsaq+K1IBlr/NbVBVgt8pUfbyI7RcmgJq6aKtMKs6kAkEq9SkacQJk3TY
	 GhO3q2zrXJVTOYpTAyEsKe37KJyCzs5ufddKBY1l3Bv1f3V7cXNReZ+ReU16Obh5PA
	 AleOAJUheD6kMOeH2twEeKGOSlHKg2s6KuMzStS+7MXnKpsQPsjjYBPW4liDSLTKsS
	 anKyQu/632QbA==
Message-ID: <fe312c65-99de-4519-9072-caeebf44227b@kernel.org>
Date: Tue, 6 May 2025 08:06:43 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] vt: move glyph determination to a separate function
To: Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <npitre@baylibre.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250505170021.29944-1-nico@fluxnic.net>
 <20250505170021.29944-4-nico@fluxnic.net>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250505170021.29944-4-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05. 05. 25, 18:55, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> No logical changes. Make it easier for enhancements to come.
...
> @@ -2984,12 +2985,40 @@ static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
>   	return 0;
>   }
>   
> +static int vc_get_glyph(struct vc_data *vc, int tc)
> +{
> +	int glyph = conv_uni_to_pc(vc, tc);
> +	int charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;

Could you keep charmask unsigned? It used to be u16.

> +
> +	if (!(glyph & ~charmask))
> +		return glyph;
> +
> +	if (glyph == -1)
> +		return -1; /* nothing to display */
> +
> +	/* Glyph not found */
> +

Do no additional \n here ^^.

> +	if ((!vc->vc_utf || vc->vc_disp_ctrl || tc < 128) && !(tc & ~charmask)) {
> +		/*
> +		 * In legacy mode use the glyph we get by a 1:1 mapping.
> +		 * This would make absolutely no sense with Unicode in mind,
> +		 * but do this for ASCII characters since a font may lack
> +		 * Unicode mapping info and we don't want to end up with
> +		 * having question marks only.

Generally: feel free to use 100 characters per line.

> +		 */
> +		return tc;
> +	}
> +
> +	/* Display U+FFFD (Unicode Replacement Character). */
> +	return conv_uni_to_pc(vc, UCS_REPLACEMENT);
> +}

thanks,
-- 
js
suse labs

