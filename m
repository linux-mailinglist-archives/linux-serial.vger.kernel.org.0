Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BCA11DA6D
	for <lists+linux-serial@lfdr.de>; Fri, 13 Dec 2019 01:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbfLMAHc (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 12 Dec 2019 19:07:32 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:42536 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731184AbfLMAH3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:29 -0500
Received: by mail-pj1-f67.google.com with SMTP id o11so333721pjp.9
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0zI46fwj74VyWlrHr0zE9775HtW1ixE7rUWLLJGBnQ=;
        b=ZDU8FPg2Z/bhIq5moxFbpIkJl5mkokE1M6A/l1ergMT75YFy3KCr76cQMYKo3eHU5P
         CJXrbFSqBKENrTaDehFlbEJpRc0qXOx/zU/pGPu4dQsLtQ9KyFGfwoGYt4GIUE6dN91s
         DCVoVBt2V2v4sjyYrmfV9GEGRvmbA+im9zVcWVnq8ncnJI7HyFUfpCMd1WhN/1B6C204
         dCFSZslPsdxyHcARs0dl+8C54fCm7BjFjlkGm9nLcFJ7eok/xzd6lxQuh9oAyAnYR8Ji
         om2C6achDu85oquscjvJ0+sUtX1QdzU5AuA4J7AIESCt87QQx3YOU6WCzuHfEt+trraM
         XlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0zI46fwj74VyWlrHr0zE9775HtW1ixE7rUWLLJGBnQ=;
        b=o0yGQDXojVG8/xgeyOZPM84APfzVswVKYA0bmeEycwGUHPSkrlLwlZ6aev6QVzVIj/
         v3MFRPaWyQ7mIltWAcHTNrLUaXYe03zicxXo5mtCa0gfbIb5uVYWXp2UPJR18IkGouJz
         R8BVaQjurNUgjIIfPXe4bhTy3Hs88zlypZElX6iUyoX1vr9oxRsrK1r6gJGBaDkdPZkT
         H4CPHI+i0ettfM/gzNcpBPLw9pJvKF1Jwib/G2Lb0a0bpeVD8ppi53fvF79a3sB+z90k
         Ja6r3mt5utkySaROw8BE5vAw+xYkTWZHWxzVkFDEodZKe1FqQJwN6QEQSqCpeaf1lJzd
         ahhg==
X-Gm-Message-State: APjAAAUlgey6HmR9JRjN0OEZYST4YLeOq522Z4MMNDwYGBkuoD2pdvTq
        ekQCcoUqamCCSYtTBN4NZlNpFg==
X-Google-Smtp-Source: APXvYqzUouBK571xMsPgmTxzYkc013roUS4jik+x+H3RHyjBPl1Tw1IuLSGJx2UMcXU/rB8ETFaFeA==
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr13007319pjb.125.1576195649264;
        Thu, 12 Dec 2019 16:07:29 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:28 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/58] tty/serial: Migrate 8250_fsl to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:04 +0000
Message-Id: <20191213000657.931618-6-dima@arista.com>
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

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/powerpc/kernel/legacy_serial.c | 4 +++-
 drivers/tty/serial/8250/8250_fsl.c  | 4 ----
 drivers/tty/serial/8250/8250_of.c   | 4 +++-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 7cea5978f21f..f061e06e9f51 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -479,8 +479,10 @@ static void __init fixup_port_irq(int index,
 	port->irq = virq;
 
 #ifdef CONFIG_SERIAL_8250_FSL
-	if (of_device_is_compatible(np, "fsl,ns16550"))
+	if (of_device_is_compatible(np, "fsl,ns16550")) {
 		port->handle_irq = fsl8250_handle_irq;
+		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
+	}
 #endif
 }
 
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index aa0e216d5ead..0d0c80905c58 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -1,8 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_reg.h>
 #include <linux/serial_8250.h>
 
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 92fbf46ce3bd..531ad67395e0 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -222,8 +222,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	if (IS_ENABLED(CONFIG_SERIAL_8250_FSL) &&
 	    (of_device_is_compatible(np, "fsl,ns16550") ||
-	     of_device_is_compatible(np, "fsl,16550-FIFO64")))
+	     of_device_is_compatible(np, "fsl,16550-FIFO64"))) {
 		port->handle_irq = fsl8250_handle_irq;
+		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
+	}
 
 	return 0;
 err_unprepare:
-- 
2.24.0

