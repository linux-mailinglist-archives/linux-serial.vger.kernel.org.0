Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47D192EF4
	for <lists+linux-serial@lfdr.de>; Wed, 25 Mar 2020 18:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCYRLY (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 25 Mar 2020 13:11:24 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47610 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYRLY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 13:11:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0127F80307C2;
        Wed, 25 Mar 2020 17:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vflws-kvy9oy; Wed, 25 Mar 2020 20:11:20 +0300 (MSK)
Date:   Wed, 25 Mar 2020 20:11:09 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Maxime Ripard <maxime@cerno.tech>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chen-Yu Tsai <wens@csie.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] serial: 8250_dw: Fix common clocks usage race
 condition
Message-ID: <20200325171109.cohnsw3s57ckaqud@ubsrv2.baikal.int>
References: <20200306130231.05BBC8030795@mail.baikalelectronics.ru>
 <20200323024611.16039-1-Sergey.Semin@baikalelectronics.ru>
 <20200323100109.k2gckdyneyzo23fb@gilmour.lan>
 <20200323135017.4vi5nwam2rlpepgn@ubsrv2.baikal.int>
 <20200324101243.GG1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200324101243.GG1922688@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 24, 2020 at 12:12:43PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 23, 2020 at 04:50:17PM +0300, Sergey Semin wrote:
> > On Mon, Mar 23, 2020 at 11:01:09AM +0100, Maxime Ripard wrote:
> > > On Mon, Mar 23, 2020 at 05:46:09AM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > >
> > > > There are races possible in the dw8250_set_termios() callback method
> > > > and while the device is in PM suspend state. A race condition may
> > > > happen if the baudrate clock source device is shared with some other
> > > > device (in our machine it's another DW UART port). In this case if that
> > > > device changes the clock rate while serial console is using it the
> > > > DW 8250 UART port might not only end up with an invalid uartclk value
> > > > saved, but may also experience a distorted output data since baud-clock
> > > > could have been changed. In order to fix this lets enable an exclusive
> > > > reference clock rate access in case if "baudclk" device is specified.
> > > >
> > > > So if some other device also acquires the rate exclusivity during the
> > > > time of a DW UART 8250 port being opened, then DW UART 8250 driver
> > > > won't be able to alter the baud-clock. It shall just use the available
> > > > clock rate. Similarly another device also won't manage to change the
> > > > rate at that time. If nothing else have the exclusive rate access
> > > > acquired except DW UART 8250 driver, then the driver will be able to
> > > > alter the rate as much as it needs to in accordance with the currently
> > > > implemented logic.
> 
> > > clk_rate_exclusive_get is pretty intrusive, and due to the usual
> > > topology of clock trees, this will lock down 3-4 parent clocks to
> > > their current rate as well. In the Allwinner SoCs case for example,
> > > this will lock down the same PLL than the one used by the CPU,
> > > preventing cpufreq from running.
> > 
> > Speaking about weak design of a SoC' clock tree. Our problems are nothing
> > with respect to the Allwinner SoC, in which case of changing the
> > CPU-frequency may cause the UART glitches subsequently causing data
> > transfer artefacts.) Moreover as I can see the same issue may raise for
> > I2C, QSPI, PWM devices there.
> > 
> > Anyway your concern does make sense.
> > 
> > > However, the 8250 has a pretty wide range of dividers and can adapt to
> > > any reasonable parent clock rate, so we don't really need to lock the
> > > rate either, we can simply react to a parent clock rate change using
> > > the clock notifiers, just like the SiFive UART is doing.
> > > 
> > > I tried to do that, but given that I don't really have an extensive
> > > knowledge of the 8250, I couldn't find a way to stop the TX of chars
> > > while we change the clock rate. I'm not sure if this is a big deal or
> > > not, the SiFive UART doesn't seem to care.
> > 
> > Yes, your solution is also possible, but even in case of stopping Tx/Rx it
> > doesn't lack drawbacks. First of all AFAIK there is no easy way to just
> > pause the transfers. We'd have to first wait for the current transfers
> > to be completed, then somehow lock the port usage (both Tx and Rx
> > traffic), permit the reference clock rate change, accordingly adjust the
> > UART clock divider, and finally unlock the port. While if we don't mind
> > to occasionally have UART data glitches, we can just adjust the UART ref
> > divider synchronously with ref clock rate change as you and SiFive UART
> > driver suggest.
> > 
> > So we are now at a zugzwang - a fork to three not that good solutions:
> > 1) lock the whole clock branch and provide a glitchless interfaces. But
> > by doing so we may (in case of Allwinner SoCs we will) lockup some very
> > important functionality like CPU-frequency change while the UART port is
> > started up. In this case we won't have the data glitches.
> > 2) just adjust the UART clock divider in case of reference clock rate
> > change (use the SiFive UART driver approach). In this case we may have the
> > data corruption.
> > 3) somehow implement the algo: wait for the transfers to be completed,
> > lock UART interface (it's possible for Tx, but for Rx in case of no handshake
> > enabled it's simply impossible), permit the ref clock rate change,
> > adjust the UART divider, then unlock the UART interface. In this case the data
> > glitches still may happen (if no modem control is available or
> > handshakes are disabled).
> > 
> > As for the cases of Baikal-T1 UARTs the first solutions is the most suitable.
> > We don't lock anything valuable, since a base PLL output isn't directly
> > connected to any device and it's rate once setup isn't changed during the
> > system running. On the other hand I don't mind to implement the second
> > solution, even though it's prone to data glitches. Regarding the solution
> > 3) I won't even try. It's too complicated, I don't have time and
> > test-infrastructure for this.
> > 
> > So Andy what do you think?
> 
> From Intel HW perspective the first two are okay, but since Maxime is against
> first, you have the only option from your list. Perhaps somebody may give
> option 4) here...
> 

Ok then. I'll implement the option 2) in v3 if noone gives any alternatives
before that.

Regards,
-Sergey

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
