Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15D74C0C
	for <lists+linux-serial@lfdr.de>; Thu, 25 Jul 2019 12:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfGYKpZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 25 Jul 2019 06:45:25 -0400
Received: from svc.spearhead.de ([138.201.174.56]:48586 "EHLO mx.spearhead.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfGYKpZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jul 2019 06:45:25 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2019 06:45:24 EDT
Received: from ks-ws-898.localnet (unknown [109.234.108.5])
        (Authenticated sender: ngollan@spearhead.de)
        by mx.spearhead.de (Postfix) with ESMTPSA id 6B01A1A0383;
        Thu, 25 Jul 2019 12:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=spearhead.de;
        s=20180801; t=1564051122;
        bh=RQ05gSzkt4R7kWoLy4g1LDvDU/PmRYUYINChz0dD/sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLYivsPaqrP/d3XTztY58X4yO8mqRBkxdreOQuTkoLFRhwojlRz8PeEsmtpqe9FWl
         a+UWxgXlraGsCocEsj7olUdU7jAjnk4FSTUk+6jhUCzUvLBY1EwFpzoAEZJJ+vAxl1
         ZEztt0vA85/yf1anyTTDan8C2RTWYa8WTSGC07n4bEhkTofKoTP7eoDfBf/WOOXKRf
         FZJdvRNx1O0t1hIR0kYRVZIEo9UTOxOlTkx8PtOMqKW8k9dYSKO+gJB2RpDv3xUw0P
         ALMVJtT4JOb5LfWoKt8X+wxwgUdG7vI5bbo7lLw9lefDmXYzhmpigxBd7myqb81Fyx
         Kb6oYtKGyCeEA==
From:   Nicos Gollan <gtdev@spearhead.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mike Bogdanov <mbogdanov@shtrih-m.ru>, linux-serial@vger.kernel.org
Subject: Re: st-lab i-472 serial card problem
Date:   Thu, 25 Jul 2019 12:38:41 +0200
Message-ID: <3789008.8O4pXQ00YW@ks-ws-898>
In-Reply-To: <20190725101847.GB7550@kroah.com>
References: <001e01d5415a$6c677800$45366800$@shtrih-m.ru> <20190725101847.GB7550@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On fimmtudagur, 25. j=C3=BAl=C3=AD 2019 12:18:47 CEST Greg KH wrote:
> On Tue, Jul 23, 2019 at 04:27:47PM +0300, Mike Bogdanov wrote:
>
> > In dmesg i found the follow message with yuor email:
> > [ 2.180347] Serial: 8250/16550 driver, 10 ports, IRQ sharing enabled
> > [ 2.207661] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200)=
 is a
> > 16550A
> > [ 2.237213] 0000:01:00.0: ttyS4 at I/O 0xe050 (irq =3D 16, base_baud =3D
> > 115200) is a ST16650V2
> > [ 2.266932] 0000:01:00.0: ttyS5 at I/O 0xe040 (irq =3D 16, base_baud =3D
> > 115200) is a ST16650V2
> > [ 2.296576] 0000:01:00.1: ttyS6 at I/O 0xe030 (irq =3D 17, base_baud =3D
> > 115200) is a ST16650V2
> > [ 2.326296] 0000:01:00.1: ttyS7 at I/O 0xe020 (irq =3D 17, base_baud =3D
> > 115200) is a ST16650V2
> > [ 2.334970] serial 0000:01:00.2: NetMos/Mostech serial driver ignoring
> > port
> > on ambiguous config.
> > [ 2.343895] serial 0000:01:00.2: 0000:01:00.2: unknown NetMos/Mostech
> > device Please send the output of lspci -vv, this
> > message (0x9710,0x9900,0xa000,0x1000), the
> > manufacturer and name of serial board or
> > modem board to <linux-serial@vger.kernel.org>.

This appears to be the case referenced by the "something" part of

/* two possibilities: 0x30ps encodes number of parallel and
 * serial ports, or 0x1000 indicates *something*. This is not
 * immediately obvious, since the 2s1p+4s configuration seems
 * to offer all functionality on functions 0..2, while still
 * advertising the same function 3 as the 4s+2s1p config.
 */

in 8250_pci.c=E2=80=A6

You have two serial ports each on the 0xa000 0x3002 subsystems seen in lspc=
i=20
output, and then presumably the remaining two on the mystery 0xa000 0x1000.

It's been 8 years since I scraped that information from documentation and=20
experiments, and all I had at hand was a card with 2 serial ports and a=20
parallel port (that I couldn't even test and that proved problematic since=
=20
then), so I'm afraid I cannot be of more help here.

I could hunt around and see if I still have the reference material somewher=
e=20
if that'd be any help.

Regards,
Nicos=20


