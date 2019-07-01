Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A622AE50
	for <lists+linux-serial@lfdr.de>; Mon, 27 May 2019 07:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfE0F5U (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 27 May 2019 01:57:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43235 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0F5T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 May 2019 01:57:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so8924318pfa.10
        for <linux-serial@vger.kernel.org>; Sun, 26 May 2019 22:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JyuJRgpS/Z7CTA8H0O+hxtzN/dPpz0TyAwIDE7XTsoE=;
        b=tuK8ZJtVIXwdPqsWdCte9y3TqlJG9qgELDQ3Qtp6LQKM8RKkyKpCzZkxEj0Rc2WkDL
         2Zsfou7/kcXjVBVVKZbyd1vpgHoltIgN/xtEWFYBHpnAG3V6zkWDiy1iTyxASIA9CENQ
         mA7+QcLY3xq9OCa85rUrfTnUC93wNgN7pb/iWF9gDRmtjp/EREjqEwTpSmkigkxsMWFW
         Dch1i+eR2PB3g/qfC+a+rSADliGMCp1rcVIDlZ1nUQhX3IA1oVSLv+0kdbMvq+wLMVEH
         EiFnt8NM5d7BexcLwQ+IFWTjLJXCKlKrLgcaDZCIFCHPhnltSPGoP4cbGO158bKGJAU7
         /huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JyuJRgpS/Z7CTA8H0O+hxtzN/dPpz0TyAwIDE7XTsoE=;
        b=EMWalToza/SsEqOOwU6EBKz2iSDxXI7lGy/5pJMOT1MMYWwEuH7QLOtADkWEUSGFZH
         XaXUz1twFrBdYi1W9rZ9fWsvcmk7QhAJ+hqA1+gHMAw2dgNFH799FWRTPbs4gjXBJuFp
         5UYiqwWYDFQvneWKH124eiIFpH6281RwkJiocekwhhpjP8wHMWmyZPooqPRe0aZ+sn+4
         sWVf/pYRuySxUw/HMYdbxIQHL+/+LVR75y3/qVSNNStTfbiWa2vkn+wnOMIgput6tqZP
         3YzCbn+Vc2s1IiuHm2V5Udf/eNRIUiDCRQOli/p6XspC9zwKR6J7rdNWnxWDhk+/ykhp
         lbkA==
X-Gm-Message-State: APjAAAUbpEwGvm9WFUnzIuLpaLdS5IYhj1mq0mAVQWYXw5kwDUmfcUH5
        MB2iW30zYh19ZoLtCgGDqDR2Dw==
X-Google-Smtp-Source: APXvYqyFsSMergPg5Nna/kdDGDiTnNFmQX2Z9Q80x2Bevc9+pSNViT0695L4158UfsAXYGHWblpzzg==
X-Received: by 2002:a63:e603:: with SMTP id g3mr14837549pgh.167.1558936638925;
        Sun, 26 May 2019 22:57:18 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t18sm8297274pgm.69.2019.05.26.22.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 May 2019 22:57:17 -0700 (PDT)
Date:   Sun, 26 May 2019 22:57:15 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        macro@linux-mips.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, slemieux.tyco@gmail.com,
        andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 20/45] drivers: tty: serial: msm_serial: use devm_*
 functions
Message-ID: <20190527055715.GW31438@minitux>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-21-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552602855-26086-21-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu 14 Mar 15:33 PDT 2019, Enrico Weigelt, metux IT consult wrote:

> Use the safer devm versions of memory mapping functions.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

As pointed out by others, this resource does not follow the life cycle
of the port->dev, so I don't think this improves the code.

Regards,
Bjorn

> ---
>  drivers/tty/serial/msm_serial.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 1090960..e8e0c87 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -1324,8 +1324,8 @@ static void msm_release_port(struct uart_port *port)
>  		return;
>  	size = resource_size(uart_resource);
>  
> -	release_mem_region(port->mapbase, size);
> -	iounmap(port->membase);
> +	devm_release_mem_region(port->dev, port->mapbase, size);
> +	devm_iounmap(port->dev, port->membase);
>  	port->membase = NULL;
>  }
>  
> @@ -1342,10 +1342,13 @@ static int msm_request_port(struct uart_port *port)
>  
>  	size = resource_size(uart_resource);
>  
> -	if (!request_mem_region(port->mapbase, size, "msm_serial"))
> +	if (!devm_request_mem_region(port->dev,
> +				     port->mapbase,
> +				     size,
> +				     "msm_serial"))
>  		return -EBUSY;
>  
> -	port->membase = ioremap(port->mapbase, size);
> +	port->membase = ioremap(port->dev, port->mapbase, size);
>  	if (!port->membase) {
>  		ret = -EBUSY;
>  		goto fail_release_port;
> @@ -1354,7 +1357,7 @@ static int msm_request_port(struct uart_port *port)
>  	return 0;
>  
>  fail_release_port:
> -	release_mem_region(port->mapbase, size);
> +	devm_release_mem_region(port->dev, port->mapbase, size);
>  	return ret;
>  }
>  
> -- 
> 1.9.1
> 
