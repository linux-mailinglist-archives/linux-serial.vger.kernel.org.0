Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A458308D6
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 08:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfEaGmv (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 02:42:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48763 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaGmv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 02:42:51 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWbFZ-0007ZI-NM; Fri, 31 May 2019 08:42:49 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWbFY-0004G1-RY; Fri, 31 May 2019 08:42:48 +0200
Date:   Fri, 31 May 2019 08:42:48 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 4/8] serial: imx: get rid of unbounded busy-waiting loop
Message-ID: <20190531064248.qh4tecbv6ejvroyw@pengutronix.de>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-5-sorganov@gmail.com>
 <20190530210059.xt7qlyk57cf3zaux@pengutronix.de>
 <87imtrup3z.fsf@javad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87imtrup3z.fsf@javad.com>
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

On Fri, May 31, 2019 at 09:14:56AM +0300, Sergey Organov wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> 
> > On Thu, May 30, 2019 at 06:29:46PM +0300, Sergey Organov wrote:
> >> imx_set_termios(): remove busy-waiting "drain Tx FIFO" loop. Worse
> >> yet, it was potentially unbounded wait due to RTS/CTS (hardware)
> >> handshake.
> >> 
> >> Let user space ensure draining is done before termios change, if
> >> draining is needed in the first place.
> >
> > I don't know for sure what the intended behaviour is here, but I tend to
> > think that changing the unbounded wait to a timeout and then return
> > -EBUSY (?) would be more suitable.
> 
> No, please! Bytes in Tx FIFO are not an excuse to exit with error
> instead of setting new termios as asked to. 

Well, my suggestion is more defensive. It at least tells the user that
they do something wrong. If they already care for having the FIFO and
transmitter empty before changing the baud rate the behaviour of both
your and my approach are identical. With yours however it undefined if
characters written to the device before the change are sent with the old
or new settings. So my suggestions yields a deterministic behaviour
which is good. And it tells the user when they do something wrong, which
is good, too.

> > With your change you're possibly breaking existent software.
> 
> Well, I suspect the software is already broken then, as most widely used
> drivers out there seem to do no Tx FIFO draining on set_termios() call,
> or do they?
> 
> I mean I tried to find similar code in some of the other drivers, to
> replicate it, but I failed to find one.

The first (and only) driver I checked does. (sa1100.c)
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
