Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C758AFB8
	for <lists+linux-serial@lfdr.de>; Tue, 13 Aug 2019 08:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfHMGN4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 13 Aug 2019 02:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbfHMGN4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Aug 2019 02:13:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A7A720578;
        Tue, 13 Aug 2019 06:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565676835;
        bh=rGzT4MhKwakUGdTMTEcOkbIXp0hWQNwP5MypgQuJsIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVwKOG9r8ypIhK++8Aa5+RdbVadNcgASQxH8gJAp2wcWDhI3qiyj0o0o2x6+ePNi9
         eFe4QkgX6oAO30XlaZGhgM2UG43tRu+R4ihPnhre/H5S8iPpK7o0b/WcI7dOXs4Vva
         GHkMeAeGkuWnPlLvXqvdhiyJxGidvwW7c0V/r8Y4=
Date:   Tue, 13 Aug 2019 08:13:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suji Velupillai <suji.velupillai@broadcom.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Serial to shared memory
Message-ID: <20190813061353.GI6670@kroah.com>
References: <CAJHBTCAiUoRwXq=ZNKfSKbdoAXCe8KSiqcL3iv510jseB8s6mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHBTCAiUoRwXq=ZNKfSKbdoAXCe8KSiqcL3iv510jseB8s6mA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 12, 2019 at 05:14:19PM -0700, Suji Velupillai wrote:
> Hello,
> 
> We have client which is running Linux and it is connected to host over
> PCIe. Both shares PCIe bar space as shared memory. Currently we only
> have one UART for debug, but this can't be used by the client, thus we
> need a virtual serial console running on a client side, which can
> read/write from PCIe mapped shared memory. The host can open the tty
> port seamlessly for communication.
> 
> I looked into the kernel tty/serial/ tree, and did not find any sample
> one. Is there a sample code?

Not for just this single thing, but there are a number of existing
busses and implementations that communicate across PCIe shared memory
between systems.  I suggest looking into them.

good luck!

greg k-h
