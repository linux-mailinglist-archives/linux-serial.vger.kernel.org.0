Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73816FD9D
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 12:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfGVKSE (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 06:18:04 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37778 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfGVKSE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 06:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gkWJDjFmWvFFo5gn/ayeQxqCDeYWcEkDWLfDsEOJL5U=; b=rJJPZ2p+apwCmb/V5Vsn8Y/dg
        Ua49j0qBRTTuSpzl2xmnSRvJSkzT0Mlnatvj0/L2J/qMwIUMX01OoNHJtEiDw0norBA1aX92RCRrC
        1UyHgScCvDJTza80ug4GnR1zXU3MLiKX4/HlqrPPe2dwGPFXxgUiLkftYfuZ9e91fIhbfTqYRtKwP
        3X4RZR4pqXDqV3n3ha9wLcxc7bcjIECkf3L3FdTajiSXYwrVTPhOgSnDnvMzr55D2csHbRp3S6WG4
        EUpgGf29vq3qcbsG65KLmooOSkLW/fB2+IJ6ikKrHOZQm3B61K6hvjlDonq/7uN5awiEPEQzwkvdh
        Vj7XKIJ5g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48444)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hpVOJ-0004x4-Pk; Mon, 22 Jul 2019 11:17:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hpVOH-0002tS-Pi; Mon, 22 Jul 2019 11:17:57 +0100
Date:   Mon, 22 Jul 2019 11:17:57 +0100
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
Message-ID: <20190722101757.GC1330@shell.armlinux.org.uk>
References: <1563526074-20399-2-git-send-email-sorganov@gmail.com>
 <20190719091143.uhjxeibtolgswq2l@pengutronix.de>
 <87h87idxq2.fsf@osv.gnss.ru>
 <20190719143151.gx43ndn2oy35h247@pengutronix.de>
 <87woge9hvz.fsf@osv.gnss.ru>
 <20190719201949.ldqlcwjhcmt7wwhg@pengutronix.de>
 <87ftmy8qgu.fsf@osv.gnss.ru>
 <20190722075107.cc3tvf6gmxhaeh5m@pengutronix.de>
 <20190722095721.GB1330@shell.armlinux.org.uk>
 <20190722100414.k5wp4osx3gtuhmnc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722100414.k5wp4osx3gtuhmnc@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 22, 2019 at 12:04:14PM +0200, Uwe Kleine-König wrote:
> Hello Russell,
> 
> On Mon, Jul 22, 2019 at 10:57:21AM +0100, Russell King - ARM Linux admin wrote:
> > However, RTS is not guaranteed to stop the remote end sending characters
> > as soon as it is deasserted - 16550 relies on software noticing that
> > CTS has changed, and even then it may have a FIFO full of characters
> > already queued to be sent that will still be sent.
> > 
> > So, disabling RTS just before changing the baud doesn't give any
> > guarantees that a character won't be in the process of being received
> > while we're changing the baud rate, which means disabling it doesn't
> > actually gain us anything.
> 
> <sarcasm>With that reasoning we can drop RTS driving completely. Let's
> just assert it unconditionally.</sarcam>

Please, I'm being serious.

> Right, deasserting RTS doesn't help against long receive FIFOs or
> senders that react slowly (or not at all), but still it's better than
> nothing, isn't it?

Not really.

In the normal use case of RTS, RTS doesn't get deasserted when there is
no buffer space available, but when the available buffer space reaches
a low-threshold.  Buffer space remains to allow the sender to react to
the change of RTS state.

In the case you are promoting, which is to deassert RTS and then
immediately start changing the port settings, you are not giving any
chance for the sender to react to that state change.  You could even
be mid-way through receiving a character from the remote end - and
at 75 baud, a single character lasts around 133ms.

Even if you wait 133ms, that doesn't mean that the remote end has
finished sending.  If the remote end has a 16 byte FIFO, you'd need
to wait about 2.2 seconds.  At faster baud rates, of course the
delay gets shorter.

Just deasserting RTS just before changing the port settings gains
very little protection.  You need a character-period based delay as
well.

If we do start adding delays, it means that changing the baud rate
for a port set to 75 baud starts taking ages to complete if CRTSCTS
is enabled, irrespective of the settings change mode that was
requested by userspace.

However, adding delays is likely to screw up various userspace
applications, such as those that do need to change baud rate at
specific points in their protocol.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
