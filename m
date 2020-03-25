Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4875192A46
	for <lists+linux-serial@lfdr.de>; Wed, 25 Mar 2020 14:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgCYNmB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Wed, 25 Mar 2020 09:42:01 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36420 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgCYNmB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 09:42:01 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jH6I2-0005OR-Tp; Wed, 25 Mar 2020 14:41:50 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, matwey.kornilov@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Date:   Wed, 25 Mar 2020 14:41:50 +0100
Message-ID: <1688171.mLF46rTMEE@diego>
In-Reply-To: <20200323134106.GL1922688@smile.fi.intel.com>
References: <20200318142640.982763-1-heiko@sntech.de> <20200323131714.vmhjws5xpj6yf536@wunner.de> <20200323134106.GL1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am Montag, 23. M�rz 2020, 14:41:06 CET schrieb Andy Shevchenko:
> On Mon, Mar 23, 2020 at 02:17:14PM +0100, Lukas Wunner wrote:
> > On Mon, Mar 23, 2020 at 09:25:57AM +0100, Heiko St�bner wrote:
> > > Am Donnerstag, 19. M�rz 2020, 06:40:34 CET schrieb Lukas Wunner:
> 
> > "rs485-re-gpios" seems a bit cryptic, how about "rs485-rx-enable-gpios"
> > or "rs485-full-duplex-gpios"?
> 
> First is in align with well established pin name, second is its elaboration,
> I'm for any, but last.

So I guess the intersection of both your preferences
is "rs485-rx-enable-gpios" ... and I did go with that ;-)

I've now moved my rs485 things over to tty-next + taking
	- "serial: Allow uart_get_rs485_mode() to return errno"
	- "serial: 8250: Support rs485 bus termination GPIO"
from Lukas' git-tree + fixing other things according to review comments.

I guess I'll now just sit on things till after the 5.7 merge window for
the depending patches to get posted.


Heiko


