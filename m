Return-Path: <linux-serial+bounces-280-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 666857FBB82
	for <lists+linux-serial@lfdr.de>; Tue, 28 Nov 2023 14:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA500B218CB
	for <lists+linux-serial@lfdr.de>; Tue, 28 Nov 2023 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C8258110;
	Tue, 28 Nov 2023 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAGUmJV1"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA1310F4;
	Tue, 28 Nov 2023 05:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701177991; x=1732713991;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Vfb4ahSBf4vSRtc/lP0oWViVNK0OVo/cmZbQVDvOfeI=;
  b=EAGUmJV1uS0Whw3XtnesHOSDo1eaF8aL/qAH5JX5Z48RIYPnzFlKY2NY
   B1Cljt82E8v4Ghg7d5jeg2OmOhy4s8QUGGqbAa4KcGCwx7RvsEylCwx48
   bjcC8S0gaTZY0/lKEtZH3jj02cQ3q/tBqemsjzlU65A3co9qM4tUtOkHG
   RK9xfRsygRGNBRzX+j89tZej27YCeGX3YN1iGT3ZgQZ9k33qnT2GPuRls
   KYwoYfttvoHjbZK0YmCz2YWcRHkEz+VWzHehtR0M/VV+z15tYls/QhyFI
   7r3IEJ/HwzN0+b6xnOUwSGW8CE3TpF5ntsFdkXBZCzsiF4AZzgIJ4EPwx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372296118"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="372296118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 05:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="912430861"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="912430861"
Received: from haslam-mobl1.ger.corp.intel.com ([10.252.43.79])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 05:26:06 -0800
Date: Tue, 28 Nov 2023 15:26:03 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 3/5] tty: srmcons: use 'count' directly in
 srmcons_do_write()
In-Reply-To: <20231127123713.14504-3-jirislaby@kernel.org>
Message-ID: <c06cb71-575f-1d6b-aed-49e4bbab444@linux.intel.com>
References: <20231127123713.14504-1-jirislaby@kernel.org> <20231127123713.14504-3-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1536688584-1701177968=:1797"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1536688584-1701177968=:1797
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 27 Nov 2023, Jiri Slaby (SUSE) wrote:

> Similarly to 'buf' in the previous patch, there is no need to have a
> separate counter ('remaining') in srmcons_do_write(). 'count' can be
> used directly which simplifies the code a bit.
> 
> Note that the type of the current count ('c') is changed from 'long' to
> 'size_t' so that:
> 1) it is prepared for the upcoming change of 'count's type, and
> 2) is unsigned.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
> 
> Notes:
>     [v2] reordered so that it makes sense
> 
>  arch/alpha/kernel/srmcons.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
> index de896fa9829e..32bc098de7da 100644
> --- a/arch/alpha/kernel/srmcons.c
> +++ b/arch/alpha/kernel/srmcons.c
> @@ -92,24 +92,24 @@ static void
>  srmcons_do_write(struct tty_port *port, const char *buf, int count)
>  {
>  	static char str_cr[1] = "\r";
> -	long c, remaining = count;
> +	size_t c;
>  	srmcons_result result;
>  	int need_cr;
>  
> -	while (remaining > 0) {
> +	while (count > 0) {
>  		need_cr = 0;
>  		/* 
>  		 * Break it up into reasonable size chunks to allow a chance
>  		 * for input to get in
>  		 */
> -		for (c = 0; c < min_t(long, 128L, remaining) && !need_cr; c++)
> +		for (c = 0; c < min_t(size_t, 128U, count) && !need_cr; c++)
>  			if (buf[c] == '\n')
>  				need_cr = 1;
>  		
>  		while (c > 0) {
>  			result.as_long = callback_puts(0, buf, c);
>  			c -= result.bits.c;
> -			remaining -= result.bits.c;
> +			count -= result.bits.c;
>  			buf += result.bits.c;
>  
>  			/*
> 

Reviewed-by: Ilpo J�rvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1536688584-1701177968=:1797--

