Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B35393FF0
	for <lists+linux-serial@lfdr.de>; Fri, 28 May 2021 11:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhE1J3C (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 28 May 2021 05:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235991AbhE1J3A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 May 2021 05:29:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9585661183;
        Fri, 28 May 2021 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622194046;
        bh=ZmBIcREgp2uM7s3flXyB5yh2WUlsZQ4tBLWQceOOo38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEcTxfo5GZPVNH9fHcwa0tAtBbDyMWFsVjeVnuLgWKwhreuS4OuSJt5sz4J9xWQI2
         C8WhKuRl6hcwZS96+glVlsLT7jG1almiYVyrdfMhdOYr4jG5lP/bbkwuuUlcZd3yv+
         enUoVvUfxTf3XNUNgKzLUiumyH6MySu3EmaVIGbM=
Date:   Fri, 28 May 2021 11:27:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-serial@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com
Subject: Re: [PATCH] Add supprt for SUNIX SDC serial port driver
Message-ID: <YLC3e+K9vDctfRxL@kroah.com>
References: <20210528092240.5896-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528092240.5896-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 28, 2021 at 05:22:40PM +0800, Moriis Ku wrote:
> From: Morris Ku <saumah@gmail.com>
> 
> SUNIX SDC serial port driver.
> 
> Cc: Jason Lee <jason_lee@sunix.com>
> Cc: Taian Chen <taian.chen@sunix.com>
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  Kconfig  | 6 ++++++
>  Makefile | 1 +
>  2 files changed, 7 insertions(+)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for a description of how
  to do this so that Greg has a chance to apply these correctly.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
