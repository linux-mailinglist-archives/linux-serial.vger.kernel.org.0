Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE08D22377D
	for <lists+linux-serial@lfdr.de>; Fri, 17 Jul 2020 10:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgGQI7I (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 17 Jul 2020 04:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgGQI7I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Jul 2020 04:59:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B70207F5;
        Fri, 17 Jul 2020 08:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594976348;
        bh=IXlzJSRmLjILYOGPtxfflwMvAE4986iTMlHH0LUkjeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPcm7NGk9OR/D6uMiVGROzPaFrkOkAMSGoJND5gd+Jp+aUrGmLe4jgYG+H/bAuXtf
         5rotJSJT+aeWkbVbeHpXtYpBNo/4GNIC6lCOu3v4AuhgFQAk33YjjBZvSXLoqfR0uD
         crRNNOmzXQOA41WgR8ki+gsBd2f3SO28FR+stABk=
Date:   Fri, 17 Jul 2020 10:59:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fugang Duan <fugang.duan@nxp.com>
Cc:     linux-serial@vger.kernel.org, lukas@wunner.de,
        s.hauer@pengutronix.de, kernel@pengutronix.de, jslaby@suse.com
Subject: Re: [PATCH tty/serial v2 1/1] tty: serial: imx: enable imx serial
 console port as module
Message-ID: <20200717085900.GB1457960@kroah.com>
References: <20200717081827.3417-1-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717081827.3417-1-fugang.duan@nxp.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 17, 2020 at 04:18:27PM +0800, Fugang Duan wrote:
> GKI kernel requires drivers built as modules including
> console driver, so add the support that imx serial console
> driver can be built as module.

No one knows what "GKI" is, and it isn't relevant here.

> 
> The changes of the patch:
> - imx console driver can be built as module.
> - move out earlycon code to separated driver like imx_earlycon.c,
>   and imx earlycon driver only support build-in.

Why is this not 2 separate patches?

> v2:
>  - fix kbuild error

These v2: stuff should go below the --- line.

thanks,

greg k-h
