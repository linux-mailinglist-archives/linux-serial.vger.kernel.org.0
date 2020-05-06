Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325181C6F9D
	for <lists+linux-serial@lfdr.de>; Wed,  6 May 2020 13:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEFLqR (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 6 May 2020 07:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgEFLqP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 07:46:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EA17206D5;
        Wed,  6 May 2020 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588765574;
        bh=nMpVxHTQ1110Y/a2PQ4LV7iUJ4I+82nYm2QntxAeR0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=utap/Qy+zVICkyNxJ/zrD0hp/wpkLjoL3XAzrrJgtK5aFwdAkwHXIOF5XfHDLfsBo
         A+grfxHi0v9nVgJ/X3mUlyy0qT7kOBJpAAzpmhODDYPPVbaiMTp+pUQHhyjcpm5bel
         xGPlMsXYHzWK7/OCholjJGrzreM8HPOS1P5vbaho=
Date:   Wed, 6 May 2020 13:46:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
Subject: Re: [PATCH] serial: msm_geni_serial_console : Add Earlycon support
Message-ID: <20200506114612.GA3024358@kroah.com>
References: <20200429171934.17376-1-msavaliy@codeaurora.org>
 <20200429173826.GB2332435@kroah.com>
 <9dd11375-7f6e-8e3d-6243-89089a938f01@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dd11375-7f6e-8e3d-6243-89089a938f01@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 06, 2020 at 05:01:52PM +0530, Mukesh, Savaliya wrote:
> 
> On 4/29/2020 11:08 PM, Greg KH wrote:
> > On Wed, Apr 29, 2020 at 10:49:34PM +0530, Mukesh, Savaliya wrote:
> > > From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> > > 
> > > This change enables earlyconsole support as static driver for geni
> > > based UART. Kernel space UART console driver will be generic for
> > > console and other usecases of UART.
> > > 
> > > Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> > > ---
> > >   drivers/tty/serial/Kconfig                   |  15 +
> > >   drivers/tty/serial/Makefile                  |   1 +
> > >   drivers/tty/serial/msm_geni_serial_console.c | 525 +++++++++++++++++++
> > >   3 files changed, 541 insertions(+)
> > >   create mode 100644 drivers/tty/serial/msm_geni_serial_console.c
> > > 
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index 0aea76cd67ff..ded19d80e696 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -956,6 +956,21 @@ config SERIAL_MSM_CONSOLE
> > >   	select SERIAL_CORE_CONSOLE
> > >   	select SERIAL_EARLYCON
> > > +config SERIAL_MSM_GENI_HALF_SAMPLING
> > > +	bool "Changes clock divider which impacts sampling rate for QUP HW ver greater than 2.5.0"
> > > +	help
> > > +	  Clock divider value should be doubled for QUP hardware version
> > > +	  greater than 2.5.0.
> > How do we know this?  Can't this be dynamically determined at runtime?
> > What about kernels that want to be built for both types of hardware at
> > the same time?
> 
> This will vary for different hardware only if QUP version is lower than
> this.
> 
> We can not determine this dynamically because register address space to read
> QUP version is in QUP wrapper space and that also keep varying per target.
> 
> we only  get internal SE address base in cmdline arg.

I don't understand.  So does this mean we can not build a single kernel
image with support for both?

Why can't you detect "version 2.5.0 or greater" at runtime?  How do you
know this at kernel build time and not at runtime?

We can't add options that prevent generic versions of the kernel from
being able to be built, as that means you just broke kernels that did
work, right?



> 
> > 
> > > +	  As earlycon can't have HW version awareness, decision is taken
> > > +	  based on the configuration.
> > > +
> > > +config SERIAL_MSM_GENI_EARLY_CONSOLE
> > > +	bool "MSM on-chip GENI HW based early console support"
> > > +	select SERIAL_MSM_GENI_HALF_SAMPLING
> > > +	help
> > > +	  Serial early console driver for Qualcomm Technologies Inc's GENI
> > > +	  based QUP hardware.
> > Why can't we have early console without SERIAL_MSM_GENI_HALF_SAMPLING?
> > 
> > Why are these tied directly to each other?  Do you really need 2
> > options?
> HALF_SAMPLING controlls the sampling rate of UART HW, if not then logs come
> garbled due to wrong sampling.

I do not understand what you mean here.  Again, why can this not be
detected at runtime?

Can you split this into two patches, one for the console driver, and one
for the crazy new hardware for newer systems?

thanks,

greg k-h
