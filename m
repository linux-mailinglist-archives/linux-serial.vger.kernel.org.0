Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6142922D
	for <lists+linux-serial@lfdr.de>; Fri, 24 May 2019 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbfEXH5Q (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 24 May 2019 03:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbfEXH5Q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 May 2019 03:57:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA48020879;
        Fri, 24 May 2019 07:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558684635;
        bh=vAYcLZiYVq3O5KhRY0OKolvSq/MVf8bBgjD/JdjCsCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hri8bYkq46EXQBVgdJ9xPHx9IHmnef7c2H6SapXWTmsh1FfJPflXoOBIyxneL4tVI
         F7fXLHWzrD60QA+jL0STKNXfTqgRkd0gBe8rR/xaZ8pt6I+kGammv/2jdF96Sl2biE
         ZhEi5pWWukb1RJZ0zvtQVXdxJkxZ1HsbZFwf8VAE=
Date:   Fri, 24 May 2019 09:57:12 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3] serial: 8250: Fix TX interrupt handling condition
Message-ID: <20190524075712.GC31438@kroah.com>
References: <1558680424-57578-1-git-send-email-ext-kimmo.rautkoski@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558680424-57578-1-git-send-email-ext-kimmo.rautkoski@vaisala.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 24, 2019 at 06:47:33AM +0000, Rautkoski Kimmo EXT wrote:
> Interrupt handler checked THRE bit (transmitter holding register
> empty) in LSR to detect if TX fifo is empty.
> In case when there is only receive interrupts the TX handling
> got called because THRE bit in LSR is set when there is no
> transmission (FIFO empty). TX handling caused TX stop, which in
> RS-485 half-duplex mode actually resets receiver FIFO. This is not
> desired during reception because of possible data loss.
> 
> The fix is to check if THRI is set in IER in addition of the TX
> fifo status. THRI in IER is set when TX is started and cleared
> when TX is stopped.
> This ensures that TX handling is only called when there is really
> transmission on going and an interrupt for THRE and not when there
> are only RX interrupts.
> 
> Signed-off-by: Kimmo Rautkoski <ext-kimmo.rautkoski@vaisala.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

What changed from all of the previous versions of this patch?  That
needs to go below the --- line.

Please fix up and resend a v4.

thanks,

greg k-h
