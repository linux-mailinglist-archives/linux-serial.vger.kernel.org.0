Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C640E3C702
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 11:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403786AbfFKJHq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 05:07:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51027 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404078AbfFKJHq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 05:07:46 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hackq-0002ra-Mf; Tue, 11 Jun 2019 11:07:44 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hackp-0007aR-Je; Tue, 11 Jun 2019 11:07:43 +0200
Date:   Tue, 11 Jun 2019 11:07:43 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH RFC] serial: imx: fix locking in set_termios()
Message-ID: <20190611090743.lkuiuvsd2hsmhcmc@pengutronix.de>
References: <1559807977-4598-1-git-send-email-sorganov@gmail.com>
 <20190611071024.xpnxrx7sdys43hnf@pengutronix.de>
 <87ef40tw1r.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ef40tw1r.fsf@osv.gnss.ru>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Sergey,

On Tue, Jun 11, 2019 at 10:34:24AM +0300, Sergey Organov wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >> index dff75dc..cb95ff71 100644
> >> --- a/drivers/tty/serial/imx.c
> >> +++ b/drivers/tty/serial/imx.c
> >> @@ -1550,6 +1550,20 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
> >>  		old_csize = CS8;
> >>  	}
> >>  
> >> +	del_timer_sync(&sport->timer);
> >> +
> >> +	/*
> >> +	 * Ask the core to calculate the divisor for us.
> >> +	 */
> >> +	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
> >> +	quot = uart_get_divisor(port, baud);
> >> +
> >> +	/*
> >> +	 * Take port lock before imx_uart_rts_*() calls, as they change
> >> +	 * sport->port.mctrl
> >> +	 */
> >> +	spin_lock_irqsave(&sport->port.lock, flags);
> >> +
> >
> > You can move this block a bit down (and so grab the lock later). The
> > check for CSIZE doesn't need protection.
> 
> I considered it, but decided putting lock inside UCR2 initialization
> sequence would negatively affect readability of the code. OTOH, 2-3 more
> asm instructions under the lock shouldn't be a big deal, right?

It seems I wasn't affected by the reduced readability. But I don't care
much, so if you prefer it that way, keep it as is.

> In addition, I've got further patches on top of this one, and there I
> need to read-modify-write the UCR2, so I need to take the lock before
> taking initial value.
> 
> I'll move the lock down in this patch if you still think it's worth it.
> 
> > Assuming you respin: Several functions are annotated to have to be
> > called with the lock taken; I would put the comment to imx_uart_rts_* in
> > the same way, instead of in imx_uart_set_termios.
> 
> Yeah, I will. I assume you mean
> 
> /* called with port.lock taken and irqs off */ 
> 
> comment? The "and irqs off" part doesn't seem to be true for calls from
> set_termios() though, so I'd need to get rid of it for these new
> comments, right?

Sometimes the settermios callback is called with irqs disabled, at least
that's what Documentation/serial/driver.rst claims. I think this needs
fixing.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
