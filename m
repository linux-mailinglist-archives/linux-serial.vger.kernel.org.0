Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B762D0869
	for <lists+linux-serial@lfdr.de>; Wed,  9 Oct 2019 09:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfJIHh1 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 9 Oct 2019 03:37:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54523 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJIHh0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Oct 2019 03:37:26 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iI6XB-0003fs-8a; Wed, 09 Oct 2019 09:37:21 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iI6X7-0004RL-ER; Wed, 09 Oct 2019 09:37:17 +0200
Date:   Wed, 9 Oct 2019 09:37:17 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty: serial: imx: Only get second/third IRQ when there
 is more than one IRQ
Message-ID: <20191009073717.qlr2svma5fiaf4ad@pengutronix.de>
References: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
 <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
 <DB3PR0402MB39165F9CE876772F8F94F187F5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191009071403.ugd2wuac6ue5zsd6@pengutronix.de>
 <DB3PR0402MB39161E02A9D042948B71FDCDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB39161E02A9D042948B71FDCDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 09, 2019 at 07:24:57AM +0000, Anson Huang wrote:
> > On Wed, Oct 09, 2019 at 06:58:24AM +0000, Anson Huang wrote:
> > > > The patch is fine given the changed behaviour of platform_get_irq. I
> > > > wonder if it is sensible to introduce a variant of platform_get_irq (say
> > > > platform_get_irq_nowarn) that behaves like __platform_get_irq does t
> > > > Then the imx driver would just call platform_get_irq_nowarn without
> > > > having to check the number of available irqs first.
> > >
> > > Agreed, it would be nice if we can fix this from the API level, this
> > > is to save many patches from various drivers side, let me know if
> > > agreement is reached and I will do the patch.
> > 
> > I wouldn't expect that most callers actually want an error message and so
> > these need a different patch (i.e. dropping the error message by the caller).
> > This type of patch is fine and the normal load when something is
> > consolidated.
> > 
> > Which other drivers do you have on your radar that don't want an error
> > message if platform_get_irq() fails?
> 
> I did NOT mean drivers don't want an error when getting irq failed, but I just
> agree that introducing another API with nowarn as you mentioned upper, then
> i.MX driver can call it. For now, the FEC driver also have many such error message,
> we will fix later.
> 
> So if the API with nowarn is added, then I can change the API call in some i.MX driver
> instead of getting irq_count first. Do you think I should add the nowarn API and redo
> this patch to call it? 

Having a patch (or a set of patches) is probably helpful to get forward
here, yes. You have my blessing to create a suggestion. (Not that you
actually need that :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
