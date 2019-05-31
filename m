Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A09310EC
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 17:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEaPKf (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 11:10:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49879 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaPKf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 11:10:35 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWjAv-0007Ee-J5; Fri, 31 May 2019 17:10:33 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWjAu-0003Zv-98; Fri, 31 May 2019 17:10:32 +0200
Date:   Fri, 31 May 2019 17:10:32 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 1/6] serial: sa1100: add support for mctrl gpios
Message-ID: <20190531151032.tfrl7yqph6wsg5pl@pengutronix.de>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
 <E1hWfTn-0003fP-Rl@rmk-PC.armlinux.org.uk>
 <20190531125013.3gkexhmbqjpdvrtf@pengutronix.de>
 <20190531132340.bco6xpyl3aatbryl@shell.armlinux.org.uk>
 <20190531135658.jo4kas3ozj7gpmmc@pengutronix.de>
 <20190531140127.yp2o7effrsxencyb@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531140127.yp2o7effrsxencyb@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 03:01:28PM +0100, Russell King - ARM Linux admin wrote:
> On Fri, May 31, 2019 at 03:56:58PM +0200, Uwe Kleine-König wrote:
> > Unless I miss something (which is quite possible given that it's quite
> > some time ago I looked into mctrl_gpio) with mctrl_gpio_init_noauto()
> > having a CTS-gpio is just ignored unless the modem ctrl lines are
> > explicitely requestet while with mctrl_gpio_init() it results in an
> > error. Isn't the error the better alternative?
> 
> Unless the serial driver polls the modem control line status, which
> the SA1100 driver continues to do in exactly the same way after this
> conversion.
> 
> Do you suggest that we just regress the driver by ripping out this
> support that no one has had any problems with, and that is known to
> work sufficiently in its day, just because we now don't like it?

No, of course not. A nice improvement would be to teach gpio_mctrl (or
serial core?) about polling. But this is of course out of scope for this
patch, so I suggest to stay with mctrl_gpio_init_noauto and document the
lack of irq-capability somewhere prominently such that someone who picks
up converting mctrl_gpio_init_noauto to mctrl_gpio_init notices this
problem before actually hitting it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
