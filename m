Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83437AC764
	for <lists+linux-serial@lfdr.de>; Sat,  7 Sep 2019 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404454AbfIGPxu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 7 Sep 2019 11:53:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:4617 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390029AbfIGPxt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 7 Sep 2019 11:53:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 08:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,477,1559545200"; 
   d="scan'208";a="188599567"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 07 Sep 2019 08:53:44 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6d1y-0007J6-7D; Sat, 07 Sep 2019 18:53:42 +0300
Date:   Sat, 7 Sep 2019 18:53:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] 8250_lpss: check null return when calling
 pci_ioremap_bar
Message-ID: <20190907155342.GG2680@smile.fi.intel.com>
References: <20190726115746.GT9224@smile.fi.intel.com>
 <20190726195345.30294-1-navid.emamdoost@gmail.com>
 <CAEkB2ERhxLj7ogoy1E3j8d4MyEZqroWS1tPRxyJXR2oLhNz+LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkB2ERhxLj7ogoy1E3j8d4MyEZqroWS1tPRxyJXR2oLhNz+LQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 06, 2019 at 05:32:39PM -0500, Navid Emamdoost wrote:

> I was wondering is anyone reviewing this patch?
> https://lore.kernel.org/patchwork/patch/1106267/

Why?

The one below is a part of upstraem

commit f5d6aadf3b6434f11393e33be9fd25a56d0bc872
Author: Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Fri Jul 19 12:48:45 2019 -0500

    8250_lpss: check null return when calling pci_ioremap_bar

-- 
With Best Regards,
Andy Shevchenko


