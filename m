Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8DA13B120
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2019 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbfFJIpF (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Jun 2019 04:45:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50638 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388340AbfFJIpF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jun 2019 04:45:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so7617974wmf.0
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2019 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=M+cP6C7+VK3jw1r29YjrDx6Ndjlh7cgtx3v4K/NgDeo=;
        b=skNfvRf9d+s4BJ3piPlivoHWyDhAwaIRmipuCtcV3u2KR+vFbN4F+TJuRmtQ8/lnvF
         1gtZAsGOd56DCCnP1pmwBnX2m2YQLDATKu4pUkOmahNnAPJ/MNrjJSfW7MSY7+j21xPI
         Mhr9hj0SmaCObOLnsXZTJRZ5thrzaXG3syQQBNPB/FJkoXl4UC7/pALnd/1O1tjvkixy
         DCIbarfpgzpMXJO4PPUWxqzowa49YG/LWIkMjAQpoMn9oZPrX4iN9MGm7n8+SYn9p9kd
         BUAKc/S+myiWbw7/p1Nd/QWCDET3wxjz3eijq8BQ3AVmtbcO5Kcn3gKl1ToUub+WIZ10
         4Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=M+cP6C7+VK3jw1r29YjrDx6Ndjlh7cgtx3v4K/NgDeo=;
        b=nuU4ph/e8tAZANT7hlKIqIsX+cCEjvqLOVJU09WUMxkfy9mU6IA89PLGgVNMw5ohV+
         PUN+ZqMZjRYr988MCVdHtgmZo0FffI4JC41WXdq/xVJASS9vcOtchC8wSTVTSyxUE/iI
         5Jft64WIAoniKXekkvRcvLPSQ1l1TKmx2WwBKestUrnu1nxICOHPbleFcDCnI9+vK27w
         HA/JGZS/xut6nZxqVkBym5/bIMLh/bNCBSeIYz6BIa5NfbEnG0OenfVnw1lfCjJtVKo3
         3PUwyphOf5Tcgq/c9WeTN50ezFXqYRA2Z6Ca0RiznyJj+7pfyAhyAd9tofXlEG2Rqbxm
         /DJw==
X-Gm-Message-State: APjAAAVkG16T+TfsL6z7xSB+a63dLVF0hYYiLrBghClGvhsmlrjV2y84
        yn65ZHw1HSUO75/RncGQAyfnpQ==
X-Google-Smtp-Source: APXvYqyqoIr6fU1KzvLY8lEPM3s5B6qJXzVnTwekyShtxIqDrTxMhdNjfJPY9GeTEpwMm2XWi5yoPg==
X-Received: by 2002:a1c:750d:: with SMTP id o13mr12156994wmc.35.1560156303497;
        Mon, 10 Jun 2019 01:45:03 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w23sm7629173wmi.45.2019.06.10.01.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 01:45:03 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] serial: uartps: Use the same dynamin major number for all ports
Date:   Mon, 10 Jun 2019 10:44:56 +0200
Message-Id: <381ea608440345a4424d24296666b2451b1a20ee.1560156294.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
References: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
In-Reply-To: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
References: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Let kernel to find out major number dynamically for the first device and
then reuse it for other instances.
This fixes the issue that each uart is registered with a
different major number.

After the patch:
crw-------    1 root     root      253,   0 Jun 10 08:31 /dev/ttyPS0
crw--w----    1 root     root      253,   1 Jan  1  1970 /dev/ttyPS1

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 6af2886f5ba7..a0b51c60faeb 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -29,12 +29,12 @@
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
-#define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
 
 /* Rx Trigger level */
 static int rx_trigger_level = 56;
+static int uartps_major;
 module_param(rx_trigger_level, uint, 0444);
 MODULE_PARM_DESC(rx_trigger_level, "Rx trigger level, 1-63 bytes");
 
@@ -1516,7 +1516,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	cdns_uart_uart_driver->owner = THIS_MODULE;
 	cdns_uart_uart_driver->driver_name = driver_name;
 	cdns_uart_uart_driver->dev_name	= CDNS_UART_TTY_NAME;
-	cdns_uart_uart_driver->major = CDNS_UART_MAJOR;
+	cdns_uart_uart_driver->major = uartps_major;
 	cdns_uart_uart_driver->minor = cdns_uart_data->id;
 	cdns_uart_uart_driver->nr = 1;
 
@@ -1545,6 +1545,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		goto err_out_id;
 	}
 
+	uartps_major = cdns_uart_uart_driver->tty_driver->major;
 	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
 
 	/*
-- 
2.17.1

