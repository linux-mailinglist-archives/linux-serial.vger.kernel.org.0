Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA43BA08
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2019 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfFJQwm (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Jun 2019 12:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfFJQwm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jun 2019 12:52:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97856206E0;
        Mon, 10 Jun 2019 16:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560185562;
        bh=U22J3zqRWQrXfzSq3xT69AtP2QQgptGYHGVKSL0xji4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBRabEOfdfEtQw2TOeGYDz0rvNKi7yg3UXI5/3sGeuwrHJDYA9ZzUVJtusc4EClBo
         JdfaZw+bV3RU+8v7HYJf+wVhkvqAWQmW5B4++8iwKtHWnUsoA+EB+FjIdzUwpvkJGZ
         NdCsmwrKzCuUkq7ehcu6UTb5HXqPhiqUUsLsUhKQ=
Date:   Mon, 10 Jun 2019 18:52:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH RFC] serial: imx: fix locking in set_termios()
Message-ID: <20190610165239.GC32085@kroah.com>
References: <1559807977-4598-1-git-send-email-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559807977-4598-1-git-send-email-sorganov@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 06, 2019 at 10:59:37AM +0300, Sergey Organov wrote:
> imx_uart_set_termios() called imx_uart_rts_active(), or
> imx_uart_rts_inactive() before taking port->port.lock.
> 
> As a consequence, sport->port.mctrl that these functions modify
> could have been changed without holding port->port.lock.
> 
> Moved locking of port->port.lock above the calls to fix the issue.
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

I do not review "RFC" patches as obviously the submitter doesn't think
they are actually correct :)

thanks,

greg k-h
