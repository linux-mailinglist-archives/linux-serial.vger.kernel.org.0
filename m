Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDCA1004A1
	for <lists+linux-serial@lfdr.de>; Mon, 18 Nov 2019 12:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfKRLrC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 18 Nov 2019 06:47:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfKRLrB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Nov 2019 06:47:01 -0500
Received: from localhost (unknown [89.205.134.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB5820730;
        Mon, 18 Nov 2019 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574077621;
        bh=kDnVWqM8rv4v0DFbARQKnL4pnCPNws5EF5tS19PJ2+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feKrCvQ/m8Ef+oJobtODMFU/XcxXBRqauk0eAksInQzk60LFEAgNKobEQ/8djXNv5
         SdqcRwonoa3KFQt2IANfPfJy1hUC6al1156N2ZzeXxFqzBcrATsNn3ry8d6fDDotjk
         aJ+T9NNv1Sxv4LKP2WJOIGl1ohIEsJFHgpW31F1E=
Date:   Mon, 18 Nov 2019 12:46:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] {tty: serial, nand: onenand}: samsung: rename to fix
 build warning
Message-ID: <20191118114657.GA228826@kroah.com>
References: <20191117202435.28127-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117202435.28127-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 17, 2019 at 08:24:35PM +0000, Sudip Mukherjee wrote:
> Any arm config which has 'CONFIG_MTD_ONENAND_SAMSUNG=m' and
> 'CONFIG_SERIAL_SAMSUNG=m' gives a build warning:
> 
> warning: same module names found:
>   drivers/tty/serial/samsung.ko
>   drivers/mtd/nand/onenand/samsung.ko
> 
> Rename both drivers/tty/serial/samsung.c to
> drivers/tty/serial/samsung_tty.c and drivers/mtd/nand/onenand/samsung.c
> drivers/mtd/nand/onenand/samsung_mtd.c to fix the warning.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
> 
> v1: only renamed drivers/tty/serial/samsung.c
> link: https://lore.kernel.org/lkml/20191018194707.27188-1-sudipm.mukherjee@gmail.com
> 
> v2: rename both files.
> 
> I was not sure if this should have been two different patch, but since
> this will be fixing the same problem so it seems its better to have them
> in a single patch.
> 
>  drivers/mtd/nand/onenand/Makefile                     | 2 +-
>  drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} | 0
>  drivers/tty/serial/Makefile                           | 2 +-
>  drivers/tty/serial/{samsung.c => samsung_tty.c}       | 0
>  4 files changed, 2 insertions(+), 2 deletions(-)
>  rename drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} (100%)
>  rename drivers/tty/serial/{samsung.c => samsung_tty.c} (100%)

I can take this in the tty tree if the mtd maintainer gives an ack for
it...

