Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B2282D0D
	for <lists+linux-serial@lfdr.de>; Tue,  6 Aug 2019 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfHFHpm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 6 Aug 2019 03:45:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43617 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFHpl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Aug 2019 03:45:41 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1huuA4-000499-7m; Tue, 06 Aug 2019 09:45:36 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1huuA2-00079K-Tu; Tue, 06 Aug 2019 09:45:34 +0200
Date:   Tue, 6 Aug 2019 09:45:34 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/4] serial: mctrl_gpio: Add a NULL check to
 mctrl_gpio_to_gpiod()
Message-ID: <20190806074534.5w773nltywxyiljz@pengutronix.de>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
 <20190802100349.8659-2-frieder.schrempf@kontron.de>
 <20190802121231.wk6yg5mkyivs3rni@pengutronix.de>
 <f866213b-fd3b-8602-6c11-56cb65a1ea05@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f866213b-fd3b-8602-6c11-56cb65a1ea05@kontron.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Frieder,

On Mon, Aug 05, 2019 at 09:01:39AM +0000, Schrempf Frieder wrote:
> On 02.08.19 14:12, Uwe Kleine-K�nig wrote:
> > On Fri, Aug 02, 2019 at 10:04:10AM +0000, Schrempf Frieder wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> As it is allowed to use the mctrl_gpio_* functions before
> >> initialization (as the 8250 driver does according to 434be0ae7aa7),
> > 
> > Actually I was surprised some time ago that 8250 used serial_mctrl
> > without first initializing it and expecting it to work. I didn't look in
> > detail, but I wouldn't go so far to call this "allowed". The commit
> > itself calls it "workaround" which seems a better match.
> 
> Ok, but if this is considered to be a workaround and as the 8250 driver 
> does not use mctrl_gpio_to_gpiod(), we should maybe just drop this patch 
> instead of encouraging others to use mctrl_gpio before initialization.
> 
> I'm really not sure what's best, so depending on what you will propose, 
> I'll send a new version of this patch with adjusted commit message or not.

I wouldn't encourage usage of mctrl-gpio before it's initialized. So I
suggest to drop this patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
