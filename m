Return-Path: <linux-serial+bounces-1456-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF782AD91
	for <lists+linux-serial@lfdr.de>; Thu, 11 Jan 2024 12:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A82B27DDB
	for <lists+linux-serial@lfdr.de>; Thu, 11 Jan 2024 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EC4154B0;
	Thu, 11 Jan 2024 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/oKqtcD"
X-Original-To: linux-serial@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C8616430;
	Thu, 11 Jan 2024 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704972747; x=1736508747;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JMx2hOiNSzrCPV5QLRfEfnwiFNNKfNaqg0e3g2wmUf4=;
  b=e/oKqtcDoVm2Tqw+AALrkImWdtfdTeKmTUo3WebpTAlQfmuH9ylNm4tK
   rEGGYmm2W7llf3rADf9oANdxvnbk3By6WxRst6VvQ4aU67nWOwTuvzwmd
   SI4NqRs3bdlM85X431jya30G9VD+C0ZdctjHifAcWdnHTEM3LOiRG+hxh
   5lU3nkTNLPzDlpB2tB50jC5e6cdiGMW5BnF8z9b20FY6L4bOMWx/SJ1c9
   2kmdjuL7aUzdFwT3DHB8I0aISPbA2X365Df2UC9MrUXPu1E9RFXeBkhnG
   yIUk50ZqXJrKwqJPY8sS8JSFWBtp6QmtSnkxlT3SNCZoItpKmH6wZCmuH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="463106935"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="463106935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:32:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="732194638"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="732194638"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.201])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:32:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jan 2024 13:32:20 +0200 (EET)
To: Michael Pratt <mcpratt@pm.me>
cc: LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Wander Lairson Costa <wander@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 RESEND] serial: 8250: Set fifo timeout with
 uart_fifo_timeout()
In-Reply-To: <20240111002056.28205-1-mcpratt@pm.me>
Message-ID: <3cd108c6-8344-130f-9cbe-4d031c7e008c@linux.intel.com>
References: <20240111002056.28205-1-mcpratt@pm.me>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Jan 2024, Michael Pratt wrote:

> Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> reworked functions for basic 8250 and 16550 type serial devices
> in order to enable and use the internal FIFO device for buffering,
> however the default timeout of 10 ms remained, which is proving
> to be insufficient for low baud rates like 9600, causing data overrun.
> 
> Unforunately, that commit was written and accepted just before commit

Unfortunately,

-- 
 i.

> 31f6bd7fad3b ("serial: Store character timing information to uart_port")
> which introduced the frame_time member of the uart_port struct
> in order to store the amount of time it takes to send one UART frame
> relative to the baud rate and other serial port configuration,
> and commit f9008285bb69 ("serial: Drop timeout from uart_port")
> which established function uart_fifo_timeout() in order to
> calculate a reasonable timeout to wait for all frames
> in the FIFO device to flush before writing data again
> using the now stored frame_time value and size of the buffer.
> 
> Fix this by using the new function to calculate the timeout
> whenever the buffer is larger than 1 byte (unknown port default).
> 
> Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.
> 
> Signed-off-by: Michael Pratt <mcpratt@pm.me>
> ---
> v1 thread: https://lore.kernel.org/linux-serial/20231125063552.517-1-mcpratt@pm.me/
>  drivers/tty/serial/8250/8250_port.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 8ca061d3bbb9..777b61a79c5e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2076,7 +2076,10 @@ static void wait_for_lsr(struct uart_8250_port *up, int bits)
>  {
>  	unsigned int status, tmout = 10000;
>  
> -	/* Wait up to 10ms for the character(s) to be sent. */
> +	/* Wait for a time relative to buffer size and baud */
> +	if (up->port.fifosize > 1)
> +		tmout = jiffies_to_usecs(uart_fifo_timeout(&up->port));
> +
>  	for (;;) {
>  		status = serial_lsr_in(up);
>  
> 

