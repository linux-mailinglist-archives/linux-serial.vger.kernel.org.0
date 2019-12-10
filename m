Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA59118C2B
	for <lists+linux-serial@lfdr.de>; Tue, 10 Dec 2019 16:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLJPML (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Dec 2019 10:12:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42540 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfLJPMJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Dec 2019 10:12:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so16250989edv.9;
        Tue, 10 Dec 2019 07:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sJaeGKsrAgF2COrnApNd92HDMsm8/A1cviivFQnAaJw=;
        b=j2qOPrsw3wa7Mb+Z+tK3dtFbPo/Yzh38KMlM6OfzCqq7BzC6r7NX8TUNzUF5zFyw1W
         S3hZePpWMQ/6odsfn/Areh/HZdzB9puwpf3H1mVUgadDXZieFHRUpLj56n+oCCJ9S7jS
         ds7ovfL4wWGyhOJFrRrqxVoEEcAq/W6ZhI62jzfNSFTnbDV6RhsdKbUIZGRxdD7FLM2j
         pPJ3LqBW4HEtVQqO+oDwuqv/4tuml3kAcOy61R1Q4/LZ9d5Ozu3TDr9feT53cJL6CwO/
         dHgL4GuiJz1x/8CTC7vMq3ohL/fDE9auejLfW3l6v2hvI8zGkJlfG0rwjPbpJHfgxg9W
         4K9Q==
X-Gm-Message-State: APjAAAUNYhJEtfNZI1OLBnnsQ/yDKCw1CztOkCgVjnW1/D0PZU2/C9lq
        8qKfN4Cmn4Oto0xcQUE+eI4cy9PMQB0=
X-Google-Smtp-Source: APXvYqxujei1imzn332R8bQdgC3x3CynHzWuf7LdbAxNnqzLlR0w18cSud9VlWzURCVvIyZ4WjeMdQ==
X-Received: by 2002:a50:fb96:: with SMTP id e22mr37840514edq.18.1575990727498;
        Tue, 10 Dec 2019 07:12:07 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id dh4sm87820edb.77.2019.12.10.07.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:12:06 -0800 (PST)
Date:   Tue, 10 Dec 2019 16:12:04 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] tty: serial: samsung.h: fix up minor comment issues
Message-ID: <20191210151204.GH11222@pi3>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-3-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210143706.3928480-3-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 10, 2019 at 03:36:59PM +0100, Greg Kroah-Hartman wrote:
> checkpatch found some minor issues with comments in samsung.h, so fix
> that up.
>

No, you remove this header two patches later. No point to fix checkpatch
issues here.

Best regards,
Krzysztof


> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Hyunki Koo <kkoos00@naver.com>
> Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
> Cc: Shinbeom Choi <sbeom.choi@samsung.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/samsung.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
> index f93022113f59..cdfd53acead3 100644
> --- a/drivers/tty/serial/samsung.h
> +++ b/drivers/tty/serial/samsung.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef __SAMSUNG_H
>  #define __SAMSUNG_H
>  
> @@ -7,7 +7,7 @@
>   *
>   * Ben Dooks, Copyright (c) 2003-2008 Simtec Electronics
>   *	http://armlinux.simtec.co.uk/
> -*/
> + */
>  
>  #include <linux/dmaengine.h>
>  
> -- 
> 2.24.0
> 
