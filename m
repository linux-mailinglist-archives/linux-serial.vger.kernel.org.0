Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A33BE23B
	for <lists+linux-serial@lfdr.de>; Wed, 25 Sep 2019 18:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502017AbfIYQRV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 25 Sep 2019 12:17:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:4914 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501946AbfIYQRV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Sep 2019 12:17:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 09:17:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="203636618"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 25 Sep 2019 09:17:10 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iD9yY-0007H7-2E; Wed, 25 Sep 2019 19:17:10 +0300
Date:   Wed, 25 Sep 2019 19:17:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1] serial: 8250_dw: Use devm_clk_get_optional() to get
 the input clock
Message-ID: <20190925161710.GW5933@smile.fi.intel.com>
References: <20190925161155.55735-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925161155.55735-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 25, 2019 at 07:11:55PM +0300, Andy Shevchenko wrote:
> Simplify the code which fetches the input clock by using
> devm_clk_get_optional(). This comes with a small functional change: previously
> all errors were ignored except deferred probe. Now all errors are
> treated as errors. If no input clock is present devm_clk_get_optional() will
> return NULL instead of an error which matches the behavior of the old code.

Please, ignore this one, it will break the systems where more than one clock
defined.

-- 
With Best Regards,
Andy Shevchenko


