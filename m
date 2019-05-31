Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9919E30F5B
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 15:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEaNys (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 09:54:48 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60614 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaNys (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 09:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NndIUZOREYEyaAGrLKsS3lwz5m1HhXfUAr5q/2lHKaI=; b=PEelSHd83kML9pRQDS1XfWUUi
        6Jh7dgYfzoFEMsdOEa4JsaWo+QNllCTf9q6iFpFn6O/D0MibvlZ34i0RK6UihUae0AqR7P+A+NdLq
        9mijaV9U8mydZp3S2aVFCySxP9itw7/+t5nyHhEpbXcvvrWeEncNZNtwmTfroUnXRIoMQq0Rxd8A2
        yGg78kYdWbmaCi1CViLcILjMcTbI7VUoc+ipYUDybNMFB6ZbXYYOrF8sQCagqTCgqpyJUJ6z9jZVF
        YuJVrHB2i2H4cL6gwS373GveeyWjbpmlixYZT7abqfuWyRFjgjQ1qgC45rcas8dx6vRsvNdwUiClC
        CtHVQwgPw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38406)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hWhzV-00017l-AP; Fri, 31 May 2019 14:54:41 +0100
Received: from rmk by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <rmk@shell.armlinux.org.uk>)
        id 1hWhzS-0006OY-Mu; Fri, 31 May 2019 14:54:38 +0100
Date:   Fri, 31 May 2019 14:54:38 +0100
From:   Russell King <rmk@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/8] serial: imx: fix breaking RTS/CTS handshake by mctrl
 change
Message-ID: <20190531135438.bqrpek6niddnrqmo@shell.armlinux.org.uk>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-3-sorganov@gmail.com>
 <20190530203931.n6b22ktbzuyg67sd@pengutronix.de>
 <87woi7ur1g.fsf@javad.com>
 <20190531062809.nacg54russc3wvcz@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531062809.nacg54russc3wvcz@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe, this is more ment for Sergey, I don't seem to have his emails
obviously to hand...

On Fri, May 31, 2019 at 08:28:09AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, May 31, 2019 at 08:33:15AM +0300, Sergey Organov wrote:
> > This is still wrong, as it turns off RTS/CTS handshake in hardware on
> > TIOCM_RTS=0. Once again, set_mctrl() should not touch UCR2_CTSC, -- it's
> > as simple as that.

That is incorrect.

The point of hardware flow control is to stop the remote end when the
buffers at the receiver fill up, and by "buffers" I mean _either_ the
FIFO or the kernel's buffers.

With serial ports that do not have hardware RTS support, the kernel
can only notify the remote end that the kernel buffers are full, and
it does this by calling set_mctrl() to deassert RTS.

Some serial ports have additional hardware that allows them to
automatically deassert the RTS signal when the receive FIFO is in
danger of overflowing - this is entirely supplementary to the above
mechanism, so the conditions for deasserting the RTS signal when
CRTSCTS is set become:

   If the kernel buffers fill up, and the kernel calls set_mctrl()
   with RTS false, _or_ the hardware decides that the FIFO is close
   to overflowing and itself decides to deassert RTS, then RTS should
   be deasserted.

Ergo, if the driver's set_mctrl() is called with RTS=0, then RTS must
be force-deasserted whether or not hardware assisted flow control is
enabled.

If this is not done, data loss will occur: characters will be received
from the FIFO, and the attempt to place them into the kernel buffer
will fail, resulting in the characters being discarded.  This would not
be an effective hardware flow control implementation.

-- 
Russell King
ARM architecture Linux Kernel maintainer, ex-serial maintainer, author
of the serial-core and the basis of the serial structure in
drivers/tty/serial.
