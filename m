Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7896228DD5
	for <lists+linux-serial@lfdr.de>; Wed, 22 Jul 2020 04:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgGVCD1 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 Jul 2020 22:03:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38092 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731614AbgGVCD1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 22:03:27 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9E13415924246FF15238;
        Wed, 22 Jul 2020 09:56:45 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Jul 2020 09:56:39 +0800
Subject: Re: [PATCH] serial: 8250: fix null-ptr-deref in serial8250_start_tx()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <gregkh@linuxfoundation.org>
CC:     <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
References: <20200721143852.4058352-1-yangyingliang@huawei.com>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <c56e0ecc-275c-2cd6-4f9b-8ae37656ab5b@huawei.com>
Date:   Wed, 22 Jul 2020 09:56:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200721143852.4058352-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Yingliang,

On 2020/7/21 22:38, Yang Yingliang wrote:
(SNIP)
> 
> SERIAL_PORT_DFNS is not defined on each arch, if it's not defined,
> serial8250_set_defaults() won't be called in serial8250_isa_init_ports(),
> so the p->serial_in pointer won't be initialized, and it leads a null-ptr-deref.
> Fix this problem by calling serial8250_set_defaults() after init uart port.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index fc118f649887..cae61d1ebec5 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -524,6 +524,7 @@ static void __init serial8250_isa_init_ports(void)
>  		 */
>  		up->mcr_mask = ~ALPHA_KLUDGE_MCR;
>  		up->mcr_force = ALPHA_KLUDGE_MCR;
> +		serial8250_set_defaults(up);

That is really a good catch, but this modification looks not good to me.

First, serial8250_set_defaults()'s parameter 'up' updated in the loop below is used to
lead to different branch in this function. So that the logic is broken.

Second, up->port.iobase and up->port.iotype are both initialized to 0, so the 'serial_in'
and 'serial_out' will be assigned to the ops for IO space with port 0 here, i don't think
that is correct.

>  	}
>  
>  	/* chain base port ops to support Remote Supervisor Adapter */
> @@ -547,7 +548,6 @@ static void __init serial8250_isa_init_ports(void)
>  		port->membase  = old_serial_port[i].iomem_base;
>  		port->iotype   = old_serial_port[i].io_type;
>  		port->regshift = old_serial_port[i].iomem_reg_shift;
> -		serial8250_set_defaults(up);
>  
>  		port->irqflags |= irqflag;
>  		if (serial8250_isa_config != NULL)
> 


Thanks,
Wei
