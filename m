Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE72D0BCE
	for <lists+linux-serial@lfdr.de>; Wed,  9 Oct 2019 11:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfJIJvu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 9 Oct 2019 05:51:50 -0400
Received: from inva021.nxp.com ([92.121.34.21]:35598 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbfJIJvu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Oct 2019 05:51:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6275C2003A5;
        Wed,  9 Oct 2019 11:51:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 452862001C1;
        Wed,  9 Oct 2019 11:51:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9025E402B1;
        Wed,  9 Oct 2019 17:51:34 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        andy.shevchenko@gmail.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: imx: Use platform_get_irq_optional() for optional IRQs
Date:   Wed,  9 Oct 2019 17:49:19 +0800
Message-Id: <1570614559-11900-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

All i.MX SoCs except i.MX1 have ONLY one necessary IRQ, use
platform_get_irq_optional() to get second/third IRQ which are
optional to avoid below error message during probe:

[    0.726219] imx-uart 30860000.serial: IRQ index 1 not found
[    0.731329] imx-uart 30860000.serial: IRQ index 2 not found

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- use platform_get_irq_optional() directly instead of getting irq count.
---
 drivers/tty/serial/imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 504d81c..357d3ff 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2221,8 +2221,8 @@ static int imx_uart_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	rxirq = platform_get_irq(pdev, 0);
-	txirq = platform_get_irq(pdev, 1);
-	rtsirq = platform_get_irq(pdev, 2);
+	txirq = platform_get_irq_optional(pdev, 1);
+	rtsirq = platform_get_irq_optional(pdev, 2);
 
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
-- 
2.7.4

