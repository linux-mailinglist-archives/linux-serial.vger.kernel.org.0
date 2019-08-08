Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15B186314
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbfHHN0S (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 09:26:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:6779 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732643AbfHHN0S (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 09:26:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 06:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="193156426"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 Aug 2019 06:26:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Aug 2019 16:26:14 +0300
Date:   Thu, 8 Aug 2019 16:26:14 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 9/9] serial: 8250_lpss: Enable HS UART on Elkhart Lake
Message-ID: <20190808132614.GH8938@kuha.fi.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
 <20190806094322.64987-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806094322.64987-9-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 06, 2019 at 12:43:22PM +0300, Andy Shevchenko wrote:
> Intel Elkhart Lake may use High Speed UART from OSE IP block.
> This is different to what we have in main LPSS, though compatible
> with older version of it, which is handled by this driver.
> 
> Enable OSE HS UART on Intel Elkhart Lake by adding PCI IDs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/tty/serial/8250/8250_lpss.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index cfe0ab443250..5f72ef3ea574 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -24,6 +24,13 @@
>  #define PCI_DEVICE_ID_INTEL_BSW_UART1	0x228a
>  #define PCI_DEVICE_ID_INTEL_BSW_UART2	0x228c
>  
> +#define PCI_DEVICE_ID_INTEL_EHL_UART0	0x4b96
> +#define PCI_DEVICE_ID_INTEL_EHL_UART1	0x4b97
> +#define PCI_DEVICE_ID_INTEL_EHL_UART2	0x4b98
> +#define PCI_DEVICE_ID_INTEL_EHL_UART3	0x4b99
> +#define PCI_DEVICE_ID_INTEL_EHL_UART4	0x4b9a
> +#define PCI_DEVICE_ID_INTEL_EHL_UART5	0x4b9b
> +
>  #define PCI_DEVICE_ID_INTEL_BDW_UART1	0x9ce3
>  #define PCI_DEVICE_ID_INTEL_BDW_UART2	0x9ce4
>  
> @@ -349,6 +356,11 @@ static const struct lpss8250_board byt_board = {
>  	.setup = byt_serial_setup,
>  };
>  
> +static const struct lpss8250_board ehl_board = {
> +	.freq = 200000000,
> +	.base_baud = 12500000,
> +};
> +
>  static const struct lpss8250_board qrk_board = {
>  	.freq = 44236800,
>  	.base_baud = 2764800,
> @@ -358,6 +370,12 @@ static const struct lpss8250_board qrk_board = {
>  
>  static const struct pci_device_id pci_ids[] = {
>  	{ PCI_DEVICE_DATA(INTEL, QRK_UARTx, &qrk_board) },
> +	{ PCI_DEVICE_DATA(INTEL, EHL_UART0, &ehl_board) },
> +	{ PCI_DEVICE_DATA(INTEL, EHL_UART1, &ehl_board) },
> +	{ PCI_DEVICE_DATA(INTEL, EHL_UART2, &ehl_board) },
> +	{ PCI_DEVICE_DATA(INTEL, EHL_UART3, &ehl_board) },
> +	{ PCI_DEVICE_DATA(INTEL, EHL_UART4, &ehl_board) },
> +	{ PCI_DEVICE_DATA(INTEL, EHL_UART5, &ehl_board) },
>  	{ PCI_DEVICE_DATA(INTEL, BYT_UART1, &byt_board) },
>  	{ PCI_DEVICE_DATA(INTEL, BYT_UART2, &byt_board) },
>  	{ PCI_DEVICE_DATA(INTEL, BSW_UART1, &byt_board) },
> -- 
> 2.20.1

-- 
heikki
