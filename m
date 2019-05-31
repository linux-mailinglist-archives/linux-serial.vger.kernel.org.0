Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9C30807
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 07:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfEaFOe (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 01:14:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37297 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaFOe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 01:14:34 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWZs8-0008IX-Fl; Fri, 31 May 2019 07:14:32 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWZs6-0001gt-U8; Fri, 31 May 2019 07:14:30 +0200
Date:   Fri, 31 May 2019 07:14:30 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/8] serial: imx: fix DTR inversion
Message-ID: <20190531051430.yojydtk63vkuektg@pengutronix.de>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-2-sorganov@gmail.com>
 <20190530205313.uwue3q2t5tp2vwz6@pengutronix.de>
 <87ftovw7h8.fsf@javad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftovw7h8.fsf@javad.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 07:52:51AM +0300, Sergey Organov wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> 
> > On Thu, May 30, 2019 at 06:29:43PM +0300, Sergey Organov wrote:
> >> imx_set_mctrl() had TIOCM_DTR meaning inverted
> >> 
> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> ---
> >>  drivers/tty/serial/imx.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >> index dff75dc..e9e812a 100644
> >> --- a/drivers/tty/serial/imx.c
> >> +++ b/drivers/tty/serial/imx.c
> >> @@ -974,7 +974,7 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> >>  	}
> >>  
> >>  	ucr3 = imx_uart_readl(sport, UCR3) & ~UCR3_DSR;
> >> -	if (!(mctrl & TIOCM_DTR))
> >> +	if (mctrl & TIOCM_DTR)
> >>  		ucr3 |= UCR3_DSR;
> >>  	imx_uart_writel(sport, ucr3, UCR3);
> >
> > I'm not sure this is right and your commit log is too short to convince
> > me otherwise.
> >
> > In the past I had several customers that used handshaking on an imx UART
> > so I'd be surprised if such a bug would have stayed unnoticed until now.
> >
> > The i.MX25 Reference manual states:
> >
> > 	This bit [UCR3_DSR] used by software to control the DSR/DTR output pin
> > 	for the modem interface. In DCE mode it applies to DSR and in DTE mode
> > 	it applies to DTR.
> >
> > 		0 DSR/ DTR pin is logic zero
> > 		1 DSR/ DTR pin is logic one
> >
> >
> > Semantically if TIOCM_DTR is set in .set_mctrl, the DTR output should
> > become active (i.e. low). Without testing I'm not sure if "active"
> > corresponds to "logic one" which would make your patch correct.
> 
> Yeah, I was not sure myself, and this pin is not wired on my board, so
> in fact I can't check either.
> 
> Unfortunately, the language in the manual is inconsistent. For CTS/ RTS
> is clearly says:
> 
> 0 The CTS_B pin is high (inactive)
> 1 The CTS_B pin is low (active)

Ack.

@NXP: Maybe you can pick up this and improve the documentation here.

> and the code in the driver is:
> 
> 		if (mctrl & TIOCM_RTS)
> 			ucr2 |= UCR2_CTS;
> 
> that works correct.
> 
> My best reasoning was that  DSR/ DTR is likely implemented the same as
> CTS/ RTS in the metal, and I found other drivers where both RTS and DSR
> are inverted, so I guessed it could be a remnant of old copy-paste.

This is not a good enough reason to "fix" that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
