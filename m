Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B868867F17
	for <lists+linux-serial@lfdr.de>; Sun, 14 Jul 2019 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfGNNWr (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 14 Jul 2019 09:22:47 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:52238 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfGNNWq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 14 Jul 2019 09:22:46 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990429AbfGNNWoAUwkD (ORCPT
        <rfc822;linux-serial@vger.kernel.org> + 1 other);
        Sun, 14 Jul 2019 15:22:44 +0200
Date:   Sun, 14 Jul 2019 15:22:42 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/5] usb: gadget: u_serial: Fix and cleanup
Message-ID: <20190714132242.GA17980@lenoch>
References: <20190713210853.GA25753@lenoch>
 <20190714100426.GA24183@qmqm.qmqm.pl>
 <20190714113717.GA7399@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190714113717.GA7399@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jul 14, 2019 at 01:37:17PM +0200, Micha³ Miros³aw wrote:
> On Sun, Jul 14, 2019 at 12:04:26PM +0200, Micha³ Miros³aw wrote:
> > On Sat, Jul 13, 2019 at 11:08:53PM +0200, Ladislav Michl wrote:
> > > Following patchset makes console work (patch 1 and 4) for an AT91SAM9G20
> > > board connected to xhci_hcd and does some cleanup.
> > > Tested with "console=ttyS0,115200n8 console=ttyGS0" on kernel command line
> > > and following inittab:
> > > console::respawn:/sbin/getty -L 115200 ttyS0 vt100
> > > console::respawn:/sbin/getty -L 115200 ttyGS0 vt100
> > > 
> > > However there is an issue remaining:
> > > Disconnect triggers WARN_ON in gs_close:
> > [...]
> > 
> > Hi,
> > 
> > Can you try a patchset I sent some time ago [1] if it fixes your case?
> 
> You can pull it from branch usb-console on https://rere.qmqm.pl/git/linux
> (rebased on current usb-next tree).

Thank you! I has just in the middle of pulling patches from mail archive.

Your first two patches are definitely worth applying and I'll add my
Tested-by after more testing. 3/5 is unfortunately "I do not care" as
not having use case, 4/5 is something I do not see use case either, but
I'm fine with that, except for #ifdefs, but 5/5 should be solved the
other way around - just wait until everything is written out, of course
only if USB is connected. That's what serial consoles does and that's
what I expect from kernel console.

Your patch set does not attempt to solve tty write to unconnected USB
and WARN_ON on gs_close, so I'll wait for comments to those two issues
and redo fix on top of "reimplement console support" as getting rid of
the kthread is definitely superior to fixing it :)

Best regards,
	ladis
