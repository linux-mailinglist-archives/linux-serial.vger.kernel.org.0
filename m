Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFE12483BC
	for <lists+linux-serial@lfdr.de>; Tue, 18 Aug 2020 13:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgHRLTb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 18 Aug 2020 07:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHRLTa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 07:19:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD0520706;
        Tue, 18 Aug 2020 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597749570;
        bh=/erd3TMa+88zcgkkl/pnfVVP6m25RnHWrfKehr1Rf7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFrMEsAaQ4e2eIQP6w2vhxLzUTsVbBEGumqrH4ZLIl+tVLkEQBwu9elFSX+T8ST+2
         FsZDu0b1aVJFczOkZKq9S25Gny35wVj0N2LyLbpir2J2BMlnhflUy0lALeKDYZZ9yr
         hVh5HRbpmxuHfHXwbCqZknzkUu0NPVCgo19oUU5k=
Date:   Tue, 18 Aug 2020 13:19:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fixes: tty: serial: earlycon dependency
Message-ID: <20200818111954.GA283417@kroah.com>
References: <20200817170038.GA725471@kroah.com>
 <20200817185419.1133596-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817185419.1133596-1-ztong0001@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 17, 2020 at 02:54:19PM -0400, Tong Zhang wrote:
> parse_options() in drivers/tty/serial/earlycon.c calls uart_parse_earlycon
> in drivers/tty/serial/serial_core.c therefore selecting SERIAL_EARLYCON
> should automatically select SERIAL_CORE, otherwise will result in symbol
> not found error during linking if SERIAL_CORE is not configured as builtin
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

As Jiri pointed out, the Fixes: line goes down here, not in your subject
line :)

Please fix up, thanks.

> ---
>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

What changed from v1?  Also always list that below the --- line so we
know.

thanks,

greg k-h
