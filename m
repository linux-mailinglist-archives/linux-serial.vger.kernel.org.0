Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4321B176FFB
	for <lists+linux-serial@lfdr.de>; Tue,  3 Mar 2020 08:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCCHWh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 3 Mar 2020 02:22:37 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7364 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgCCHWh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 02:22:37 -0500
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 02:22:35 EST
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e5e035d2c5-c6d2e; Tue, 03 Mar 2020 15:12:30 +0800 (CST)
X-RM-TRANSID: 2ee65e5e035d2c5-c6d2e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.208.44])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5e5e03553e9-cdb48;
        Tue, 03 Mar 2020 15:12:30 +0800 (CST)
X-RM-TRANSID: 2eea5e5e03553e9-cdb48
From:   tangbin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 2/2] tty:serial:mvebu-uart:fix a wrong return
Date:   Tue,  3 Mar 2020 15:13:09 +0800
Message-Id: <20200303071309.17172-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

in this place,the right return should be
return PTR_ERR(),not return -PTR_ERR()

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index c12a12556..4e9a59071 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -851,7 +851,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 
 	port->membase = devm_ioremap_resource(&pdev->dev, reg);
 	if (IS_ERR(port->membase))
-		return -PTR_ERR(port->membase);
+		return PTR_ERR(port->membase);
 
 	mvuart = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_uart),
 			      GFP_KERNEL);
-- 
2.20.1.windows.1



