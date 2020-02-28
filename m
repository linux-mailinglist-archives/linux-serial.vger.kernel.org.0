Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846691735EF
	for <lists+linux-serial@lfdr.de>; Fri, 28 Feb 2020 12:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgB1LSS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 28 Feb 2020 06:18:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgB1LSR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 06:18:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE9920658;
        Fri, 28 Feb 2020 11:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582888697;
        bh=fSY96SDopWfyGJlBh/YWZ0XEkxZAt2S5uQ5qaCPocYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2i6didYKoZTm0I9zwFmf0/HY1ZgAdrT+IAWL20dEcr3VqxhALHdTGN792AVKRI8N
         qyKPzMNH0p48RC3LaFGnGgymWSnZ+rHKVu0K9vWjN9bSLd6i7KAkVguufW6ff/sJtR
         jf6Ijo3ZFaqLwHxXVW8YmUJyyRO6XOlADv/aD1kg=
Date:   Fri, 28 Feb 2020 12:18:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: earlycon: prefer EARLYCON_DECLARE() variant
Message-ID: <20200228111815.GA2915187@kroah.com>
References: <20200220174607.24285-1-michael@walle.cc>
 <ba54e9c14d4e0947df964964c020bc71@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba54e9c14d4e0947df964964c020bc71@walle.cc>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 28, 2020 at 11:26:36AM +0100, Michael Walle wrote:
> Hi Greg,
> 
> 
> Am 2020-02-20 18:46, schrieb Michael Walle:
> > If a driver exposes early consoles with EARLYCON_DECLARE() and
> > OF_EARLYCON_DECLARE(), pefer the non-OF variant if the user specifies it
> > by
> >   earlycon=<driver>,<options>
> > 
> > The rationale behind this is that some drivers register multiple setup
> > functions under the same driver name. Eg.
> > 
> > OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart",
> > lpuart_early_console_setup);
> > OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart",
> > lpuart32_early_console_setup);
> > OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart",
> > lpuart32_imx_early_console_setup);
> > EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
> > EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
> > 
> > It depends on the order of the entries which console_setup() actually
> > gets called. To make things worse, I guess it also depends on the
> > compiler how these are ordered. Thus always prefer the
> > EARLYCON_DECLARE()
> > ones.
> 
> Do you have an opinon on this proposal?

It's only been a week, please give me a chance to catch up on serial
patches...

thanks,

greg k-h
