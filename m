Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D664D1801E4
	for <lists+linux-serial@lfdr.de>; Tue, 10 Mar 2020 16:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgCJPdI (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Mar 2020 11:33:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:61036 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgCJPdH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 11:33:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 08:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="441343060"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2020 08:33:05 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jBgsW-008Uor-AL; Tue, 10 Mar 2020 17:33:08 +0200
Date:   Tue, 10 Mar 2020 17:33:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 1/4] serial: core: Use string length for SysRq magic
 sequence
Message-ID: <20200310153308.GS1922688@smile.fi.intel.com>
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
 <64f650b7-8c39-4bef-f1d9-ff2720923c8c@gmail.com>
 <20200310145706.GQ1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310145706.GQ1922688@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 10, 2020 at 04:57:06PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 10, 2020 at 02:38:48PM +0000, Dmitry Safonov wrote:
> > On 3/10/20 1:20 PM, Andy Shevchenko wrote:

...

> > BTW, is this gcc 10 you see the warning with?
> > I have gcc (GCC) 9.2.0 and I don't see a warning with/without the config
> > string.
> 
> gcc (Debian 9.2.1-30) 9.2.1 20200224

I think it will be even on older versions.
I usually run build with `make O=... W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64`.

-- 
With Best Regards,
Andy Shevchenko


