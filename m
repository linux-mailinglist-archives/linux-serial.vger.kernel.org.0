Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1572D84CC7
	for <lists+linux-serial@lfdr.de>; Wed,  7 Aug 2019 15:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfHGNVC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 7 Aug 2019 09:21:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:20092 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388079AbfHGNVC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Aug 2019 09:21:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 06:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="374406771"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2019 06:20:58 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hvLs8-0002b6-FI; Wed, 07 Aug 2019 16:20:56 +0300
Date:   Wed, 7 Aug 2019 16:20:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Subject: Re: [PATCH 2/5] serial: lantiq: Use proper DT compatible string
Message-ID: <20190807132056.GX30120@smile.fi.intel.com>
References: <cover.1565160764.git.rahul.tanwar@linux.intel.com>
 <12c3029f406ca1fedf14154154f7082e358f0473.1565160764.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c3029f406ca1fedf14154154f7082e358f0473.1565160764.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 07, 2019 at 05:21:32PM +0800, Rahul Tanwar wrote:
> The patch adds change to use explicit string instead of a macro for
> DT compatible string.

For consistency you may need to convert OF_EARLYCON_DECLARE() as well.

Perhaps commit message should explain the rationale, i.e. the following patches
will add another compatible string and thus it makes sense to have them
explicitly mentioned.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/tty/serial/lantiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 42e27b48e9cc..1116261c973e 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -792,7 +792,7 @@ lqasc_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id ltq_asc_match[] = {
> -	{ .compatible = DRVNAME },
> +	{ .compatible = "lantiq,asc" },
>  	{},
>  };
>  
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko


