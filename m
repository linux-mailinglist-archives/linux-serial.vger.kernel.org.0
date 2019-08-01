Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631EC7DE82
	for <lists+linux-serial@lfdr.de>; Thu,  1 Aug 2019 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfHAPMG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 1 Aug 2019 11:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbfHAPMF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Aug 2019 11:12:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33BE206B8;
        Thu,  1 Aug 2019 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564672325;
        bh=Ic5iqDoAqfcWirJY/0YZF55fRUiswE0+4gbzSTJUdIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6SvSbKcgAtb70BEB67Hqok+5QSefhpBR3l3B7l/4/Pg/zjAk6VbDaNHoUpvDf3rZ
         /HEPuzux820piLbox02gNiJaAz89phsyQXyLtozIs0kbg26TWP5t39gDoDOhpXC4DF
         3Kq39goFzyq8fypOcBwUzo0OaVaAd5SM3YuzZtzE=
Date:   Thu, 1 Aug 2019 17:12:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aaron Sierra <asierra@xes-inc.com>
Cc:     linux-serial@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_exar: Absorb remaining 8250_port INT0
 support
Message-ID: <20190801151202.GA24347@kroah.com>
References: <20190731174545.8192-1-asierra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731174545.8192-1-asierra@xes-inc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 31, 2019 at 12:45:45PM -0500, Aaron Sierra wrote:
> Move INT0 clearing out of common, per-port serial8250_do_startup()
> into PCI device probe/resume.
> 
> As described in commit 2c0ac5b48a35 ("serial: exar: Fix stuck MSIs"),
> the purpose of clearing INT0 is to prevent the PCI interrupt line from
> becoming stuck asserted, "which is fatal with edge-triggered MSIs".
> 
> Like the clearing via interrupt handler that moved from common code in
> commit c7e1b4059075 ("tty: serial: exar: Relocate sleep wake-up
> handling"), this clearing at startup can be better handled at the PCI
> device level.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> The embedded patch is written to follow this patch from Andy Shevchenko:
> [PATCH v4 3/3] serial: 8250_exar: Move custom divisor support out from 8250_port

It does not apply to my tree after that patch, are you sure about this?

Please rebase against my tty-testing branch and resend.

thanks,

greg k-h
