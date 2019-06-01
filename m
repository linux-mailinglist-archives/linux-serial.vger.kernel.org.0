Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4AAD31FE3
	for <lists+linux-serial@lfdr.de>; Sat,  1 Jun 2019 18:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfFAQNA (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 1 Jun 2019 12:13:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35709 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfFAQNA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 1 Jun 2019 12:13:00 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hX6cs-0005rD-7s; Sat, 01 Jun 2019 18:12:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hX6cq-0003E1-3P; Sat, 01 Jun 2019 18:12:56 +0200
Date:   Sat, 1 Jun 2019 18:12:56 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/8] serial: imx: fix breaking RTS/CTS handshake by mctrl
 change
Message-ID: <20190601161256.4zuhqzrdskjdymu5@pengutronix.de>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-3-sorganov@gmail.com>
 <20190530203931.n6b22ktbzuyg67sd@pengutronix.de>
 <87woi7ur1g.fsf@javad.com>
 <20190531062809.nacg54russc3wvcz@pengutronix.de>
 <20190531135438.bqrpek6niddnrqmo@shell.armlinux.org.uk>
 <87r28ea2qa.fsf@javad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r28ea2qa.fsf@javad.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On Fri, May 31, 2019 at 09:38:37PM +0300, Sergey Organov wrote:
> Russell King <rmk@armlinux.org.uk> writes:
> > If this is not done, data loss will occur: characters will be received
> > from the FIFO, and the attempt to place them into the kernel buffer
> > will fail, resulting in the characters being discarded.  This would not
> > be an effective hardware flow control implementation.
> 
> Why? Doesn't kernel stop its receiving machinery anyway when software
> receive buffers get filled?
> 
> If it does, that seems logical, then it will rather stop reading from
> FIFO, and once FIFO fills above threshold (if at all), hardware will
> de-assert RTS by itself, no complications required.

Not all hardware has a FIFO and the necessary mechanisms to
auto-deassert RTS when it fills. So there must be support in software to
deassert RTS, too. And even in the presence of a "smart" FIFO, the
software then usually knows earlier about having to stop the other side
and this might be the necessary margin that makes them stop before the
local buffer is over full.

Best regards
Uwe
-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
