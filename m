Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78CEB11DA70
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfLMAHg (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:07:36 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41786 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbfLMAHf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id bd4so378708plb.8
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YlEOMykm0pUUW4Au/ZArNmhJRo0+IrRx0kDkEfqgRAw=;
        b=F+unhEj/nQuN3yep7N11kKTtZYa+h3msqunbmn6zo+ucK8v0A6TREFRPTxRm5FbzOz
         wb9OtDsxh0tlqH6nHzgkn1hYoSKWFZsPhUo5qm3D4ZARE/FnuKAg/d1ygzGKUeWp+70d
         nKzsiG/MYaMDA0T+cG+Ci0YkpcBD337/yeDArPXaHAUlQbtBlPnS9QJFru8BqGIjfB6b
         QppVLbdoRihm70kiqrxv27js9pdotkLOWfvSdFZxbWQydO9gnEstdtyaYRCKP8UVXMH/
         IBnTLuN4UgADDtwRJyBkICt/fGPnwhJH+Iapy6LSo+s9DN/YOyQ2b/j32nM/I4+L0zT8
         1ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YlEOMykm0pUUW4Au/ZArNmhJRo0+IrRx0kDkEfqgRAw=;
        b=Y6DJWUt4EZaz5nj4SonG8opLo8Rqznvn8q2sc5HV5XUIFKYu8o4P1NeMEZmnO8rqng
         69cQdpm0AFJW80hgiJinr3T+op8dN7lAznjs0ri0QnxM5mCDdttzY5CyQdbOF6EGgKK/
         pq2DHwl2S3G9rhme51upeAdLlmlq9lKDVr4MDYL1GxwKDJ+iT4rlgz7fB3F6yDMmcvAx
         sKoT/5ww10EIDURDhlUZ3q3bxVfSANVtjLKSSfCpwWk9jyncE8Gl+vEVXI5skcYDxH8o
         9BeF34YBO0z2djWHI9wnboPAMfL3B+uAVk73gUPLXnY32SUpk8cQGUSRfr7Qr1ukcamU
         2BbA==
X-Gm-Message-State: APjAAAXyj286PSCAH72PQ82yV2WLcuSV9/qknyeDVzFwNsmRxDP+4fFB
        Flu/+4ASx/cZoNtNkS6+L/o1rQ==
X-Google-Smtp-Source: APXvYqxLt+x4aDEtuO8uG/IaFdabl/RUXmCZbSI6W62GN7uJYXKPgTSYX+dH9492eStGG3f/Sfp2mQ==
X-Received: by 2002:a17:90a:25a8:: with SMTP id k37mr12506158pje.127.1576195654992;
        Thu, 12 Dec 2019 16:07:34 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:34 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 07/58] tty/serial: Migrate 8250_omap to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:06 +0000
Message-Id: <20191213000657.931618-8-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/8250/8250_omap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 836e736ae188..1ee7b89817dd 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -8,10 +8,6 @@
  *
  */
 
-#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -1192,6 +1188,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.throttle = omap_8250_throttle;
 	up.port.unthrottle = omap_8250_unthrottle;
 	up.port.rs485_config = omap_8250_rs485_config;
+	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
 	ret = of_alias_get_id(np, "serial");
 	if (ret < 0) {
-- 
2.24.0

