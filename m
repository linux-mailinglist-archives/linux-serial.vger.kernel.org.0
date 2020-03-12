Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD9182BC5
	for <lists+linux-serial@lfdr.de>; Thu, 12 Mar 2020 10:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgCLJDB (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Mar 2020 05:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgCLJDB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 05:03:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6761320691;
        Thu, 12 Mar 2020 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584003780;
        bh=W3VhYB0+37wDg2ve0xW9G4K2A31AP6lXnjoIl/W109Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYdPB8TeqL3Mva1QSnRLzmsTKUKX0Dlo5A0028hiWu7RUnhp1FsMqH/aayraJ6vAx
         Xhtkk2r2ntLubZKny8JvmH7VVCM1rays1My8CENWodPLv/Y7HAew69NvHeNuCq9wII
         EpQjXnUYDmeqjPCtMSv3g41/LlZ3GNOPJuKMOYWs=
Date:   Thu, 12 Mar 2020 10:02:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Devera <devik@eaxlabs.cz>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tty/serial: Add st,swap OF option to stm32-usart
Message-ID: <20200312090258.GA180600@kroah.com>
References: <20200229160507.31309-1-devik@eaxlabs.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229160507.31309-1-devik@eaxlabs.cz>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Feb 29, 2020 at 05:05:06PM +0100, Martin Devera wrote:
> STM32 F7/H7 usarts supports RX & TX pin swapping.
> Add option to turn it on.
> Tested on STM32MP157.
> 
> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> ---
>  drivers/tty/serial/stm32-usart.c | 3 ++-
>  drivers/tty/serial/stm32-usart.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

This, and patch 2/2, do not apply to my tty-next branch at all.  What
did you make them against?

Please rebase and resend the series.

thanks,

greg k-h
