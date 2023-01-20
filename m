Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2FF674EBA
	for <lists+linux-serial@lfdr.de>; Fri, 20 Jan 2023 08:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjATH4J (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 20 Jan 2023 02:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjATH4J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Jan 2023 02:56:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460474C0D
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 23:56:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D65F961E4C
        for <linux-serial@vger.kernel.org>; Fri, 20 Jan 2023 07:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2C3C433D2;
        Fri, 20 Jan 2023 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674201367;
        bh=c688OOpDWVhuqGhY+/x9dAkohzUMXOoFxhSUWfx5qzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUx/z/LwoDJy4rFy22t87SG8iJKJAe6rSaGu3gg4TQqvvJFsK8XKo/w3Izw/jbZRr
         gsNgxC04rF3U1gZ3owJkd78Cjf+LlWZZmdMmzpc9DD+9TAYR172hwVw2LForVpjRbf
         2CCKsG25NLGJC3mlBuOGGCHkB3NZe0QHZF6Ew7Dwk/6TgywUvokGZz3gs6a+ABUBqd
         hCmMrQRNpWWJEiW9ALLygoj0dae3nlDbYV/rroXmMO2Y0u5Q1FM0XnfLbrHVr2itab
         /mZ9wE7hWczFwiSjun8WTsPReY99zg3n8uuJE6WCtB11YIKE/j8VYBValI7W5Qj8/o
         wR72ZL28RbQkQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pImGK-000749-FS; Fri, 20 Jan 2023 08:56:37 +0100
Date:   Fri, 20 Jan 2023 08:56:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [tty:tty-linus 4/7] drivers/tty/serial/stm32-usart.c:804:62:
 error: 'flags' undeclared
Message-ID: <Y8pJNKb103VZvEpD@hovoldconsulting.com>
References: <202301200130.ttBiTzfO-lkp@intel.com>
 <f5f4b504-8e58-2844-fa26-c8896a625794@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5f4b504-8e58-2844-fa26-c8896a625794@denx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 19, 2023 at 07:08:00PM +0100, Marek Vasut wrote:
> On 1/19/23 18:33, kernel test robot wrote:
> 
> [...]
> 
> > cc58d0a3f0a475 Erwan Le Ray     2021-10-20  800  	/* Receiver timeout irq for DMA RX */
> > f24771b62a8323 Marek Vasut      2023-01-12  801  	if (stm32_usart_rx_dma_enabled(port) && !stm32_port->throttled) {
> > f24771b62a8323 Marek Vasut      2023-01-12  802  		spin_lock(&port->lock);
> > 6333a485062172 Erwan Le Ray     2021-10-25  803  		size = stm32_usart_receive_chars(port, false);
> > 6333a485062172 Erwan Le Ray     2021-10-25 @804  		uart_unlock_and_check_sysrq_irqrestore(port, flags);
> 
> +CC Johan
> 
> This one should be uart_unlock_and_check_sysrq(port); I think . If 
> that's correct, then I'll send a patch.

That should be it. Next time, please compile-test your patches...

> > 6333a485062172 Erwan Le Ray     2021-10-25  805  		if (size)
> > 6333a485062172 Erwan Le Ray     2021-10-25  806  			tty_flip_buffer_push(tport);
> > 6333a485062172 Erwan Le Ray     2021-10-25  807  	}
> 
> [...]

Johan
