Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067836872A
	for <lists+linux-serial@lfdr.de>; Mon, 15 Jul 2019 12:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfGOKki (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 15 Jul 2019 06:40:38 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:57730 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfGOKki (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jul 2019 06:40:38 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990945AbfGOKkfwMa3r (ORCPT
        <rfc822;linux-serial@vger.kernel.org> + 1 other);
        Mon, 15 Jul 2019 12:40:35 +0200
Date:   Mon, 15 Jul 2019 12:40:32 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/5] usb: gadget: u_serial: Fix and cleanup
Message-ID: <20190715104032.GA5084@lenoch>
References: <20190713210853.GA25753@lenoch>
 <20190714100426.GA24183@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190714100426.GA24183@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Micha³,

On Sun, Jul 14, 2019 at 12:04:26PM +0200, Micha³ Miros³aw wrote:
> On Sat, Jul 13, 2019 at 11:08:53PM +0200, Ladislav Michl wrote:
> > Following patchset makes console work (patch 1 and 4) for an AT91SAM9G20
> > board connected to xhci_hcd and does some cleanup.
> > Tested with "console=ttyS0,115200n8 console=ttyGS0" on kernel command line
> > and following inittab:
> > console::respawn:/sbin/getty -L 115200 ttyS0 vt100
> > console::respawn:/sbin/getty -L 115200 ttyGS0 vt100
> > 
> > However there is an issue remaining:
> > Disconnect triggers WARN_ON in gs_close:
> [...]
> 
> Hi,
> 
> Can you try a patchset I sent some time ago [1] if it fixes your case?

your "usb: gadget: u_serial: add missing port entry locking" and
"usb: gadget: u_serial: reimplement console support" fixes every single
problem I had with the driver (including that WARN_ON on gs_close),
except starving console write.
Fortunately my patch "usb: gadget: u_serial: Fix starving write"
applies on top of your first two patches.

So here's my
Tested-by: Ladislav Michl <ladis@linux-mips.org>
and also one nit for your second patch (there are people running cocci scripts,
so save them some time ;-)):
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -931,8 +931,8 @@ static void gs_console_complete_out(struct usb_ep *ep, struct usb_request *req)
 static void __gs_console_push(struct gs_console *cons)
 {
 	struct usb_request *req = cons->req;
-	struct usb_ep *ep = cons->console.data;
-	size_t size = 0;
+	struct usb_ep *ep;
+	size_t size;
 
 	if (!req)
 		return;	/* disconnected */
@@ -940,6 +940,7 @@ static void __gs_console_push(struct gs_console *cons)
 	if (req->length)
 		return;	/* busy */
 
+	ep = cons->console.data;
 	size = kfifo_out(&cons->buf, req->buf, ep->maxpacket);
 	if (!size)
 		return;

I'm dropping all my patches except the fourth one in favour of your solution
as it is clearly superior. Care to resend it possibly with above fix and
said fourth patch as a single serie?

Thank you,
	ladis
