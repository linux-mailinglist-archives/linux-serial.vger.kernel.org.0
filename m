Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D64B315849E
	for <lists+linux-serial@lfdr.de>; Mon, 10 Feb 2020 22:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJVQz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Feb 2020 16:16:55 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50289 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJVQy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Feb 2020 16:16:54 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1GQG-0000YA-EO; Mon, 10 Feb 2020 22:16:52 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1GQF-0003sB-Jm; Mon, 10 Feb 2020 22:16:51 +0100
Date:   Mon, 10 Feb 2020 22:16:51 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     George Hilliard <ghilliard@kopismobile.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] tty: imx serial: Implement support for reversing TX
 and RX polarity
Message-ID: <20200210211651.5jys7ytgdm72hh6f@pengutronix.de>
References: <20200210174942.14182-1-ghilliard@kopismobile.com>
 <20200210174942.14182-3-ghilliard@kopismobile.com>
 <20200210181156.fbq66yazb5j5quvn@pengutronix.de>
 <CALM8J=f1HV8BucyLVAz8cje392F98uOPoYdOMTSL0970eJnAcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALM8J=f1HV8BucyLVAz8cje392F98uOPoYdOMTSL0970eJnAcw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi George,

On Mon, Feb 10, 2020 at 12:38:59PM -0600, George Hilliard wrote:
> On Mon, Feb 10, 2020 at 12:11 PM Uwe Kleine-K�nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Feb 10, 2020 at 11:49:42AM -0600, George Hilliard wrote:
> > > (confidentiality spam)
> >
> > Hmm, sad, I would have had some review feedback that should be addressed
> > before application of the patch. As I only noticed the footer after
> > looking at the patch, it was already too late to stop me reviewing it.
> > As I don't have an expressed permission I will at least not share it
> > (and I expect that Greg will also refuse to apply a patch with such a
> > footer).
>
> This is fixed now. Apologies - added without my knowledge. Should I
> simply resend a v2 without the notice?  Happy to CC everyone else you
> included.

You did it right. (i.e. yes, resend without the notice is the right
thing.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
