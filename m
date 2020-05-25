Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D05E1E1217
	for <lists+linux-serial@lfdr.de>; Mon, 25 May 2020 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391055AbgEYPwS (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 25 May 2020 11:52:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:52635 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391047AbgEYPwS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 11:52:18 -0400
IronPort-SDR: XRO/ixTEnycOVreFDtZVqjKfS3QIzaaQcbb22ri1VQSFI/FGIf5luaisT+t/YlZP6DxnlT7oAu
 +laqfgbUg5PA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 08:52:18 -0700
IronPort-SDR: QlIbhdvIzXDTfYaPgeIeYGFxa6PJqRmIvelfJIrVZV1UcneEfI9ArgLmDMNtgsWLGLePGP/isC
 WYnVA2NAJCOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="269796700"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2020 08:52:15 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdFOk-008orn-S2; Mon, 25 May 2020 18:52:18 +0300
Date:   Mon, 25 May 2020 18:52:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-serial@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1] serial: imx: Initialize lock for non-registered
 console
Message-ID: <20200525155218.GF1634618@smile.fi.intel.com>
References: <20200525105952.13744-1-andriy.shevchenko@linux.intel.com>
 <c5b1caca-32fc-1482-b4f5-71787b73a814@roeck-us.net>
 <20200525140752.GA910887@kroah.com>
 <20200525153418.GE1634618@smile.fi.intel.com>
 <20200525154107.GA1016976@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525154107.GA1016976@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 25, 2020 at 05:41:07PM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 25, 2020 at 06:34:18PM +0300, Andy Shevchenko wrote:
> > On Mon, May 25, 2020 at 04:07:52PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, May 25, 2020 at 07:01:13AM -0700, Guenter Roeck wrote:

...

> > > I'm with Guenter here, let's fix them all at once please.
> > 
> > Okay. Do you want series per driver or one for all?
> 
> one per driver is always easier to apply :)

Will do during this week. Please, apply this one as it's ready to go.

-- 
With Best Regards,
Andy Shevchenko


