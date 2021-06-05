Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE339CA0C
	for <lists+linux-serial@lfdr.de>; Sat,  5 Jun 2021 19:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFERFu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 5 Jun 2021 13:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:32888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFERFu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 5 Jun 2021 13:05:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3C8961358;
        Sat,  5 Jun 2021 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622912642;
        bh=+V4uKwJL+ZCJUWxhuytpSh+gH08F8MVBtRwrWr7rwb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7X35gnanHm3FN7rpIPp9eRPjoHZH6d3ryKfONVHieWqKC7Vbx+qoBh4aDOts+iO7
         7cdmoaIQQ0HqD8mNQtQR9q5w5bzNV4GYzRs3oqPuMeU5pptVb/xRrfGj7teSxJfvq+
         0fUvy8fLS2WT49D929xzUc5THNEllpRsUlyM+6gI=
Date:   Sat, 5 Jun 2021 19:03:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: jsm: allocate queue buffer at probe time
Message-ID: <YLuufbiZSchCzMQ2@kroah.com>
References: <1622906616-19696-1-git-send-email-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622906616-19696-1-git-send-email-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jun 05, 2021 at 03:23:36PM +0000, Zheyu Ma wrote:
> In function 'neo_intr', the driver uses 'ch->ch_equeue' and
> 'ch->ch_reuque'. These two pointers are initialized in 'jsm_tty_open',
> but the interrupt handler 'neo_intr' has been registered in the probe
> progress. If 'jsm_tty_open' has not been called at this time, it will
> cause null pointer dereference.
> 
> Once the driver registers the interrupt handler, the driver should be
> ready to handle it.
> 
> Fix this by allocating the memory at probe time and not at open time.
> 
> This log reveals it:
> 
> [   50.934983] BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> [   50.938297] #PF: supervisor write access in kernel mode
> [   50.940075] #PF: error_code(0x0002) - not-present page
> [   50.940460] PGD 0 P4D 0
> [   50.940654] Oops: 0002 [#1] PREEMPT SMP PTI
> [   50.940967] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
> 5.12.4-g70e7f0549188-dirty #97
> [   50.941554] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   50.942419] RIP: 0010:memcpy_fromio+0x75/0xa0
> [   50.942759] Code: e9 02 f3 a5 41 f6 c5 02 74 02 66 a5 41 f6 c5 01 74
> 01 a4 e8 5d 93 6b ff 5b 41 5c 41 5d 5d c3 e8 51 93 6b ff 4c 89 e7 48 89
> de <a4> 49 89 fc 48 89 f3 49 83 ed 01 eb a4 e8 39 93 6b ff 4c 89 e7 48
> [   50.944158] RSP: 0018:ffffc90000118df8 EFLAGS: 00010046
> [   50.944559] RAX: ffff888100258000 RBX: ffffc90007f0030f
> RCX: 0000000000000000
> [   50.945114] RDX: 0000000000000000 RSI: ffffc90007f0030f
> RDI: 0000000000000000
> [   50.945652] RBP: ffffc90000118e10 R08: 0000000000000000
> R09: 0000000000000000
> [   50.946192] R10: 0000000000000000 R11: 0000000000000001
> R12: 0000000000000000
> [   50.946729] R13: 0000000000000001 R14: 0000000007f0021e
> R15: 0000000000000000
> [   50.947279] FS:  0000000000000000(0000) GS:ffff88817bc80000(0000)
> knlGS:0000000000000000
> [   50.947912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   50.948346] CR2: 0000000000000000 CR3: 0000000107950000
> CR4: 00000000000006e0
> [   50.948892] DR0: 0000000000000000 DR1: 0000000000000000
> DR2: 0000000000000000
> [   50.949429] DR3: 0000000000000000 DR6: 00000000fffe0ff0
> DR7: 0000000000000400

Please do not line-wrap these types of lines.

