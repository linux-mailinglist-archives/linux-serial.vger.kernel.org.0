Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39D9AC794
	for <lists+linux-serial@lfdr.de>; Sat,  7 Sep 2019 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbfIGQQL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 7 Sep 2019 12:16:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:6315 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388253AbfIGQQL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 7 Sep 2019 12:16:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 09:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,477,1559545200"; 
   d="scan'208";a="383561334"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2019 09:16:07 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6dNf-0007V4-5c; Sat, 07 Sep 2019 19:16:07 +0300
Date:   Sat, 7 Sep 2019 19:16:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] 8250_lpss: check null return when calling
 pci_ioremap_bar
Message-ID: <20190907161607.GK2680@smile.fi.intel.com>
References: <20190726115746.GT9224@smile.fi.intel.com>
 <20190726195345.30294-1-navid.emamdoost@gmail.com>
 <CAEkB2ERhxLj7ogoy1E3j8d4MyEZqroWS1tPRxyJXR2oLhNz+LQ@mail.gmail.com>
 <20190907155342.GG2680@smile.fi.intel.com>
 <CAEkB2ET-SQFiBbroxDFEVrPxto6a2wLJf0NM7R=ERcPargr66Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkB2ET-SQFiBbroxDFEVrPxto6a2wLJf0NM7R=ERcPargr66Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Sep 07, 2019 at 11:06:29AM -0500, Navid Emamdoost wrote:
> Cool! I thought it is forgotten, as there were no response to the v3 of the
> patch.

Nevertheless, you may send a follow up, since one call to pci_iounmap() is
missed when dw_dma_probe() fails.

> Thanks for letting me know.

You're welcome.

-- 
With Best Regards,
Andy Shevchenko


