Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC097C9DE
	for <lists+linux-serial@lfdr.de>; Wed, 31 Jul 2019 19:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfGaRFQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 31 Jul 2019 13:05:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:16919 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfGaRFP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Jul 2019 13:05:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 10:05:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="172514936"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jul 2019 10:05:14 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hss2J-0002PA-PC; Wed, 31 Jul 2019 20:05:11 +0300
Date:   Wed, 31 Jul 2019 20:05:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Aaron Sierra <asierra@xes-inc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Subject: Re: [PATCH v3] serial: 8250_exar: Move the Exar bits out from
 8250_port
Message-ID: <20190731170511.GQ23480@smile.fi.intel.com>
References: <20190721142659.60773-1-andriy.shevchenko@linux.intel.com>
 <1785128142.57495.1564351929356.JavaMail.zimbra@xes-inc.com>
 <20190729120059.GD23480@smile.fi.intel.com>
 <708985591.123086.1564413111128.JavaMail.zimbra@xes-inc.com>
 <20190730090159.GH23480@smile.fi.intel.com>
 <1516192036.531051.1564527522157.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516192036.531051.1564527522157.JavaMail.zimbra@xes-inc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 30, 2019 at 05:58:42PM -0500, Aaron Sierra wrote:

> Sure, I can do that. You're saying that you'd submit a patch for the INT0
> removal as the last patch in your series?

I meant to add to the bunch, but since I'm about to send a new version and
didn't see anything from you it can be sent separately with dependency
reference.

-- 
With Best Regards,
Andy Shevchenko


