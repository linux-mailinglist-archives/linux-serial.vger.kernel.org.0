Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A8B1353B7
	for <lists+linux-serial@lfdr.de>; Thu,  9 Jan 2020 08:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgAIHdJ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 9 Jan 2020 02:33:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41715 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgAIHdI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Jan 2020 02:33:08 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipSJX-0001FH-C0; Thu, 09 Jan 2020 08:33:07 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipSJV-00065H-KM; Thu, 09 Jan 2020 08:33:05 +0100
Date:   Thu, 9 Jan 2020 08:33:05 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Richard Genoud <richard.genoud@gmail.com>
Cc:     Codrin.Ciubotariu@microchip.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, jslaby@suse.com
Subject: Re: [PATCH] tty/serial: atmel: RS485 & ISO7816: wait for TXRDY
 before sending data
Message-ID: <20200109073305.yn5y6sgomjniwwj6@pengutronix.de>
References: <20200107111656.26308-1-codrin.ciubotariu@microchip.com>
 <b11e47c3-8b94-7915-ae5a-d9e8f5b02047@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b11e47c3-8b94-7915-ae5a-d9e8f5b02047@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On Wed, Jan 08, 2020 at 02:45:05PM +0100, Richard Genoud wrote:
> NB: MS exchange has added some =3D and =20 here and there, but git am
> doesn't seems to be bothered by them.

Unless I missed something I cannot confirm. In mutt I don't see any =3D
or =20.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
