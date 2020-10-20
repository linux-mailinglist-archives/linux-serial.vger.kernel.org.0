Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C163294224
	for <lists+linux-serial@lfdr.de>; Tue, 20 Oct 2020 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390344AbgJTScG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 20 Oct 2020 14:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390270AbgJTScG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Oct 2020 14:32:06 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA27B21534;
        Tue, 20 Oct 2020 18:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603218725;
        bh=rYkBj1ZJWTczz5/r0ofs7bNB91o9zGiASSEmBN2me+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYdQL3WqM7p6HeQ0EeMAIo5Q2YOfnLuT4iVy5ZEoFobMfwLlGD4IAPVmgw+BUTYAb
         EqhiJi5sA+fXVSNRzB+d6NDWeOqxt4Y137jjticPgIoqKRJ55sa6oAYaWiKzjhDLiV
         tkHoaxu4fBh4Yu4mpzIN7rlSt59KQPCq8o4o/hCw=
Date:   Tue, 20 Oct 2020 20:32:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org, Joshua Thompson <funaho@jurai.org>,
        linux-serial@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] serial: pmac_zilog: don't init if zilog is not available
Message-ID: <20201020183246.GA912431@kroah.com>
References: <20201020162303.1730562-1-laurent@vivier.eu>
 <20201020162844.GA865546@kroah.com>
 <468bbbef-4745-3b16-b6f4-30b46ebcdc33@vivier.eu>
 <20201020173745.GA882703@kroah.com>
 <387fd2aa-b181-c41f-0581-0a7e79a44e41@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <387fd2aa-b181-c41f-0581-0a7e79a44e41@vivier.eu>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 20, 2020 at 08:19:26PM +0200, Laurent Vivier wrote:
> Le 20/10/2020 � 19:37, Greg KH a �crit�:
> > On Tue, Oct 20, 2020 at 06:37:41PM +0200, Laurent Vivier wrote:
> >> Le 20/10/2020 � 18:28, Greg KH a �crit�:
> >>> On Tue, Oct 20, 2020 at 06:23:03PM +0200, Laurent Vivier wrote:
> >>>> We can avoid to probe for the Zilog device (and generate ugly kernel warning)
> >>>> if kernel is built for Mac but not on a Mac.
> >>>>
> >>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> >>>> ---
> >>>>  drivers/tty/serial/pmac_zilog.c | 11 +++++++++++
> >>>>  1 file changed, 11 insertions(+)
> >>>>
> >>>> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> >>>> index 063484b22523..d1d2e55983c3 100644
> >>>> --- a/drivers/tty/serial/pmac_zilog.c
> >>>> +++ b/drivers/tty/serial/pmac_zilog.c
> >>>> @@ -1867,6 +1867,12 @@ static struct platform_driver pmz_driver = {
> >>>>  static int __init init_pmz(void)
> >>>>  {
> >>>>  	int rc, i;
> >>>> +
> >>>> +#ifdef CONFIG_MAC
> >>>> +	if (!MACH_IS_MAC)
> >>>> +		return -ENODEV;
> >>>> +#endif
> >>>
> >>> Why is the #ifdef needed?
> >>>
> >>> We don't like putting #ifdef in .c files for good reasons.  Can you make
> >>> the api check for this work with and without that #ifdef needed?
> >>
> >> The #ifdef is needed because this file can be compiled for PowerMac and
> >> m68k Mac. For PowerMac, the MACH_IS_MAC is not defined, so we need the
> >> #ifdef.
> >>
> >> We need the MAC_IS_MAC because the same kernel can be used with several
> >> m68k machines, so the init_pmz can be called on a m68k machine without
> >> the zilog device (it's a multi-targets kernel).
> >>
> >> You can check it's the good way to do by looking inside:
> >>
> >>     drivers/video/fbdev/valkyriefb.c +317
> >>     drivers/macintosh/adb.c +316
> >>
> >> That are two files used by both, mac and pmac.
> > 
> > Why not fix it to work properly like other arch checks are done
> I would be happy to do the same.
> 
> > Put it in a .h file and do the #ifdef there.  Why is this "special"?
> 
> I don't know.
> 
> Do you mean something like:
> 
> drivers/tty/serial/pmac_zilog.h
> ...
> #ifndef MACH_IS_MAC
> #define MACH_IS_MAC (0)
> #endif
> ...
> 
> drivers/tty/serial/pmac_zilog.c
> ...
> static int __init pmz_console_init(void)
> {
>         if (!MACH_IS_MAC)
>                 return -ENODEV;
> ...

Yup, that would be a good start, but why is the pmac_zilog.h file
responsible for this?  Shouldn't this be in some arch-specific file
somewhere?

thanks,

greg k-h
