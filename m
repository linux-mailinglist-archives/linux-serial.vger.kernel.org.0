Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E881115CB93
	for <lists+linux-serial@lfdr.de>; Thu, 13 Feb 2020 21:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgBMUAJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 13 Feb 2020 15:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgBMUAJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Feb 2020 15:00:09 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C481921734;
        Thu, 13 Feb 2020 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581624008;
        bh=KnHHKVe1n67O5ZYl7TzEtlRCPIGA53LFZUcP+UZsmYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oqoOKlMQBYw9F9M+411L6xVqQwUVwuJhMEWjAlE313tBT8KpWqsV3XMSSnB5e7Br8
         DNkECUcNMjr9j4gYT7Uthte8mJ95tYe52py1tC/NDCGKwnPPXjWuayrTR+DFx8Uh1L
         aqYU0b094x2ZJiTMkfxhKzY7LmoGcgZZiYkQVFqk=
Date:   Thu, 13 Feb 2020 12:00:08 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: cpm_uart: call cpm_muram_init before registering
 console
Message-ID: <20200213200008.GB3815621@kroah.com>
References: <20200213114342.21712-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213114342.21712-1-linux@rasmusvillemoes.dk>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 13, 2020 at 12:43:42PM +0100, Rasmus Villemoes wrote:
> Christophe reports that powerpc 8xx silently fails to 5.6-rc1. It turns
> out I was wrong about nobody relying on the lazy initialization of the
> cpm/qe muram in commit b6231ea2b3c6 (soc: fsl: qe: drop broken lazy
> call of cpm_muram_init()).
> 
> Rather than reinstating the somewhat dubious lazy call (initializing a
> currently held spinlock, and implicitly doing a GFP_KERNEL under that
> spinlock), make sure that cpm_muram_init() is called early enough - I
> thought the calls from the subsys_initcalls were good enough, but when
> used by console drivers, that's obviously not the
> case. cpm_muram_init() is safe to call twice (there's an early return
> if it is already initialized), so keep the call from cpm_init() - in
> case SERIAL_CPM_CONSOLE=n.
> 
> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: b6231ea2b3c6 (soc: fsl: qe: drop broken lazy call of cpm_muram_init())
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> 
> Christophe, can I get you to add a formal Tested-by?
> 
> I'm not sure which tree this should go through.

I can take it, thanks.

greg k-h
