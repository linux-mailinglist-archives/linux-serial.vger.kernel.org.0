Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4B3D72E7
	for <lists+linux-serial@lfdr.de>; Tue, 27 Jul 2021 12:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhG0KQp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 27 Jul 2021 06:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236098AbhG0KQp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Jul 2021 06:16:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CAAB611C4;
        Tue, 27 Jul 2021 10:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627381004;
        bh=Cr+VenWXbDUt38w3nYvOCPe9DT984VLWHXWJmS8i/YQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zyn3nmZkTOazHVcdW3fDIfhsUwl3d7arOCVvexVudZxhVAj4M0u9AL50uERUjlcZ6
         HiB227/qFhzdXhSaORvxeyHPVDlWzlh+xo1R25hcOpZYOJGwMEXULYidobmMbodkdA
         EgJHzGuDMvW0fJ4nhI0Yv7+pUlBpCF4Iaw1sBtII=
Date:   Tue, 27 Jul 2021 12:16:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tty: split and cleanup headers
Message-ID: <YP/dCpd4k2JtLEa4@kroah.com>
References: <20210723103147.18250-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723103147.18250-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 23, 2021 at 12:31:39PM +0200, Jiri Slaby wrote:
> I started writing up kernel-doc documentation of the TTY layer. It
> turned out that linux/tty.h is a header containing many structures and
> even function definitions. With added kernel-doc documentation for
> tty_port, tty_buffer, and other main structures, tty.h grew into a very
> large file.
> 
> This series moves many declarations/definitions from tty.h to places
> where they fit better. For that purpose, we also create two brave new
> headers to move there tty_port and tty_buffer structs.
> 
> That way, the combination of documentation and code in the headers
> remains on maintainable level.

Thanks for the cleanups, much appreciated, now applied.

greg k-h
