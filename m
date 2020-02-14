Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F98215F65B
	for <lists+linux-serial@lfdr.de>; Fri, 14 Feb 2020 20:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbgBNTGG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Feb 2020 14:06:06 -0500
Received: from muru.com ([72.249.23.125]:55378 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbgBNTGG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 14:06:06 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6B90C80E7;
        Fri, 14 Feb 2020 19:06:50 +0000 (UTC)
Date:   Fri, 14 Feb 2020 11:06:03 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 5/8] serial: 8250_port: Don't use power management for
 kernel console
Message-ID: <20200214190603.GT16391@atomide.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-6-andriy.shevchenko@linux.intel.com>
 <20200214133918.GP25745@shell.armlinux.org.uk>
 <20200214171348.GP16391@atomide.com>
 <20200214180935.GP10400@smile.fi.intel.com>
 <20200214184251.GR16391@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214184251.GR16391@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [200214 10:42]:
> OK. So far no luck getting console UART idled after detaching the
> console with:
> 
> # echo N > /sys/class/tty/ttyS2/console
> 
> Any ideas what might be missing still?

Looks like echo Y keeps increasing the usage count while
echo N will never decrease it currently. Is port->dev
maybe already NULL in serial8250_console_exit() or something?

This is still without the series you listed as a dependency
though. I need to test with that later on today when I get
a chance.

Regards,

Tony
