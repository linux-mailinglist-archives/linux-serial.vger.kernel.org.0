Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 498C874E44
	for <lists+linux-serial@lfdr.de>; Thu, 25 Jul 2019 14:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbfGYMka (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 25 Jul 2019 08:40:30 -0400
Received: from mail.shtrih-m.ru ([46.28.88.60]:41428 "EHLO mail.shtrih-m.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387879AbfGYMka (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jul 2019 08:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=shtrih-m.ru
        ; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:In-Reply-To:References:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BUOe9B7bZPThQYsOUc/81D6uhr1Y9Vm/MlvLicGnotw=; b=RloeNO1WQNmFCE079OwQKQlf96
        9BpdB2eWjQJ0makq2CA7YFSobdVX79OEllGoOqLdhAwsPCtN9lpVq0eb4KaotRUWxfXiy1R1qIIB1
        9wMxTrI8jW725Mx7uvYquBQASsJp9TBLOHk3UMSmTppm8UNiLedRRZaAf6sGEB7i20qK3+1DSe4cQ
        hpTn62nZT9qEovqfhehnmRaUOIdXxTNrkUYUTI23IUgM4Z15ru8rBM8MUDWLnGmvnUYKsTpvndwW8
        nGE2kcxykYU1wLafHQqL75IVy5kEsUuI1IhL4ca7YOiVWr1Qd57UT6ZSKRp/GTk2j+1m3miv2gW7P
        ZMI+naNA==;
Received: from [46.28.89.34] (helo=mbogdanovnb)
        by mail.shtrih-m.ru with esmtpa (envelope-from <mbogdanov@shtrih-m.ru>)
        id 1hqd2q-0001oi-Qu; Thu, 25 Jul 2019 15:40:29 +0300
From:   "Mike Bogdanov" <mbogdanov@shtrih-m.ru>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>,
        "'Nicos Gollan'" <gtdev@spearhead.de>
Cc:     <linux-serial@vger.kernel.org>
References: <001e01d5415a$6c677800$45366800$@shtrih-m.ru> <20190725101847.GB7550@kroah.com>
In-Reply-To: <20190725101847.GB7550@kroah.com>
Subject: RE: st-lab i-472 serial card problem
Date:   Thu, 25 Jul 2019 15:40:29 +0300
Message-ID: <001f01d542e6$263cfca0$72b6f5e0$@shtrih-m.ru>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIKrhPb9icA+bgxJjOcW/U9Ff9dsAI/DTI8pl5vsWA=
Content-Language: ru
X-Authenticated-As: mbogdanov@shtrih-m.ru
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, July 25, 2019 1:19 PM
> To: Mike Bogdanov; Nicos Gollan
> Cc: linux-serial@vger.kernel.org
> Subject: Re: st-lab i-472 serial card problem
> 
> On Tue, Jul 23, 2019 at 04:27:47PM +0300, Mike Bogdanov wrote:
> > Hi,
> > I have a problem with 6  serial port card st-lab i-472
> >
(http://www.stlab.ru/catalog/kontrolleri/controller-st-lab-pci-e-x1-i-472-i-
> > 470-6-ext-6xcom9m-ret.html).
> >
> > i have instaled debian 8.
> > >root@c000050:~# uname -a
> > >Linux c000050 4.9.0-0.bpo.9-686-pae #1 SMP Debian 4.9.168-
> 1+deb9u3~deb8u1
> > (2019-06-17) i686 GNU/Linux
> >
> >
> > In dmesg i found the follow message with yuor email:
> > [ 2.180347] Serial: 8250/16550 driver, 10 ports, IRQ sharing enabled
> > [ 2.207661] 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a
> > 16550A
> > [ 2.237213] 0000:01:00.0: ttyS4 at I/O 0xe050 (irq = 16, base_baud =
115200)
> > is a ST16650V2
> > [ 2.266932] 0000:01:00.0: ttyS5 at I/O 0xe040 (irq = 16, base_baud =
115200)
> > is a ST16650V2
> > [ 2.296576] 0000:01:00.1: ttyS6 at I/O 0xe030 (irq = 17, base_baud =
115200)
> > is a ST16650V2
> > [ 2.326296] 0000:01:00.1: ttyS7 at I/O 0xe020 (irq = 17, base_baud =
115200)
> > is a ST16650V2
> > [ 2.334970] serial 0000:01:00.2: NetMos/Mostech serial driver ignoring
port
> > on ambiguous config.
> > [ 2.343895] serial 0000:01:00.2: 0000:01:00.2: unknown NetMos/Mostech
> device
> > Please send the output of lspci -vv, this
> > message (0x9710,0x9900,0xa000,0x1000), the
> > manufacturer and name of serial board or
> > modem board to <linux-serial@vger.kernel.org>.
> > [ 2.371816] serial 0000:01:00.3: NetMos/Mostech serial driver ignoring
port
> > on ambiguous config.
> > [ 2.380734] serial 0000:01:00.3: 0000:01:00.3: unknown NetMos/Mostech
> device
> > Please send the output of lspci -vv, this
> > message (0x9710,0x9900,0xa000,0x1000), the
> > manufacturer and name of serial board or
> > modem board to <linux-serial@vger.kernel.org>.
> >
> >
> 
> Odd, this "should" work.  Nicos added support for this back in the 3.1
> kernel, but odds are something has changed in the hardware since then.
> Does the device work properly even with these messages?

Before linux kernel 4.9 I work with 3.16 . Yes port was workable with
similar message but without suggestion to write message to someone. 

> Nicos, any idea?
> 
> lspci-v output below for reference.
> 
> thanks,
> 
> greg k-h
> 
> ----------------------------------------------------------
> >
> > Can you give advice how can i start this board?
> >

I'm not shure I'm right.... especially if consider a comment in code I found
near my error message:
 //serial ports, or 0x1000 indicates *something*. This is not immediately
obvious, since the 2s1p+4s ...

But I decide to make temporary solution for me witch work now:
----------------------------------------------------------
*** 8250_pci.old.c      
--- 8250_pci.c  
***************
*** 810,819 ****
--- 810,821 ----
                 * advertising the same function 3 as the 4s+2s1p config.
                 */
                sub_serports = dev->subsystem_device & 0xf;
                if (sub_serports > 0)
                        return sub_serports;
+               if (dev->subsystem_vendor == 0xa000 && dev->subsystem_device
== 0x1000)
+                       return 1;
                dev_err(&dev->dev,
                        "NetMos/Mostech serial driver ignoring port on
ambiguous config.\n");
                return 0;
        }
----------------------------------------------------------


Best Regards,
Bogdanov Mike




