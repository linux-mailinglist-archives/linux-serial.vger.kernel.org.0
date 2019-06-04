Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6C333D8B
	for <lists+linux-serial@lfdr.de>; Tue,  4 Jun 2019 05:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFDDbu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 3 Jun 2019 23:31:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39569 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDDbu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jun 2019 23:31:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id i125so1933203qkd.6
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2019 20:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1hhm33XSznqNx8kqBLtqjqTHA6QOtE+oEjMNqIXzJzs=;
        b=Ttu2SQiDGlThzzIG+GXTweaJbE1O2CY3XaTuwXx1kct7iDEfKvuU6cmzVeyd+P5BEi
         pRDBpWAe4HDIUSd0gWe1U9X4lIodHDZp1l5a2eiYpHXhx5+GYupOOQEJs8qcjnMI6BRq
         zd0xzLGXpFjOL40667xA+nTo5n3D4xvaJn1Yt+2/C1OGc0kapSUhSTaN9ykXCt2CLWC9
         W9ipobuHNMkTWTlgHPWPFT0jhyn8oPcJGcwwVBrJ2pSTsCu7baqLc0vHJ3nxjaOIhCeW
         vBAu6BvLlXTilsDkhMjLVkORari1IcsNmDL3kVgsUzmGZhfHx+SdRg406/cviaBmlc62
         D9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1hhm33XSznqNx8kqBLtqjqTHA6QOtE+oEjMNqIXzJzs=;
        b=PcikMIKIyNqPBNrgGz1cyEjC7bD0jjDWSk0GEP6/j/j2ENJNLdIDk6FpdEDIS/Y1+A
         0OuspkwZ2FPjWHrZSgGIYVs8r4lEGk3k0oUp6no5UuBBLQp4yPTq0Cn+eXouCTzYJ6uG
         wfzHl/6ajL6vaBeqT8dw7dElCsUIQMQQoTNYNUGU3tg680dMlDIUFWpJ3S/2CU4Wh9Ig
         GXA9MbUXii8LkKp5RxTSAPr2mUiIZXihu2qnt19RSnogUxcG9p21KxAL/LJQ8VfhT411
         U2ElvSOsWf0lNeE41JG32uFRGmGfhq5k4O+VzDGNy82vTB5J/jaD0Jf7qTZfkeTD/mah
         eGTA==
X-Gm-Message-State: APjAAAWNXsGLA7JzruSk7vCj2UoI4B1I50ebeuUn2gLGYq28UmjlGzVM
        /Ue/Ph4SvY1YtTTf8TR6Wak=
X-Google-Smtp-Source: APXvYqzzOcZlsNoIkQ1imBXsmdzuCFgW6LgMzg00vtP+cIoYZ/ZSNjni8vzEZFrmdVVo8XMSruNDgA==
X-Received: by 2002:ae9:c208:: with SMTP id j8mr25017195qkg.264.1559619109011;
        Mon, 03 Jun 2019 20:31:49 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id v41sm5189310qta.78.2019.06.03.20.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 20:31:47 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     fugang.duan@nxp.com, linux-serial@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] serial: fsl_lpuart: Use dev_info() instead of printk()
Date:   Tue,  4 Jun 2019 00:31:38 -0300
Message-Id: <20190604033139.25546-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

dev_info() is more appropriate for printing messages inside drivers, so
switch to dev_info().

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- None

 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ea1c85e3b432..08b52cca650c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2078,7 +2078,7 @@ lpuart_console_get_options(struct lpuart_port *sport, int *baud,
 	baud_raw = uartclk / (16 * (sbr + brfa / 32));
 
 	if (*baud != baud_raw)
-		printk(KERN_INFO "Serial: Console lpuart rounded baud rate"
+		dev_info(sport->port.dev, "Serial: Console lpuart rounded baud rate"
 				"from %d to %d\n", baud_raw, *baud);
 }
 
@@ -2121,7 +2121,7 @@ lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
 	baud_raw = uartclk / (16 * sbr);
 
 	if (*baud != baud_raw)
-		printk(KERN_INFO "Serial: Console lpuart rounded baud rate"
+		dev_info(sport->port.dev, "Serial: Console lpuart rounded baud rate"
 				"from %d to %d\n", baud_raw, *baud);
 }
 
-- 
2.17.1

