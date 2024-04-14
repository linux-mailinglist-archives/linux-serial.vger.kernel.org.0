Return-Path: <linux-serial+bounces-3398-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495C8A1E7E
	for <lists+linux-serial@lfdr.de>; Thu, 11 Apr 2024 20:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159851F28D12
	for <lists+linux-serial@lfdr.de>; Thu, 11 Apr 2024 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AE91386B3;
	Thu, 11 Apr 2024 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NncTN4tR"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF84F20A;
	Thu, 11 Apr 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859006; cv=none; b=H8VD1G1GpxQCN6mpXw+DsKPrA6hCgzgWskpMsu1Vl+pNgpnBNw8zfHjdVbwvQ3orfg9KfcSGZFZUUbPZVVK9F2aA0/yoIltAV8yAc3bS9fAKdyDS17FwuXR+w2bqyQe9bI5XUfGKKZ4s+G4XQRUOGiuJiks8Bn/00Nz1gWtkdOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859006; c=relaxed/simple;
	bh=ZGBgyafpmKoKHUJVnGr1ydBDerMlQpXQky8psG7f2Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyeGWJwGlFYRS9AkNcEHPqUw9FM3v1MYPEBtnBXQt0jcoVFAIvYqbkNlqyUJ1jd8G9Ppdau92V4uSiwTXZNTfyG8peVQDsmZYJbFZJjFMbpl916OlQ7xP92YtLd9n9hDNNOkvJibRua5Xqlfkes5WIzeZ5fUqB2hHYznJuY28u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NncTN4tR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E288EC072AA;
	Thu, 11 Apr 2024 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712859006;
	bh=ZGBgyafpmKoKHUJVnGr1ydBDerMlQpXQky8psG7f2Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NncTN4tRRsKOdV9NtIGff+qoDc46Z4ObDpdAgzuruKoHADJX5L7lRNQrV8yzYPfjY
	 0C85GAbh2ZxuNe77XxZ0YHHxV4Q42syNW8mUeV0SnTO5EZ1yiawD6eSxWSTyEIo4ra
	 saisB5m3XEdmKzSIcY4DFtN4CUGAZeHBtSpH/MbQ=
Date: Thu, 11 Apr 2024 20:10:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: jirislaby@kernel.org, Julia.Lawall@inria.fr, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] sysrq: Auto release device node using __free attribute
Message-ID: <2024041146-exciting-predefine-05bb@gregkh>
References: <20240411180256.61001-1-romeusmeister@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411180256.61001-1-romeusmeister@gmail.com>

On Thu, Apr 11, 2024 at 08:02:56PM +0200, Roman Storozhenko wrote:
> Add a cleanup function attribute '__free(device_node)' to the device node
> pointer initialization statement and remove the pairing cleanup function
> call of 'of_node_put' at the end of the function.
> The '_free()' attrubute is introduced by scope-based resource management
> in-kernel framework implemented in 'cleanup.h'. A pointer marked with
> '__free()' attribute makes a compiler insert a cleanup function call
> to the places where the pointer goes out of the scope. This feature
> allows to get rid of manual cleanup function calls.
> 
> Suggested-by: Julia.Lawall <Julia.Lawall@inria.fr>
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> This patch targets the next tree:
> tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> tag: next-20240411
> ---
>  drivers/tty/sysrq.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 02217e3c916b..1d1261f618c0 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -758,11 +758,12 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
>  static void sysrq_of_get_keyreset_config(void)
>  {
>  	u32 key;
> -	struct device_node *np;
>  	struct property *prop;
>  	const __be32 *p;
>  
> -	np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> +	struct device_node *np __free(device_node) =
> +		of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> +

Did you run this through checkpatch.pl?  Please do so.


