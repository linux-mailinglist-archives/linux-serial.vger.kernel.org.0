Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011AB11ED31
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 22:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLMVsw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 13 Dec 2019 16:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfLMVsw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Dec 2019 16:48:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51772465A;
        Fri, 13 Dec 2019 21:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576273731;
        bh=W6PNMUKclSNiyukyuEfFoNLFmNoXI+aexIYgZ4MTdjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PeEofRhsCvjZ+oPbAqR3cXLYfTQrMxwVJwTPrn2WP14QZe/PuCvRGUlRXNDZ6L22p
         UNxVsIZmRGhOh7RIjhSqn/YG+VgeeZM0YsLYAovRdNf5reI1pvJr3oq5XoxQmmHWrg
         Yf7uhsv8CrEa5gmU7TN4t3Be9otvEyQCgL+krue4=
Date:   Fri, 13 Dec 2019 17:07:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Engraf <david.engraf@sysgo.com>
Cc:     richard.genoud@gmail.com, jslaby@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty/serial: atmel: fix out of range clock divider
 handling
Message-ID: <20191213160726.GB2632926@kroah.com>
References: <1e2e3f63-84db-4b38-1bf1-85916116e0a2@sysgo.com>
 <20191213140301.16490-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213140301.16490-1-david.engraf@sysgo.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 13, 2019 at 03:03:01PM +0100, David Engraf wrote:
> Use MCK_DIV8 when the clock divider is > 65535. Unfortunately the mode
> register was already written thus the clock selection is ignored.
> 
> Fix by doing the baud rate calulation before setting the mode.
> 
> Fixes: 5bf5635ac170 ("tty/serial: atmel: add fractional baud rate support")
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 43 ++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 21 deletions(-)

What changed from v1?

Always put that below the --- line.

v3 please?

thanks,

greg k-h
