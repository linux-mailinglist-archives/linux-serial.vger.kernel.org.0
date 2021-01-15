Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078112F72FD
	for <lists+linux-serial@lfdr.de>; Fri, 15 Jan 2021 07:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbhAOGme (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 15 Jan 2021 01:42:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAOGme (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Jan 2021 01:42:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69CBC233EE;
        Fri, 15 Jan 2021 06:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610692913;
        bh=kAGMYDnjUVxaR/2FsM9b10aYvToVE6YyaoVpAogED0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EAmEVwaOVg2ZObdR32E4mgvXJRO7/vBD31ICczrl4VKJhUcNNBERNXLtNJCJv+4pQ
         14z67G68f1Zi/Zz5kw6oN0+bpYpUz4Vxf+hZwI1tQ11By73NOZ8K2zFn6JzZXbgf9x
         DM5d/xmm11JxJNbkdmH96uchXjGiQy0NtL223ZgA=
Date:   Fri, 15 Jan 2021 07:41:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     linux-serial@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Jason Li <jason.li@cortina-access.com>
Subject: Re: [PATCH 1/2] tty: serial: Add UART driver for Cortina-Access
 CAxxxx SoCs
Message-ID: <YAE5L8snkCNU/Lae@kroah.com>
References: <1610673113-14503-1-git-send-email-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610673113-14503-1-git-send-email-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 14, 2021 at 05:11:52PM -0800, Alex Nemirovsky wrote:
> From: Jason Li <jason.li@cortina-access.com>
> 
> 	This driver supports Cortina Access UART IP integrated
> 	in most all CAXXXX line of SoCs. Earlycom is also supported.
> 
> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> Reviewed-by: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> ---
>  .../bindings/serial/cortina-access,serial.yaml     | Bin 0 -> 836 bytes
>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +

Also, you need to split this up, with the DT-specific changes a separate
patch, and cc: the device tree maintainers to get them to review it
properly.

thanks,

greg k-h
