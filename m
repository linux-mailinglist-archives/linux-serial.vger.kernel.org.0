Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D013D5DF
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391677AbfFKSwz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 14:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389470AbfFKSwz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 14:52:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C934206E0;
        Tue, 11 Jun 2019 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279174;
        bh=brtqsLjk7CxqDVhYGPESyZ8udsnF+g+tbhCDITsVKzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=haKvwamGODfZKEvGpsHeEbCgMHZgQ0yi0E1Pf+LF7qQMwW46gRBldTQejhyyDxUx0
         A7AvKuoCjyC4lqiI0Nm9wWAL7I/H51cYDoQ9wJYiJE/Mv0Jy7NiAFu1oE3SE/N1Psm
         wk/dLT5BsbOJbSx2L8H65StfayAgyDCEl8OqN2Ys=
Date:   Tue, 11 Jun 2019 20:52:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     linux-serial@vger.kernel.org
Subject: Re: RFC: can we get rid of ->request_port() boilerplate ?
Message-ID: <20190611185252.GA3951@kroah.com>
References: <999dbc29-8254-7168-1fa0-7caf03bb6d77@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <999dbc29-8254-7168-1fa0-7caf03bb6d77@metux.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 11, 2019 at 08:04:08PM +0200, Enrico Weigelt, metux IT consult wrote:
> Hi folks,
> 
> 
> we've got lots of cases, where ->request_port() / ->release_port()
> are just (request|release)_mem_region calls, where the parameter
> values are practicall known after the device is initialized (*1).
> The only preparation needed for that is changing the individual
> drivers to initialize mapsize field on probing (*2).
> 
> I see two practical options for that:
> 
> a) introduce generic helpers, which are assigned as driver callbacks
>    instead of the currently used driver specific ones.
> 
> b) introduce a flag which tells the serial core to do that.
> 
> 
> What's your oppinion on that ?

Why would this help anything?

> If you like, I can prepare some patches and post them here.

kernel development is done with actual patches, almost never with "would
this be a good idea", as you never know if it will or not until you
actually do the work.

thanks,

greg k-h
