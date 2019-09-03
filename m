Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B39A68CB
	for <lists+linux-serial@lfdr.de>; Tue,  3 Sep 2019 14:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfICMoD (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 3 Sep 2019 08:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfICMoD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Sep 2019 08:44:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115CF20674;
        Tue,  3 Sep 2019 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567514642;
        bh=uHpU2fS3ncY7HIiEqEC8A5jkzGaNvGl/C7uzvwCT+Bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dL8vbkptV30A1Vhn4pCTfziMiH6Oa6xptvU8mjRh2NwJDj+8qxiwpoUFCvlKsQg5B
         r+0emvehTNx1OPJoyg4P6MN8iLtqCDEzZyTuLY2R+XM0meRBOG5NNJLBsp1N+nG5QU
         Owxw7MZk12r0RCiJDmrTmdF75JrQuDzazAB1Qa2s=
Date:   Tue, 3 Sep 2019 14:43:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Temp Sha <temp.sha@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: tty_ldisc_lock hangs at reboot
Message-ID: <20190903124359.GA493@kroah.com>
References: <CANe=CUka=VPOQSyvu5pS8oe9hV3acjdp7OZXVB=TZMCyKeQy5g@mail.gmail.com>
 <20190903111358.GA28823@kroah.com>
 <CANe=CUmJXkJVAoe7rtmUirya71zjJ=G-JPkkUPBU4aJzbNo8MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANe=CUmJXkJVAoe7rtmUirya71zjJ=G-JPkkUPBU4aJzbNo8MQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Sep 03, 2019 at 05:08:37PM +0530, Temp Sha wrote:
> Can it be anything with busybox implementation of reboot command? I am
> using similar other customized linux device with same kernel but some
> changes in busybox (not sure what) where reboot is working perfectly
> fine.
> I just need to know how can I proceed in this case to fix? Upgrading
> kernel version will not be possible for me.

You are using a very old and obsolete and known insecure kernel version.
If you can not update it to the latest 4.14.y release then you have much
worse problems then just dealing with a reboot issue, as well as the
basic issue of if this was a kernel issue, you would not be able to fix
it.

I don't know what to suggest here, it sounds like there is nothing we
can do to help out, sorry.

good luck!

greg k-h
