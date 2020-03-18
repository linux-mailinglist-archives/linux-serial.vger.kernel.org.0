Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30C189E26
	for <lists+linux-serial@lfdr.de>; Wed, 18 Mar 2020 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCROnV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 18 Mar 2020 10:43:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:1841 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbgCROnV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 10:43:21 -0400
IronPort-SDR: wup2s6ZvqxSvGEI4TAtd6zzDbKk8ff3By2COm+yvk6zd6OabwlotbbGO5fuNSYto52H5ZQV9Zq
 pGcyJUbB36BQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 07:43:20 -0700
IronPort-SDR: 1yy0BrLTbQOfTnMarUFSfbBqDMuYmioEEmM2OXOBDPxd12rjmA+jV4B+m86mAMfF7UObMkbhKI
 tfGS1nn2sVZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="291335984"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Mar 2020 07:43:18 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jEZui-00AmsZ-JP; Wed, 18 Mar 2020 16:43:20 +0200
Date:   Wed, 18 Mar 2020 16:43:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>, Lukas Wunner <lukas@wunner.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Message-ID: <20200318144320.GL1922688@smile.fi.intel.com>
References: <20200318142640.982763-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318142640.982763-1-heiko@sntech.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

+Cc: Lukas, who did recently some work WRT RS485 support in 8250.

On Wed, Mar 18, 2020 at 03:26:33PM +0100, Heiko Stuebner wrote:
> This series tries to revive the work of Giulio Benetti from 2018 [0]
> which seemed to have stalled at that time.
> 
> The board I needed that on also had the additional caveat that it
> uses non-standard pins for DE/RE so needed gpio mctrl layer as well
> and even more special needed to control the RE pin manually not as
> part of it being connected to the DE signal as seems to be the standard.
> 
> So I've marked the patch doing this as DTR pin as RFC but that patch
> isn't needed for the other core functionality, so could also be left out.

Thank you, I'll look at them later on.

> Changes from the 2018 submission include:
> - add timeout when waiting for fifos to clear using a new helper
> - move on-boot enablement of the rs485 mode to after registering
>   the port. This saves having to copy the em485 struct as done
>   originally, which also ran into spinlock-debug warnings when testing
>   and also makes it actually possible to use the mctrl gpio layer
>   for non-standard gpios.
> 
> [0] Link: https://lore.kernel.org/linux-serial/20180601124021.102970-1-giulio.benetti@micronovasrl.com/
> 
> Giulio Benetti (4):
>   serial: 8250: Make em485_rts_after_send() set mctrl according to rts
>     state.
>   serial: 8250: Handle case port doesn't have TEMT interrupt using
>     em485.
>   serial: 8250_dw: add em485 support
>   serial: 8250_dw: allow enable rs485 at boot time
> 
> Heiko Stuebner (3):
>   serial: 8250: add serial_in_poll_timeout helper
>   serial: 8250: Start rs485 after registering port if rs485 is enabled
>     in probe
>   serial: 8250: handle DTR in rs485 emulation
> 
>  drivers/tty/serial/8250/8250.h      | 36 ++++++++++++++++++++-
>  drivers/tty/serial/8250/8250_core.c |  9 ++++++
>  drivers/tty/serial/8250/8250_dw.c   | 35 +++++++++++++++++++-
>  drivers/tty/serial/8250/8250_of.c   |  2 +-
>  drivers/tty/serial/8250/8250_omap.c |  2 +-
>  drivers/tty/serial/8250/8250_port.c | 50 +++++++++++++++++++++++------
>  include/linux/serial_8250.h         |  1 +
>  7 files changed, 121 insertions(+), 14 deletions(-)
> 
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


