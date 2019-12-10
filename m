Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B05118B95
	for <lists+linux-serial@lfdr.de>; Tue, 10 Dec 2019 15:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLJOxv (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Dec 2019 09:53:51 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42688 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLJOxv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Dec 2019 09:53:51 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so16193564edv.9;
        Tue, 10 Dec 2019 06:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J3ePAvbBtA2GFkH/GUkVyhurDlAL5lGAx4tH8RkORZ0=;
        b=a+4rIlANegaZfGrr0z1EA3OyuVbIGEiukgPQV0Ht/N/UoF/Qv7Ivexz/eWkhOIJaFD
         0zEGp3u40fxKxPInDEedaTY3Ci3IpcTXOIZ6ebmhB13bH0zdDrM12m00nXHwOvPmW/1h
         AN9jY70gJ/X8JNrHiYLxINAIpO/u47STJM2tpR7iOkHw5jaWY/T460kwoFj3ZZWUslgr
         xDkYfQqb3ZGf6VuvdldeYhzUt8pf3jbi0ycRo7zpP/FpoyM8c7wuM7Y0uLHrsyEKtPhy
         WkOXbZJval9LobjRfyPV77NkiePTvpCPvNcSHq1Y70zNm+kFItRZlae+FvBeZTCjR3tK
         ctVQ==
X-Gm-Message-State: APjAAAW94IISfkdSLTGU8kqpY7dCpeTarHSPDPqj6FAmtauZN6Rg1VJ/
        +W4qCRl0ytQ0eRQv0YogNnGHyT6v+z0=
X-Google-Smtp-Source: APXvYqxqRciyed+2OJtA3xXe9pB4A4wCu/SQT8sBJWcQGqcqWcoGcOTuXxH4KgdXVL9C0KXUH+gJ5g==
X-Received: by 2002:a17:906:3953:: with SMTP id g19mr3940761eje.227.1575989629067;
        Tue, 10 Dec 2019 06:53:49 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id x8sm81066eds.88.2019.12.10.06.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:53:48 -0800 (PST)
Date:   Tue, 10 Dec 2019 15:53:46 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] tty: serial: samsung_tty: drop unneded dbg() calls
Message-ID: <20191210145346.GE11222@pi3>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-6-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210143706.3928480-6-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 10, 2019 at 03:37:02PM +0100, Greg Kroah-Hartman wrote:
> Now that the kernel has ftrace, any debugging calls that just do "made
> it to this function!" and "leaving this function!" can be removed.
> 
> On the quest to move the samsung_tty driver over to use the standard
> kernel debugging functions, drop these unneeded calls.
> 
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
>  drivers/tty/serial/samsung_tty.c | 22 ----------------------
>  1 file changed, 22 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

