Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E906FAB8
	for <lists+linux-serial@lfdr.de>; Mon, 22 Jul 2019 09:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfGVHvK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 03:51:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33623 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfGVHvK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 03:51:10 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hpT6D-00054d-1g; Mon, 22 Jul 2019 09:51:09 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hpT6B-0006dO-Em; Mon, 22 Jul 2019 09:51:07 +0200
Date:   Mon, 22 Jul 2019 09:51:07 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] serial: imx: set_termios(): do not enable autoRTS
 if RTS is unset
Message-ID: <20190722075107.cc3tvf6gmxhaeh5m@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563526074-20399-1-git-send-email-sorganov@gmail.com>
 <1563526074-20399-2-git-send-email-sorganov@gmail.com>
 <20190719091143.uhjxeibtolgswq2l@pengutronix.de>
 <87h87idxq2.fsf@osv.gnss.ru>
 <20190719143151.gx43ndn2oy35h247@pengutronix.de>
 <87woge9hvz.fsf@osv.gnss.ru>
 <20190719201949.ldqlcwjhcmt7wwhg@pengutronix.de>
 <87ftmy8qgu.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftmy8qgu.fsf@osv.gnss.ru>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 22, 2019 at 10:42:57AM +0300, Sergey Organov wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> 
> > On Fri, Jul 19, 2019 at 06:13:52PM +0300, Sergey Organov wrote:
> >> Hello Uwe,
> >> 
> >> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> >> > Hello Sergey,
> >> >
> >> > On Fri, Jul 19, 2019 at 03:18:13PM +0300, Sergey Organov wrote:
> >> >> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> >> >> > On Fri, Jul 19, 2019 at 11:47:52AM +0300, Sergey Organov wrote:
> >> >> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >> >> >> index 57d6e6b..95d7984 100644
> >> >> >> --- a/drivers/tty/serial/imx.c
> >> >> >> +++ b/drivers/tty/serial/imx.c
> >> >> >> @@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
> >> >> >>  /* called with port.lock taken and irqs caller dependent */
> >> >> >>  static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
> >> >> >>  {
> >> >> >> -	*ucr2 |= UCR2_CTSC;
> >> >> >> +	if (*ucr2 & UCR2_CTS)
> >> >> >> +		*ucr2 |= UCR2_CTSC;
> >> >> >
> >> >> > I think this patch is wrong or the commit log is insufficient.
> >> >> > imx_uart_rts_auto() has only a single caller and there ucr2 & UCR2_CTS is
> >> >> > never true. And CTSC isn't restored anywhere, is it?
> >> >> 
> >> >> This is rebase to 'tty-next' branch, and you need to look at it in that
> >> >> context. There, ucr2 & UCR2_CTS does already make sense, due to previous
> >> >> fix that is already there.
> >> >
> >> > I looked at 57d6e6b which is the file you patched. And there
> >> > imx_uart_rts_auto is only ever called with *ucr2 not having UCR2_CTS.
> >> >
> >> > If you still think I'm wrong, please improve the commit log
> >> > accordingly.
> >> 
> >> I still think you are wrong, but I don't know how to improve commit log.
> >> 
> >> To check it once again, I just did:
> >> 
> >> $ git show 57d6e6b > imx.c
> >> 
> >> There, in imx_uart_set_termios(), I see:
> >> 
> >> 1569:	old_ucr2 = imx_uart_readl(sport, UCR2);
> >> 1570:	ucr2 = old_ucr2 & (UCR2_TXEN | UCR2_RXEN | UCR2_ATEN | UCR2_CTS);
> >> 
> >> Here, current UCR2 value is read into 'old_ucr2' and then its /current/
> >> UCR2_CTS bit is copied into 'ucr2' (along with 3 other bits).
> >> 
> >> Then, later in the same function:
> >> 
> >> 1591:		imx_uart_rts_auto(sport, &ucr2);
> >> 
> >> is called that can check /current/ state of UCR2_CTS bit in '*ucr2'.
> >> 
> >> That's what the patch does, checks this bit.
> >> 
> >> Sorry, I fail to see how you came to conclusion that "*ucr2 not having
> >> UCR2_CTS". Do we maybe still read different versions of the file?
> >
> > No, it's just that I failed to see that UCR2_CTS is in the set of bits
> > that are retained even when looking twice :-|
> 
> Ah, that one... How familiar :-)

I thought again a bit over the weekend about this. I wonder if it's
correct to keep RTS active while going through .set_termios. Shouldn't
it maybe always be inactive to prevent the other side sending data while
we are changing the baud rate?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
