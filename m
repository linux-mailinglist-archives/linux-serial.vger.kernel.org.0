Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFEF49B7C
	for <lists+linux-serial@lfdr.de>; Tue, 18 Jun 2019 09:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfFRHuu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 18 Jun 2019 03:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfFRHuu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Jun 2019 03:50:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC98920663;
        Tue, 18 Jun 2019 07:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560844249;
        bh=30eyHFEAZ7ZLhEJQbLsi0Y+iy/d8NRTiNGf/2dgnpQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3nOEcxYM1c7kO48so5T3oab7Ue+w0Bcabzeq/oPAJNDlZmY9+cjKiKdnbgMl+IBT
         eJZgbO8rNL7zsK8+BSYYvZ27vriBS4CGneOXIbPP6MKS0Bq/r4LdpUyZq3wU99S7XB
         w4pHO01A7FHnb/UjRovIsB8PsANwvd77dFfTUuvc=
Date:   Tue, 18 Jun 2019 09:50:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 2/3 v7] serial: 8250: Add MSR/MCR TIOCM conversion
 wrapper functions
Message-ID: <20190618075046.GA5710@kroah.com>
References: <20190617145952.4848-1-sr@denx.de>
 <20190617145952.4848-2-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617145952.4848-2-sr@denx.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 17, 2019 at 04:59:51PM +0200, Stefan Roese wrote:
> This patch adds wrapper functions to convert MSR <-> TIOCM and also
> MCR <-> TIOCM. These functions are used now in serial8250_do_set_mctrl()
> and serial8250_do_get_mctrl().
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
> v7:
> - No change
> 
> v6:
> - New patch
> 
>  drivers/tty/serial/8250/8250.h      | 54 +++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c | 25 ++-----------
>  2 files changed, 57 insertions(+), 22 deletions(-)

This patch does not apply to my tty-next tree.  Please rebase the series
and resend.

thanks,

greg k-h
