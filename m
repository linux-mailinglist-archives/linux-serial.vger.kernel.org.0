Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8078910CB0B
	for <lists+linux-serial@lfdr.de>; Thu, 28 Nov 2019 15:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfK1O7N (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 28 Nov 2019 09:59:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35485 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfK1O5s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so19826199lja.2
        for <linux-serial@vger.kernel.org>; Thu, 28 Nov 2019 06:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lk3laNSvKrksBmzvW1+vBhhKfEZjlULs2tdXrxvrw9M=;
        b=WL+NyXT4PE96r/aFfykz6rJ/jSO5ngXrbuEXhHV2hvCO2pLlE226VK6kJOehz+jQDF
         aLFIJFEAZY+IOodG+ekGt6hgWrjisce5XzijEQcM5TRjGF3DmtuQDgzP9yT52SmHQvQE
         +CXBMdpP8v47QFJKPuUJL3H7gaGIy0wI6SElg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lk3laNSvKrksBmzvW1+vBhhKfEZjlULs2tdXrxvrw9M=;
        b=Ihoc+M8BlU7dC5ZE99MfpClSCWgwGyV0EaUY0mF0UFR2dEmVjCufgJrC1it5MGe3lx
         DWSNsKAiIl9m2NgnOF8n4NumT3wrYXjJ5IznZZrzGbOEdizRp30G6k0Xg2QtJWxKvP+e
         qBvh7I29Iz9EiSbn+cbowRZTdtSOJGMDLcsRK7GckblGXifTY9pE25uq9SRlb4Xx1FNr
         21DqMFiJ6ab1AnwEOEh1ZOEw/DsNsLMrMfP5ySV8OU9AuF56K2DeReiMel/IX2WSqKz3
         nnXWqK/l31N6hZY+k7mmyAFj2PIPB/KSJaxXdWs/oG148LeR1ittuho8Yb+weyfD4ecy
         Hpww==
X-Gm-Message-State: APjAAAUS+YDgT7Dcy0w9CPjvsya1Xr/skaQXHZtChVlBtuJToreeWMPC
        iSW97dDuEHJm9pAaOuLSgl0FPQ==
X-Google-Smtp-Source: APXvYqzWZGc7U6YNYIXxabBpQROWk46uY46htczHX91iAC5ZJJaEArYMvILp8Ju6zSpngcewVqC5vw==
X-Received: by 2002:a2e:8ed1:: with SMTP id e17mr10842604ljl.52.1574953066298;
        Thu, 28 Nov 2019 06:57:46 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:45 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v6 31/49] serial: ucc_uart: stub out soft_uart_init for !CONFIG_PPC32
Date:   Thu, 28 Nov 2019 15:55:36 +0100
Message-Id: <20191128145554.1297-32-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Soft UART hack is only needed for some PPC-based SOCs. To allow
building this driver for non-PPC, guard soft_uart_init() and its
helpers by CONFIG_PPC32, and use a no-op soft_uart_init() otherwise.

Reviewed-by: Timur Tabi <timur@kernel.org>
Acked-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index f286e91714cb..313697842e24 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -33,7 +33,10 @@
 
 #include <linux/firmware.h>
 #include <soc/fsl/cpm.h>
-#include <asm/reg.h>
+
+#ifdef CONFIG_PPC32
+#include <asm/reg.h> /* mfspr, SPRN_SVR */
+#endif
 
 /*
  * The GUMR flag for Soft UART.  This would normally be defined in qe.h,
@@ -1096,6 +1099,8 @@ static const struct uart_ops qe_uart_pops = {
 	.verify_port    = qe_uart_verify_port,
 };
 
+
+#ifdef CONFIG_PPC32
 /*
  * Obtain the SOC model number and revision level
  *
@@ -1238,6 +1243,16 @@ static int soft_uart_init(struct platform_device *ofdev)
 	return 0;
 }
 
+#else /* !CONFIG_PPC32 */
+
+static int soft_uart_init(struct platform_device *ofdev)
+{
+	return 0;
+}
+
+#endif
+
+
 static int ucc_uart_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
-- 
2.23.0

