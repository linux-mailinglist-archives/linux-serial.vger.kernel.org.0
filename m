Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56EFEC2E9
	for <lists+linux-serial@lfdr.de>; Fri,  1 Nov 2019 13:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfKAMmz (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 1 Nov 2019 08:42:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41176 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbfKAMmz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id m9so10090704ljh.8
        for <linux-serial@vger.kernel.org>; Fri, 01 Nov 2019 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPi0SchlJBpcK2Uafamd7sY3psIZzF+ErFogb8EsMtA=;
        b=FgkhkzeSYJafzm+DXrl6r0ta0raYRc/ZnjHF6yCQHxFbbGNUxEdzoS/j/aXd3Z2EAO
         hw9z52EZvMA2GL3c0mAU2KtYNwS9SYbSqE/jeozwpGumHKa2VCr+wpc1rEJNszK7u+I7
         0ZPLO2ccA2UHvIcStPP44EBdQttMJjlSayBbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPi0SchlJBpcK2Uafamd7sY3psIZzF+ErFogb8EsMtA=;
        b=R2E7a9pXS5zAT4l5n3Ik3/FQndopFPsdCUZdHbGAQoB2KjBhEdn8IVRVWFJq+qIRUm
         T9Ssy6M1bjNbu2fmkB3RhW763hJUb7NRKM3WQs96rO21xcgG/wJNPzZsYZivikmmpB6t
         I7QdXlt56lZVlgOADvo/pFxsQvHApcTIvMr5U79QDoIeLlwNMaTLWlmmpD2kNLGZ3zbV
         2cwcqI6BxZXPJIJftLzKfeLUPrm+HpJV1AFyLRll1bVCSB2uA3pA7SsvIstSBe2IeXD7
         KRhrxAM+PGT67XVrUb2RIkhbwPIQ1tQs6ejl5lFlzlxjwPkHp7r2X1lX9j+Rq7XFILtq
         RxEA==
X-Gm-Message-State: APjAAAUd9MGvTHyyugakS1eqh/ZkuTH4uq4Tac+yLG56nb7gIfYyHdLP
        yZnLlX0MhOMHtgzqp6qL5OYXWQ==
X-Google-Smtp-Source: APXvYqwEgK3pWHNhLdwW3stHSxRWQSbXwYpIh6GddHwwHetrW/PUmKwb0NC0I7oqmSb92E/no6nwnw==
X-Received: by 2002:a2e:819a:: with SMTP id e26mr4744325ljg.26.1572612172961;
        Fri, 01 Nov 2019 05:42:52 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:52 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v3 31/36] serial: ucc_uart: stub out soft_uart_init for !CONFIG_PPC32
Date:   Fri,  1 Nov 2019 13:42:05 +0100
Message-Id: <20191101124210.14510-32-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Soft UART hack is only needed for some PPC-based SOCs. To allow
building this driver for non-PPC, guard soft_uart_init() and its
helpers by CONFIG_PPC32, and use a no-op soft_uart_init() otherwise.

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

