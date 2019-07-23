Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1727121A
	for <lists+linux-serial@lfdr.de>; Tue, 23 Jul 2019 08:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfGWGs4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 23 Jul 2019 02:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729552AbfGWGs4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jul 2019 02:48:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CB452238E;
        Tue, 23 Jul 2019 06:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563864535;
        bh=s/HUPcnN3v942I9WohUTWxUEI6Z+I6OJlsdU6knfous=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmLRQfb4jLOX90pPvHjwZM345YWtM6U4JBsgx+ChxME44a7qWYgBwZ3G94hFEToXH
         IT2bnsVAMhrlWrQOkJWVQwsJrv9VqXDjZnZ2MQSQU1X5VwxwoiOMvGdXmjvKy+uhYs
         uiAY7nN56YeysKMMc8I+p/QtMGB7I9Q3xuXGdCKQ=
Date:   Tue, 23 Jul 2019 08:48:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     morrisku <saumah@gmail.com>
Cc:     kai.heng.feng@canonical.com, tiffany.wang@canonical.com,
        morris_ku@sunix.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH] Add driver for SUNIX Serial board.
Message-ID: <20190723064852.GA27629@kroah.com>
References: <20190723030813.4728-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723030813.4728-1-saumah@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 23, 2019 at 11:08:13AM +0800, morrisku wrote:
> >On Fri, Jul 19, 2019 at 06:10:50PM +0800, morrisku wrote:
> >> Add Kconfig and Makefile entry.
> >> 
> >> Signed-off-by: Morris Ku <saumah@gmail.com>
> >> ---
> >>  serial/Kconfig  | 11 +++++++++++
> >>  serial/Makefile |  2 +-
> >>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> >Same report as the 1/2 patch, and your subject is wrong here :(
> 
> I will modify subject line to [PATCH 2/2] tty/serial: Add driver for SUNIX serial board.
> or [PATCH 2/2] tty:serial: Add driver for SUNIX serial board.
> 
> Is that OK?

You can not have the same subject lines for different patches that do
different things.

> This driver patch separate into 2 patches : 
> Do i need to modify subject line to [PATCH 1/2] and [PATCH 2/2] ?

Why do you need two different patches at all when one of them just adds
the Kconfig and Makefile entries?  Why not do it all in one?

thanks,

greg k-h
