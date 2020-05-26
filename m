Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302E51BD2F7
	for <lists+linux-serial@lfdr.de>; Wed, 29 Apr 2020 05:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgD2Dbe (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 28 Apr 2020 23:31:34 -0400
Received: from kernel.crashing.org ([76.164.61.194]:49574 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgD2Dbe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 23:31:34 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 03T3BtAO008504
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 28 Apr 2020 22:11:59 -0500
Message-ID: <aa7c915310753b042be35758893dee91d3651ffc.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 3/5] drivers/soc/litex: add LiteX SoC Controller
 driver
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Mateusz Holenko <mholenko@antmicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Apr 2020 13:11:54 +1000
In-Reply-To: <20200425133939.3508912-3-mholenko@antmicro.com>
References: <20200425133939.3508912-0-mholenko@antmicro.com>
         <20200425133939.3508912-3-mholenko@antmicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 2020-04-25 at 13:42 +0200, Mateusz Holenko wrote:
> From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> 
> This commit adds driver for the FPGA-based LiteX SoC
> Controller from LiteX SoC builder.

Sorry for jumping in late, Joel only just pointed me to this :)

> + * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
> + * the logic of writing to/reading from the LiteX CSR in a single
> + * place that can be then reused by all LiteX drivers.
> + */
> +void litex_set_reg(void __iomem *reg, unsigned long reg_size,
> +		    unsigned long val)
> +{
> +	unsigned long shifted_data, shift, i;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&csr_lock, flags);
> +
> +	for (i = 0; i < reg_size; ++i) {
> +		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> +		shifted_data = val >> shift;
> +
> +		__raw_writel(shifted_data, reg + (LITEX_REG_SIZE * i));
> +	}
> +
> +	spin_unlock_irqrestore(&csr_lock, flags);
> +}
> +
> +unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_size)
> +{
> +	unsigned long shifted_data, shift, i;
> +	unsigned long result = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&csr_lock, flags);
> +
> +	for (i = 0; i < reg_size; ++i) {
> +		shifted_data = __raw_readl(reg + (LITEX_REG_SIZE * i));
> +
> +		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> +		result |= (shifted_data << shift);
> +	}
> +
> +	spin_unlock_irqrestore(&csr_lock, flags);
> +
> +	return result;
> +}

I really don't like the fact that the register sizes & sub sizes are
#defined. As your comment explains, this makes it harder to support
other configurations. This geometry should come from the device-tree
instead.

Also this while thing is rather gross (and the lock will not help
performance). Why can't CSRs be normally memory mapped always instead ?

Even when transporting them on a HW bus that's smaller, the HW bus
conversion should be able to do the break-down into a multi-breat
transfer rather than doing that in SW.

Or at least have a fast-path if the register size is no larger than the
sub size, so you can use a normal ioread32/iowrite32.

Also I wonder ... last I played with LiteX, it would re-generate the
register layout (including the bit layout inside registers potentially)
rather enthousiastically, making it pretty hard to have a fixed
register layout for use by a kernel driver. Was this addressed ?

Cheers,
Ben.


