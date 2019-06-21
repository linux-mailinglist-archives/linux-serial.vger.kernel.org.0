Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6B44E1BD
	for <lists+linux-serial@lfdr.de>; Fri, 21 Jun 2019 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfFUINh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 21 Jun 2019 04:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfFUINg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Jun 2019 04:13:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90350208C3;
        Fri, 21 Jun 2019 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561104816;
        bh=awoGjmxJjaFlKS1vjBcYTVKavhI3GbputRY/8qjR0p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2JmllEoUecIJeApEkaNeCbpBRtUtqs3NmU5vLANpQDUoY91DXfw4bIyxuBDkma7Gx
         6sju5goZxD+GnKu8X1eby2FeHAb2aZnxl/TiPf6u+I4/j+lmbkzuRS8M5Av2cruKiI
         EmOPdvzvVaTMp92oVx8ud4JdP/rlzdzjgHnnsF1A=
Date:   Fri, 21 Jun 2019 10:13:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oliver Barta <o.barta89@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jiri Slaby <jslaby@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH] Revert "serial: 8250: Don't service RX FIFO if
 interrupts are disabled"
Message-ID: <20190621081333.GA28160@kroah.com>
References: <20190619081639.325-1-o.barta89@gmail.com>
 <20190619112052.GD9224@smile.fi.intel.com>
 <CALJK04OjK7=iQyH=1RnU9un=hZusMCbE-54-RMSdcRruE9j7Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALJK04OjK7=iQyH=1RnU9un=hZusMCbE-54-RMSdcRruE9j7Ow@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 20, 2019 at 09:28:46AM +0200, Oliver Barta wrote:
> On Wed, Jun 19, 2019 at 1:20 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Jun 19, 2019 at 10:16:39AM +0200, Oliver Barta wrote:
> > > This reverts commit 2e9fe539108320820016f78ca7704a7342788380.
> > >
> > > Reading LSR unconditionally but processing the error flags only if
> > > UART_IIR_RDI bit was set before in IIR may lead to a loss of transmission
> > > error information on UARTs where the transmission error flags are cleared
> > > by a read of LSR. Information are lost in case an error is detected right
> > > before the read of LSR while processing e.g. an UART_IIR_THRI interrupt.
> > >
> >
> > Perhaps Fixes tag?
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> 
> Thank you for the review. I also thought about the Fixes tag but
> finally decided not to use it. It is a simple revert, i.e. the subject
> of the commit which would be mentioned by the Fixes tag is in the new
> subject anyway and the commit ID is referred in the first line of the
> commit message body. The Fixes tag would not add any additional
> information. I also checked a couple of recent revert commits in the
> kernel and noticed that many of them actually don't have this tag.

fixes is needed, as I will backport this to the stable trees.  I'll add
it...

thanks,

greg k-h
