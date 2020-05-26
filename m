Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C63C41A0943
	for <lists+linux-serial@lfdr.de>; Tue,  7 Apr 2020 10:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgDGIY6 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 7 Apr 2020 04:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgDGIY6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Apr 2020 04:24:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 351A2206F5;
        Tue,  7 Apr 2020 08:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586247896;
        bh=IYb2+hXmpvqAeqxl3BbYye9bnfH9byYpN4dj42j/PW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ynnn9jZaCGXhbzmY63rVaQFUK6H2S+7lQvJnbYjaIqQyW6rbxw5ZXCJtmDM4d8rm4
         A432RuZIMP4yy2FOz3mf4WBcUytQyIoP5DKoqeg53zT9GSsjvmfYBysYHSyo7/JhAp
         0WnTFz+qXA+BGrqQaA6y66f5xBPCTOul1IcxO0qs=
Date:   Tue, 7 Apr 2020 10:24:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     gianluca <gianlucarenzi@eurek.it>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gianluca Renzi <icjtqr@gmail.com>,
        dimka@embeddedalley.com, linux@rempel-privat.de
Subject: Re: Serial data loss
Message-ID: <20200407082454.GA299198@kroah.com>
References: <960c5054-48b0-fedc-4f3a-7246d84da832@eurek.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960c5054-48b0-fedc-4f3a-7246d84da832@eurek.it>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 07, 2020 at 09:30:21AM +0200, gianluca wrote:
> I have a BIG trouble having dataloss when using two internal serial ports of
> my boards based on NXP/FreeScale iMX28 SoC ARMv5Te ARM920ej-s architecture.
> 
> It runs at 454Mhz.
> 
> Kernel used 4.9.x

That's a very old kernel, you are going to have to get support for that
from the vendor you bought it from :(

> When using my test case unit software between two serial ports connect each
> other by a null modem cable, it fails when the speed rate are different,

Of course, how would that work?

> and
> dataloss is increasing higher the speed rate.

What type of flow control are you using?

> I suppose to have overruns (now I am modifying my software to check them
> too), but I think it is due the way the ISR is called and all data are
> passed to the uart circular buffer within the interrupt routine.

Are you using flow control?

> I am talking about the high latency from the IRQ up to the service routine
> when flushing the FIFO and another IRQ is called by another uart in the same
> time at different speed.
> 
> The code I was looking is: drivers/tty/serial/mxs-auart.c __but__ all other
> serial drivers are acting in the same way: they are reading one character at
> time from the FIFO (if it exists) and put it into the circular buffer so
> serial/tty driver can pass them to the user read routine.
> 
> Each function call has some overhead and it is time-consuming, and if
> another interrupt is invoked by the same UART Core but from another serial
> port (different context) the continuos insertion done by hardware UART into
> the FIFO cannot be served fast enough to have an overrun. I think this can
> be applied __almost__ to every serial driver as they are written in the same
> way.
> 
> And it is __NOT__ an issue because of the CPU and its speed! Using two
> serial converter (FTDI and Prolific PL2303 based) on each board, the problem
> does not appear at all even after 24 hours running at more than 115200!!!

usb-serial devices are totally different and send data to the host in a
completly different way.

Your hardware might just not be able to handle really high baud rates at
a continous stream, what baud rate were you using?

And again, this is what flow control was designed for, please use it.

> It does work fine if I am using two different serial devices: one internal
> uart (mxs-auart) and an external uart (ttyUSB).

Again, different interrupt and protocols being used for the USB stuff.

thanks,

greg k-h
