Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C61C6FD9
	for <lists+linux-serial@lfdr.de>; Wed,  6 May 2020 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEFMCl (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 6 May 2020 08:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgEFMCl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 08:02:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BCC8206DD;
        Wed,  6 May 2020 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588766559;
        bh=0waTvXj6ch4/Km+poCgx3lGdYsYsUHDyQeTnFSg0ENk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItsxgBUimZaa4uVpr1A4ybm/3ORq+a1iXEn8Tu8Ioo9cvS+gcdQYJ5CB+IWPWkHGX
         4l5E7huhUfzwEUwUu7sYlaRjUQZsoWB1eJWp77x50yOrOnUDe0LMfxU5ddUwjheCHn
         m8J6sPjt0ispCKHezfvrOIXHjm/YcZ4FbMkw1C3s=
Date:   Wed, 6 May 2020 14:02:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Mukesh, Savaliya" <msavaliy@codeaurora.org>, will@kernel.org
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
Subject: Re: [PATCH V2] serial: msm_geni_serial_console : Add Earlycon support
Message-ID: <20200506120237.GA3047211@kroah.com>
References: <20200506113331.32562-1-msavaliy@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506113331.32562-1-msavaliy@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 06, 2020 at 05:03:31PM +0530, Mukesh, Savaliya wrote:
> +static void msm_geni_serial_wr_char(struct uart_port *uport, int ch)
> +{
> +	writel_relaxed(ch, uport->membase+SE_GENI_TX_FIFOn);
> +	/*
> +	 * Ensure FIFO write clear goes through before
> +	 * next iteration.
> +	 */
> +	mb();

Can't you just write the above two lines as:
	writel(ch, uport->membase+SE_GENI_TX_FIFOn);
?

Why put a mb() after a _relaxed() call?

Will, I know I asked you about this on irc a while ago, is the above
really correct?

This happens other places in the driver.

Also, Savaliya, please use checkpatch on your patch, you need some
whitespace fixes in this code before I could accept it at the very
least.

thanks,

greg k-h
