Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6295333C1
	for <lists+linux-serial@lfdr.de>; Mon,  3 Jun 2019 17:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfFCPkt (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 3 Jun 2019 11:40:49 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52282 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfFCPks (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jun 2019 11:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YSNg+78IfBsInyz5teLIuGp2liUpOszxWOcCrlIMeYc=; b=wXXQpOx9TdKU4jLk6LqOM+oBe
        DT9H7wTM2KTN67UG1fctXmYzOi2B88a8qZBNwtC7MhyDfHQL8uxPvwdrRoHjsy8PSxVGxiFZqrrNc
        pijTphCaoUFJUC+xl9h7qFjEtzPppIIQDaacx1l2N0iijk+DEdp7vbLTdY+gxjGuKwBoHCvFf2czp
        BN9pXTxHSfQvxu/PZBdnTy6G1tl5y//W7HYwLaANBOB1jl1BHDArUudx5cy2LQKg2hBaWpIkKjOXi
        0sQZufA6eDd+n8eacaIhR+jXyrLcKkynGCPUHSffoRzinSRvhuM01FjzhVYciUlC1HGnIXte3R+0u
        7j2nh19fA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38472)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hXp4m-0003nF-Pl; Mon, 03 Jun 2019 16:40:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hXp4k-0000jB-0t; Mon, 03 Jun 2019 16:40:42 +0100
Date:   Mon, 3 Jun 2019 16:40:41 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/8] serial: imx: fix breaking RTS/CTS handshake by mctrl
 change
Message-ID: <20190603154041.disl65ibr5zasqor@shell.armlinux.org.uk>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-3-sorganov@gmail.com>
 <20190530203931.n6b22ktbzuyg67sd@pengutronix.de>
 <87woi7ur1g.fsf@javad.com>
 <20190531062809.nacg54russc3wvcz@pengutronix.de>
 <20190531135438.bqrpek6niddnrqmo@shell.armlinux.org.uk>
 <87r28ea2qa.fsf@javad.com>
 <20190601161256.4zuhqzrdskjdymu5@pengutronix.de>
 <20190601193436.irs6sdknz755uyem@shell.armlinux.org.uk>
 <875zpm7ty1.fsf@javad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zpm7ty1.fsf@javad.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 03, 2019 at 03:08:06PM +0300, Sergey Organov wrote:
> Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:
> 
> [...]
> 
> > If we want the kernel to stop reading the FIFO, we would have to add
> > additional complexity to a lot of serial drivers, and a capability
> > which tells the kernel that they support this behaviour - why do we
> > want individual drivers to have to implement this?
> 
> How does it work when no handshake is configured? Drivers continue to
> read FIFOs/TxDs and drop data when software buffers are full, spending
> CPU cycles on nothing?

I assume what you mean by "no handshake" is "no flow control", then
yes, the CPU continues to read the FIFO and drops the received
characters on the floor.

When no flow control is configured, it means there is no way to signal
to the remote end that there is congestion at the receiving end, and
if there is no buffer space available, where would you expect the
received characters to be stored?

If the CPU were to stop reading the FIFO, the result would be that the
FIFO fills, and then any further characters received get discarded by
the hardware (instead of the CPU) and the hardware marks an overrun
error.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
