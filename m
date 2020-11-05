Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001A92A77B1
	for <lists+linux-serial@lfdr.de>; Thu,  5 Nov 2020 08:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgKEHFP (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 5 Nov 2020 02:05:15 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13004 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgKEHFO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 02:05:14 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CRZKM47t1z9v117;
        Thu,  5 Nov 2020 08:05:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id b4BaAEdbvgaQ; Thu,  5 Nov 2020 08:05:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CRZKM3KnPz9v116;
        Thu,  5 Nov 2020 08:05:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 40D2E8B819;
        Thu,  5 Nov 2020 08:05:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QNSBaGaQp51J; Thu,  5 Nov 2020 08:05:12 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E8EB58B764;
        Thu,  5 Nov 2020 08:05:10 +0100 (CET)
Subject: Re: [PATCH 34/36] tty: serial: pmac_zilog: Make disposable variable
 __always_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-35-lee.jones@linaro.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <445a6440-b4c8-4536-891b-0cefc78e5f57@csgroup.eu>
Date:   Thu, 5 Nov 2020 08:04:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201104193549.4026187-35-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



Le 04/11/2020 à 20:35, Lee Jones a écrit :
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/tty/serial/pmac_zilog.h:365:58: warning: variable ‘garbage’ set but not used [-Wunused-but-set-variable]

Explain how you are fixing this warning.

Setting  __always_unused is usually not the good solution for fixing this warning, but here I guess 
this is likely the good solution. But it should be explained why.

Christophe


> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linux-serial@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/tty/serial/pmac_zilog.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/pmac_zilog.h b/drivers/tty/serial/pmac_zilog.h
> index bb874e76810e0..968aec7c1cf82 100644
> --- a/drivers/tty/serial/pmac_zilog.h
> +++ b/drivers/tty/serial/pmac_zilog.h
> @@ -362,7 +362,7 @@ static inline void zssync(struct uart_pmac_port *port)
>   
>   /* Misc macros */
>   #define ZS_CLEARERR(port)    (write_zsreg(port, 0, ERR_RES))
> -#define ZS_CLEARFIFO(port)   do { volatile unsigned char garbage; \
> +#define ZS_CLEARFIFO(port)   do { volatile unsigned char __always_unused garbage; \
>   				     garbage = read_zsdata(port); \
>   				     garbage = read_zsdata(port); \
>   				     garbage = read_zsdata(port); \
> 
