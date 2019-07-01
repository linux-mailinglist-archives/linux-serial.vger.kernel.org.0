Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FB83BAB1
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2019 19:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbfFJRNG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Jun 2019 13:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387500AbfFJRNG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jun 2019 13:13:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41AE5207E0;
        Mon, 10 Jun 2019 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560186785;
        bh=sT/rZSZYEkVXc+vfxxISMm6Asd7SJoGF8UinSixDpnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1bSwVDIRlZNG9xrSaFEIuayW/tn8kHGx1Y+QO1S18vHPPtZ9tJlabLj8ZLJC6+Tz2
         y8zMJ6kOVtka73LQLBRNh+BCMJSvcylXJPydtkd+yOr2W2daDYUUczRmRC32TVuVqy
         9Ynq/LYS1yDKhy4KOLZhtUGXm2SmfunmUR5jtq2A=
Date:   Mon, 10 Jun 2019 19:13:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, johan@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] serial: uartps: Use the same dynamin major number
 for all ports
Message-ID: <20190610171303.GA14134@kroah.com>
References: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
 <381ea608440345a4424d24296666b2451b1a20ee.1560156294.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381ea608440345a4424d24296666b2451b1a20ee.1560156294.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 10, 2019 at 10:44:56AM +0200, Michal Simek wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Let kernel to find out major number dynamically for the first device and
> then reuse it for other instances.
> This fixes the issue that each uart is registered with a
> different major number.
> 
> After the patch:
> crw-------    1 root     root      253,   0 Jun 10 08:31 /dev/ttyPS0
> crw--w----    1 root     root      253,   1 Jan  1  1970 /dev/ttyPS1
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/tty/serial/xilinx_uartps.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Does not apply without patch 1/2, so dropping it from my queue.

Which is ALWAYS a good reason why you should submit bug fixes or other
things before code cleanup patches.

thanks,

greg k-h
