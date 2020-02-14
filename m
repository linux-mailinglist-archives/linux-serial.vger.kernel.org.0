Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27BE15F75D
	for <lists+linux-serial@lfdr.de>; Fri, 14 Feb 2020 21:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbgBNUCi (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 14 Feb 2020 15:02:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389136AbgBNUCi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 15:02:38 -0500
Received: from localhost (unknown [12.246.51.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ADDB206D7;
        Fri, 14 Feb 2020 20:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581710557;
        bh=RVEMlwToQEeJOI4WJs70xB0FXNBHV/POQoK8OinCRCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dwEmMplSpvaQ3H8ghJufswXeBNuOPd4AgCEF4y0LfOlUr+aCwZbGsQ7XDcQCOGM0u
         jqKyI+7XkOcKahtfVMfyBQrzZmwLgBbLEOcE6wn4JwFCpgrKD60jU+8Pn3QZPyxYaV
         VZKV2kNAo1GVhggnerV2u+WimlxczAVEXezseXlc=
Date:   Fri, 14 Feb 2020 08:33:25 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/8] serial: Disable DMA and PM on kernel console
Message-ID: <20200214163325.GA3992427@kroah.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 14, 2020 at 01:43:31PM +0200, Andy Shevchenko wrote:
> This is second attempt [1] to get rid of problematic DMA and PM calls
> in the serial kernel console code.
> 
> Kernel console is sensitive to any kind of complex work needed to print
> out anything on it. One such case is emergency print during Oops.
> 
> Patches 1-3 are preparatory ones.

I've applied these first 3, as they are "obvious" :)

I'll let others weigh in on the other patches here, as I'd like to see
if Tony and others feel it solves their issues or not.

thanks,

greg k-h
