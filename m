Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290371DC8EE
	for <lists+linux-serial@lfdr.de>; Thu, 21 May 2020 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgEUInQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 21 May 2020 04:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgEUInQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 May 2020 04:43:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB6620721;
        Thu, 21 May 2020 08:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590050595;
        bh=FUzPuUkK7yJPPxDEeG7AeR2q5U1ot/3gTtCpIrQAv30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ygwCOlZ50OWnr9Uo9EkfcrRvf1xQyXzxyFqvMfQF6XwHKxAM5dRPB5leWSkw45rAP
         fBrflVvhCBy/vLhaQtR8iuZ6JLusYjJI7YDtXDOVBmmLzhFXqLIL0Blk0PJAMXf4cd
         MZQ3yQDadDqnu4QtRsmKwdD37hsnh53h7Cp9yFj4=
Date:   Thu, 21 May 2020 10:43:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, jslaby@suse.com, jringle@gridpoint.com,
        m.brock@vanmierlo.com, pascal.huerst@gmail.com
Subject: Re: [PATCH v2 2/6] sc16is7xx: Add flag to activate IrDA mode
Message-ID: <20200521084313.GA2701989@kroah.com>
References: <20200519182147.218713-1-daniel@zonque.org>
 <20200519182147.218713-3-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519182147.218713-3-daniel@zonque.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 19, 2020 at 08:21:43PM +0200, Daniel Mack wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
> 
> This series of uart controllers is able to work in IrDA mode.
> Add per-port flag to the device-tree to enable that feature if needed.
> 
> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
> ---

If you send on a patch from someone else, you too need to sign-off on
it, so that I could take it.  Please fix this up for all of the patches
that need it in this series and resend.

thanks,

greg k-h
