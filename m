Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6B470543
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfGVQUO (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 12:20:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60983 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfGVQUO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 12:20:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hpb2q-0004BQ-FK; Mon, 22 Jul 2019 18:20:12 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hpb2p-0007pT-LL; Mon, 22 Jul 2019 18:20:11 +0200
Date:   Mon, 22 Jul 2019 18:20:11 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v5 1/3] serial: imx: set_termios(): do not enable autoRTS
 if RTS is unset
Message-ID: <20190722162011.wv36d7epunjm4h4t@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563787330-1394-1-git-send-email-sorganov@gmail.com>
 <1563787330-1394-2-git-send-email-sorganov@gmail.com>
 <20190722095405.qdc77cb2qrgltzrx@pengutronix.de>
 <877e8a5fz6.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877e8a5fz6.fsf@osv.gnss.ru>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 22, 2019 at 04:57:49PM +0300, Sergey Organov wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> 
> > On Mon, Jul 22, 2019 at 12:22:08PM +0300, Sergey Organov wrote:
> >> Don't let receiver hardware automatically control RTS output if it
> >> was requested to be inactive.
> >> 
> >> To ensure this, set_termios() shouldn't set UCR2_CTSC bit if UCR2_CTS
> >> (=TIOCM_RTS) is cleared. Added corresponding check in imx_uart_rts_auto()
> >> to fix this.
> >> 
> >> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >
> > I think it's a bit bold to add a review-tag for me here. The best reason
> > for that that I'm aware of is that I wrote for v4: "[I]f you update the
> > commit log as agreed already before and even add a comment in
> > imx_uart_rts_auto along the lines of ... you can have my Ack." which IMO
> > isn't good enough to justify a "Reviewed-by". I wouldn't even add an
> > Acked-by: without the other person being able to actually see the
> > changed patch (but this might be arguable).
> 
> I'll do whatever you say. Should I remove the Reviewed-by: you, or is it
> OK to leave it in, to avoid re-iterating again?

I'd like to have it an Acked-by.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
