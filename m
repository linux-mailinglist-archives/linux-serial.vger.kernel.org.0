Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9362104444
	for <lists+linux-serial@lfdr.de>; Wed, 20 Nov 2019 20:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKTT0v (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 20 Nov 2019 14:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfKTT0v (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Nov 2019 14:26:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF3FC20715;
        Wed, 20 Nov 2019 19:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574278010;
        bh=888qcNglt2aTTLwRLbfmkuf5RTUPH/vN/mvNViLPEiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKUolow49rTYCuaqW/HzuQAs4Vg7WSbifWby4JjUoi0Or7N8DDNZkdmk4g9956COv
         CpjE0MSqZK+GWUnI7iPlhI2DF+XaKdOsDIGdK7+T1+WcFtaiAaAVF0qi87dhpTvrWg
         dz9CzAS+fK97+U2w6Gn5+TV720gK0+C77qDyjKqk=
Date:   Wed, 20 Nov 2019 20:26:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] litex: add common LiteX header
Message-ID: <20191120192648.GA3087498@kroah.com>
References: <20191023114634.13657-0-mholenko@antmicro.com>
 <20191023114634.13657-2-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023114634.13657-2-mholenko@antmicro.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 23, 2019 at 11:47:04AM +0200, Mateusz Holenko wrote:
> +#ifdef __LITTLE_ENDIAN
> +# define LITEX_READ_REG(addr)                  ioread32(addr)
> +# define LITEX_READ_REG_OFF(addr, off)         ioread32(addr + off)
> +# define LITEX_WRITE_REG(val, addr)            iowrite32(val, addr)
> +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32(val, addr + off)
> +#else
> +# define LITEX_READ_REG(addr)                  ioread32be(addr)
> +# define LITEX_READ_REG_OFF(addr, off)         ioread32be(addr + off)
> +# define LITEX_WRITE_REG(val, addr)            iowrite32be(val, addr)
> +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32be(val, addr + off)
> +#endif

I just noticed this.

Ick, this is not good.  You will run into problems in the future with
this, I can guarantee it.  What about systems where the CPU is one
endian and the hardware in the other?  It will happen trust us.

Make these real functions (inline is nice) and pass in the pointer to
the device so you can test for it and call the correct function based on
the cpu/hardware type.

And what about bitfields?  What endian are they for your
system/hardware?

Almost no kernel code should EVER be testing __LITTLE_ENDIAN, don't add
to it as it is not a good idea.

thanks,

greg k-h
