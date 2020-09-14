Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FA268411
	for <lists+linux-serial@lfdr.de>; Mon, 14 Sep 2020 07:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgINFaA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 14 Sep 2020 01:30:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41716 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgINF37 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Sep 2020 01:29:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id ay8so16226019edb.8
        for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2020 22:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z1T/2900SANPNqCTbSqc4He4lRILj51ILCl9GCqP3W4=;
        b=ZNTXozmi0Jp+IVVbGJmc+liEZKbZLRAusKUWeIbnaEsZzEw1fdIYE2M8XL6iGWfFZI
         Yiz3Qjwr+WKMN2gxBSlH7kdfkntb4QeHbgCP5vUct/zclC0X5b657EShmppxHIzMyJ5L
         d+C9z1AX4tT5ZWUrJA1q53HMQFIaY2pDTCprz2XKp1I0CPUaXEYWq9CEBFsLuOWve8W0
         r5x8/HQARApH83opwi2Yh8MwUe9fhG/o+rUF8nA/4HrVGTN8RmcpZnqoMEEPTgr/Rv//
         kqrzYtugUh2pdla1o9XHeoXg2ID66kTJpRaLzEprs39uK6Rtsw77LlHRyjAcLabIOMc2
         VxHw==
X-Gm-Message-State: AOAM531UnpGbU4Pl1YTJHzPZLDBV/npxYRz/IgaXu7z9PHdSkGaffq+h
        bIX94XDGDY/DOe8TXk7P/Fyda/30nEpSkA==
X-Google-Smtp-Source: ABdhPJws3XUQIstEOGdOZPJBBXittRedeH4J1mdmUeRlgYjVJja4dh8lelFgQzZbYXI6D6tqtn3KRQ==
X-Received: by 2002:aa7:c896:: with SMTP id p22mr15216133eds.382.1600061397730;
        Sun, 13 Sep 2020 22:29:57 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id k10sm8371017edo.36.2020.09.13.22.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2020 22:29:56 -0700 (PDT)
Subject: Re: [PATCH] serial: ucc_uart: make qe_uart_set_mctrl() static
To:     Jason Yan <yanaijie@huawei.com>, timur@kernel.org,
        gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Cc:     Hulk Robot <hulkci@huawei.com>
References: <20200912033834.143166-1-yanaijie@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <27cadfe5-7a7e-6d59-476d-1d03acc2185d@kernel.org>
Date:   Mon, 14 Sep 2020 07:29:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200912033834.143166-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12. 09. 20, 5:38, Jason Yan wrote:
> This eliminates the following sparse warning:
> 
> drivers/tty/serial/ucc_uart.c:286:6: warning: symbol 'qe_uart_set_mctrl'
> was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Sure:
Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>  drivers/tty/serial/ucc_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
> index 3c8c662c69e2..d6a8604157ab 100644
> --- a/drivers/tty/serial/ucc_uart.c
> +++ b/drivers/tty/serial/ucc_uart.c
> @@ -283,7 +283,7 @@ static unsigned int qe_uart_tx_empty(struct uart_port *port)
>   * don't need that support. This function must exist, however, otherwise
>   * the kernel will panic.
>   */
> -void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +static void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
>  }
>  
> 


-- 
js
