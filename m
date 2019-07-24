Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0955F72E2A
	for <lists+linux-serial@lfdr.de>; Wed, 24 Jul 2019 13:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387394AbfGXLtx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 24 Jul 2019 07:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387393AbfGXLtx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Jul 2019 07:49:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD6D22387;
        Wed, 24 Jul 2019 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563968992;
        bh=1/xmoYA57W4JcTzKmGFdkNHp9cxIaPDiJ7hzKntNi7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xao00mpH+A4rLMdX576y0UK4HUBQpxysFCBXjwRuApfbmiH500cFGJByDK2U/kxOf
         ZfIP8JSk7ucAbvQxU37o2vxZ3Kzbbgz8+i2MHescWVJLYAbfblbfzlI3JycpuDlB6D
         ftdGWRtlJq1EBPA0x7sAZs7CBj8DZcDLWFrY4EIc=
Date:   Wed, 24 Jul 2019 13:49:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     morrisku <saumah@gmail.com>
Cc:     linux-serial@vger.kernel.org, morris_ku@sunix.com
Subject: Re: [PATCH] Add driver for SUNIX serial board
Message-ID: <20190724114948.GA20533@kroah.com>
References: <20190724112647.4177-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724112647.4177-1-saumah@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 24, 2019 at 07:26:47PM +0800, morrisku wrote:
> This patch add support for SUNIX serial board.
> 
> Signed-off-by: morrisku <saumah@gmail.com>

I need a "real" name here, and on the From: line in order to ba able to
apply anything.  Use whatever you sign legal documents with please.

> ---
>  serial/Kconfig      |  11 ++
>  serial/Makefile     |   1 +
>  serial/sunix_uart.c | 357 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 369 insertions(+)
>  create mode 100644 serial/sunix_uart.c

Why can't you just use the 8250_pci.c driver here instead of a whole
separate one?  What does this hardware need that is so different that
you can not just add to the normal pci_boards[] array in that code?

If you can not do that, then you need to explain in great detail why
that is in the changelog comment in order for us to be able to accept
this code.

thanks,

greg k-h
