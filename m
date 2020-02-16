Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F4A160373
	for <lists+linux-serial@lfdr.de>; Sun, 16 Feb 2020 11:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgBPK1x (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 16 Feb 2020 05:27:53 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:28249 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgBPK1x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 16 Feb 2020 05:27:53 -0500
Received: from localhost.localdomain ([93.22.36.246])
        by mwinf5d13 with ME
        id 3NTo2200F5JeL2d03NTpE1; Sun, 16 Feb 2020 11:27:50 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Feb 2020 11:27:50 +0100
X-ME-IP: 93.22.36.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] tty: serial: Kconfig: Fix a typo
Date:   Sun, 16 Feb 2020 11:27:42 +0100
Message-Id: <20200216102742.19298-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

'exsisting' has an extra 's'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 52eaac21ff9f..7172f1c5fa6d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1111,7 +1111,7 @@ config SERIAL_SC16IS7XX_SPI
 	help
 	  Enable SC16IS7xx driver on SPI bus,
 	  If required say y, and say n to spi if not required,
-	  This is additional support to exsisting driver.
+	  This is additional support to existing driver.
 	  You must select at least one bus for the driver to be built.
 
 config SERIAL_TIMBERDALE
-- 
2.20.1

