Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5C9CDD06
	for <lists+linux-serial@lfdr.de>; Mon,  7 Oct 2019 10:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfJGIRb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 7 Oct 2019 04:17:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:25671 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfJGIRb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Oct 2019 04:17:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 01:17:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,265,1566889200"; 
   d="scan'208";a="217888752"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 07 Oct 2019 01:17:27 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iHOCs-00055M-Bw; Mon, 07 Oct 2019 11:17:26 +0300
Date:   Mon, 7 Oct 2019 11:17:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Adam Ford <aford173@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial 8250 DMA Broken on OMAP3630
Message-ID: <20191007081726.GK32742@smile.fi.intel.com>
References: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Oct 06, 2019 at 12:04:47PM -0500, Adam Ford wrote:

I think the best one who may shed a light is bigeasy@ (Cc'ed).

> Has anyone else had any issues using the CONFIG_SERIAL_8250_DMA on the OMAP?
> 
> I can use the DMA on the legacy, omap-serial driver, but when I enable
> the DMA on the 8250-omap driver, I get missing frames in Bluetooth.
> 
> The older driver seems to have an ISR that seems to address a variety
> of items compared to the very tiny ISR for 8250-omap.c.
> 
> I am not exactly sure where to start, but if someone has any
> suggestions on how I can troubleshoot, please let me know.  As of now,
> I have to disable CONFIG_SERIAL_8250_DMA to get the Bluetooth
> connected to UART2 operational on a DM3730 at 3,000,000 baud, but it
> appears to work just fine after some patches I just submitted for
> handling RTS/CTS.  The legacy omap-serial driver works fine with DMA.
> 
> adam

-- 
With Best Regards,
Andy Shevchenko


