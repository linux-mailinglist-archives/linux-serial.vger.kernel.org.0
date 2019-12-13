Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1211DAED
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfLMAHy (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:07:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37544 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbfLMAHx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so389934plz.4
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1lzeOKE7E2xm2Pt7osPxOs8CjOGmgq2Y6YA5myrIRwI=;
        b=UAGjR5Lwhlk2Ldz8b3cTLehatxJ/23uzY+Ob377pN0apnlpA770tNf4dQhE0OtCW+S
         L/QyIj6i2JC/neA9LoyfQmluxjAFkAcgszhlqfHmyDmHOlom6m3rRD1AvK2WraW9al61
         +iTX8p0wkbUv84baDL/YqJX2paQPCuceH4dmb8uMHS83muaLzVYaj6xTSassG8mmh4E8
         /u1z4oMQmA03jFhf/icDV8SAhnxBTKqNv5SiNq0FEyMdIdVPWm+mrzos74CwWVUzCXC8
         S45FAbDm+7QtukDSwo73q4zwfwMRmH8aVTECzWx4T3AaPfQRYMdqcrYcYSZJ55o7+exF
         AGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1lzeOKE7E2xm2Pt7osPxOs8CjOGmgq2Y6YA5myrIRwI=;
        b=QlINOgsY0yqooBstV1oal19Aixub9HynjRIxoDfl9Y81KdA1gG5WuQMXYxjWH41uo6
         SdRrHLJx3s2tNG0WuCApBOJuawBHkzQTxJeVkVLs5doLDvpqJvgmaf+Ks4BwHkh46bY3
         M6CVaUbBzv2eb0BVUAWW446G3BNok+YSIf2Rpk1wtq/ZisNz89SO6DCxGUwXQRniT4OE
         sh2uxiUsY5hB+AbBr9qGFwIQHXh+MFSpc7BT1PSicW+dAp4/0nD0CtA4FMRicCQfwZ7G
         prsLblvvi7Bbdla53PAaoqs38ISPQdVHu6D/mTdLlC5FuSEGfEvPgVZ7uZqQsuUJ8o77
         LB9g==
X-Gm-Message-State: APjAAAVQXCYRFXf3nRd+CFITbUgzpeTn+IvRwXFSEL9V6HFlT3T/4Ea5
        U2JjVPgltyVvYFOx7RiWbdoTZQ==
X-Google-Smtp-Source: APXvYqwojedrKhxZAq5cumleNwwcoSZ1lEw0FeB3H5QkX03T5VYZcpLlDknvC/Jx8tVgNaDLXobTIg==
X-Received: by 2002:a17:902:6b:: with SMTP id 98mr13070692pla.128.1576195672261;
        Thu, 12 Dec 2019 16:07:52 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:51 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/58] tty/serial: Migrate clps711x to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:12 +0000
Message-Id: <20191213000657.931618-14-dima@arista.com>
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

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/clps711x.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 061590795680..95abc6faa3d5 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -8,10 +8,6 @@
  *  Copyright (C) 2000 Deep Blue Solutions Ltd.
  */
 
-#if defined(CONFIG_SERIAL_CLPS711X_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/console.h>
@@ -479,6 +475,7 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	s->port.mapbase		= res->start;
 	s->port.type		= PORT_CLPS711X;
 	s->port.fifosize	= 16;
+	s->port.has_sysrq	= IS_ENABLED(CONFIG_SERIAL_CLPS711X_CONSOLE);
 	s->port.flags		= UPF_SKIP_TEST | UPF_FIXED_TYPE;
 	s->port.uartclk		= clk_get_rate(uart_clk);
 	s->port.ops		= &uart_clps711x_ops;
-- 
2.24.0

