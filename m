Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB113A874D
	for <lists+linux-serial@lfdr.de>; Tue, 15 Jun 2021 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhFORRp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 15 Jun 2021 13:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhFORRo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 13:17:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77D8D610A3;
        Tue, 15 Jun 2021 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623777339;
        bh=oWjB9JBtbZ8X7eFz8/GtBvNUu9YTAMLtqpt+Nuho9/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myCAKCwZTXFBDK7Pi/fzMwqbGLmNqTEFB53fufVJ1hdKK7A2c83IzrcefghXf+W2K
         xyx6eRJCDndQMCymz/2REX5mtsL7O/IO0Jplw9mchlaj23/if/R/QXM4bRoGCFtBKb
         TG5FBQ8U5wL2g4NLQXe8/i1kWXooaFCzNG8wWfQk=
Date:   Tue, 15 Jun 2021 19:15:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YMjgOl6dbv2Oxzcg@kroah.com>
References: <20210615165750.31261-1-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615165750.31261-1-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 15, 2021 at 09:57:48AM -0700, Alex Nemirovsky wrote:
> From: Jason Li <jason.li@cortina-access.com>
> 
> This driver supports Cortina Access UART IP integrated
> in most all CAXXXX line of SoCs. Earlycom is also supported
> 
> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> ---
> 
> Notes:
>     Change log
>      drivers/tty/serial/serial_cortina-access.c
>       v4:
>        - Removed modification to core serial.h which added unique
>          ID for this driver. Instead used internal assigned ID
>          similar to the method used by the liteuart driver to
>          avoid adding additional IDs to the core serial.h file.

Note, this is really v5, you added the MAINTAINERS entry.  Please be
more careful.
