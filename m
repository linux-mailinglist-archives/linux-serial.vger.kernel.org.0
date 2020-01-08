Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5DD134197
	for <lists+linux-serial@lfdr.de>; Wed,  8 Jan 2020 13:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgAHMZJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 8 Jan 2020 07:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgAHMZJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jan 2020 07:25:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B883206DB;
        Wed,  8 Jan 2020 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578486308;
        bh=rAcYAvEZZV25I3HlRw6DaITMren/blPnJhI7i3jJePc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtwHonC5bke/h9XdKtgaLcoWpj+42FtFBLe5kFzDFfVuoQQQ4vOCxx1vElXTCz9dh
         BEuiw/9gEeeFW20c3wVk7Y2bpOtRxPEx0bGC4KL0gPJx1sTSLG1tLKBscrW7giDEsr
         q3RbTV91HPtBKIGIDOLnKIngeI+b7NAGpoD1bVRA=
Date:   Wed, 8 Jan 2020 13:25:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: 4.12 mainline crash in n_tty_receive_buf_common when using
 g_serial
Message-ID: <20200108122506.GA2365594@kroah.com>
References: <CAAfyv37N4OSLtcLRGRRPUg2av6AAqCSu5snR1qv9e=wA74vX1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfyv37N4OSLtcLRGRRPUg2av6AAqCSu5snR1qv9e=wA74vX1w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 08, 2020 at 12:49:52PM +0100, Belisko Marek wrote:
> Hi,
> 
> we're using mainline 4.12 kernel (bit too old I know) on am335x board.

That's _MUCH_ too old and obsolete and broken, there's nothing the
community can do about this, sorry.  Please update to a modern kernel
version, like 5.4, and we will be glad to help.

If you are stuck at 4.12 due to a SoC vendor issue, please contact that
vendor for support as you are already paying for it from them.

good luck!

greg k-h
