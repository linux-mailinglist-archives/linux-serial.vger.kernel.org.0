Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86E467EDC
	for <lists+linux-serial@lfdr.de>; Sun, 14 Jul 2019 13:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfGNLhV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 14 Jul 2019 07:37:21 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:40273 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbfGNLhV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 14 Jul 2019 07:37:21 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 45ml3R67Vdz11;
        Sun, 14 Jul 2019 13:36:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1563104164; bh=7HabMtUqMho0Z7HXEeVbSCVRP1hN2FB9e5q746zNy3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kakBuXEdxnjqRQAXwZ/qzZOSAhDdwtdINrqbUgzxuh9jHg8a5OeuRUjXr5yyOeNKq
         a0uw35O8abj89MIem0kgaznD+ZJxLWT7NuM9BYVOKUdweX5q24373cpaY7OLuk9ZIF
         C1BRG/9XWfWYNM0xhHakNiWDsAFEQ9RE9VUgwasqzAomxeXFIWB1JR6xJow7WTHf7p
         6GaPlptX5y0wP0qn+vxi0EKCFwo2cOeoTw7HbjJtPYrEhfFALvSTRlp0IMzt5+0qRU
         JPswkcH0cRpHICBk3JZHBxJpKyuaX3vB97VFCLag9KvDprPgq+DrHIQLnP/ctk8QM6
         pemXLRviM/qzg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Sun, 14 Jul 2019 13:37:17 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/5] usb: gadget: u_serial: Fix and cleanup
Message-ID: <20190714113717.GA7399@qmqm.qmqm.pl>
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

You can pull it from branch usb-console on https://rere.qmqm.pl/git/linux
(rebased on current usb-next tree).

Best Regards,
Micha³ Miros³aw
