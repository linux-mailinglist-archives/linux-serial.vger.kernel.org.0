Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50A26FD43
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfGVJ53 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 05:57:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37494 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfGVJ53 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 05:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tQ5m2UDprMKRY1x5W1rLDOU7BxPXCW4165TN6Wpecgo=; b=y2wQkrRA2llYBYaZorJdtoIjx
        1CL1Rhi65cP4suUWxgsOYCXi1eYBjtZlzCfgo66KcUD3esWUWDtPpNwuaM2v8iXHDc9aGojY/QW0v
        GvExlpFk/KUCXK0N65J0Ng1+KBfSrOfnBjjEnSJXDPg2aOvFyoRZ0UKEwrmF5dkaEmyJcyUtodaOL
        3GQqlkJs4w7tG+1THttsFJK3gx6mcpvmUBOBqTRsN2TqPatX6nQWcLMkNW3Z8dtDuSHVJ8T9PRpDf
        /zraglUiBSuFDgvxYUbM6BA+oEyE994UuZ9r0g+5oWGJIagcDPg9EsR9x9EqbNeTKo2sos8YxcRhB
        LfZmBQQ8A==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:44302)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hpV4O-0004pn-CG; Mon, 22 Jul 2019 10:57:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hpV4L-0002rc-GW; Mon, 22 Jul 2019 10:57:21 +0100
Date:   Mon, 22 Jul 2019 10:57:21 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sergey Organov <sorganov@gmail.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] serial: imx: set_termios(): do not enable autoRTS
 if RTS is unset
Message-ID: <20190722095721.GB1330@shell.armlinux.org.uk>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563526074-20399-1-git-send-email-sorganov@gmail.com>
 <1563526074-20399-2-git-send-email-sorganov@gmail.com>
 <20190719091143.uhjxeibtolgswq2l@pengutronix.de>
 <87h87idxq2.fsf@osv.gnss.ru>
 <20190719143151.gx43ndn2oy35h247@pengutronix.de>
 <87woge9hvz.fsf@osv.gnss.ru>
 <20190719201949.ldqlcwjhcmt7wwhg@pengutronix.de>
 <87ftmy8qgu.fsf@osv.gnss.ru>
 <20190722075107.cc3tvf6gmxhaeh5m@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722075107.cc3tvf6gmxhaeh5m@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 22, 2019 at 09:51:07AM +0200, Uwe Kleine-König wrote:
> On Mon, Jul 22, 2019 at 10:42:57AM +0300, Sergey Organov wrote:
> > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> > 
> > > On Fri, Jul 19, 2019 at 06:13:52PM +0300, Sergey Organov wrote:
> > >> Hello Uwe,
> > >> 
> > >> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> > >> > Hello Sergey,
> > >> >
> > >> > On Fri, Jul 19, 2019 at 03:18:13PM +0300, Sergey Organov wrote:
> > >> >> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> > >> >> > On Fri, Jul 19, 2019 at 11:47:52AM +0300, Sergey Organov wrote:
> > >> >> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > >> >> >> index 57d6e6b..95d7984 100644
> > >> >> >> --- a/drivers/tty/serial/imx.c
> > >> >> >> +++ b/drivers/tty/serial/imx.c
> > >> >> >> @@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
> > >> >> >>  /* called with port.lock taken and irqs caller dependent */
> > >> >> >>  static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
> > >> >> >>  {
> > >> >> >> -	*ucr2 |= UCR2_CTSC;
> > >> >> >> +	if (*ucr2 & UCR2_CTS)
> > >> >> >> +		*ucr2 |= UCR2_CTSC;
> > >> >> >
> > >> >> > I think this patch is wrong or the commit log is insufficient.
> > >> >> > imx_uart_rts_auto() has only a single caller and there ucr2 & UCR2_CTS is
> > >> >> > never true. And CTSC isn't restored anywhere, is it?
> > >> >> 
> > >> >> This is rebase to 'tty-next' branch, and you need to look at it in that
> > >> >> context. There, ucr2 & UCR2_CTS does already make sense, due to previous
> > >> >> fix that is already there.
> > >> >
> > >> > I looked at 57d6e6b which is the file you patched. And there
> > >> > imx_uart_rts_auto is only ever called with *ucr2 not having UCR2_CTS.
> > >> >
> > >> > If you still think I'm wrong, please improve the commit log
> > >> > accordingly.
> > >> 
> > >> I still think you are wrong, but I don't know how to improve commit log.
> > >> 
> > >> To check it once again, I just did:
> > >> 
> > >> $ git show 57d6e6b > imx.c
> > >> 
> > >> There, in imx_uart_set_termios(), I see:
> > >> 
> > >> 1569:	old_ucr2 = imx_uart_readl(sport, UCR2);
> > >> 1570:	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTS);
> > >> 
> > >> Here, current UCR2 value is read into 'old_ucr2' and then its /current/
> > >> UCR2_CTS bit is copied into 'ucr2' (along with 3 other bits).
> > >> 
> > >> Then, later in the same function:
> > >> 
> > >> 1591:		imx_uart_rts_auto(sport, &ucr2);
> > >> 
> > >> is called that can check /current/ state of UCR2_CTS bit in '*ucr2'.
> > >> 
> > >> That's what the patch does, checks this bit.
> > >> 
> > >> Sorry, I fail to see how you came to conclusion that "*ucr2 not having
> > >> UCR2_CTS". Do we maybe still read different versions of the file?
> > >
> > > No, it's just that I failed to see that UCR2_CTS is in the set of bits
> > > that are retained even when looking twice :-|
> > 
> > Ah, that one... How familiar :-)
> 
> I thought again a bit over the weekend about this. I wonder if it's
> correct to keep RTS active while going through .set_termios. Shouldn't
> it maybe always be inactive to prevent the other side sending data while
> we are changing the baud rate?

Only if CRTSCTS is enabled, and then there are a lot of serial drivers
to fix.

However, RTS is not guaranteed to stop the remote end sending characters
as soon as it is deasserted - 16550 relies on software noticing that
CTS has changed, and even then it may have a FIFO full of characters
already queued to be sent that will still be sent.

So, disabling RTS just before changing the baud doesn't give any
guarantees that a character won't be in the process of being received
while we're changing the baud rate, which means disabling it doesn't
actually gain us anything.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
