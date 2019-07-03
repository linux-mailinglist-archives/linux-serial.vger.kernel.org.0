Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B57195E848
	for <lists+linux-serial@lfdr.de>; Wed,  3 Jul 2019 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfGCP7o (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 3 Jul 2019 11:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGCP7o (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Jul 2019 11:59:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806DA2189E;
        Wed,  3 Jul 2019 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562169584;
        bh=g4YfMS0at5H5fxKFbuWjLjLz//Y1pZ+NOQaMeDBxGco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJJ+JfPCn064vt74jHWmcQrdy4Itbn8W/Zxl3CWXcGHsvHz+FQkwR58FkbBIYBcsX
         QQSpEZ5ILwOSJwm4dAepvuNnbwg4udN3eNe6hvHBgyroXkaERV8bw93gF/Ls8c0qFr
         A9TZ+7xqUqwwSKlViUJXJLeU5OFWXiHMDOKdUdks=
Date:   Wed, 3 Jul 2019 17:59:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     jeyentam <je.yen.tam@ni.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Message-ID: <20190703155941.GB19567@kroah.com>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <63697b10-98a7-86b7-2513-3eb793ed03c5@metux.net>
 <20190703144744.GB24961@kroah.com>
 <d6910b29-3ba6-4a3b-04e2-bc7c3c012554@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6910b29-3ba6-4a3b-04e2-bc7c3c012554@metux.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 03, 2019 at 05:41:25PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 03.07.19 16:47, Greg KH wrote:
> > On Wed, Jul 03, 2019 at 03:27:11PM +0200, Enrico Weigelt, metux IT consult wrote:
> >>>  /* UART Port Control Register */> -#define NI8430_PORTCON	0x0f> -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
> >> Can we have that renaming as a separate patch, to ease review ?
> >>
> >> And what about introducing a config sym for the new device specific
> >> stuff ? These devices seem to be pretty rare - never seen them in
> >> embeded world, where we do need to care of kernel size.
> > 
> > No, that's not the way this driver works, sorry.
> 
> That's sad, because in embedded world we often have to care about
> code size, so making those devices optional would be of great help.

Really?  are you sure?  Try it and see what you really end up saving.

greg k-h
