Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DC53C57E
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 09:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404486AbfFKH6p (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 03:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403815AbfFKH6p (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 03:58:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5695D208E3;
        Tue, 11 Jun 2019 07:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560239924;
        bh=l7IGuoBcx5l6hBGHKT+HgAxkvhEVkTLPCSI893kIBpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZ9YxWLs81PHNoghv31MDzwl7eAGmsRwBV+xd+0CJCkyg8/35rglLdikKeIyYENkU
         hX67yzfL0+DRd+RA9SmCW19f3mKgCJv0xiSa9pNvAgjLNikF7EuLk5Ce08581G2kCC
         IkP2AIOqRUK+BL+0Yh1VIXBSEGqT1m4VrQVakBms=
Date:   Tue, 11 Jun 2019 09:58:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH RFC] serial: imx: fix locking in set_termios()
Message-ID: <20190611075841.GA13408@kroah.com>
References: <1559807977-4598-1-git-send-email-sorganov@gmail.com>
 <20190610165239.GC32085@kroah.com>
 <87tvcwu2dl.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvcwu2dl.fsf@osv.gnss.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 11, 2019 at 08:17:42AM +0300, Sergey Organov wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, Jun 06, 2019 at 10:59:37AM +0300, Sergey Organov wrote:
> >> imx_uart_set_termios() called imx_uart_rts_active(), or
> >> imx_uart_rts_inactive() before taking port->port.lock.
> >> 
> >> As a consequence, sport->port.mctrl that these functions modify
> >> could have been changed without holding port->port.lock.
> >> 
> >> Moved locking of port->port.lock above the calls to fix the issue.
> >> 
> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> ---
> >>  drivers/tty/serial/imx.c | 24 ++++++++++++++----------
> >>  1 file changed, 14 insertions(+), 10 deletions(-)
> >
> > I do not review "RFC" patches as obviously the submitter doesn't think
> > they are actually correct :)
> 
> Oops! Noticed. As an excuse, there is no: "Don't put "RFC" in if you'd
> like Greg to review the patch" in the submitting-patches :)

You can't document everything :)

> Lock-correctness is delicate matter that is hard to test, reviewing by
> the experts in the filed being probably the best testing strategy
> available, and thus your review, Greg, is in fact one of those I'd
> especially like to achieve.

Then write the patch to your satisfaction and post it without the RFC!

thanks,

greg k-h
