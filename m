Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80A79B209
	for <lists+linux-serial@lfdr.de>; Fri, 23 Aug 2019 16:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbfHWOct (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 23 Aug 2019 10:32:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57735 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389183AbfHWOct (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Aug 2019 10:32:49 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1AcM-0000Ge-T2; Fri, 23 Aug 2019 16:32:42 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1AcL-000574-By; Fri, 23 Aug 2019 16:32:41 +0200
Date:   Fri, 23 Aug 2019 16:32:41 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Richard Genoud <richard.genoud@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-serial@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/serial: atmel: remove unneeded
 atmel_get_lines_status function
Message-ID: <20190823143241.zixdsnwrtzhgkig7@pengutronix.de>
References: <20190823134109.12402-1-richard.genoud@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190823134109.12402-1-richard.genoud@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 23, 2019 at 03:41:09PM +0200, Richard Genoud wrote:
> Since commit ce59e48fdbad ("serial: mctrl_gpio: implement interrupt
> handling"), the GPIOs interrupts are handled by mctrl_gpio_irq_handle().

Well no, since ce59e48fdbad the mctrl_gpio helper can do all that
interrupt stuff. You want to reference
18dfef9c7f87b75bbb0fb66a634f7c13a45b9f8d here.

> So, atmel_get_lines_status() can be completely killed and replaced by :
> atmel_uart_readl(port, ATMEL_US_CSR);
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Suggested-by: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
