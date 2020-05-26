Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA511DE299
	for <lists+linux-serial@lfdr.de>; Fri, 22 May 2020 11:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgEVJH7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 22 May 2020 05:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbgEVJH6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 May 2020 05:07:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDB3A20812;
        Fri, 22 May 2020 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590138477;
        bh=OdSUmSl2dQed18lAXpKNsGTVU8XUgZFxwZQxHSs2Axc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPi3etuBsAuJ1RwJFRXqXIiAEk2TyNw9JIBdKkgQMB+1Kf+WX+Sa173Ca/X7JSsp+
         9IzlAgFHj+6z2eCQSx++kmiaNoUd1FMl3MiGmiM9pK2kvvBnt5gp6GOaojYLvdUOIG
         HHn+u+HGzTJVQnkYcKDl8Duyqs1490BC7eMpuSUY=
Date:   Fri, 22 May 2020 11:07:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, jslaby@suse.com, jringle@gridpoint.com,
        m.brock@vanmierlo.com, pascal.huerst@gmail.com
Subject: Re: [PATCH v3 0/6] sc16is7xx: IrDA mode and threaded IRQs
Message-ID: <20200522090755.GA1189521@kroah.com>
References: <20200521091152.404404-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521091152.404404-1-daniel@zonque.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 21, 2020 at 11:11:46AM +0200, Daniel Mack wrote:
> This is v3 of the series.
> 
> v3:
> 
>  * Add my s-o-b to the first two patches
> 
> v2:
> 
>  * Change single bool properties into an array
>    (suggested by Rob Herring)
>  * Add a patch first try TRIGGER_LOW and SHARED interrupts, and then
>    fall back to FALLING edge if the IRQ controller fails to provide the
>    former (suggested by Maarten Brock)
>  * Add a patch to check for the device presence
> 
> Daniel Mack (4):
>   sc16is7xx: Always use falling edge IRQ
>   sc16is7xx: Use threaded IRQ
>   sc16is7xx: Allow sharing the IRQ line
>   sc16is7xx: Read the LSR register for basic device presence check
> 
> Pascal Huerst (2):
>   dt-bindings: sc16is7xx: Add flag to activate IrDA mode
>   sc16is7xx: Add flag to activate IrDA mode

As I have to wait for the DT addition to be reviewed before applying the
first 2 patches here, I've taken the other 4 instead at the moment.  If
you could rebase the first two and resend when they get acked, so that I
could apply them, that would be great.

thanks,

greg k-h
