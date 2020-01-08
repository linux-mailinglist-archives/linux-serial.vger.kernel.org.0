Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE93A134417
	for <lists+linux-serial@lfdr.de>; Wed,  8 Jan 2020 14:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgAHNnj (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 8 Jan 2020 08:43:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgAHNnj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jan 2020 08:43:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 070E920692;
        Wed,  8 Jan 2020 13:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578491018;
        bh=61SidVWCRqjLTwc0g+JaYNpCOtLS9l6Z3iMuXJfBafU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iFAqANgcbHJwtK35WceTsTFX1rPjoa9eHuAGJy+2gsANkogAv6CY37+ILJoVA3gQ9
         YsjuaIwWpOYwinD2tlPcnrBk/oBQ+0SgoH6iuDGYOmaYsEOIW3cblcKZVIHwlst9AE
         tyi5c/cOrt0o5XRySJ1PtUwA/9e6ukFKXJ3S8oR0=
Date:   Wed, 8 Jan 2020 14:43:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: 4.12 mainline crash in n_tty_receive_buf_common when using
 g_serial
Message-ID: <20200108134336.GA2377543@kroah.com>
References: <CAAfyv37N4OSLtcLRGRRPUg2av6AAqCSu5snR1qv9e=wA74vX1w@mail.gmail.com>
 <20200108122506.GA2365594@kroah.com>
 <CAAfyv35wRyoZMjep=DPOGNk_gX-GxoKknmU1Gu97dUvcUaAEgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfyv35wRyoZMjep=DPOGNk_gX-GxoKknmU1Gu97dUvcUaAEgw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 08, 2020 at 01:38:08PM +0100, Belisko Marek wrote:
> Hi Greg,
> 
> On Wed, Jan 8, 2020 at 1:25 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jan 08, 2020 at 12:49:52PM +0100, Belisko Marek wrote:
> > > Hi,
> > >
> > > we're using mainline 4.12 kernel (bit too old I know) on am335x board.
> >
> > That's _MUCH_ too old and obsolete and broken, there's nothing the
> > community can do about this, sorry.  Please update to a modern kernel
> > version, like 5.4, and we will be glad to help.
> Yes I know it's old but it's behaving fine just hit this issue
> recently. Will take a look if we can bump to something latest.
> >
> > If you are stuck at 4.12 due to a SoC vendor issue, please contact that
> > vendor for support as you are already paying for it from them.
> No it' no vendor kernel it's really mainline (from yocto build).

Then there really is no reason to be using such an old and totally
insecure kernel version.  That's almost a liability :)

thanks,

greg k-h
