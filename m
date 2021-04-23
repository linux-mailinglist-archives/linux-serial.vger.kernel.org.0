Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1B368F80
	for <lists+linux-serial@lfdr.de>; Fri, 23 Apr 2021 11:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhDWJjd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 23 Apr 2021 05:39:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16617 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhDWJjc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Apr 2021 05:39:32 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FRTgy2fGxz1BGhy;
        Fri, 23 Apr 2021 17:36:30 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 23 Apr 2021 17:38:46 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, "Tian Tao" <tiantao6@hisilicon.com>
Subject: [PATCH] tty: serial: samsung_tty: remove set but not used variables
Date:   Fri, 23 Apr 2021 17:39:00 +0800
Message-ID: <1619170740-63717-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The value of 'ret' is not used, so just delete it.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/tty/serial/samsung_tty.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d9e4b67..d269d75 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2220,7 +2220,6 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 			default:
 				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
 						prop);
-				ret = -EINVAL;
 				break;
 			}
 		}
-- 
2.7.4

