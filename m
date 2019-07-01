Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 353B93B816
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2019 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389450AbfFJPMQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Jun 2019 11:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389322AbfFJPMQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jun 2019 11:12:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D408207E0;
        Mon, 10 Jun 2019 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560179536;
        bh=h7mmrFketdGrH+jhcRTn+JLEZxAETRUZZjfI6AMHvCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hf0QAKqPWs3ENU591+37VscvqlxLG+/JbxsSF6qbnzU1/X5YVItVSaPjV2rM4rQ09
         B2uL15jg0n+qvd/+BGm0HDMCWtU1ZX9y71BYyMplT4kmo4siqp9sMlIAHDG9P9BcSE
         gwGJufDeL6oNOgTo8oiicRdA7nzeTfFWE1hgQOPk=
Date:   Mon, 10 Jun 2019 17:12:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, johan@kernel.org,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] serial: xilinx_uartps: Fix warnings in the driver
Message-ID: <20190610151213.GA7305@kroah.com>
References: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
 <20190610144425.GC31086@kroah.com>
 <888c7d0a-28dc-978c-662a-e96ee3863c41@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888c7d0a-28dc-978c-662a-e96ee3863c41@xilinx.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 10, 2019 at 05:06:57PM +0200, Michal Simek wrote:
> On 10. 06. 19 16:44, Greg KH wrote:
> > On Mon, Jun 10, 2019 at 10:44:55AM +0200, Michal Simek wrote:
> >> From: Nava kishore Manne <nava.manne@xilinx.com>
> >>
> >> This patch fixes the below warning
> >>
> >>         -->Symbolic permissions 'S_IRUGO' are not preferred.
> >>            Consider using octal permissions '0444'.
> >>         -->macros should not use a trailing semicolon.
> >>         -->line over 80 characters.
> >>         -->void function return statements are not generally useful.
> >>         -->Prefer 'unsigned int' to bare use of 'unsigned'.
> >>
> >> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >>
> >> Happy to split it if needed.
> > 
> > Please split.  Do not do more than one "logical thing" per patch.
> > 
> > And the subject is not correct, there are no general "warnings", these
> > are all checkpatch warnings, not a build issue.
> 
> ok. Will do. Any issue with second patch?

It will change your user/kernel api but hey, it's your call, it looks
like a nice fix to me :)

thanks,

greg k-h
