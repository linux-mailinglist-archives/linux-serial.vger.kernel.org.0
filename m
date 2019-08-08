Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F5F86310
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 15:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbfHHN0B (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 09:26:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:23513 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732643AbfHHN0B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 09:26:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 06:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="193156376"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 Aug 2019 06:25:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Aug 2019 16:25:57 +0300
Date:   Thu, 8 Aug 2019 16:25:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 8/9] serial: 8250_lpss: Get rid of custom
 LPSS_DEVICE() macro
Message-ID: <20190808132557.GG8938@kuha.fi.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
 <20190806094322.64987-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806094322.64987-8-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 06, 2019 at 12:43:21PM +0300, Andy Shevchenko wrote:
> Since PCI core provides a generic PCI_DEVICE_DATA() macro,
> replace LPSS_DEVICE() with former one.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/tty/serial/8250/8250_lpss.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 2bb30e688433..cfe0ab443250 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -356,17 +356,15 @@ static const struct lpss8250_board qrk_board = {
>  	.exit = qrk_serial_exit,
>  };
>  
> -#define LPSS_DEVICE(id, board) { PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&board }
> -
>  static const struct pci_device_id pci_ids[] = {
> -	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_QRK_UARTx, qrk_board),
> -	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BYT_UART1, byt_board),
> -	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BYT_UART2, byt_board),
> -	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BSW_UART1, byt_board),
> -	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BSW_UART2, byt_board),
> -	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BDW_UART1, byt_board),
> -	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BDW_UART2, byt_board),
> -	{ },
> +	{ PCI_DEVICE_DATA(INTEL, QRK_UARTx, &qrk_board) },
> +	{ PCI_DEVICE_DATA(INTEL, BYT_UART1, &byt_board) },
> +	{ PCI_DEVICE_DATA(INTEL, BYT_UART2, &byt_board) },
> +	{ PCI_DEVICE_DATA(INTEL, BSW_UART1, &byt_board) },
> +	{ PCI_DEVICE_DATA(INTEL, BSW_UART2, &byt_board) },
> +	{ PCI_DEVICE_DATA(INTEL, BDW_UART1, &byt_board) },
> +	{ PCI_DEVICE_DATA(INTEL, BDW_UART2, &byt_board) },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, pci_ids);
>  
> -- 
> 2.20.1

-- 
heikki
