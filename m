Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA8158216
	for <lists+linux-serial@lfdr.de>; Mon, 10 Feb 2020 19:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgBJSL7 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Feb 2020 13:11:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57095 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJSL7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Feb 2020 13:11:59 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1DXJ-0000IB-Fa; Mon, 10 Feb 2020 19:11:57 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1DXI-0001fF-By; Mon, 10 Feb 2020 19:11:56 +0100
Date:   Mon, 10 Feb 2020 19:11:56 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     George Hilliard <ghilliard@kopismobile.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] tty: imx serial: Implement support for reversing TX
 and RX polarity
Message-ID: <20200210181156.fbq66yazb5j5quvn@pengutronix.de>
References: <20200210174942.14182-1-ghilliard@kopismobile.com>
 <20200210174942.14182-3-ghilliard@kopismobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200210174942.14182-3-ghilliard@kopismobile.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello George,

expanding Cc: a bit

On Mon, Feb 10, 2020 at 11:49:42AM -0600, George Hilliard wrote:
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use 
> of the intended recipient and may contain material that is proprietary, 
> confidential, privileged or otherwise legally protected or restricted under 
> applicable government laws. Any review, disclosure, distributing or other 
> use without expressed permission of the sender is strictly prohibited. If 
> you are not the intended recipient, please contact the sender and delete 
> all copies without reading, printing, or saving.

Hmm, sad, I would have had some review feedback that should be addressed
before application of the patch. As I only noticed the footer after
looking at the patch, it was already too late to stop me reviewing it.
As I don't have an expressed permission I will at least not share it
(and I expect that Greg will also refuse to apply a patch with such a
footer).

:-|
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