> [   50.949950] Call Trace:
> [   50.950138]  <IRQ>
> [   50.950292]  neo_copy_data_from_uart_to_queue+0x2f7/0x4e0
> [   50.950694]  neo_intr+0x253/0x7a0
> [   50.950975]  __handle_irq_event_percpu+0x53/0x3e0
> [   50.951352]  handle_irq_event_percpu+0x35/0x90
> [   50.951706]  handle_irq_event+0x39/0x60
> [   50.951999]  handle_fasteoi_irq+0xc2/0x1d0
> [   50.952319]  __common_interrupt+0x7f/0x150
> [   50.952638]  common_interrupt+0xb4/0xd0
> [   50.952954]  </IRQ>
> [   50.953136]  asm_common_interrupt+0x1e/0x40
> [   50.969513] Kernel panic - not syncing: Fatal exception in interrupt
> [   50.970151] Dumping ftrace buffer:
> [   50.970420]    (ftrace buffer empty)
> [   50.970693] Kernel Offset: disabled
> [   50.970968] Rebooting in 1 seconds..
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v2:
>     - Allocate the memory at probe time, instead of simply checking whether it
>     is a null pointer.
> ---
>  drivers/tty/serial/jsm/jsm_tty.c | 64 +++++++++++++-------------------
>  1 file changed, 26 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
> index 8e42a7682c63..1c77c982daaf 100644
> --- a/drivers/tty/serial/jsm/jsm_tty.c
> +++ b/drivers/tty/serial/jsm/jsm_tty.c
> @@ -195,44 +195,6 @@ static int jsm_tty_open(struct uart_port *port)
>  	/* Get board pointer from our array of majors we have allocated */
>  	brd = channel->ch_bd;
>  
> -	/*
> -	 * Allocate channel buffers for read/write/error.
> -	 * Set flag, so we don't get trounced on.
> -	 */
> -	channel->ch_flags |= (CH_OPENING);
> -
> -	/* Drop locks, as malloc with GFP_KERNEL can sleep */
> -
> -	if (!channel->ch_rqueue) {
> -		channel->ch_rqueue = kzalloc(RQUEUESIZE, GFP_KERNEL);
> -		if (!channel->ch_rqueue) {
> -			jsm_dbg(INIT, &channel->ch_bd->pci_dev,
> -				"unable to allocate read queue buf\n");
> -			return -ENOMEM;
> -		}
> -	}
> -	if (!channel->ch_equeue) {
> -		channel->ch_equeue = kzalloc(EQUEUESIZE, GFP_KERNEL);
> -		if (!channel->ch_equeue) {
> -			jsm_dbg(INIT, &channel->ch_bd->pci_dev,
> -				"unable to allocate error queue buf\n");
> -			return -ENOMEM;
> -		}
> -	}
> -
> -	channel->ch_flags &= ~(CH_OPENING);
> -	/*
> -	 * Initialize if neither terminal is open.
> -	 */
> -	jsm_dbg(OPEN, &channel->ch_bd->pci_dev,
> -		"jsm_open: initializing channel in open...\n");
> -
> -	/*
> -	 * Flush input queues.
> -	 */
> -	channel->ch_r_head = channel->ch_r_tail = 0;
> -	channel->ch_e_head = channel->ch_e_tail = 0;
> -
>  	brd->bd_ops->flush_uart_write(channel);
>  	brd->bd_ops->flush_uart_read(channel);
>  
> @@ -420,6 +382,32 @@ int jsm_tty_init(struct jsm_board *brd)
>  		ch->ch_close_delay = 250;
>  
>  		init_waitqueue_head(&ch->ch_flags_wait);
> +
> +		/*
> +		 * Allocate channel buffers for read/write/error.
> +		 * Set flag, so we don't get trounced on.
> +		 */
> +		ch->ch_flags |= (CH_OPENING);

But you are not opening the device at this point in time.

Did you test this?


> +
> +		/* Drop locks, as malloc with GFP_KERNEL can sleep */

What locks got dropped?

> +
> +		if (!ch->ch_rqueue) {
> +			ch->ch_rqueue = kzalloc(RQUEUESIZE, GFP_KERNEL);
> +			if (!ch->ch_rqueue)
> +				return -ENOMEM;
> +		}
> +		if (!ch->ch_equeue) {
> +			ch->ch_equeue = kzalloc(EQUEUESIZE, GFP_KERNEL);
> +			if (!ch->ch_equeue)
> +				return -ENOMEM;
> +		}
> +
> +		ch->ch_flags &= ~(CH_OPENING);

Again, you are not opening right now.

> +		/*
> +		 * Flush input queues.
> +		 */
> +		ch->ch_r_head = ch->ch_r_tail = 0;
> +		ch->ch_e_head = ch->ch_e_tail = 0;

Are you sure this is ok for probe time?

thanks,

greg k-h
