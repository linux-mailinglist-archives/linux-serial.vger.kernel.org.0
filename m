Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB91E475
	for <lists+linux-serial@lfdr.de>; Mon, 29 Apr 2019 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfD2OQN (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 29 Apr 2019 10:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfD2OQN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Apr 2019 10:16:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7240120652;
        Mon, 29 Apr 2019 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556547372;
        bh=Jy7wW9SesxQRIddpm99IMDL532x4my772dExgLMy5qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOMEMPNwHDwC2hSrHJwhydy+M/+BzvChosToN9/9HjkBMMGG4Za5clpmaJsmyIb1w
         gHGdQb4RbqdW5Q9yIDqRczOWXz/qmjpjyfbuZUDegcKAy5I04FjnFLDVGm6RHoJhHw
         eGNA0w9wQOc6+lWReZxsOLvDmhVOEzs1T8v3Atrc=
Date:   Mon, 29 Apr 2019 16:16:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fatih =?utf-8?B?QcWfxLFjxLE=?= <fatih.asici@procenne.com>
Cc:     Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        fatih.asici@gmail.com
Subject: Re: [PATCH] serdev: add method to set stop bits
Message-ID: <20190429141610.GA12903@kroah.com>
References: <20190412064737.30424-1-fatih.asici@procenne.com>
 <CAL_JsqLgURV2uHMG-q904Z+hWsP0qskPKCf4MQQBOGTGUjqfcw@mail.gmail.com>
 <5406741.ymGCjNrDGl@fatih-x542urr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5406741.ymGCjNrDGl@fatih-x542urr>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 29, 2019 at 09:27:26AM +0300, Fatih Aşıcı wrote:
> On 26 Nisan 2019 Cuma 17:00:02 +03 Rob Herring wrote:
> > On Fri, Apr 12, 2019 at 1:55 AM Fatih Aşıcı <fatih.asici@procenne.com> 
> wrote:
> > > Adds serdev_device_set_stop_bits() which takes an int argument with
> > > a value of 1 or 2.
> > 
> > Do you have a user? We normally like to have one before adding
> > functions to the kernel.
> 
> We are developing a smartcard interface [1] driver for use in our embedded 
> project. The driver is not suitable for general use.

Why not?  Who's to say what others will find useful?  You have to
publish the changes somewhere, might as well be upstream so you do not
have to drag it around for the next 10+ years :)

Please submit it, we do not add new apis with no in-kernel users.

thanks,

greg k-h
