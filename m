Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAD480666
	for <lists+linux-serial@lfdr.de>; Sat,  3 Aug 2019 15:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfHCNzl (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 3 Aug 2019 09:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfHCNzk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 3 Aug 2019 09:55:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3EBA2166E;
        Sat,  3 Aug 2019 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564840540;
        bh=4UmoDoYVdrWFjZ2tni2H5YosvR67LNdT3rchHwiQHEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DSjAwHm8J2w5ILHJh27mU4VqH+sajLtPJ20zxB9s76nP2Ha6J94z3zv0xJS/WtJ5J
         kukH2u6JKnBx0MhQQg+ExnlhH0JgM6jJ4GXbhbqPWgiZEMNQ0M/5LSBldpxxI3YqZa
         EhReTiKjhnDzuG+ZTDUzuJMRzBads4uKtCNU4YGc=
Date:   Sat, 3 Aug 2019 15:55:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: Device to write to all (serial) consoles
Message-ID: <20190803135537.GA1743@kroah.com>
References: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
 <20190802160243.GA15484@kroah.com>
 <cab1fe06-0dc7-e7c1-50ac-cc01773c5ef5@molgen.mpg.de>
 <20190803132323.GB6703@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803132323.GB6703@angband.pl>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Aug 03, 2019 at 03:23:23PM +0200, Adam Borowski wrote:
> On Fri, Aug 02, 2019 at 09:59:06PM +0200, Paul Menzel wrote:
> > On 02.08.19 18:02, Greg Kroah-Hartman wrote:
> > > On Fri, Aug 02, 2019 at 03:23:08PM +0200, Paul Menzel wrote:
> > > > On a lot of devices, like servers, you have more than one serial console,
> > > > and you do not always know, how they are numbered. Therefore, we start a
> > > > console on ttyS0 and ttyS1.
> > 
> > Because the cable is always connected to the port on the back side, and
> > sometimes the port in the front has ID 0, and the one in the back 1, and
> > other times vice versa. We do not want to track that, and it would be
> > convenient to just write to both ports.
> 
> Sounds like an XY problem then: what you want is not writing to all ports,
> but to have the port assignments stable (see also: disk device reordering).

You can get that information from the symlinks in /dev/serial/ which
udev creates.

