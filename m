Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290C5100C28
	for <lists+linux-serial@lfdr.de>; Mon, 18 Nov 2019 20:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfKRTXL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Mon, 18 Nov 2019 14:23:11 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59451 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfKRTXL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Nov 2019 14:23:11 -0500
X-Originating-IP: 90.38.106.182
Received: from xps13 (atoulouse-659-1-107-182.w90-38.abo.wanadoo.fr [90.38.106.182])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 593ED40008;
        Mon, 18 Nov 2019 19:22:58 +0000 (UTC)
Date:   Mon, 18 Nov 2019 20:22:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] {tty: serial, nand: onenand}: samsung: rename to fix
 build warning
Message-ID: <20191118202257.6cfd1a7e@xps13>
In-Reply-To: <1505628642.90849.1574081270290.JavaMail.zimbra@nod.at>
References: <20191117202435.28127-1-sudipm.mukherjee@gmail.com>
        <20191118114657.GA228826@kroah.com>
        <1505628642.90849.1574081270290.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi all,

Richard Weinberger <richard@nod.at> wrote on Mon, 18 Nov 2019 13:47:50
+0100 (CET):

> ----- Ursprüngliche Mail -----
> >> I was not sure if this should have been two different patch, but since
> >> this will be fixing the same problem so it seems its better to have them
> >> in a single patch.
> >> 
> >>  drivers/mtd/nand/onenand/Makefile                     | 2 +-
> >>  drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} | 0
> >>  drivers/tty/serial/Makefile                           | 2 +-
> >>  drivers/tty/serial/{samsung.c => samsung_tty.c}       | 0
> >>  4 files changed, 2 insertions(+), 2 deletions(-)
> >>  rename drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} (100%)
> >>  rename drivers/tty/serial/{samsung.c => samsung_tty.c} (100%)  
> > 
> > I can take this in the tty tree if the mtd maintainer gives an ack for
> > it...  
> 
> Acked-by: Richard Weinberger <richard@nod.at>

If it is not too late, I am not a big fan of the new naming which is
rather not descriptive. Files in the onenand subdirectory are:
* onenand_<something>.c for the base files
* <vendor>.c for the vendors files (currently: omap2.c and samsung.c).

What about doing the MTD changes in a single patch and renaming both
vendor drivers (for the same reason): onenand_omap2.c and
onenand_samsung.c? I know it makes git blaming more difficult though.

Thanks,
Miquèl
