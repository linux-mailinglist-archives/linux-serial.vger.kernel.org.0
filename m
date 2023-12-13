Return-Path: <linux-serial+bounces-630-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAB380885E
	for <lists+linux-serial@lfdr.de>; Thu,  7 Dec 2023 13:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D641F2115E
	for <lists+linux-serial@lfdr.de>; Thu,  7 Dec 2023 12:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B987A3D0AC;
	Thu,  7 Dec 2023 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfZ22qTY"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A208010C4;
	Thu,  7 Dec 2023 04:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701953464; x=1733489464;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qZHsWoDGythR+xpoV3du0UBWiGRf3tb4+oh+E8eq000=;
  b=VfZ22qTYIByY9zYexwiRhypIN8L7O+OfFiLQJNlzx70FtMbYHW3UXUYF
   r+yxv1h1Dy1O7lMqOcseRwDZnIrJ1b698v1aRW9ueoZhagetnhv9uh75o
   kV2QTmrYb9RZLBAb0h/H98MQ/5/MGsMhJc2+uxoB105xl/GkfhVLdO+Lf
   Yz0Abg6HIqn3gDYhNblIt4I1guKWjDRm5c8R/1UjxQnt+7rbl3AEVF3Ow
   Ul1BUJMlGnqp50LULap0lXNw3k07DOghXF6WEaFn32Quaov/Hxes8q5Dy
   SfCl1+l6+7g9nY/rfOuMGOjmrnnpRdgO4/Dxmhrg6X9ETyWXGBN5+tGwp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1092104"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1092104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:51:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="915567795"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="915567795"
Received: from dkrupnov-mobl3.ger.corp.intel.com ([10.249.34.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:51:01 -0800
Date: Thu, 7 Dec 2023 14:50:59 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 21/27] tty: nozomi: convert to u8 and size_t
In-Reply-To: <20231206073712.17776-22-jirislaby@kernel.org>
Message-ID: <9246bc67-518a-72b9-beaf-3204a4a977@linux.intel.com>
References: <20231206073712.17776-1-jirislaby@kernel.org> <20231206073712.17776-22-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 6 Dec 2023, Jiri Slaby (SUSE) wrote:

> Switch character types to u8 and sizes to size_t. To conform to
> characters/sizes in the rest of the tty layer.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/nozomi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
> index b247341bd12f..e28a921c1637 100644
> --- a/drivers/tty/nozomi.c
> +++ b/drivers/tty/nozomi.c
> @@ -783,11 +783,10 @@ static int receive_data(enum port_type index, struct nozomi *dc)
>  			tty_insert_flip_char(&port->port, buf[0], TTY_NORMAL);
>  			size = 0;
>  		} else if (size < RECEIVE_BUF_MAX) {
> -			size -= tty_insert_flip_string(&port->port,
> -					(char *)buf, size);
> +			size -= tty_insert_flip_string(&port->port, buf, size);
>  		} else {
> -			i = tty_insert_flip_string(&port->port,
> -					(char *)buf, RECEIVE_BUF_MAX);
> +			i = tty_insert_flip_string(&port->port, buf,
> +						   RECEIVE_BUF_MAX);
>  			size -= i;
>  			offset += i;
>  		}
> @@ -1584,10 +1583,10 @@ static void ntty_hangup(struct tty_struct *tty)
>  static ssize_t ntty_write(struct tty_struct *tty, const u8 *buffer,
>  			  size_t count)
>  {
> -	int rval = -EINVAL;
>  	struct nozomi *dc = get_dc_by_tty(tty);
>  	struct port *port = tty->driver_data;
>  	unsigned long flags;
> +	size_t rval;
>  
>  	if (!dc || !port)
>  		return -ENODEV;
> 

It wouldn't hurt to mention in the commit message that -EINVAL 
initialization is unnecessary.

-- 
 i.


