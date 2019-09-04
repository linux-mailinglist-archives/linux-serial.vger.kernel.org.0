Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00815A7CAC
	for <lists+linux-serial@lfdr.de>; Wed,  4 Sep 2019 09:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfIDHWK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 4 Sep 2019 03:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfIDHWK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Sep 2019 03:22:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9E9A2339D;
        Wed,  4 Sep 2019 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567581729;
        bh=/k6hqNoFUppn3++Ml5qNUf7m5FLMRWZkY6VgoWUQV9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iE4vcZxdAuhyhLVUt9bk9Adcli31F9tdkFIcCfiVZw2f0ojeYAFGHNX2Bpk1SUdh/
         B9q51o+kYpm/18qB63ln7EtWyDfwHPzmpOXnJmylLIw6fq3Jm0UuVE2AW7tnZjU/hL
         bwRRLekaU9/kxI49EoqrLEDd8s8RAUWVgwRffmgQ=
Date:   Wed, 4 Sep 2019 09:22:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        jailhouse-dev@googlegroups.com, Jay Dolan <jay.dolan@accesio.com>
Subject: Re: [PATCH] serial: 8250_pci: Implement MSI(-X) support
Message-ID: <20190904072206.GA30185@kroah.com>
References: <20190812112152.693622-1-ralf.ramsauer@oth-regensburg.de>
 <740fc1e7-fb3d-c0c7-c17b-2ea3a8864d89@oth-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <740fc1e7-fb3d-c0c7-c17b-2ea3a8864d89@oth-regensburg.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 30, 2019 at 12:33:09AM +0200, Ralf Ramsauer wrote:
> *ping* :)
> 
> On 8/12/19 1:21 PM, Ralf Ramsauer wrote:
> > There may be setups, where legacy interrupts are not available. This is
> > the caese, e.g., when Linux runs as guest (aka. non-root cell) of the
> > partitioning hypervisor Jailhouse. There, only MSI(-X) interrupts are
> > available for guests.
> > 
> > But the 8250_pci driver currently only supports legacy ints. So let's
> > enable MSI(-X) interrupts.
> > 
> > Nevertheless, this needs to handled with care: while many 8250 devices
> > actually claim to support MSI(-X) interrupts it should not be enabled be
> > default. I had at least one device in my hands with broken MSI
> > implementation.
> > 
> > So better introduce a whitelist with devices that are known to support
> > MSI(-X) interrupts. I tested all devices mentioned in the patch.
> > 
> > Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>

Ok, will queue this up, let's see what breaks :)

