Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADE62A80D8
	for <lists+linux-serial@lfdr.de>; Thu,  5 Nov 2020 15:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgKEO2v (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 5 Nov 2020 09:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKEO2u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 09:28:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D4C0613CF
        for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2020 06:28:50 -0800 (PST)
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kagFp-0008CW-Th; Thu, 05 Nov 2020 15:28:46 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Fugang Duan <fugang.duan@nxp.com>, linux-serial@vger.kernel.org,
        patchwork-lst@pengutronix.de, kernel@pengutronix.de
Date:   Thu,  5 Nov 2020 15:28:44 +0100
Message-Id: <20201105142844.1698969-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=4.0 tests=AWL,BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH] tty: serial: imx: enable eralycon by default if IMX_SERIAL_CONSOLE is enabled
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since 699cc4dfd140 (tty: serial: imx: add imx earlycon driver), the earlycon
part of imx serial is a separate driver and isn't necessarily enabled anymore
when the console is enabled. This causes users to loose the earlycon
functionality when upgrading their kenrel configuration via oldconfig.

Enable earlycon by default when IMX_SERIAL_CONSOLE is enabled.

Fixes: 699cc4dfd140 (tty: serial: imx: add imx earlycon driver)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1044fc387691..28f22e58639c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -522,6 +522,7 @@ config SERIAL_IMX_EARLYCON
 	depends on OF
 	select SERIAL_EARLYCON
 	select SERIAL_CORE_CONSOLE
+	default y if SERIAL_IMX_CONSOLE
 	help
 	  If you have enabled the earlycon on the Freescale IMX
 	  CPU you can make it the earlycon by answering Y to this option.
-- 
2.20.1

