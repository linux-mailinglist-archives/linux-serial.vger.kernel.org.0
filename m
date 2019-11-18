Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9656A1005DC
	for <lists+linux-serial@lfdr.de>; Mon, 18 Nov 2019 13:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKRMry convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Mon, 18 Nov 2019 07:47:54 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49390 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfKRMry (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Nov 2019 07:47:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1B738608325B;
        Mon, 18 Nov 2019 13:47:51 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9twFQkO4XXdp; Mon, 18 Nov 2019 13:47:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A6CE260632CE;
        Mon, 18 Nov 2019 13:47:50 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UsjnQgIzNO_j; Mon, 18 Nov 2019 13:47:50 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 72DCD605AD4C;
        Mon, 18 Nov 2019 13:47:50 +0100 (CET)
Date:   Mon, 18 Nov 2019 13:47:50 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-serial@vger.kernel.org
Message-ID: <1505628642.90849.1574081270290.JavaMail.zimbra@nod.at>
In-Reply-To: <20191118114657.GA228826@kroah.com>
References: <20191117202435.28127-1-sudipm.mukherjee@gmail.com> <20191118114657.GA228826@kroah.com>
Subject: Re: [PATCH v2] {tty: serial, nand: onenand}: samsung: rename to fix
 build warning
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: {tty: serial, nand: onenand}: samsung: rename to fix build warning
Thread-Index: e5heYAEPAAm1QXkAbCz7WpzWPdhATg==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

----- Ursprüngliche Mail -----
>> I was not sure if this should have been two different patch, but since
>> this will be fixing the same problem so it seems its better to have them
>> in a single patch.
>> 
>>  drivers/mtd/nand/onenand/Makefile                     | 2 +-
>>  drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} | 0
>>  drivers/tty/serial/Makefile                           | 2 +-
>>  drivers/tty/serial/{samsung.c => samsung_tty.c}       | 0
>>  4 files changed, 2 insertions(+), 2 deletions(-)
>>  rename drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} (100%)
>>  rename drivers/tty/serial/{samsung.c => samsung_tty.c} (100%)
> 
> I can take this in the tty tree if the mtd maintainer gives an ack for
> it...

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
