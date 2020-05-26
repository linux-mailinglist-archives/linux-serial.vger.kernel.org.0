Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8781C595F
	for <lists+linux-serial@lfdr.de>; Tue,  5 May 2020 16:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgEEOZH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 5 May 2020 10:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgEEOZG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 May 2020 10:25:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18EFC206B9;
        Tue,  5 May 2020 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588688706;
        bh=K0bIucW1nhsO/NsokpCDnFKIwn428xqF3PCKp10lWG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCNVpVKs7B9iJ4XdJ4WAO52eI5W+BZfYmUu/nyABcJi9oBgQWoI1sj/7QYISeMxXQ
         MrEl+1yvHOdGETqKKHwV8F+mtpn81J5uR2SxanS7d2wXE8kWXu0IXfT5oS+ZJspPFT
         OE0QoRePheXpWqd66axcJh4WDHoczOdcIk6bGbHc=
Date:   Tue, 5 May 2020 16:25:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH] serial: lantiq: Add x86 in Kconfig dependencies for
 Lantiq serial driver
Message-ID: <20200505142504.GA832370@kroah.com>
References: <96fd193c0a8939d27641ff93573545c02313048f.1588577002.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96fd193c0a8939d27641ff93573545c02313048f.1588577002.git.rahul.tanwar@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 04, 2020 at 04:03:52PM +0800, Rahul Tanwar wrote:
> Lantiq serial driver/IP is reused for a x86 based SoC as well.
> Update the Kconfig accordingly.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 0aea76cd67ff..4b0a7b98f8c7 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1035,7 +1035,7 @@ config SERIAL_SIFIVE_CONSOLE
>  
>  config SERIAL_LANTIQ
>  	bool "Lantiq serial driver"
> -	depends on LANTIQ
> +	depends on (LANTIQ || X86) || COMPILE_TEST
>  	select SERIAL_CORE
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
> -- 
> 2.11.0
> 

Any reason this can't also be a module?

thanks,

greg k-h
