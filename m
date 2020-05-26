Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E04E1D7CBE
	for <lists+linux-serial@lfdr.de>; Mon, 18 May 2020 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgERPWu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 18 May 2020 11:22:50 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:41365 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgERPWu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 11:22:50 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 01E2230008F30;
        Mon, 18 May 2020 17:22:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CE6A75B551; Mon, 18 May 2020 17:22:47 +0200 (CEST)
Date:   Mon, 18 May 2020 17:22:47 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v3 3/5] serial: 8250: Support separate rs485 rx-enable
 GPIO
Message-ID: <20200518152247.slenjeiiplps7mcd@wunner.de>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-4-heiko@sntech.de>
 <20200518151241.GG1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518151241.GG1634618@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 18, 2020 at 06:12:41PM +0300, Andy Shevchenko wrote:
> On Sun, May 17, 2020 at 11:56:08PM +0200, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > 
> > The RE signal is used to control the duplex mode of transmissions,
> > aka receiving data while sending in full duplex mode, while stopping
> > receiving data in half-duplex mode.
> > 
> > On a number of boards the !RE signal is tied to ground so reception
> > is always enabled except if the UART allows disabling the receiver.
> > This can be taken advantage of to implement half-duplex mode - like
> > done on 8250_bcm2835aux.
> > 
> > Another solution is to tie !RE to RTS always forcing half-duplex mode.
> > 
> > And finally there is the option to control the RE signal separately,
> > like done here by introducing a new rs485-specific gpio that can be
> > set depending on the RX_DURING_TX setting in the common em485 callbacks.
> 
> ...
> 
> > +	port->rs485_re_gpio = devm_gpiod_get_optional(dev, "rs485-rx-enable",
> > +						      GPIOD_OUT_HIGH);
> 
> While reviewing some other patch I realized that people are missing the
> point of these GPIO flags when pin is declared to be output.
> 
> HIGH here means "asserted" (consider active-high vs. active-low in
> general). Is that the intention here?
> 
> Lukas, same question to your patch.

Yes.  "High", i.e. asserted, means "termination enabled" in the case of
my patch and "receiver enabled" in the case of Heiko's patch.

For termination, the default is "low", i.e. termination disabled.
I talked to our hardware engineers and they said that disabling
termination by default is the safe choice:  If multiple devices
on the RS485 bus enable termination, then no communication may
be possible at all.  Whereas if termination is disabled,
communication should always work at least for short cables.
And for longer cables, users may have to disable it using the
TIOCSRS485 ioctl.

In the case of Heiko's patches, the default is "high", i.e.
the receiver is enabled by default so you're able to receive
data over the bus after opening the tty.  Once you start
transmitting, the GPIO may be switched to low for the duration
of the transmission if half-duplex mode is enabled.

Thanks,

Lukas
