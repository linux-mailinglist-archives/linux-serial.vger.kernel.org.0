Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C921E1F12
	for <lists+linux-serial@lfdr.de>; Tue, 26 May 2020 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbgEZJrr (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 26 May 2020 05:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbgEZJrq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 May 2020 05:47:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B572070A;
        Tue, 26 May 2020 09:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590486466;
        bh=GcqVqLDZT31D78fCyoIuaygnsuaS0GrFTXjSL8Zx6/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWLUOtgHh9rJeVEMMqEirHnR90qAmSFnMZH9X6wJ7ap02vgog7iv9+m8EYPi8u4DB
         hxIUYkjK6poeI58Y05K3zrhk3GpdmjlQSywgT+WASky5zY6DEm958D+1AHfQlwAk06
         zM6MV/C24ekohBTpxu3rGdU3QfZcCOlmGHj8lbzA=
Date:   Tue, 26 May 2020 11:47:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Enable 16550A variants by default on
 non-x86
Message-ID: <20200526094744.GB2735879@kroah.com>
References: <d32bdbf9fed2719c1180228464ba84dfcdeb5aa5.1590482037.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d32bdbf9fed2719c1180228464ba84dfcdeb5aa5.1590482037.git.josh@joshtriplett.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 26, 2020 at 01:40:06AM -0700, Josh Triplett wrote:
> Some embedded devices still use these serial ports; make sure they're
> still enabled by default on architectures more likely to have them, to
> avoid rendering someone's console unavailable.
> 
> Fixes: dc56ecb81a0a ("serial: 8250: Support disabling mdelay-filled probes of 16550A variants")
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
> 
> Based on user reports from embedded devices that need these variants.

No "reported-by:" lines for these people?  Not even the author of the
other competing patch for this issue?

Please fix up and resend.

thanks,

greg k-h
