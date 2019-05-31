Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D1308EC
	for <lists+linux-serial@lfdr.de>; Fri, 31 May 2019 08:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEaGov (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 31 May 2019 02:44:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45969 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaGou (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 May 2019 02:44:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWbHU-0007jG-Dx; Fri, 31 May 2019 08:44:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWbHU-0004GJ-2J; Fri, 31 May 2019 08:44:48 +0200
Date:   Fri, 31 May 2019 08:44:48 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/8] serial: imx: fix DTR inversion
Message-ID: <20190531064448.llskliwcqdeagjb4@pengutronix.de>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-2-sorganov@gmail.com>
 <20190530205313.uwue3q2t5tp2vwz6@pengutronix.de>
 <87ftovw7h8.fsf@javad.com>
 <20190531051430.yojydtk63vkuektg@pengutronix.de>
 <87ef4fup0h.fsf@javad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ef4fup0h.fsf@javad.com>
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

On Fri, May 31, 2019 at 09:17:02AM +0300, Sergey Organov wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> 
> > On Fri, May 31, 2019 at 07:52:51AM +0300, Sergey Organov wrote:
> >> My best reasoning was that  DSR/ DTR is likely implemented the same as
> >> CTS/ RTS in the metal, and I found other drivers where both RTS and DSR
> >> are inverted, so I guessed it could be a remnant of old copy-paste.
> >
> > This is not a good enough reason to "fix" that.
> 
> Yeah, I agree. I rather mostly kept it in the series not to forget about
> the issue. I should have said that in the comments, sorry.

Then also sort this to the end of the series to allow clean application
of the patches you are sure about and mark the questionable patches as
RFC or RFT.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
