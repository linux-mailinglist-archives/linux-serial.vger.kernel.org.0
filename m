Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBAD30F6C5
	for <lists+linux-serial@lfdr.de>; Thu,  4 Feb 2021 16:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbhBDPtJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Feb 2021 10:49:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237439AbhBDPsc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Feb 2021 10:48:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E198F64F4D;
        Thu,  4 Feb 2021 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612453670;
        bh=PE6ihUTJGGIDvgTTA1LwlKJ/3kbMVz7bUoF1io+k2BU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGjTMB9nXC0/ckYE2cIznFpDg0W4X6BVTqOCMHBa2olIqwJc2U5SSgBopW3Ktixgy
         DkKEirLmk1NpDcjg2ob+BX8E/vfbyo5roZxrWPIefmVvlKae1kh0sHl9E4qOG8d10m
         X9zDKrGTxbrkHMFiAH5wHf/EykWrFKfOoAwJvWh0=
Date:   Thu, 4 Feb 2021 16:47:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Jason Li <jason.li@cortina-access.com>
Subject: Re: [PATCH 1/2] tty: serial: Add UART driver for Cortina-Access
 CAxxxx SoCs
Message-ID: <YBwXIxrIsUxwripd@kroah.com>
References: <1610673113-14503-1-git-send-email-alex.nemirovsky@cortina-access.com>
 <YAE4+BNIk7Yu4V35@kroah.com>
 <4B59D43F-FEE9-4AA0-BEF6-DEE986609460@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B59D43F-FEE9-4AA0-BEF6-DEE986609460@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 04, 2021 at 07:40:25AM +0000, Alex Nemirovsky wrote:
> Hi Greg,
> 
> It took us a little while but I think this should address most of your feedback from our first submission.

I do not understand, this is an html message which got rejected by the
mailing list and an attached patch.

Why not actually answer the questions I asked?  Isn't that a bit more
conversational?

What would you want to have happen if you reviewed my code with a bunch
of questions?

thanks,

greg k-h
