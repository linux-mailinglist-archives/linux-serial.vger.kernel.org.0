Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7F8303B1
	for <lists+linux-serial@lfdr.de>; Thu, 30 May 2019 23:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfE3VBC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 May 2019 17:01:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41683 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3VBC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 May 2019 17:01:02 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWSAW-0003hp-FT; Thu, 30 May 2019 23:01:00 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hWSAV-00087w-JV; Thu, 30 May 2019 23:00:59 +0200
Date:   Thu, 30 May 2019 23:00:59 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 4/8] serial: imx: get rid of unbounded busy-waiting loop
Message-ID: <20190530210059.xt7qlyk57cf3zaux@pengutronix.de>
References: <20190530152950.25377-1-sorganov@gmail.com>
 <20190530152950.25377-5-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190530152950.25377-5-sorganov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 30, 2019 at 06:29:46PM +0300, Sergey Organov wrote:
> imx_set_termios(): remove busy-waiting "drain Tx FIFO" loop. Worse
> yet, it was potentially unbounded wait due to RTS/CTS (hardware)
> handshake.
> 
> Let user space ensure draining is done before termios change, if
> draining is needed in the first place.

I don't know for sure what the intended behaviour is here, but I tend to
think that changing the unbounded wait to a timeout and then return
-EBUSY (?) would be more suitable. With your change you're possibly
breaking existent software.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
