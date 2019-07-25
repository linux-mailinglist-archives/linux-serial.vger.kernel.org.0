Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490F7747A2
	for <lists+linux-serial@lfdr.de>; Thu, 25 Jul 2019 08:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbfGYG7o (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 25 Jul 2019 02:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387668AbfGYG7o (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jul 2019 02:59:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B1622BEB;
        Thu, 25 Jul 2019 06:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564037983;
        bh=E2j/LasuGChNhBPL7nZOjM5bTKvK21frj0b+CnvwhGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXGyo32pk7nW6+h2qXg8kJHH02Zj5yXulbCQhzmZ/8X8lwhP4EMpIpEvy5w74QDoH
         ANjIUr97FD8G6VWqIs7Iv2SPi87FILc6FdM2940cINnXJMVZ51DxNC4CwAet9mQgHp
         FBMLGCKI3oxVtyiGRsPlptEoExIlhqJkrWFFvh7M=
Date:   Thu, 25 Jul 2019 08:37:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Morris Ku <saumah@gmail.com>
Cc:     linux-serial@vger.kernel.org, morris_ku@sunix.com,
        kai.heng.feng@canonical.com, tiffany.wang@canonical.com
Subject: Re: [PATCH] Add driver for SUNIX serial board
Message-ID: <20190725063734.GF6723@kroah.com>
References: <20190725062308.7986-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725062308.7986-1-saumah@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 25, 2019 at 02:23:08PM +0800, Morris Ku wrote:
> >> ---
> >>  serial/Kconfig      |  11 ++
> >>  serial/Makefile     |   1 +
> >>  serial/sunix_uart.c | 357 ++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 369 insertions(+)
> >>  create mode 100644 serial/sunix_uart.c
> 
> >Why can't you just use the 8250_pci.c driver here instead of a whole
> >separate one?  What does this hardware need that is so different that
> >you can not just add to the normal pci_boards[] array in that code?
> 
> >If you can not do that, then you need to explain in great detail why
> >that is in the changelog comment in order for us to be able to accept
> >this code.
> 
> SUNIX uses a mixture of bars and offsets, 
> the first four ports use bar0,fifth to sixteenth ports use bar1,
> 8025_pci.c using different bars and offsets,
> fist port use bar0,port two use use bar0 + offset,
> but three to four ports use bar1 ,after port use bar2~bar5,
> can not just use 8250 existing code to set up our hardware,
> the configure method is not suitable for us,
> therefore, we separate one driver for SUNIX serial board. 

Ugh, really?  There's no way to fit this into the existing driver
framework?  You are duplicating a lot of logic here so it really makes
me question if all of this is needed or not.

Are there other drivers in drivers/tty/serial/ that work more like yours
do?

thanks,

greg k-h
