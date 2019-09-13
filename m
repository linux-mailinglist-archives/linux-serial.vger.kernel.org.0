Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B177B18EA
	for <lists+linux-serial@lfdr.de>; Fri, 13 Sep 2019 09:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfIMH2h (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 13 Sep 2019 03:28:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35306 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfIMH2e (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Sep 2019 03:28:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id g7so31063395wrx.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Sep 2019 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=HBeSnnaknF8l50flmejOlPoMNRFfD6iWBsjsOqPj+d0=;
        b=iBcZbYKS9kEIsmLFLKGgi8dVQynqqARBR3pZUlHdw07+qkP+mM4JaljCPnbXn29WcU
         Wh8LDkQnK2mCu9b3RDxj0kWUysIuRRgYoEDDOLPO3FT4NiWRNj5JpNcZ9W/k8me1dS+o
         y9WEV5ebefC0wyCmSEA2QymG5/UX5qoliD8t6bQ5XVFMgMVuj1h1r49nDIY41AOoFGSb
         g803a8MH9wPQdfuzIfHdYv4N7Xci2NoqYxcdxITcXmjjgB8FEHGqM/o8vRY6ZH8nV9Bj
         1a+T/u268RHPM1a+6HmbgOR5iycHdMktQUA+0JVDx0e+M8khwS+Zk1/Bsk5V6eR9YLcZ
         iYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=HBeSnnaknF8l50flmejOlPoMNRFfD6iWBsjsOqPj+d0=;
        b=WESXCzuXc0L/MgUsdvQ0c66sl2dlt3phFb/Y3AhdM2mGVPWxYIFo0tE5QHONJekUwP
         Cfv5KMf3EXPXQASSOceFF0N3k3tkTKtbRDsKmS3G2S0KQkwF358FbwFI5ETkZsbnve8j
         vRSESwVm13WnHSZHoEvL9FXID7BZlE3rVndYMtBvHxcXHH4VGBgNHcY4sHvuFAK4fbIN
         NtWFocnAAB1K5fTpyAsKOfubZ/SgXeZo7ddJvz0GkGVUzGfWaHtXZ7tVbuauzadsY+M5
         A7OqQnRShhOL4i3/eJ/jOP6VA0IMeurvqugOo4MMpP3nHqXOtWZdjILKsjMFFIfXbBs1
         HhKA==
X-Gm-Message-State: APjAAAXTru6RfL/x1c302CZLbQGUdVAKkMIgf0MUQci8bWXV8Y/Pp9aU
        VHf/GocwNIYQ2GR3Vh3dVoWv8Q==
X-Google-Smtp-Source: APXvYqxHBtSh+/6IJVUafbfXSPoUImAQ5IbkQ1l66MjQy8e3RUYc28sXyCP+8jS6lFV9j9YqfpKiRA==
X-Received: by 2002:adf:ce04:: with SMTP id p4mr3773130wrn.130.1568359711768;
        Fri, 13 Sep 2019 00:28:31 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w8sm1798031wmc.1.2019.09.13.00.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Sep 2019 00:28:31 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Paul Thomas <pthomas8589@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH] serial: uartps: Fix uartps_major handling
Date:   Fri, 13 Sep 2019 09:28:29 +0200
Message-Id: <00a269bc15c4f8c0a73c14958c5d7a5d37ff70ce.1568359707.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are two parts which should be fixed. The first one is to assigned
uartps_major at the end of probe() to avoid complicated logic when
something fails.
The second part is initialized uartps_major number to 0 when last device is
removed. This will ensure that on next probe driver will ask for new
dynamic major number.

Fixes: c9712e333809 ("serial: uartps: Use the same dynamic major number for all ports")
Reported-by: Paul Thomas <pthomas8589@gmail.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index f145946f659b..92df0c4f1c7a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1550,7 +1550,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		goto err_out_id;
 	}
 
-	uartps_major = cdns_uart_uart_driver->tty_driver->major;
 	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
 
 	/*
@@ -1680,6 +1679,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
+	uartps_major = cdns_uart_uart_driver->tty_driver->major;
 	cdns_uart_data->cts_override = of_property_read_bool(pdev->dev.of_node,
 							     "cts-override");
 	return 0;
@@ -1741,6 +1741,12 @@ static int cdns_uart_remove(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
+	/* If this is last instance major number should be initialized */
+	mutex_lock(&bitmap_lock);
+	if (bitmap_empty(bitmap, MAX_UART_INSTANCES))
+		uartps_major = 0;
+	mutex_unlock(&bitmap_lock);
+
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
-- 
2.17.1

