Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C6730881
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 08:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfEaG2O (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 02:28:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34825 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaG2O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 02:28:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWb1Q-0006CN-CA; Fri, 31 May 2019 08:28:12 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWb1N-0003tt-Gu; Fri, 31 May 2019 08:28:09 +0200
Date:   Fri, 31 May 2019 08:28:09 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 2/8] serial: imx: fix breaking RTS/CTS handshake by mctrl
 change
Message-ID: <20190531062809.nacg54russc3wvcz@pengutronix.de>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-3-sorganov@gmail.com>
 <20190530203931.n6b22ktbzuyg67sd@pengutronix.de>
 <87woi7ur1g.fsf@javad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87woi7ur1g.fsf@javad.com>
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

On Fri, May 31, 2019 at 08:33:15AM +0300, Sergey Organov wrote:
> This is still wrong, as it turns off RTS/CTS handshake in hardware on
> TIOCM_RTS=0. Once again, set_mctrl() should not touch UCR2_CTSC, -- it's
> as simple as that.
> 
> I still think it's rather what I did in the patch above is the right
> thing to do. It's simple and does the job, no surprises.

I agree that your patch implements the behaviour you intend as the right
one. I believe however that this behaviour isn't right.

We agree that with handshaking disabled (i.e CRTSCTS unset) the RTS
output should be set active iff TIOCM_RTS is requested.

With hardware handshaking enabled the two options we disagree about are:

 a) RTS is not supposed to be changed, only the hardware controls the
    level of RTS.
 b) RTS should be set to inactive if !TIOCM_RTS. Otherwise the hardware
    controls the RTS level.

An equivalent wording of b) is:

	RTS should be active iff both the receiver and the software
	request want it to be active.

Sergey thinks a) is the right one, I believe in b).

I think b) is sane, because with a) the kernel (or userspace) cannot
stop the other side sending data (unless they disable handshaking).

Documentation/serial/driver isn't clear here, we should improve that
once we found an agreement (probably by other people chiming in on what
they think is right).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
