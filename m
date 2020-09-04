Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9033525DCDF
	for <lists+linux-serial@lfdr.de>; Fri,  4 Sep 2020 17:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgIDPLF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 4 Sep 2020 11:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbgIDPLF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Sep 2020 11:11:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB2C2073B;
        Fri,  4 Sep 2020 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599232264;
        bh=tYJdMqrk0GYWpMweFguKqDno9M3LJpFL3eQwj/m0Txc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MdOMEGmst9Yob16TZ5IpYFaGoXecLUmvIlJ7DKcf7SvgUB8BDD+GNoKGQmCuVBde1
         yz0urAv/drFzGttsdCy6ySKWqUHvJ7QS79fajCLlWyf7zur+7xwAsXgGwM1zxdAv1P
         +UhU6RJjrX88wNNbK3GafUXz8uAXxZYkqN8EdWAY=
Date:   Fri, 4 Sep 2020 17:11:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Ye Bin <yebin10@huawei.com>, chris.ruehl@gtsys.com.hk,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: imx: Delete duplicated argument to '|' in
 imx_uart_probe
Message-ID: <20200904151125.GA3347894@kroah.com>
References: <20200903062401.692442-1-yebin10@huawei.com>
 <20200903073541.g57uoipyolsixfjn@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200903073541.g57uoipyolsixfjn@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 03, 2020 at 09:35:41AM +0200, Uwe Kleine-K�nig wrote:
> Hello,
> 
> On Thu, Sep 03, 2020 at 02:24:01PM +0800, Ye Bin wrote:
> > When calculate "ucr1" UCR1_TRDYEN is duplicate.
> > 
> > Fixes: c514a6f848b5b ("serial: imx: use Tx ready rather than Tx empty irq")
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> 
> Not sure I'd use Fixes: to reference the commit that introduced this
> duplication, as this fix is not critical at all.

Agreed, I'm dropping that line.

thanks,

greg k-h
