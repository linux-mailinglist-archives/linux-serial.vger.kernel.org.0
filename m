Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8642E49B80
	for <lists+linux-serial@lfdr.de>; Tue, 18 Jun 2019 09:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfFRHvd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 18 Jun 2019 03:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfFRHvd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Jun 2019 03:51:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B807E20663;
        Tue, 18 Jun 2019 07:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560844292;
        bh=23BYx5ouw7aDhaIn4A1s/pjkdzeloujvJWB5786p2Vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1CqTGWgKX2Ya5UX85OlDX1y+514S8xex7o70WO0BkBG2gnq04aIIz7vBk1rlUuUfY
         iNe4LtdxH3FDFHhSZNgdosPmImxH8hPwkWR1fnvGo6PRvRF7qAi58p0frjwgRxwsyt
         c0JgkHKfamr6b/EFI+Qp2YZ9SSdIttnNBUf8THL0=
Date:   Tue, 18 Jun 2019 09:51:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kpark3469@gmail.com
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, keun-o.park@darkmatter.ae
Subject: Re: [PATCH] tty: serial_core: recover uport->cons->cflag on
 uart_close
Message-ID: <20190618075129.GA5758@kroah.com>
References: <1560697034-4807-1-git-send-email-kpark3469@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560697034-4807-1-git-send-email-kpark3469@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jun 16, 2019 at 06:57:14PM +0400, kpark3469@gmail.com wrote:
> From: Sahara <keun-o.park@darkmatter.ae>

I need a "full" name here please, something you use to sign legal
documents.

> Since uart_close was converted to use tty_port_close, uart_shutdown
> also moved to uart_tty_port_shutdown, which means it does not backup
> tty's termios to uart_port.console.cflag when console is closed and
> uart_console is true.
> By losing this value, serial console was not set correctly especially
> after suspend/resume when there is no consumer of console device.
> This problem resets console driver's configuration to an unwanted value
> and may give a performance regression in the system eventually.
> This patch fixes the bug introduced from v4.9 kernel.
> 
> Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
> Reported-by: Jouni Linnamaa <Jouni.Linnamaa@darkmatter.ae>
> Signed-off-by: Sahara <keun-o.park@darkmatter.ae>

Same here as well.

thanks,

greg k-h
