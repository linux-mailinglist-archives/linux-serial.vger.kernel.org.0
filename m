Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5DC11DAEC
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfLMAHw (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:07:52 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34880 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbfLMAHl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:41 -0500
Received: by mail-pj1-f66.google.com with SMTP id w23so349227pjd.2
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOfw8DvGelk55VHYuQqtGjkzT+5DacD+SJoWHYJTR3I=;
        b=XCdpRu57dNmoWnj2l4EG7ZDbsjFSrjIpki7aSV4S3h/YRY5z9QZKOes+9is2EyjqDi
         Pggu8FM3/7QWvzeC21hsbCLhcGMQo4g+ugnC+0QPnM7fqEMVKKR/LOxJA4rFtuNZmFJ0
         emjiYa/2Ns4Yv3HuAJhAI8IRO7/Gn2ljOKX+tfvBR207LOLY4JpQpr3XmBD6pMHFFdeK
         +FFab1PlU1DCuACaqcrDYr+LhVt3ihA3qfjHHaEar1ILptYMg4ID3rVleAZoisR6GURI
         6gMOPR4kRiTK0OV22sjNYFT3GWYlyH+dJHuhFM/9DiKyQtsss/VGLt/tXriatRoDRFqI
         GabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOfw8DvGelk55VHYuQqtGjkzT+5DacD+SJoWHYJTR3I=;
        b=qOQSY4S2p1q1eh007B+uATiuyjuVWORApWtm2hFs6gJJ6sZtxiRxVICJsdte9piFDq
         0Ra/L3hj2w7PfgauJGRRwelZzV/ilGfovtUqA4f39l6GoG4a6ZpflWSMtRICTFrcnGbA
         iccy0lhvyPB+Jd3YtDsjQC4SaOdOzHqScrebo1KOWpcUJWsUHJZ6qf28v6Seozgu5Kp0
         3B0AoUi4y0YRPw7SPmX38cyqqQFmpM55XFlYskgLzvuxq5XZOLxKiv7Je4xyEslnXFqB
         K2aaPCFg4h5MIFrWDJ5/ABpRnNUN3eCVexwmvmB8dRX6d6g5Q1StB49CO6lAP8ngP/Q5
         UCOw==
X-Gm-Message-State: APjAAAXWw04EtVya/Nbs/X7qfzr1RBcNgHT6CelIrjK1fxqlkbFoT7CG
        ZO53jgWMP9Y6bVmD4ep85LDiLg==
X-Google-Smtp-Source: APXvYqwKzXaCGQEeoKJrUNZJQ9fKFxNSrrIEiT/fYpiiBnXVX3v8SPs8UTDHVRjx6kdnyz5cai2w1w==
X-Received: by 2002:a17:902:b204:: with SMTP id t4mr12673801plr.137.1576195660500;
        Thu, 12 Dec 2019 16:07:40 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:39 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH 09/58] tty/serial: Migrate amba-pl01* to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:08 +0000
Message-Id: <20191213000657.931618-10-dima@arista.com>
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

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/amba-pl010.c | 5 +----
 drivers/tty/serial/amba-pl011.c | 6 +-----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 2c37d11726ab..3284f34e9dfe 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -15,10 +15,6 @@
  * and hooked into this driver.
  */
 
-#if defined(CONFIG_SERIAL_AMBA_PL010_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -728,6 +724,7 @@ static int pl010_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.iotype = UPIO_MEM;
 	uap->port.irq = dev->irq[0];
 	uap->port.fifosize = 16;
+	uap->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_AMBA_PL010_CONSOLE);
 	uap->port.ops = &amba_pl010_pops;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = i;
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4b28134d596a..952483ec8ea1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -16,11 +16,6 @@
  * and hooked into this driver.
  */
 
-
-#if defined(CONFIG_SERIAL_AMBA_PL011_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -2579,6 +2574,7 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 	uap->port.mapbase = mmiobase->start;
 	uap->port.membase = base;
 	uap->port.fifosize = uap->fifosize;
+	uap->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_AMBA_PL011_CONSOLE);
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = index;
 
-- 
2.24.0

