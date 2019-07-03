Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A015DF18
	for <lists+linux-serial@lfdr.de>; Wed,  3 Jul 2019 09:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGCHr6 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 3 Jul 2019 03:47:58 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:40152 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfGCHr6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Jul 2019 03:47:58 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id ACA5820331;
        Wed,  3 Jul 2019 09:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1562140071; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V06NrMwnrfL+u1iNILDTaSrIvvmvZ6ksFpixOalbNr4=;
        b=w63xg5upNQWdWx/KlHXTCaunTNPl+s7yVvmJhJovvzOYTSo6kavVlA8DJWjr/p7e0h0cmp
        aWpuDXtTWNTOc+EVbZRGBaBIUwH8Bl//JJ9RIQgjr3tD5r7PYY35AcVIKMEsRGDWZ1HLxT
        mxlrh5b9dchh9h/MQkSnWU00xZ0p0/NU/pEzWcVE7Qg2Lrx0SjMFPodfCZDp7r+kfpUAGm
        mil2cFQ7dOOuCB5gBy+Gd/FEfPdH/g8hCcnqjdurI0AgGqlzF7IAlW8cuIhnysa/hU1pEW
        +ZAxnOiMLMqJO+FN4Df2vpoGHi3qTnRHXMtwnx+ckTQCUXnPUbRsDvzi+mf29w==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 5CAEABEEBD;
        Wed,  3 Jul 2019 09:47:50 +0200 (CEST)
Message-ID: <5D1C5DA5.9030907@bfs.de>
Date:   Wed, 03 Jul 2019 09:47:49 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Wei Yongjun <weiyongjun1@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>, Stefan Roese <sr@denx.de>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] serial: 8250: 8250_core: Fix missing unlock on
 error in serial8250_register_8250_port()
References: <20190703055908.141294-1-weiyongjun1@huawei.com>
In-Reply-To: <20190703055908.141294-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.10
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         TO_DN_SOME(0.00)[];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[googlemail.com];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         NEURAL_HAM(-0.00)[-0.999,0];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



Am 03.07.2019 07:59, schrieb Wei Yongjun:
> Add the missing unlock before return from function serial8250_register_8250_port()
> in the error handling case.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index a4470771005f..df3bcc0b2d74 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1026,8 +1026,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  		if (!has_acpi_companion(uart->port.dev)) {
>  			gpios = mctrl_gpio_init(&uart->port, 0);
>  			if (IS_ERR(gpios)) {
> -				if (PTR_ERR(gpios) != -ENOSYS)
> -					return PTR_ERR(gpios);
> +				if (PTR_ERR(gpios) != -ENOSYS) {
> +					ret = PTR_ERR(gpios);
> +					goto out_unlock;
> +				}
>  			} else {
>  				uart->gpios = gpios;
>  			}
> @@ -1099,6 +1101,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  		}
>  	}
>  
> +out_unlock:
>  	mutex_unlock(&serial_mutex);
>  
>  	return ret;
> 


i am sorry but i do not understand these ENOSYS path.
So far i can see uart->gpios will be uninitialized, is that really intended ?

re,
 wh
