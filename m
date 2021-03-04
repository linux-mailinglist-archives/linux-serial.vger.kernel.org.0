Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF6A32C325
	for <lists+linux-serial@lfdr.de>; Thu,  4 Mar 2021 01:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbhCDAAF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 3 Mar 2021 19:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243806AbhCCTUy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Mar 2021 14:20:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5CEC64EDF;
        Wed,  3 Mar 2021 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614799201;
        bh=C7U8ej2WJqieYKc0vbEaH8G40r7cuNpoJwxGOEd0Cvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0JktOmwdpowrN4EsCbrh4rgLsiudmCqaa9k+BXGFFRkq9MkoGtzv2a0mk7r3uSoaw
         qtuCwZ6CnFba0JYYboN8o4xSd8E4u78oquTCknYRIZvVefkxCYEfOA5AjwfwVxtlzd
         mWjUSBt29h6OzsjFe/364VC9ymZ6LUl7h6/flaD0=
Date:   Wed, 3 Mar 2021 20:19:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/44] MAINTAINERS: orphan mxser
Message-ID: <YD/hXtUHE9WKdXcQ@kroah.com>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 02, 2021 at 07:21:31AM +0100, Jiri Slaby wrote:
> I cannot maintain this driver for years due to missing HW. Let's orphan
> the entry in MAINTAINERS. And likely drop the driver later as these
> devices are likely gone from this world. Mxser provides different
> (out-of-tree) drivers for their current devices.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks for the series, and dropping the abandonded drivers.  All now
queued up except for the 2 usb-serial driver cleanups.

thanks,

greg k-h
