Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B6109AA4
	for <lists+linux-serial@lfdr.de>; Tue, 26 Nov 2019 10:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKZJCa (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 26 Nov 2019 04:02:30 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41177 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKZJCa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Nov 2019 04:02:30 -0500
Received: by mail-il1-f193.google.com with SMTP id q15so16923068ils.8
        for <linux-serial@vger.kernel.org>; Tue, 26 Nov 2019 01:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t3siywQMic4+3G/dPDeE17s5VtxexJ2M1JK1S3ouM4A=;
        b=ZjtgOV/pr8z2qVPm7aKOTj8vneLya3QFAGjk+lNJj/QRunSEptXSIUv964TfpaXgRB
         F3OKkiaNaSAD62pS0zHb9Avv1FbKH8LTbkug33+fFZwVSPcIVSdPG2OaYPJFu6GUkPs5
         HoFCyAmD5YbmF23GK7W1JsY6CkqiKro/Yg565+jxX4ce1wygC+VMaUuGF6dJtlaxI4Ym
         sNzF1zkjllRTjDM+OqPE2rH++4EddtYqGSSZV4suxjs7Ed8/0bKxHOkaSpDWp3HMBmY5
         SkPvXeknRMoR9EGxWpz6IMr/+rKYOyJpDqQC4eL5FSrnbZKGvVFqx9l0IZDWAjuVtzsh
         3xLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t3siywQMic4+3G/dPDeE17s5VtxexJ2M1JK1S3ouM4A=;
        b=uaXts4EecmpUsgJ7/1JTwR5a3ZZe3tqO86ZypK6D1jCEsYRiabWZZELPxvpCUGzj1V
         K12/aGWWpdn/KGHcXz1/3wsbHAM6ONh50wB4NVRMpLJv5fD1H9tkvAn4nKVxB1hdbKYW
         EvrcEzgXSWvcl8Qft3OaIobkFIL5rvnBBFTHItjdnI1B8LeSc89EyK2w1RPCQM/T82CW
         2ottejWUlX6yJOh74y/vDoBCVT512A1aykQySuXEV/skZSf9xZyLUddwsrTX2+BHUo4y
         R7O6Ct4IqwQ1TrCE6MfTginFiCLMUgYL1hmaLQIlxl+3tQSkP3V/2NA9f6LYWDulVREl
         2ruQ==
X-Gm-Message-State: APjAAAWsNtgG2E7F25q1wffuy3CJ02oI4xeLDHmtzNJSGmyuPBWYJDLM
        k778D4ThaUMseyu+1mvL/QdbRqJx8xUS/OVovykUHA==
X-Google-Smtp-Source: APXvYqy4JJs4tw+DQhFyc6W+aR+iSnEHpG2/S9kZTb9FNJ0ZfmIWFBpeEsmr/idfvM6lF5Zm2kkdOgUlGH9+yBjM+B0=
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr37130431ils.270.1574758949256;
 Tue, 26 Nov 2019 01:02:29 -0800 (PST)
MIME-Version: 1.0
References: <20191023114634.13657-0-mholenko@antmicro.com> <20191023114634.13657-2-mholenko@antmicro.com>
 <20191120192648.GA3087498@kroah.com>
In-Reply-To: <20191120192648.GA3087498@kroah.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 26 Nov 2019 10:02:18 +0100
Message-ID: <CAPk366QgcOYPZJXM46o3Gn8ksFYYoNwJvnunUe7y0aLNgJuSRg@mail.gmail.com>
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

=C5=9Br., 20 lis 2019 o 20:26 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> On Wed, Oct 23, 2019 at 11:47:04AM +0200, Mateusz Holenko wrote:
> > +#ifdef __LITTLE_ENDIAN
> > +# define LITEX_READ_REG(addr)                  ioread32(addr)
> > +# define LITEX_READ_REG_OFF(addr, off)         ioread32(addr + off)
> > +# define LITEX_WRITE_REG(val, addr)            iowrite32(val, addr)
> > +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32(val, addr + o=
ff)
> > +#else
> > +# define LITEX_READ_REG(addr)                  ioread32be(addr)
> > +# define LITEX_READ_REG_OFF(addr, off)         ioread32be(addr + off)
> > +# define LITEX_WRITE_REG(val, addr)            iowrite32be(val, addr)
> > +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32be(val, addr +=
 off)
> > +#endif
>
> I just noticed this.
>
> Ick, this is not good.  You will run into problems in the future with
> this, I can guarantee it.  What about systems where the CPU is one
> endian and the hardware in the other?  It will happen trust us.

As mentioned in the previous comment, LiteX CSRs are guaranteed to be
always little-endian - this includes configurations with both
big-endian and little-endian CPUs.

The aim of including the ifdef section was exactly to target situation
where endianness is different for CPU and devices. As such this
approach *should* work.

> Make these real functions (inline is nice) and pass in the pointer to
> the device so you can test for it and call the correct function based on
> the cpu/hardware type.
>
> And what about bitfields?  What endian are they for your
> system/hardware?
>
> Almost no kernel code should EVER be testing __LITTLE_ENDIAN, don't add
> to it as it is not a good idea.

If I understand correctly, you suggest to replace compile-time
ifdefing with probing the endianness in the runtime (by reading some
register that should return a known value, say 1, and testing how bits
are arranged). This is a good idea, as it protects against breaking an
always-little-endian property of LiteX CSRs in the future.

I'll include this in the next version of the patchset.

> thanks,
>
> greg k-h

Thanks for your comments!

--=20
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
