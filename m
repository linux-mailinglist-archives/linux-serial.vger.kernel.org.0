Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3652C8AFA4
	for <lists+linux-serial@lfdr.de>; Tue, 13 Aug 2019 08:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfHMGMd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 13 Aug 2019 02:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfHMGMc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Aug 2019 02:12:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC29F20578;
        Tue, 13 Aug 2019 06:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565676751;
        bh=/kbzKCVdF8E3NqOCCP0htEJ8jCfrIzVHyivdMvBxvmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewe0rDIidQfm/k0kUS7CSsSV8o7j4yMDGNjgP2k5B5AeMGbDkaj65jxLRrImt+s7K
         D1j5vhbylkyhVr5gZVr+CgVw01TBjtxrJdJS9w02J8XAbga8uxk5oJyzgkER6uo9pg
         3kbPYKxp1OGOs9TSQXRgeTmQK5G9wdxuK2eF7nm8=
Date:   Tue, 13 Aug 2019 08:12:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Morris Ku <morris_ku@sunix.com>,
        Debbie Liu <debbie_liu@sunix.com>
Subject: Re: [PATCH v2 1/2] serial: 8250_pci: Add support for Sunix serial
 boards
Message-ID: <20190813061228.GH6670@kroah.com>
References: <20190809190130.30773-1-kai.heng.feng@canonical.com>
 <CAHp75VeGs8K+da+4CaqNjm_ci86KoLcmhY8GaJO7jm__J0TcSQ@mail.gmail.com>
 <93860D98-9CB7-4D3D-8917-E15591BD1EC4@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93860D98-9CB7-4D3D-8917-E15591BD1EC4@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 13, 2019 at 12:36:40PM +0800, Kai-Heng Feng wrote:
> Hi Andy,
> 
> at 21:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Fri, Aug 9, 2019 at 10:05 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > > Add support to Sunix serial boards with up to 16 ports.
> > > 
> > > Sunix board need its own setup callback instead of using Timedia's, to
> > > properly support more than 4 ports.
> > 
> > Can you, please, split out the Sunix quirk driver to a separate module
> > (see examples like: 8250_exar, 8250_lpss, 8250_mid)?
> > And then with a fewer LOCs add a new boards.
> 
> Greg asked Sunix to use existing 8250_pci.c instead of its own module.
> It only needs a special setup function, other parts are just 8250_pci.

Agreed.  And this patch is already in my tree :)

If people really worry about size issues, start carving this up by
different configuration options, or yes, split it up into tiny modules
(but note the overhead there when things get too tiny, it's a
diminishing return).

> Why does split them a better idea? I even think of squashing 8250_moxa into
> 8250_pci.

I would agree with you, I bet you save space if you do that.

thanks,

greg k-h
