Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF3B7858
	for <lists+linux-serial@lfdr.de>; Thu, 19 Sep 2019 13:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbfISLW3 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 19 Sep 2019 07:22:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54573 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389755AbfISLW0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Sep 2019 07:22:26 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAuVu-0002Bi-B8; Thu, 19 Sep 2019 13:22:18 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAuVs-00035s-QK; Thu, 19 Sep 2019 13:22:16 +0200
Date:   Thu, 19 Sep 2019 13:22:16 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        yibin.gong@nxp.com, fugang.duan@nxp.com, l.stach@pengutronix.de,
        jslaby@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] serial: imx: adapt rx buffer and dma periods
Message-ID: <20190919112216.qjkx5wvqhsadjxg5@pengutronix.de>
References: <20190919102628.23621-1-philipp.puschmann@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190919102628.23621-1-philipp.puschmann@emlix.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 19, 2019 at 12:26:28PM +0200, Philipp Puschmann wrote:
> Using only 4 DMA periods for UART RX is very few if we have a high
> frequency of small transfers - like in our case using Bluetooth with
> many small packets via UART - causing many dma transfers but in each
> only filling a fraction of a single buffer. Such a case may lead to
> the situation that DMA RX transfer is triggered but no free buffer is
> available. While we have addressed the dma handling already with
> "dmaengine: imx-sdma: fix dma freezes" we still want to avoid

Is this statement still true now that you split this patch out of your
bigger series?

> UART RX FIFO overrun. So we decrease the size of the buffers and
> increase their number and the total buffer size.

What happens when such an RX FIFO overrun happens? Are characters lost?
Or only time? Does your change have an influence if I do fewer but
bigger transfers?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
