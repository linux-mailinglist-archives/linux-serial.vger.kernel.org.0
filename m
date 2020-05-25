Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9631E1019
	for <lists+linux-serial@lfdr.de>; Mon, 25 May 2020 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390821AbgEYOHz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 25 May 2020 10:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388862AbgEYOHz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 10:07:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EE81207C3;
        Mon, 25 May 2020 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590415674;
        bh=iZZ5IQp9+eYVXY4bJha3aZNm4GdnqzFhOmEi5n/DfFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUH8jjgdRQMd3cdWzc4CONrc9bsCuSWrtlh1h2/TtjGJPgdCZDxxUAdopDj8SR2Z2
         7dQSbqM+DP39z7ASt81Ju64wQXM36qgnJ3pbz3iVfK8yy3KrFSU+1c+gJbg1KhJP7h
         2WUcMWtECuYchDejmh98xwYgSrj5pLz0AC45GmHg=
Date:   Mon, 25 May 2020 16:07:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-serial@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1] serial: imx: Initialize lock for non-registered
 console
Message-ID: <20200525140752.GA910887@kroah.com>
References: <20200525105952.13744-1-andriy.shevchenko@linux.intel.com>
 <c5b1caca-32fc-1482-b4f5-71787b73a814@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b1caca-32fc-1482-b4f5-71787b73a814@roeck-us.net>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 25, 2020 at 07:01:13AM -0700, Guenter Roeck wrote:
> On 5/25/20 3:59 AM, Andy Shevchenko wrote:
> > The commit a3cb39d258ef
> > ("serial: core: Allow detach and attach serial device for console")
> > changed a bit logic behind lock initialization since for most of the console
> > driver it's supposed to have lock already initialized even if console is not
> > enabled. However, it's not the case for Freescale IMX console.
> > 
> > Initialize lock explicitly in the ->probe().
> > 
> > Note, there is still an open question should or shouldn't not this driver
> > register console properly.
> > 
> > Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I really wonder if this is the correct fix, especially since it looks like
> there are several other drivers which don't call register_console() either
> but implement a console device.
> 
> Guenter
> 
> > ---
> >  drivers/tty/serial/imx.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 986d902fb7fe..6b078e395931 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -2404,6 +2404,9 @@ static int imx_uart_probe(struct platform_device *pdev)
> >  		}
> >  	}
> >  
> > +	/* We need to initialize lock even for non-registered console */
> > +	spin_lock_init(&sport->port.lock);

Why are we having to do this for all console drivers recently?
Shouldn't the original patch that required this gone through and fixed
up all drivers?

I'm with Guenter here, let's fix them all at once please.

thanks,

greg k-h
