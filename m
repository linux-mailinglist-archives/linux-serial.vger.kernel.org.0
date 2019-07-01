Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC05024DC8
	for <lists+linux-serial@lfdr.de>; Tue, 21 May 2019 13:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfEULSV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 21 May 2019 07:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEULSU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 May 2019 07:18:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C3020863;
        Tue, 21 May 2019 11:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558437499;
        bh=idCdpfIphgwsyBJcVnG3Lf/jXFBiv1TH26SgUIodjC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ILtZKTg0ksXwd6/6eguMea6fBdLiBag3w79CdHvOQPFNZvAagS+st52LaYQv9xbsY
         N70qfNzbMae4PJbZpfyGrJmFfzu6Nus9rzYzLe4tF+H5U5MQpy2UmfEwEufpqJIgj1
         F0XFVjUZufD/DJOKVawTwKyr1A79X1G5wQIHHeCY=
Date:   Tue, 21 May 2019 13:18:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD
 function
Message-ID: <20190521111817.GA24911@kroah.com>
References: <20190426084038.6377-3-esben@geanix.com>
 <20190507114905.GB29524@dell>
 <87o94ejwrx.fsf@haabendal.dk>
 <20190507133844.GA6194@dell>
 <87bm05mpmx.fsf@haabendal.dk>
 <20190514104741.GO4319@dell>
 <20190514122618.GA18859@kroah.com>
 <87imudky2o.fsf@haabendal.dk>
 <20190521100904.GA13612@kroah.com>
 <87pnocm59v.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnocm59v.fsf@haabendal.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 21, 2019 at 01:11:08PM +0200, Esben Haabendal wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> >> I will try ad hold back with this thread until you get back to it.
> >
> > Ok, I have no idea what is going on here, sorry.  This is a really long
> > and meandering thread, and I can't even find the original patches in my
> > queue.
> >
> > So can you resend things and we can start over?  :)
> 
> Will do.
> 
> > But note, using a mfd for a uart seems VERY odd to me...
> 
> Ok.  In my case, I have a pcie card with an fpga which includes 5 uart
> ports, 3 ethernet interfaces and a number of custom IP blocks.
> I believe that an mfd driver for that pcie card in that case.

I believe you need to fix that fpga to expose individual pci devices
such that you can properly bind the individual devices to the expected
drivers :)

Seriously, who makes such a broken fpga device that goes against the PCI
spec that way?  Well, not so much as "goes against it", as "ignores all
of the proper ideas of the past 20 years for working with PCI devices".

thanks,

greg k-h
