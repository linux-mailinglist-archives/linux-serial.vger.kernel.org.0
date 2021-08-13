Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AFB3EB6D2
	for <lists+linux-serial@lfdr.de>; Fri, 13 Aug 2021 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbhHMOhu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 13 Aug 2021 10:37:50 -0400
Received: from foss.arm.com ([217.140.110.172]:54144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235396AbhHMOhu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 10:37:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1622C1042;
        Fri, 13 Aug 2021 07:37:23 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3942E3F718;
        Fri, 13 Aug 2021 07:37:22 -0700 (PDT)
Subject: Re: [PATCH v6] arm pl011 serial: support multi-irq request
To:     Bing Fan <hptsfb@gmail.com>, gregkh@linuxfoundation.org,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1628825490-18937-1-git-send-email-hptsfb@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1d691b6b-dbc4-36b0-2e2a-beb95c4c9cb6@arm.com>
Date:   Fri, 13 Aug 2021 15:37:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1628825490-18937-1-git-send-email-hptsfb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[ +Russell as the listed PL011 maintainer ]

On 2021-08-13 04:31, Bing Fan wrote:
> From: Bing Fan <tombinfan@tencent.com>
> 
> In order to make pl011 work better, multiple interrupts are
> required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
> at the same time, pl011 to GIC does not merge the interrupt
> lines(each serial-interrupt corresponding to different GIC hardware
> interrupt), so need to enable and request multiple gic interrupt
> numbers in the driver.
> 
> Signed-off-by: Bing Fan <tombinfan@tencent.com>
> ---
>   drivers/tty/serial/amba-pl011.c | 39 +++++++++++++++++++++++++++++++--
>   1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index e14f3378b8a0..eaac3431459c 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1701,6 +1701,41 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>   	}
>   }
>   
> +static void pl011_release_multi_irqs(struct uart_amba_port *uap, unsigned int max_cnt)
> +{
> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> +	int i;
> +
> +	for (i = 0; i < max_cnt; i++)
> +		if (amba_dev->irq[i])
> +			free_irq(amba_dev->irq[i], uap);

When you request the IRQs you break at the first zero, so this could 
potentially try to free IRQs that you haven't requested, if there happen 
to be any nonzero values beyond that. Maybe that can never happen, but 
there seems little need for deliberate inconsistency here.

> +}
> +
> +static int pl011_allocate_multi_irqs(struct uart_amba_port *uap)
> +{
> +	int ret = 0;
> +	int i;
> +	unsigned int virq;
> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> +
> +	pl011_write(uap->im, uap, REG_IMSC);
> +
> +	for (i = 0; i < AMBA_NR_IRQS; i++) {

It's not clear where these extra IRQs are expected to come from given 
that the DT binding explicitly defines only one :/

> +		virq = amba_dev->irq[i];
> +		if (virq == 0)
> +			break;
> +
> +		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);

Note that using dev_name() here technically breaks user ABI - scripts 
looking in /proc for an irq named "uart-pl011" will no longer find it.

Furthermore, the "dev" cookie passed to request_irq is supposed to be 
globally unique, which "uap" isn't once you start registering it 
multiple times. If firmware did describe all the individual PL011 IRQ 
outputs on a system where they are muxed to the same physical IRQ 
anyway, you'd end up registering ambiguous IRQ actions here. Of course 
in practice you might still get away with that, but it is technically wrong.

Robin.

> +		if (ret) {
> +			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
> +			pl011_release_multi_irqs(uap, i - 1);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>   static int pl011_allocate_irq(struct uart_amba_port *uap)
>   {
>   	pl011_write(uap->im, uap, REG_IMSC);
> @@ -1753,7 +1788,7 @@ static int pl011_startup(struct uart_port *port)
>   	if (retval)
>   		goto clk_dis;
>   
> -	retval = pl011_allocate_irq(uap);
> +	retval = pl011_allocate_multi_irqs(uap);
>   	if (retval)
>   		goto clk_dis;
>   
> @@ -1864,7 +1899,7 @@ static void pl011_shutdown(struct uart_port *port)
>   
>   	pl011_dma_shutdown(uap);
>   
> -	free_irq(uap->port.irq, uap);
> +	pl011_release_multi_irqs(uap, AMBA_NR_IRQS);
>   
>   	pl011_disable_uart(uap);
>   
> 
