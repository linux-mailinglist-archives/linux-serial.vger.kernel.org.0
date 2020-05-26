Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797C61D320F
	for <lists+linux-serial@lfdr.de>; Thu, 14 May 2020 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgENOER (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 14 May 2020 10:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgENOER (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 May 2020 10:04:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0EF205CB;
        Thu, 14 May 2020 14:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589465057;
        bh=wK9kATV3IiwneSKIxY9R0+7LbrRi4bGCsiUEq+Bi5vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbyFUvoqPBMm223uN2NlvDVJZ5NBtetWntscw9nIQ+7aoGw+c8gFZAyYPD2N2K/aJ
         52t0GrLXeGHC9vLc4KZu5yqNaQWKI/RAu+cZxRA2ewVM6T2+Q4Grtcwcu6KdPOa4TR
         kqZ43+vIPJQ5EIuZXMqQFaxJnTp+d1tzypUWvrAc=
Date:   Thu, 14 May 2020 16:04:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
Subject: Re: [PATCH V3] serial: msm_geni_serial_console : Add Earlycon support
Message-ID: <20200514140414.GC2581983@kroah.com>
References: <20200514133429.31245-1-msavaliy@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514133429.31245-1-msavaliy@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 14, 2020 at 07:04:29PM +0530, Mukesh, Savaliya wrote:
> From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> 
> This change enables earlyconsole support as static driver for geni
> based UART. Kernel space UART console driver will be generic for
> console and other usecases of UART.
> 
> Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> ---
> Removed mb() calls as *_relaxed() should take care.

What about what happened from v1?

ALways keep the full changelog here, otherwise we don't remember what
happened.

> +static void se_io_set_mode_earlycon(void __iomem *base)
> +{
> +	unsigned int io_mode;
> +
> +	io_mode = readl_relaxed(base+SE_IRQ_EN);

	io_mode = readl_relaxed(base + SE_IRQ_EN);

please.  Use ' ', there is no need to not do so.

thanks,

greg k-h
