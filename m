Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D8B1C6927
	for <lists+linux-serial@lfdr.de>; Wed,  6 May 2020 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgEFGlv (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 6 May 2020 02:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbgEFGlv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 02:41:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3053C206E6;
        Wed,  6 May 2020 06:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588747310;
        bh=sMde20sCLZTVyoVFeFYflyQXlmvS+Vk7+sZmMSvb7Vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uChhstoiXnVKS6HT9i288ygX38FAY+ixJvXA6zPJ5Au7omKOIFzHDuzNsEkbNebNL
         fDEZaP5gJQF2J5ZHiECmjhCVH8lNhJllKaiRRtAHUSB1xGozLBIvGyI0ocrTOqvQhf
         zISbwX3e4kpu6Yw4mbs9BfeYG45KzXXoV5ISHkds=
Date:   Wed, 6 May 2020 08:41:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH] serial: lantiq: Add x86 in Kconfig dependencies for
 Lantiq serial driver
Message-ID: <20200506064148.GA2266968@kroah.com>
References: <96fd193c0a8939d27641ff93573545c02313048f.1588577002.git.rahul.tanwar@linux.intel.com>
 <20200505142504.GA832370@kroah.com>
 <3aa4aac0-a9d2-5ab2-e9c9-c7f3bd16da96@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa4aac0-a9d2-5ab2-e9c9-c7f3bd16da96@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 06, 2020 at 12:49:57PM +0800, Tanwar, Rahul wrote:
> 
> On 5/5/2020 10:25 pm, Greg KH wrote:
> > On Mon, May 04, 2020 at 04:03:52PM +0800, Rahul Tanwar wrote:
> >> Lantiq serial driver/IP is reused for a x86 based SoC as well.
> >> Update the Kconfig accordingly.
> >>
> >> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> >> ---
> >>  drivers/tty/serial/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> >> index 0aea76cd67ff..4b0a7b98f8c7 100644
> >> --- a/drivers/tty/serial/Kconfig
> >> +++ b/drivers/tty/serial/Kconfig
> >> @@ -1035,7 +1035,7 @@ config SERIAL_SIFIVE_CONSOLE
> >>  
> >>  config SERIAL_LANTIQ
> >>  	bool "Lantiq serial driver"
> >> -	depends on LANTIQ
> >> +	depends on (LANTIQ || X86) || COMPILE_TEST
> >>  	select SERIAL_CORE
> >>  	select SERIAL_CORE_CONSOLE
> >>  	select SERIAL_EARLYCON
> >> -- 
> >> 2.11.0
> >>
> > Any reason this can't also be a module?
> 
> Thanks a lot for accepting the patch. This driver is also used for
> console during bootup so we always have it as built in.

So no generic kernel images can ever be made for this driver?  That's
not good, what about systems that have this serial port but does not
care about the console?

That's just ensuring that it will not be built into any distro kernel
images, I suggest fixing this up please.

thanks,

greg k-h
