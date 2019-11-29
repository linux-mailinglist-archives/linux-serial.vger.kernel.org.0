Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD0510D7F1
	for <lists+linux-serial@lfdr.de>; Fri, 29 Nov 2019 16:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfK2Pjl (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 29 Nov 2019 10:39:41 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46377 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfK2Pjk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Nov 2019 10:39:40 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so32817914iol.13
        for <linux-serial@vger.kernel.org>; Fri, 29 Nov 2019 07:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GZ64dFx/b6xoVXXGFcVREkFmLBqmtyqbMTpiRv9D3vk=;
        b=b1IChhjArK99MWA1YVOtlfL8+65h6lp14vSr6zaz6U/uJRX1NnqsinLYifo5jeI8QL
         9NQqI1S+uP+PGNiVgwxZaSP1yEr699GBPQgTa6Kxh2KZRCo8kjWU6gyU6oXnAHBXHxm3
         kKZNUp9hgsc4yPCyLbIbC8GpTx/9/en1oOVRoFnC6VE98XRs3rHb47JkrHJC94IOtQeB
         i66Upa+3wY0VAI9TN3tHeEZHLaWFuZqdU/5nelGTlXkejXirbyXtWERnkMkfKQm+EgWO
         WBNJuDj1LGuChGWfugCocwa7j5aYFC6mASJdftS5jEu3k3FjKMWHf2Aw2qU7gKJaz5Yb
         RekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GZ64dFx/b6xoVXXGFcVREkFmLBqmtyqbMTpiRv9D3vk=;
        b=g2lXzAIqAvNh7kBejqowC1JeX7pUE0D4FE9s+WCrsw1NyxWAngtbQWls5bMB9V699U
         jNXShWBn+6JoJDELLrHn9fdsB40Q3oIf0VEwl296OkW/GPDmA2dmxfMKpZaW9avN6SHp
         +rPeA0/rlOi72xk0P4uUs5skqeFaXnjOp3lLuU5q9hRbqXgX0NnGFPIUwts97TkQGrbi
         63PERdamDjXOkfOXYkwQuWuuoptuiRexC3ENuxi3tGB+s3GlNMTsRYiH3kj9cRK+3frO
         +T5tNHLOhW4EiU4WsHPMrQZS4vnkcLkVwZDJSMt2g8Lsht82WuFKe9ENXttd6hYXwPUk
         k9fA==
X-Gm-Message-State: APjAAAXIEzpqIaFKKhjyCPQOMJzHI6vLUBt2VtytOISQBDKdTZeFly/f
        0QgBmwDWWF+ENMGD6fnWREq/XYsJ4/pVorl0INELxg==
X-Google-Smtp-Source: APXvYqxXwIY3yJH7Gn9pZM6Hw5rVVw762bvoB4Gded6U8Sn+JmxOp/vhgIZapxUg9GwljvgJfYpXIkZys55MYqMsxDU=
X-Received: by 2002:a02:a388:: with SMTP id y8mr10590059jak.70.1575041979840;
 Fri, 29 Nov 2019 07:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20191023114634.13657-0-mholenko@antmicro.com> <20191023114634.13657-2-mholenko@antmicro.com>
 <20191120192648.GA3087498@kroah.com> <CAPk366QgcOYPZJXM46o3Gn8ksFYYoNwJvnunUe7y0aLNgJuSRg@mail.gmail.com>
 <20191126091926.GB1372654@kroah.com>
In-Reply-To: <20191126091926.GB1372654@kroah.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Fri, 29 Nov 2019 16:39:28 +0100
Message-ID: <CAPk366T-B_7ADCC4XhOT8QdQ5hxC3mNkvfcuY3diu1wnWBHkAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] litex: add common LiteX header
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

wt., 26 lis 2019 o 10:19 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> On Tue, Nov 26, 2019 at 10:02:18AM +0100, Mateusz Holenko wrote:
> > =C5=9Br., 20 lis 2019 o 20:26 Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> napisa=C5=82(a):
> > >
> > > On Wed, Oct 23, 2019 at 11:47:04AM +0200, Mateusz Holenko wrote:
> > > > +#ifdef __LITTLE_ENDIAN
> > > > +# define LITEX_READ_REG(addr)                  ioread32(addr)
> > > > +# define LITEX_READ_REG_OFF(addr, off)         ioread32(addr + off=
)
> > > > +# define LITEX_WRITE_REG(val, addr)            iowrite32(val, addr=
)
> > > > +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32(val, addr=
 + off)
> > > > +#else
> > > > +# define LITEX_READ_REG(addr)                  ioread32be(addr)
> > > > +# define LITEX_READ_REG_OFF(addr, off)         ioread32be(addr + o=
ff)
> > > > +# define LITEX_WRITE_REG(val, addr)            iowrite32be(val, ad=
dr)
> > > > +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32be(val, ad=
dr + off)
> > > > +#endif
> > >
> > > I just noticed this.
> > >
> > > Ick, this is not good.  You will run into problems in the future with
> > > this, I can guarantee it.  What about systems where the CPU is one
> > > endian and the hardware in the other?  It will happen trust us.
> >
> > As mentioned in the previous comment, LiteX CSRs are guaranteed to be
> > always little-endian - this includes configurations with both
> > big-endian and little-endian CPUs.
>
> What enforces that guarantee?

liteuart is na IP core that comes as a part of a design generated and
configured by LiteX SoC builder
(https://github.com/enjoy-digital/litex). Current implementation of
LiteX generates systems in such a way that CSRs in peripherals are
little-endian regardless of a softcore CPU used (available options
cover both little-endian and big-endian CPU cores). Liteuart is a part
of the LiteX project and is probably not usable outside of it.

I was digging through the code and documentation to verify that the
always-little-endian-CSR behaviour is "guaranteed", but - to my
surprise - couldn't find anything. It seems to be simply an
implementation detail that might (maybe?) change in the future.

In this context your suggestion about probing things dynamically seems
to be even more relevant.

> > The aim of including the ifdef section was exactly to target situation
> > where endianness is different for CPU and devices. As such this
> > approach *should* work.
>
> "should" :)
>
> We have seen it happen all the time that some hardware team hooks this
> up backwards, no matter what the "spec" required.  So be careful here.
>
> good luck!
>
> greg k-h



--=20
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
