Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD128F5A9
	for <lists+linux-serial@lfdr.de>; Thu, 15 Aug 2019 22:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfHOUVH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 15 Aug 2019 16:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfHOUVG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Aug 2019 16:21:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 871942173E;
        Thu, 15 Aug 2019 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565900466;
        bh=jW7EYXfpCbT3xXHAaacwb6N4hObQOLnuGBCEq8QylRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wO63QM9HopWiHOZkAY5HbNKjsY5fmZgcv6bNbTDcarAn678R1FsWjJ9FFYKX1brzo
         6p/JNq+25vKYttSXHg7OW9lDhl716xOsOC9Y6NeEZ+HIZ8Q1PripI2kOtq0U7WbFbW
         RTe0rhHy/TwUxrferWIhhfOpYxTPk91yIPh0tMog=
Date:   Thu, 15 Aug 2019 22:21:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-serial@vger.kernel.org
Subject: Re: [tty:tty-testing 84/90] drivers/tty/serial/lpc32xx_hs.c:447:14:
 sparse: sparse: incompatible types for 'case' statement
Message-ID: <20190815202103.GA4488@kroah.com>
References: <201908160045.ql5LACNr%lkp@intel.com>
 <20190815193157.GE30437@kroah.com>
 <CAK8P3a3mi9wmWmDiwo52oOOeFhCnbnLppEGK5vcwbOpyv_wZ=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3mi9wmWmDiwo52oOOeFhCnbnLppEGK5vcwbOpyv_wZ=w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 15, 2019 at 09:42:45PM +0200, Arnd Bergmann wrote:
> On Thu, Aug 15, 2019 at 9:32 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 16, 2019 at 12:21:48AM +0800, kbuild test robot wrote:
> > > Hi Arnd,
> > >
> > > First bad commit (maybe != root cause):
> > >
> > > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> > > head:   92770c07234fb9e097ceb512e4bb29aca750075c
> > > commit: 5dce8eccb54355ea42918b651f1085e54b2c5f2f [84/90] serial: lpc32xx_hs: allow compile-testing
> > > reproduce:
> > >         # apt-get install sparse
> > >         # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
> > >         git checkout 5dce8eccb54355ea42918b651f1085e54b2c5f2f
> > >         make ARCH=x86_64 allmodconfig
> > >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > Given that there are at least 3 issues with this patch, I'll go drop it
> > from my tty-testing branch now :(
> 
> Sorry about that. In version 1 of the lpc32xx series I had explained that
> they would have to get merged in sequence because of the dependencies.
> 
> I've applied all 13 to the arm/soc branch now after Sylvain confirmed
> that he considers the series ready.

No problem, glad to see this get merged.

thanks,

greg k-h
