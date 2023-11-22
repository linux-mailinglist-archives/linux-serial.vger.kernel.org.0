Return-Path: <linux-serial+bounces-153-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA27F50D3
	for <lists+linux-serial@lfdr.de>; Wed, 22 Nov 2023 20:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30482817C1
	for <lists+linux-serial@lfdr.de>; Wed, 22 Nov 2023 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746CB5E0BC;
	Wed, 22 Nov 2023 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="mRehwylA"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526C81990;
	Wed, 22 Nov 2023 11:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=nnReJhtIcwOcFZeVn/VC0p9TnG4qk2MuKVj6f7dJ0tA=; b=mRehwylAmHADJsSc6Nrnp3zhM1
	DhODm3bYwDRmtW/qcPicRA61nZAqpl1+4aC/kpuyf3rIZYMk6JQkZTBR3nLvFei6ZdzEe4RU9RS6Z
	58RBi9eszvdPxgg1dJvTJMUmr9b7uzwZ5AVGprmKT7lNHDZZx8beZNjHmZmJekMYYb0A=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:39316 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r5t21-0001bL-T2; Wed, 22 Nov 2023 14:37:07 -0500
Date: Wed, 22 Nov 2023 14:37:05 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Daniel Mack <daniel@zonque.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 lech.perczak@camlingroup.com, u.kleine-koenig@pengutronix.de,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Maxim Popov
 <maxim.snafu@gmail.com>, stable@vger.kernel.org
Message-Id: <20231122143705.ecb6cd9a9ff6dcca7a3397ed@hugovil.com>
In-Reply-To: <20231122073541.1200457-1-daniel@zonque.org>
References: <20231122073541.1200457-1-daniel@zonque.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: Re: [PATCH v4] serial: sc16is7xx: address RX timeout interrupt
 errata
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 22 Nov 2023 08:35:41 +0100
Daniel Mack <daniel@zonque.org> wrote:

> This device has a silicon bug that makes it report a timeout interrupt
> but no data in the FIFO.
> 
> The datasheet states the following in the errata section 18.1.4:
> 
>   "If the host reads the receive FIFO at the same time as a
>   time-out interrupt condition happens, the host might read 0xCC
>   (time-out) in the Interrupt Indication Register (IIR), but bit 0
>   of the Line Status Register (LSR) is not set (means there is no
>   data in the receive FIFO)."
> 
> The errata doesn't explicitly mention that, but tests have shown
> and the vendor has confirmed that the RXLVL register is equally
> affected.

Hi Daniel,
thank you for the feedback from NXP.

I would suggest to replace this paragraph with something like this:

------
The errata description seems to indicate it affects only polled mode of
operation when reading bit 0 of the LSR register. But when using
interrupt mode (IRQ) like this driver does, reading RXLVL gives a value
of zero even if there is data in the Rx FIFO (confirmed by tests and
NXP).
------

> This bug has hit us on production units and when it does, sc16is7xx_irq()
> would spin forever because sc16is7xx_port_irq() keeps seeing an
> interrupt in the IIR register that is not cleared because the driver
> does not call into sc16is7xx_handle_rx() unless the RXLVL register
> reports at least one byte in the FIFO.
> 
> Fix this by always reading one byte when this condition is detected

Change "reading one byte" to "reading one byte from the Rx FIFO".


> in order to clear the interrupt. This approach was confirmed to be
> correct by NXP through their support channels.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Co-Developed-by: Maxim Popov <maxim.snafu@gmail.com>
> Cc: stable@vger.kernel.org

I tested your patch for the last few days, and I was not able to
reproduce the problem (I put a trace to detect the condition). But
at the same time, it has not caused any regressions.

With the above changes, feel free to add:

Tested by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hugo.


> ---
> Meanwhile, NXP has confirmed this fix to be correct.
> 
> v4: NXP has confirmed the fix; update the commit log accordingly
> v3: re-added the additional Co-Developed-by and stable@ tags
> v2: reworded the commit log a bit for more context.
> 
>  drivers/tty/serial/sc16is7xx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 289ca7d4e566..76f76e510ed1 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -765,6 +765,18 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
>  		case SC16IS7XX_IIR_RTOI_SRC:
>  		case SC16IS7XX_IIR_XOFFI_SRC:
>  			rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
> +
> +			/*
> +			 * There is a silicon bug that makes the chip report a
> +			 * time-out interrupt but no data in the FIFO. This is
> +			 * described in errata section 18.1.4.
> +			 *
> +			 * When this happens, read one byte from the FIFO to
> +			 * clear the interrupt.
> +			 */
> +			if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
> +				rxlen = 1;
> +
>  			if (rxlen)
>  				sc16is7xx_handle_rx(port, rxlen, iir);
>  			break;
> -- 
> 2.41.0
> 
> 

