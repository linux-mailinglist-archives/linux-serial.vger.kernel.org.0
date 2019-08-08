Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA7862D2
	for <lists+linux-serial@lfdr.de>; Thu,  8 Aug 2019 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbfHHNQ3 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 8 Aug 2019 09:16:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:28168 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732808AbfHHNQ3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Aug 2019 09:16:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 06:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="193155359"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 Aug 2019 06:16:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Aug 2019 16:16:25 +0300
Date:   Thu, 8 Aug 2019 16:16:25 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/9] serial: 8250_dw: use pointer to uart local
 variable
Message-ID: <20190808131625.GA8938@kuha.fi.intel.com>
References: <20190806094322.64987-1-andriy.shevchenko@linux.intel.com>
 <20190806094322.64987-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806094322.64987-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 06, 2019 at 12:43:15PM +0300, Andy Shevchenko wrote:
> The use of pointer will simplify enabling runtime PM for the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/tty/serial/8250/8250_dw.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 7b559f969f61..010d0a292e73 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -492,10 +492,10 @@ static void dw8250_setup_port(struct uart_port *p)
>  
>  static int dw8250_probe(struct platform_device *pdev)
>  {
> -	struct uart_8250_port uart = {};
> +	struct uart_8250_port uart = {}, *up = &uart;
>  	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	int irq = platform_get_irq(pdev, 0);
> -	struct uart_port *p = &uart.port;
> +	struct uart_port *p = &up->port;
>  	struct device *dev = &pdev->dev;
>  	struct dw8250_data *data;
>  	int err;
> @@ -634,10 +634,10 @@ static int dw8250_probe(struct platform_device *pdev)
>  	if (p->fifosize) {
>  		data->dma.rxconf.src_maxburst = p->fifosize / 4;
>  		data->dma.txconf.dst_maxburst = p->fifosize / 4;
> -		uart.dma = &data->dma;
> +		up->dma = &data->dma;
>  	}
>  
> -	data->line = serial8250_register_8250_port(&uart);
> +	data->line = serial8250_register_8250_port(up);
>  	if (data->line < 0) {
>  		err = data->line;
>  		goto err_reset;
> -- 
> 2.20.1

-- 
heikki
