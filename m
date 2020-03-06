Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599C517BD51
	for <lists+linux-serial@lfdr.de>; Fri,  6 Mar 2020 13:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFMze (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 6 Mar 2020 07:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgCFMzd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 07:55:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DDE21D56;
        Fri,  6 Mar 2020 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583499333;
        bh=FmCdFdk2V7prBX0NrmUPWjmsaN5MxL6GKpLAY5HtaZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yVs7toEV5u1l4nLoBtRPTGXT5IYT5Npy+TjDB4q3uIsfcvcTtpZAe2ILpbZwlwlXR
         wP2NxHG9xOEOYfDps+57wzPf/YXmJgew91r2CSppuL2iJw/ZNpUd1lYwHPWHYCYuLR
         78ECp/RhjiH0y3Lqe/XzfnCsNGHUMhF+jJn20bWo=
Date:   Fri, 6 Mar 2020 13:55:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCHv3 2/2] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Message-ID: <20200306125531.GA3754466@kroah.com>
References: <20200302175135.269397-1-dima@arista.com>
 <20200302175135.269397-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302175135.269397-3-dima@arista.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 02, 2020 at 05:51:35PM +0000, Dmitry Safonov wrote:
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 69def4a9df00..38a8f3c99579 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -431,6 +431,14 @@ config MAGIC_SYSRQ_SERIAL
>  	  This option allows you to decide whether you want to enable the
>  	  magic SysRq key.
>  
> +config MAGIC_SYSRQ_SERIAL_SEQUENCE
> +	string "Char sequence that enables magic SysRq over serial"
> +	depends on MAGIC_SYSRQ_SERIAL
> +	default ""
> +	help
> +	  Specifies a sequence of characters that can follow BREAK to enable
> +	  SysRq on a serial console.


Can you send a follow-on patch that adds some more text here.  Something
like :
	If you do not know what to do, just select an empty string and
	the option will not be enabled.

or something like that to make it more obvious what almost everyone will
want to do here.

thanks,

greg k-h
