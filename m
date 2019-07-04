Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13A85F70A
	for <lists+linux-serial@lfdr.de>; Thu,  4 Jul 2019 13:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfGDLIb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 4 Jul 2019 07:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfGDLIb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jul 2019 07:08:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37A9C2189E;
        Thu,  4 Jul 2019 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562238510;
        bh=73THxlAoaXJ+zfqxn1j5FyMBBUxvTe/6uBNbZrlMEXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULkb49b6cyBtDqYe1on0YUWRvZ5nrXNtAzOI7TvD8NugCvl81w70+QpTQ256nCY2f
         cfyaBpZPdl33WmPxrSSKLjH59d1rRe/qQJMo0UpiZi8WHWrfD58/7ghGKvrk0t6eWd
         cK5TftQZU18WvDGPIA+0QDMMc+puIws0oylE0CPY=
Date:   Thu, 4 Jul 2019 13:08:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [EXT] Re: [PATCH tty/serial 2/2] dt-bindings: serial: lpuart:
 add the clock requirement for imx8qxp
Message-ID: <20190704110828.GF1404@kroah.com>
References: <20190704100021.10859-1-fugang.duan@nxp.com>
 <20190704100021.10859-3-fugang.duan@nxp.com>
 <20190704102234.GA11348@kroah.com>
 <VI1PR0402MB3600709B910F30AB94C6AFEDFFFA0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3600709B910F30AB94C6AFEDFFFA0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 04, 2019 at 10:55:06AM +0000, Andy Duan wrote:
> From: Greg KH <gregkh@linuxfoundation.org> Sent: Thursday, July 4, 2019 6:23 PM
> > On Thu, Jul 04, 2019 at 06:00:21PM +0800, fugang.duan@nxp.com wrote:
> > > From: Fugang Duan <fugang.duan@nxp.com>
> > >
> > > Add the baud clock requirement for imx8qxp.
> > >
> > > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > dt stuff needs to cc: the dt maintainers, right?
> 
> Right, I will resend the binding doc patch and cc the maintainers.
> And does I need to resend the lpuart driver patch ?

Shouldn't the binding doc be 1/2 here anyway?  So please resend the
whole series.

thanks,

greg k-h
