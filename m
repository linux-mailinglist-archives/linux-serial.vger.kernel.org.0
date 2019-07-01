Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3577834DE8
	for <lists+linux-serial@lfdr.de>; Tue,  4 Jun 2019 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfFDQqC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 4 Jun 2019 12:46:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:20093 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfFDQqC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jun 2019 12:46:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 09:46:01 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga004.jf.intel.com with ESMTP; 04 Jun 2019 09:45:58 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hYCZS-00015a-5N; Tue, 04 Jun 2019 19:45:58 +0300
Date:   Tue, 4 Jun 2019 19:45:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2 v4] serial: mctrl_gpio: Check if GPIO property
 exisits before requesting it
Message-ID: <20190604164558.GO9224@smile.fi.intel.com>
References: <20190603083332.12480-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603083332.12480-1-sr@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 03, 2019 at 10:33:31AM +0200, Stefan Roese wrote:
> This patch adds a check for the GPIOs property existence, before the
> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> support is added (2nd patch in this patch series) on x86 platforms using
> ACPI.

>  	for (i = 0; i < UART_GPIO_MAX; i++) {
>  		enum gpiod_flags flags;
> +		char *gpio_str;
> +
> +		/* Check if GPIO property exists and continue if not */
> +		gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
> +				     mctrl_gpios_desc[i].name);
> +		if (!device_property_present(dev, gpio_str)) {
> +			kfree(gpio_str);
> +			continue;
> +		}
> +		kfree(gpio_str);

Can we rather do something like

	bool present;


	... = kasprintf(...);
// (1)
	present = device_property_present(...);
	kfree(...);
	if (!present)
		continue;

?

On top of this, if gpio_str is NULL, we will have KABOOM.

Something like

	if (!gpio_str)
		continue;

in (1).

>  
>  		if (mctrl_gpios_desc[i].dir_out)
>  			flags = GPIOD_OUT_LOW;

-- 
With Best Regards,
Andy Shevchenko


