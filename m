Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCC0118EFEE
	for <lists+linux-serial@lfdr.de>; Mon, 23 Mar 2020 07:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCWGwO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 23 Mar 2020 02:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCWGwO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 02:52:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7C3A20736;
        Mon, 23 Mar 2020 06:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584946334;
        bh=+001deXbZhh2RCXvUG1nEQSIGMUifaT/phPTZNcsOUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhAqPWOZkKSC7pq5bMPSiXB+sj6h/Yhy27BPoA11jl6cvwJ0+6xsnBF5FUVTxNCl+
         /jgxWtXFvHRfUdJioAljtXUgUCeLV3VWIqq+DF0/gBgf+ShHleOx5UGRZ5JcqLpo7H
         kSW9ASQLVrWQV6OhNWyXyxSqbAN0ahzKwihmvOX4=
Date:   Mon, 23 Mar 2020 07:52:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ryan Lovelett <ryan@lovelett.me>
Cc:     linux-serial@vger.kernel.org
Subject: Re: FT232H user space GPIO device
Message-ID: <20200323065211.GD129571@kroah.com>
References: <6267385dcb44b73f3b5b38070da602bbdb56d545.camel@lovelett.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6267385dcb44b73f3b5b38070da602bbdb56d545.camel@lovelett.me>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Mar 22, 2020 at 03:40:33PM -0400, Ryan Lovelett wrote:
> I have been trying to find a way to get my Adafruit FT232H breakout
> board [1] to appear as a user space GPIO device so I can use it with
> libgpiod. As far as I can tell from reading table 3.5 from the
> datasheet [2] ACBUS5, ACBUS6, ACBUS8 and ACBUS9 should all be usable
> for this.
> 
> I found a patch that was submitted by Karoly Pados in 2018 [3] that
> seemes to add support for that (though maybe only for a specific chip).
> 
> Through a little bit of ftrace and printk I realized that the switch
> statement in ftdi_gpio_init was falling through to the default case for
> the FT232H [4].

So it sounds like you have the wrong device type.  Can you make sure you
use the latest kernel release (5.5) and if you have problems with this,
email the linux-usb mailing list as the driver maintainers for that
driver are there.

thanks,

greg k-h
