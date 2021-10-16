Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F152430348
	for <lists+linux-serial@lfdr.de>; Sat, 16 Oct 2021 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbhJPP1j (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 16 Oct 2021 11:27:39 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:39994 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhJPP1j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 16 Oct 2021 11:27:39 -0400
Date:   Sat, 16 Oct 2021 18:25:21 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 9ACC680307C7
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Johan Hovold <johan@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] serial: 8250: fix racy uartclk update
Message-ID: <20211016152521.zmzhtkswhphos4q7@mobilestation>
References: <20211015111422.1027-1-johan@kernel.org>
 <20211015191000.hspyxgkwwd47w4nl@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211015191000.hspyxgkwwd47w4nl@mobilestation>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Johan

On Fri, Oct 15, 2021 at 10:10:00PM +0300, Serge Semin wrote:
> On Fri, Oct 15, 2021 at 01:14:19PM +0200, Johan Hovold wrote:
> > Here's a fix for the asynchronous uartclk-update hack which was added
> > last year and a couple of related clean ups.
> 
> Yeah, that was very unfortunate patchset. Thank you very much for the fix.
> I'll test it out tomorrow.
> 
> -Sergey

The series has been tested on Baikal-T1 SoC with two UART ports
feed with a common reference clock. It's working well. Thanks again
for fixing the problem. For the whole series
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> > 
> > Johan
> > 
> > 
> > Johan Hovold (3):
> >   serial: 8250: fix racy uartclk update
> >   serial: 8250: rename unlock labels
> >   serial: 8250_dw: drop bogus uartclk optimisation
> > 
> >  drivers/tty/serial/8250/8250_dw.c   | 11 ++++------
> >  drivers/tty/serial/8250/8250_port.c | 31 ++++++++++++++++++++---------
> >  2 files changed, 26 insertions(+), 16 deletions(-)
> > 
> > -- 
> > 2.32.0
> > 
